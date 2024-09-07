from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, MessageHandler, CallbackQueryHandler, ContextTypes, filters, ConversationHandler
import googleapiclient
from googleapiclient.discovery import build, HttpError
from dotenv import load_dotenv
import logging
import os
from book import get_csv_file

# Enable logging
logging.basicConfig(format="%(asctime)s - %(name)s - %(levelname)s - %(message)s", level=logging.INFO)
logging.getLogger("httpx").setLevel(logging.WARNING)
logger = logging.getLogger(__name__)

load_dotenv()
API_TOKEN = os.getenv("TELEGRAM_API_TOKEN")
GOOGLE_BOOKS_API_KEY = os.getenv("GOOGLE_BOOKS_API_KEY")
books_service = build('books', 'v1', developerKey=GOOGLE_BOOKS_API_KEY)
application = Application.builder().token(API_TOKEN).build()

reading_list = []
ADD_BOOK, REMOVE_BOOK, GET_PREVIEW, GET_BOOKS = range(4)

async def start(update: Update, context):
    await update.message.reply_text(
        "Welcome to the Book Recommendation Bot! Type /help to see the available commands.")

async def help(update: Update, context):
    await update.message.reply_text(
        "/start - Start the bot\n"
        "/book - Get books of your favouraite genre\n"
        "/preview - Get a preview link of a book\n"
        "/list - Get instructions to view the reading list\n"
        "/reading_list - Manage your reading list\n"
        "/help - Show this help message")
    
async def book(update: Update, context):
    await update.message.reply_text("Please enter the genre name")
    return GET_BOOKS

async def get_books(update: Update, context):
    genre = update.message.text
    try:
        get_csv_file(genre=genre, books_service=books_service)
        chat_id = update.message.chat_id
        with open('Books_detail.csv', 'rb') as file:
            await update.message.reply_document(document=file)
    except HttpError as e:
        await update.message.reply_text(f"An error occurred: {e}")
    return ConversationHandler.END

async def preview(update: Update, context):
    await update.message.reply_text("Please enter the name of the book you want a preview link for:")
    return GET_PREVIEW

async def get_preview(update: Update, context):
    book_name = update.message.text
    try:
        request = books_service.volumes().list(q=book_name, langRestrict='en')
        response = request.execute()
        
        if response['totalItems'] == 0:
            await update.message.reply_text("No books found with that name.")
        else:
            first_book = response['items'][0]
            preview_link = first_book['volumeInfo'].get('previewLink', 'No preview link available.')
            await update.message.reply_text(f"Here's the preview link: {preview_link}")
    except HttpError as e:
        await update.message.reply_text(f"An error occurred: {e}")
    return ConversationHandler.END

async def list(update: Update, context: ContextTypes.DEFAULT_TYPE):
    keyboard = [
        [InlineKeyboardButton("➕ Add a book", callback_data="1")],
        [InlineKeyboardButton("❌ Delete a book", callback_data="2")],
        [InlineKeyboardButton("📚 View reading list", callback_data="3")],]
    reply_markup = InlineKeyboardMarkup(keyboard)
    await update.message.reply_text("Please choose:", reply_markup=reply_markup)

async def button(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    query = update.callback_query
    await query.answer()
    if query.data =='1':
        await query.edit_message_text("Type the name of the book to add")
        return ADD_BOOK
    elif query.data =='2':
        await query.edit_message_text("Type the name of the book to delete")
        return REMOVE_BOOK
    elif query.data =='3':
        reading_list_str = '\n'.join(reading_list) if reading_list else "Your reading list is empty."
        await query.edit_message_text(f"Here's your reading list:\n{reading_list_str}")
        return ConversationHandler.END
    
async def Add_book(update: Update, context: ContextTypes.DEFAULT_TYPE):
    name_of_book=update.message.text
    reading_list.append(name_of_book)
    await update.message.reply_text(f"{name_of_book} has been added to your reading list")
    return ConversationHandler.END

async def Remove_book(update: Update, context: ContextTypes.DEFAULT_TYPE):
    print("Executing Delete list")
    name_of_book=update.message.text
    reading_list.remove(name_of_book)
    await update.message.reply_text(name_of_book, "has been removed from your reading list")
    return ConversationHandler.END

def main() -> None:
    
    application.add_handler(CommandHandler('help', help))
    application.add_handler(CommandHandler('start', start))
    application.add_handler(CommandHandler('preview', preview))
    application.add_handler(CommandHandler('reading_list', list))

    conv_handler = ConversationHandler(
        entry_points=[CallbackQueryHandler(button), 
                      CommandHandler("preview", preview),
                      CommandHandler("reading_list", list),
                      CommandHandler('book', book)],
        states={
            ADD_BOOK : [MessageHandler(filters.TEXT, Add_book)],
            REMOVE_BOOK : [MessageHandler(filters.TEXT, Remove_book)],
            GET_PREVIEW : [MessageHandler(filters.TEXT, get_preview)],
            GET_BOOKS : [MessageHandler(filters.TEXT, get_books)]
        },
        fallbacks=[])
    application.add_handler(conv_handler)
    application.run_polling(allowed_updates=Update.ALL_TYPES)

def filter_text(update: Update) -> bool:
    return update.message.text and not update.message.text.startswith('/')
if __name__ == "__main__":
    main()
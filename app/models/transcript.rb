require 'logger'
class Transcript < ApplicationRecord
#validates :imagefile,  presence: true
validate :validate
def imagefile=(file_field)
#    @imagefile=imagefile_field

    puts "ここに書く"


    @imagefile=file_field

    logger.debug( "===========================model ================== debug =============================" )
#    logger.debug("filename="+@imagefile.original_filename)
    unless @imagefile.blank?
#      puts @imagefile.content_type 
#      puts @imagefile.original_filename
      self.filename=@imagefile.original_filename.gsub(/[^\w._-]/,'')
      self.content_type=@imagefile.content_type.chomp
      self.file=@imagefile.read
      self.user_id="ikko"
    end
end
def validate
    logger.debug( "===========================model/validate================== debug =============================" )
    if @imagefile.blank?
      errors.add(:imagefile,"は必須です")
    else
      if @imagefile.content_type !~/^image/
          errors.add(:imagefile,"ファイル形式が不正です")
      end
    end
end
end

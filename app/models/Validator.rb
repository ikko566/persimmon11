Class MyValidator < ActiveModel::Validator
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


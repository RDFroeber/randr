module ConfigHelper
   def config_amz(instance)
      instance.configure(
         aws_access_key_id:     Figaro.env.amazon_access,
         aws_secret_access_key: Figaro.env.amazon_secret,
         associate_tag:         Figaro.env.amazon_tag
      )
   end

   def config_goodr
      Goodreads.configure(
        :api_key => Figaro.env.goodreads_key,
        :api_secret => Figaro.env.goodreads_secret
      )
   end
end
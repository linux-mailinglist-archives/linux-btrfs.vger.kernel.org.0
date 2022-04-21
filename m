Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F9509E83
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 13:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiDUL2c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 07:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiDUL2b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 07:28:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D092180B;
        Thu, 21 Apr 2022 04:25:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BC40F2129B;
        Thu, 21 Apr 2022 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650540340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7OyWyFEwQEkntLRdvLg6Voyq81EeeIDQgFyUV/maK8=;
        b=Ktxn+KKUGOpgqudZ4HQDeznC4i2E+xqiybJnj9UdEsTUIuf/HFkpG5eero0gR8B0gVoQTv
        e65a4TyPYJ2L6AwiXQK9aXEJ7cEgXB34viEEmumWZDt8yVyTN29MglIf4/d7qo06ynrzW4
        +YbP8rTZcc+1g6w0m+ey6SrLEdaP4VQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E28E13446;
        Thu, 21 Apr 2022 11:25:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ceLpEzQ/YWKweQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Apr 2022 11:25:40 +0000
Message-ID: <c7d16718-1071-2b57-fc77-968945cfb4f5@suse.com>
Date:   Thu, 21 Apr 2022 14:25:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Fix a memory leak in btrfs_ioctl_balance()
Content-Language: en-US
From:   Nikolay Borisov <nborisov@suse.com>
To:     Haowen Bai <baihaowen@meizu.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
 <2aeffa33-e591-acad-f96f-59cfadb5aeb2@suse.com>
In-Reply-To: <2aeffa33-e591-acad-f96f-59cfadb5aeb2@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.04.22 г. 14:21 ч., Nikolay Borisov wrote:
> 
> 
> On 21.04.22 г. 12:51 ч., Haowen Bai wrote:
>> Free "bargs" before return.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>>   fs/btrfs/ioctl.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index f08233c2b0b2..d4c8bea914b7 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -4389,13 +4389,13 @@ static long btrfs_ioctl_balance(struct file 
>> *file, void __user *arg)
>>               /* this is (2) */
>>               mutex_unlock(&fs_info->balance_mutex);
>>               ret = -EINPROGRESS;
>> -            goto out;
>> +            goto out_bargs;
>>           }
>>       } else {
>>           /* this is (1) */
>>           mutex_unlock(&fs_info->balance_mutex);
>>           ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
>> -        goto out;
>> +        goto out_bargs;
>>       }
>>   locked:
> 
> I think this is a better fix:
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7a6974e877f4..906ed1b93654 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4391,15 +4391,13 @@ static long btrfs_ioctl_balance(struct file 
> *file, void __user *arg)
>                          goto again;
>                  } else {
>                          /* this is (2) */
> -                       mutex_unlock(&fs_info->balance_mutex);
>                          ret = -EINPROGRESS;
> -                       goto out;
> +                       goto out_bargs;
>                  }
>          } else {
>                  /* this is (1) */
> -               mutex_unlock(&fs_info->balance_mutex);
>                  ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> -               goto out;
> +               goto out_bargs;
>          }
> 
>   locked:
> 


Actually to simplify further:

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7a6974e877f4..bbda55d41a06 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4353,6 +4353,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
         bargs = memdup_user(arg, sizeof(*bargs));
         if (IS_ERR(bargs)) {
                 ret = PTR_ERR(bargs);
+               bargs = NULL;
                 goto out;
         }
  
@@ -4391,13 +4392,11 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
                         goto again;
                 } else {
                         /* this is (2) */
-                       mutex_unlock(&fs_info->balance_mutex);
                         ret = -EINPROGRESS;
                         goto out;
                 }
         } else {
                 /* this is (1) */
-               mutex_unlock(&fs_info->balance_mutex);
                 ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
                 goto out;
         }
@@ -4406,7 +4405,7 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
         if (bargs->flags & BTRFS_BALANCE_RESUME) {
                 if (!fs_info->balance_ctl) {
                         ret = -ENOTCONN;
-                       goto out_bargs;
+                       goto out;
                 }
  
                 bctl = fs_info->balance_ctl;
@@ -4420,18 +4419,18 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
  
         if (bargs->flags & ~(BTRFS_BALANCE_ARGS_MASK | BTRFS_BALANCE_TYPE_MASK)) {
                 ret = -EINVAL;
-               goto out_bargs;
+               goto out;
         }
  
         if (fs_info->balance_ctl) {
                 ret = -EINPROGRESS;
-               goto out_bargs;
+               goto out;
         }
  
         bctl = kzalloc(sizeof(*bctl), GFP_KERNEL);
         if (!bctl) {
                 ret = -ENOMEM;
-               goto out_bargs;
+               goto out;
         }
  
         memcpy(&bctl->data, &bargs->data, sizeof(bctl->data));
@@ -4457,12 +4456,11 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
         }
  
         kfree(bctl);
-out_bargs:
+out:
         kfree(bargs);
         mutex_unlock(&fs_info->balance_mutex);
         if (need_unlock)
                 btrfs_exclop_finish(fs_info);
-out:
         mnt_drop_write_file(file);
         return ret;
  }





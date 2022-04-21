Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1EE509E71
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388768AbiDULYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 07:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiDULYd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 07:24:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826CF2BB2B;
        Thu, 21 Apr 2022 04:21:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC4942112B;
        Thu, 21 Apr 2022 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650540102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fd40jvPq+S2zkGdnNvdMinMtCHUXv8cB8l1aQ1CJNCg=;
        b=N2K9u11WMkWyMBl5/Ex9nUfxjDU/z/mrbYDJs851s0/AYATM7jknDMlVoBWBU1ZmrPvw+t
        G/CfYiBrmv37fAjLrSaIzBgArDXRoenl5Qyu3uWB55S2DXRJCA2/hLRm+bNrvZ+MCGxaho
        GJl/MMS+6rwzAL8m+77mjeZ0H6QQpKo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ABD113446;
        Thu, 21 Apr 2022 11:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RMnbGkY+YWLvdwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Apr 2022 11:21:42 +0000
Message-ID: <2aeffa33-e591-acad-f96f-59cfadb5aeb2@suse.com>
Date:   Thu, 21 Apr 2022 14:21:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: Fix a memory leak in btrfs_ioctl_balance()
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
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



On 21.04.22 г. 12:51 ч., Haowen Bai wrote:
> Free "bargs" before return.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>   fs/btrfs/ioctl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index f08233c2b0b2..d4c8bea914b7 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4389,13 +4389,13 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
>   			/* this is (2) */
>   			mutex_unlock(&fs_info->balance_mutex);
>   			ret = -EINPROGRESS;
> -			goto out;
> +			goto out_bargs;
>   		}
>   	} else {
>   		/* this is (1) */
>   		mutex_unlock(&fs_info->balance_mutex);
>   		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> -		goto out;
> +		goto out_bargs;
>   	}
>   
>   locked:

I think this is a better fix:

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7a6974e877f4..906ed1b93654 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4391,15 +4391,13 @@ static long btrfs_ioctl_balance(struct file 
*file, void __user *arg)
                         goto again;
                 } else {
                         /* this is (2) */
-                       mutex_unlock(&fs_info->balance_mutex);
                         ret = -EINPROGRESS;
-                       goto out;
+                       goto out_bargs;
                 }
         } else {
                 /* this is (1) */
-               mutex_unlock(&fs_info->balance_mutex);
                 ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
-               goto out;
+               goto out_bargs;
         }

  locked:

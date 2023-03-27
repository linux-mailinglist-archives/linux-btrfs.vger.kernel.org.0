Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CB6CB223
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjC0XMM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0XML (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:12:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFC119B2;
        Mon, 27 Mar 2023 16:12:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C5081FD7B;
        Mon, 27 Mar 2023 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679958728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVP2vG2bk7Ixsyu6QZ1iwWr3gX486d6hgLJBsvOtjAU=;
        b=NEYRxmx3W36+UM+BYCflfxzQfkf8LAK2Y0ffLk+Q+rRiflsBtZAEGMFQnb0PSzsbcqwqv/
        izm1C2wZcgb+3yBLDCmgiFX03nbmSsKMRNNu/XAvd6DZKmthyoo8sMi4Gmhk6BG0a9NT6k
        o1s5oOUMnhtwb0tp5Hj7f1VaeVktoHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679958728;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVP2vG2bk7Ixsyu6QZ1iwWr3gX486d6hgLJBsvOtjAU=;
        b=njWZEhcei0rIWpfIPOJJFRluwVQE/M9s9a3WKokxyFcryqU+Y/g3RBtfOn6QQtG4Eyuufx
        X8pB6Bmyti18gLAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 644B313482;
        Mon, 27 Mar 2023 23:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CJN6F8giImQdYwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Mar 2023 23:12:08 +0000
Date:   Tue, 28 Mar 2023 01:05:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     xiaoshoukui <xiaoshoukui@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: Re: [PATCH] btrfs: ioctl: fix inaccurate determination of
 exclusive_operation
Message-ID: <20230327230553.GJ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230324031611.98986-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324031611.98986-1-xiaoshoukui@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 11:16:11PM -0400, xiaoshoukui wrote:
> with fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD enter
> btrfs_ioctl_add_dev function , exclusive_operation will be classified
> as in paused balance operation. After return from btrfs_ioctl_add_dev,
> exclusive_operation will be restore to BTRFS_EXCLOP_BALANCE_PAUSED which
> is not its original state.

Sorry, I don't understand what you mean. The paused balance and 'device
add' are supposed to be compatible exclusive operations (see commit
a174c0a2e857 ("btrfs: allow device add if balance is paused")).

Have you found some bug with the above or is there other combination of
the exclusive operations that should not work? The changes to the state
values are the same, besides the wrong locking.

> Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
> ---
>  fs/btrfs/ioctl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a0ef1a1784c7..aab5fdb9445c 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2629,7 +2629,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
>  	}
>  
>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
> -		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
> +		if (fs_info->exclusive_operation != BTRFS_EXCLOP_BALANCE_PAUSED)

This is removing the atomicity of the check so it's racy and could
forcibly overwrite the exclusive operation to BTRFS_EXCLOP_DEV_ADD
without the protecting the whole critical section.

>  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
>  
>  		/*
> @@ -2637,8 +2637,9 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
>  		 * change the exclusive op type and remember we should bring
>  		 * back the paused balance
>  		 */
> +		spin_lock(&fs_info->super_lock);

What if there's another exclusive operation started before this lock is
taken?

>  		fs_info->exclusive_operation = BTRFS_EXCLOP_DEV_ADD;
> -		btrfs_exclop_start_unlock(fs_info);
> +		spin_unlock(&fs_info->super_lock);
>  		restore_op = true;
>  	}

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E687A753780
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 12:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjGNKIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 06:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjGNKIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 06:08:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879EDE44;
        Fri, 14 Jul 2023 03:08:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FAE31FD60;
        Fri, 14 Jul 2023 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689329301;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7Rv1H6fjmBW7mfZ+ZrZR0i86EmB3mqsT9/DnQrSAjs=;
        b=qsMmse8mTusoohv3JefPmD7rtFAwwKNHClCQ0HTfc641h+qO4HfMWLwAUw6JK/6NdBGaZ3
        4mipH79Z+CbRfFNEwjSAWOdpJgWjT6dfbedZgIbWGQt/uhlHLzPYxioXVlqC/+QpWZux4K
        Y3ZQdJycLUZW19YxqTjIVmg1M2Ij6cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689329301;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7Rv1H6fjmBW7mfZ+ZrZR0i86EmB3mqsT9/DnQrSAjs=;
        b=Lw/3NxXsnUVhBmQlwadstME3Do+Rr7Sg2IMERJuFKXIfMrLHOVUqp+ivNvM2lvKfellMa2
        2bzVGhMBJJmvnGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEB3413A15;
        Fri, 14 Jul 2023 10:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R0lGOZQesWSrCgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Jul 2023 10:08:20 +0000
Date:   Fri, 14 Jul 2023 12:01:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     xiaoshoukui <xiaoshoukui@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: Re: [PATCH] btrfs: fix balance_ctl not free properly in btrfs_balance
Message-ID: <20230714100143.GE20457@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230714071548.45825-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714071548.45825-1-xiaoshoukui@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 14, 2023 at 03:15:48AM -0400, xiaoshoukui wrote:
> Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
> ---
>  fs/btrfs/volumes.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7823168c08a6..c1ab94d8694c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4055,14 +4055,6 @@ static int alloc_profile_is_valid(u64 flags, int extended)
>         return has_single_bit_set(flags);
>  }
>  
> -static inline int balance_need_close(struct btrfs_fs_info *fs_info)
> -{
> -       /* cancel requested || normal exit path */
> -       return atomic_read(&fs_info->balance_cancel_req) ||
> -               (atomic_read(&fs_info->balance_pause_req) == 0 &&
> -                atomic_read(&fs_info->balance_cancel_req) == 0);
> -}
> -
>  /*
>   * Validate target profile against allowed profiles and return true if it's OK.
>   * Otherwise print the error message and return false.
> @@ -4411,7 +4403,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>         }
>  
>         if ((ret && ret != -ECANCELED && ret != -ENOSPC) ||
> -           balance_need_close(fs_info)) {
> +           ret == -ECANCELED || ret == 0) {
>                 reset_balance_state(fs_info);
>                 btrfs_exclop_finish(fs_info);

This is a similar patch to what Josef sent but not exactly the same,

https://lore.kernel.org/linux-btrfs/9cdf58c2f045863e98a52d7f9d5102ba12b87f07.1687496547.git.josef@toxicpanda.com/

Both remove balance_need_close but your version does not track the
paused state. I haven't analyzed it closer, but it looks like you're
missing some case. Josef's fix simplifies the error handling so we don't
have te enumerate the errors.

As you have a reproducer, can you please try it with this patch instead?
It's possible that there are still some unhandled states so it would be
good to check. Thanks.

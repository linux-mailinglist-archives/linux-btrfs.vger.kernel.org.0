Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8A77F653
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350876AbjHQMSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 08:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350753AbjHQMSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 08:18:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A3912B;
        Thu, 17 Aug 2023 05:18:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60C0321877;
        Thu, 17 Aug 2023 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692274684;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kt8KWFgOazXWESxl+qrvrQADA7Fg7LjeJ8HgZNmXfnk=;
        b=geq/y9jIK3x0QLDlNaGHs/rl+i9NPtDrxBDVmJWPVBIV2YAOsh+GC7+bkYev2rz21aAIL2
        iF46ro+2UDBBBmIqr1rsBz1VgoqUkY3iG6LKwmcULboaoX+SWRMw2sEUn2qCPs+ymBXPff
        cu/UQXLth3J0Z5yEIUdE03hcJjoxZ7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692274684;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kt8KWFgOazXWESxl+qrvrQADA7Fg7LjeJ8HgZNmXfnk=;
        b=DpIUdSpX+74j5EiZmAMLzFTU/33fyb8qZofOQB1DnTBQ429fTVIH6ExR5VKTjRUmo/UFcb
        /N88qY19YEG2mrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24E7B1358B;
        Thu, 17 Aug 2023 12:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n/AtCPwP3mRGWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 17 Aug 2023 12:18:04 +0000
Date:   Thu, 17 Aug 2023 14:11:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     xiaoshoukui <xiaoshoukui@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: Re: [PATCH] btrfs: fix BUG_ON condition in btrfs_cancel_balance
Message-ID: <20230817121135.GL2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230815065559.31546-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815065559.31546-1-xiaoshoukui@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 15, 2023 at 02:55:59AM -0400, xiaoshoukui wrote:
> Pausing and canceling balance can race to intterupt balance lead to BUG_ON 
> panic in btrfs_cancel_balance. The BUG_ON condition in btrfs_cancel_balance
> does not take this race scenario into account.

Seems that it's from times the balance was not cancellable the same way
as now. Also it's a good time to switch the BUG_ON to an assertion or
handle it properly.
> 
> However, the race condition has no other side effects. We can fix that.
> 
> Reproducing it with panic trace like this:
> kernel BUG at fs/btrfs/volumes.c:4618!
> RIP: 0010:btrfs_cancel_balance+0x5cf/0x6a0
> Call Trace:
>  <TASK>
>  ? do_nanosleep+0x60/0x120
>  ? hrtimer_nanosleep+0xb7/0x1a0
>  ? sched_core_clone_cookie+0x70/0x70
>  btrfs_ioctl_balance_ctl+0x55/0x70
>  btrfs_ioctl+0xa46/0xd20
>  __x64_sys_ioctl+0x7d/0xa0
>  do_syscall_64+0x38/0x80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Race scenario as follows:
> > mutex_unlock(&fs_info->balance_mutex);
> > --------------------
> > .......issue pause and cancel req in another thread
> > --------------------
> > ret = __btrfs_balance(fs_info);
> > 
> > mutex_lock(&fs_info->balance_mutex);
> > if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
> >         btrfs_info(fs_info, "balance: paused");
> >         btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
> > }
> 
> Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
> ---
>  fs/btrfs/volumes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2ecb76cf3d91..886d667419ed 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4638,8 +4638,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
>  		}
>  	}
>  
> -	BUG_ON(fs_info->balance_ctl ||
> -		test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));
> +	BUG_ON(test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags));

I'll change to to ASSERT, this is really to verify that the state
tracking works properly.

>  	atomic_dec(&fs_info->balance_cancel_req);
>  	mutex_unlock(&fs_info->balance_mutex);
>  	return 0;
> -- 
> 2.34.1

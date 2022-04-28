Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651C45137BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348800AbiD1PKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348793AbiD1PKD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 11:10:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B328E39
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 08:06:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 471282186F;
        Thu, 28 Apr 2022 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651158406;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnyuQ/sjy9s4e1jhUjqVu1JuslPKDV50UyNsunyLSxg=;
        b=efS2chHOzaNZxnHdxJc5Xw4ONafUHwdK3f3ogoe4FSfneD3T/D9flsWN/mKFWms3nrqiR4
        rlJzFgXY2bWYZtcp2y9bN46G5NpDGVYLhA2agtj82lqzGEKslBiCIEuH4wuK04wjzV6DAU
        5tLMIp0uqBAxNHrVcV9hVsYUGaTbljU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651158406;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnyuQ/sjy9s4e1jhUjqVu1JuslPKDV50UyNsunyLSxg=;
        b=SPZPl7vw55YRh4ZMaq/ON+N+fT8ktdxWc4soxZL1SRkwW87e2IRPu14mokMt5G1Z207I7g
        pCoxBmGs7MVKcTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1151F13491;
        Thu, 28 Apr 2022 15:06:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a+M9A4atamKRegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 28 Apr 2022 15:06:46 +0000
Date:   Thu, 28 Apr 2022 17:02:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: don't call destroy_workqueue on NULL workqueues
Message-ID: <20220428150237.GC18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com
References: <20220428125341.4152527-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428125341.4152527-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 05:53:41AM -0700, Christoph Hellwig wrote:
> Unlike the btrfs_workueue code, the kernel workqueues don't like their
> cleaup function called on a NULL pointer, so add checks for them.
> 
> Fixes: a5eec25648da ("btrfs: use a normal workqueue for rmw_workers")
> Reported-by: syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: syzbot+a2c720e0f056114ea7c6@syzkaller.appspotmail.com

Thanks, folded to the patches.

> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2283,7 +2283,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
>  	btrfs_destroy_workqueue(fs_info->workers);
>  	btrfs_destroy_workqueue(fs_info->endio_workers);
>  	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
> -	destroy_workqueue(fs_info->rmw_workers);
> +	if (fs_info->rmw_workers)
> +		destroy_workqueue(fs_info->rmw_workers);

This is in "btrfs: use a normal workqueue for rmw_workers"

>  	btrfs_destroy_workqueue(fs_info->endio_write_workers);
>  	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
>  	btrfs_destroy_workqueue(fs_info->delayed_workers);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index a614ddde8c624..3985225f27be5 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3967,9 +3967,12 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
>  		fs_info->scrub_parity_workers = NULL;
>  		mutex_unlock(&fs_info->scrub_lock);
>  
> -		destroy_workqueue(scrub_workers);
> -		destroy_workqueue(scrub_wr_comp);
> -		destroy_workqueue(scrub_parity);
> +		if (scrub_workers)
> +			destroy_workqueue(scrub_workers);
> +		if (scrub_wr_comp)
> +			destroy_workqueue(scrub_wr_comp);
> +		if (scrub_parity)
> +			destroy_workqueue(scrub_parity);

And this from "btrfs: use normal workqueues for scrub"

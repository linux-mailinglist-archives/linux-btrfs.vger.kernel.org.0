Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528F26FC9BB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbjEIO7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjEIO7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 10:59:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B83A8D;
        Tue,  9 May 2023 07:59:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 077C021C74;
        Tue,  9 May 2023 14:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683644372;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ws2pfb2I14kNmCpwcuY6Ln1HcgD90lj/eSZsutM5HBc=;
        b=yuE+aeDKrScwEsnGm+ZyOwiNY9Lt+wu1e/s8mXUWFd+2M4Vb9RGil2L9BEOsZ7MWTFYHVZ
        dvfXesG20+SnDBzMjkDBMyJTeFMvW0f4vzjbzGhaHle+8wI7zxCF7Q+iKVG4FeuQigKK/Y
        iRbWXri2yo3XxWAawAi2zMRqHuXjc7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683644372;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ws2pfb2I14kNmCpwcuY6Ln1HcgD90lj/eSZsutM5HBc=;
        b=U9lDf+k2G3IdMfweOC+bN8zhFCLOyeCzlW4MnzmWE4CRq0KZUCd7YpDsZ1eJWHI0lq4KaK
        DvZSWyLP+UcRy1Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A66A13581;
        Tue,  9 May 2023 14:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B+iCItNfWmQ9HgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 09 May 2023 14:59:31 +0000
Date:   Tue, 9 May 2023 16:53:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Wang Yugui <wangyugui@e16-tech.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/13] btrfs: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <20230509145332.GA32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-9-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509015032.3768622-9-tj@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 08, 2023 at 03:50:27PM -1000, Tejun Heo wrote:
> BACKGROUND
> ==========
> 
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
> 
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
> 
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
> 
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
> 
> WHAT TO LOOK FOR
> ================
> 
> The conversions are from
> 
>   alloc_workqueue(WQ_UNBOUND | flags, 1, args..)
> 
> to
> 
>   alloc_ordered_workqueue(flags, args...)
> 
> which don't cause any functional changes. If you know that fully ordered
> execution is not ncessary, please let me know. I'll drop the conversion and
> instead add a comment noting the fact to reduce confusion while conversion
> is in progress.
> 
> If you aren't fully sure, it's completely fine to let the conversion
> through. The behavior will stay exactly the same and we can always
> reconsider later.
> 
> As there are follow-up workqueue core changes, I'd really appreciate if the
> patch can be routed through the workqueue tree w/ your acks. Thanks.
> 
> v3: btrfs_alloc_workqueue() excluded again. The concurrency level of a
>     workqueue allocated through btrfs_alloc_workqueue() may be dynamically
>     adjusted through thresh_exec_hook(), so they can't be ordered.
> 
> v2: btrfs_alloc_workqueue() updated too as suggested by Wang.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Wang Yugui <wangyugui@e16-tech.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> ---
>  fs/btrfs/disk-io.c | 2 +-
>  fs/btrfs/scrub.c   | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 59ea049fe7ee..32d08aed88b6 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2217,7 +2217,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>  	fs_info->qgroup_rescan_workers =
>  		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
>  	fs_info->discard_ctl.discard_workers =
> -		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
> +		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
>  
>  	if (!(fs_info->workers && fs_info->hipri_workers &&
>  	      fs_info->delalloc_workers && fs_info->flush_workers &&

I think there are a few more conversions missing. There's a local flags
variable in btrfs_init_workqueues

2175 static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
2176 {
2177         u32 max_active = fs_info->thread_pool_size;
2178         unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;

And used like

2194         fs_info->fixup_workers =
2195                 btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);

2213         fs_info->qgroup_rescan_workers =
2214                 btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);

WQ_UNBOUND is not mentioned explicitliy like for the "btrfs_discard"
workqueue.  Patch v2 did the switch in btrfs_alloc_workqueue according
to the max_active/limit_active parameter but this would affect all
queues and not all of them require to be ordered.

In btrfs_resize_thread_pool the workqueue_set_max_active is called
directly or indirectly so this can set the max_active to a user-defined
mount option. Could this be a problem or trigger a warning? This would
lead to max_active==1 + WQ_UNBOUND.

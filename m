Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D756F27A0
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Apr 2023 06:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjD3EkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Apr 2023 00:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3EkO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Apr 2023 00:40:14 -0400
Received: from out28-65.mail.aliyun.com (out28-65.mail.aliyun.com [115.124.28.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4BFE7C;
        Sat, 29 Apr 2023 21:40:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04437546|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00842704-0.000887824-0.990685;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.SUWc2Yx_1682829606;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.SUWc2Yx_1682829606)
          by smtp.aliyun-inc.com;
          Sun, 30 Apr 2023 12:40:07 +0800
Date:   Sun, 30 Apr 2023 12:40:08 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 16/22] btrfs: Use alloc_ordered_workqueue() to create ordered workqueues
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <20230421025046.4008499-17-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org> <20230421025046.4008499-17-tj@kernel.org>
Message-Id: <20230430124006.49D2.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

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

Should we  add alloc_ordered_workqueue to 
btrfs_alloc_workqueue() of fs/btrfs/async-thread.c too?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/04/30

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
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
> index 9e1596bb208d..b1f6ff69dbe1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2218,7 +2218,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
>  	fs_info->qgroup_rescan_workers =
>  		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
>  	fs_info->discard_ctl.discard_workers =
> -		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
> +		alloc_ordered_workqueue("btrfs_discard", WQ_FREEZABLE);
>  
>  	if (!(fs_info->workers && fs_info->hipri_workers &&
>  	      fs_info->delalloc_workers && fs_info->flush_workers &&
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 69c93ae333f6..70882358bdb0 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -4245,8 +4245,10 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
>  	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
>  		return 0;
>  
> -	scrub_workers = alloc_workqueue("btrfs-scrub", flags,
> -					is_dev_replace ? 1 : max_active);
> +	if (is_dev_replace)
> +		scrub_workers = alloc_ordered_workqueue("btrfs-scrub", flags);
> +	else
> +		scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
>  	if (!scrub_workers)
>  		goto fail_scrub_workers;
>  
> -- 
> 2.40.0



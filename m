Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE353AA616
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 23:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhFPVWR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 17:22:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43602 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhFPVWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 17:22:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5EDDC21A81;
        Wed, 16 Jun 2021 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623878409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMZe8tFDriY/VMh3aEcxF5slzR84t7cf7objfoDtFbY=;
        b=0J/HNNaY1UC5MKavSt4azmEZA5PD3V2EvCX/2m9RJ+mNTlqasdHnz/uEBSUedXn6l0NcWq
        QJTkHwbmX0FYkmvUBXp4SjM/3SZYEMJxAknsGpPtZOFG1wNMTRWDYzXwvr8j1/1hFcs9gg
        QQ2qG3WrYh7MeANZtWX/o8I4uiNrtAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623878409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eMZe8tFDriY/VMh3aEcxF5slzR84t7cf7objfoDtFbY=;
        b=hjKieAFrgqCJdiXkWt5a6rqs2NztLSXvagxsApDzbt4S2bPyqAey0qF07ZzmQ7kU7U9YPL
        yupFUFOg1KUuNnDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 56C61A3BAD;
        Wed, 16 Jun 2021 21:20:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 87B84DAF29; Wed, 16 Jun 2021 23:17:21 +0200 (CEST)
Date:   Wed, 16 Jun 2021 23:17:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: add a way to monitor for ENOSPC events on a file
 system
Message-ID: <20210616211721.GT28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <095765eb9c19463b7b0a490a9168326f2d314e68.1622577768.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095765eb9c19463b7b0a490a9168326f2d314e68.1622577768.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 01, 2021 at 04:02:58PM -0400, Josef Bacik wrote:
> At Facebook's scale of btrfs deployment it's difficult to determine if
> there's a systemic problem in our ENOSPC handling, or if it's simply
> misbehaving tasks.  Part of monitoring btrfs at any scale is having data
> about what is happening on a file system.  To that end, export the
> number of ENOSPC events we've had per space_info via sysfs.  This
> provides production users of btrfs to better monitor if they're having
> problems, as sometimes userspace fails in different and interesting ways
> that may be difficult to tie back to an errant (or even legitimate)
> ENOSPC.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c |  8 ++++++++
>  fs/btrfs/space-info.h |  6 ++++++
>  fs/btrfs/sysfs.c      | 12 ++++++++++++
>  3 files changed, 26 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index fc329aff478f..af467e888545 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -213,6 +213,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  	INIT_LIST_HEAD(&space_info->ro_bgs);
>  	INIT_LIST_HEAD(&space_info->tickets);
>  	INIT_LIST_HEAD(&space_info->priority_tickets);
> +	atomic_set(&space_info->enospc_events, 0);

This uses one value to track all enospc events. I think it would be more
useful to track each reason separately and put all the stats into eg
'enpspc_stats' for each space info.

>  	space_info->clamp = 1;
>  
>  	ret = btrfs_sysfs_add_space_info_type(info, space_info);
> @@ -1674,6 +1675,11 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
>  			ret = 0;
>  	}
>  	if (ret == -ENOSPC) {
> +		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
> +		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
> +		    flush == BTRFS_RESERVE_FLUSH_EVICT)

Like here you could have 3 stats or to if ALL are in one.

> +			atomic_inc(&block_rsv->space_info->enospc_events);
> +
>  		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
>  					      block_rsv->space_info->flags,
>  					      orig_bytes, 1);
> @@ -1707,6 +1713,8 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
>  
>  	ret = __reserve_bytes(fs_info, data_sinfo, bytes, flush);
>  	if (ret == -ENOSPC) {
> +		if (flush == BTRFS_RESERVE_FLUSH_DATA)

The previous were for metadata, this one is for data so at least
distinction on that level would make sense.

> +			atomic_inc(&data_sinfo->enospc_events);
>  		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
>  					      data_sinfo->flags, bytes, 1);
>  		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index b1a8ffb03b3e..11eff2139aae 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -73,6 +73,12 @@ struct btrfs_space_info {
>  	 */
>  	u64 tickets_id;
>  
> +	/*
> +	 * Counter for the number of times user facing flush actions have
> +	 * failed.
> +	 */
> +	atomic_t enospc_events;

Regarding memory consumption, it shouldn't be a concern because there
are at most 3 space infos. The size on release build is about 552 bytes,
so we're past 512 and the next bucket is 1024.

One more thing that could be interesting is a timestamp of the last
event, so that would be 2 values per event.

> +
>  	struct rw_semaphore groups_sem;
>  	/* for block groups in our same type */
>  	struct list_head block_groups[BTRFS_NR_RAID_TYPES];
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4b508938e728..52c5311873d3 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -674,6 +674,15 @@ static ssize_t btrfs_space_info_show_total_bytes_pinned(struct kobject *kobj,
>  	return scnprintf(buf, PAGE_SIZE, "%lld\n", val);
>  }
>  
> +static ssize_t btrfs_space_info_show_enospc_events(struct kobject *kobj,
> +						   struct kobj_attribute *a,
> +						   char *buf)
> +{
> +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> +	int events = atomic_read(&sinfo->enospc_events);
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", events);
> +}
> +
>  SPACE_INFO_ATTR(flags);
>  SPACE_INFO_ATTR(total_bytes);
>  SPACE_INFO_ATTR(bytes_used);
> @@ -686,6 +695,8 @@ SPACE_INFO_ATTR(disk_used);
>  SPACE_INFO_ATTR(disk_total);
>  BTRFS_ATTR(space_info, total_bytes_pinned,
>  	   btrfs_space_info_show_total_bytes_pinned);
> +BTRFS_ATTR(space_info, enospc_events,
> +	   btrfs_space_info_show_enospc_events);
>  
>  static struct attribute *space_info_attrs[] = {
>  	BTRFS_ATTR_PTR(space_info, flags),
> @@ -699,6 +710,7 @@ static struct attribute *space_info_attrs[] = {
>  	BTRFS_ATTR_PTR(space_info, disk_used),
>  	BTRFS_ATTR_PTR(space_info, disk_total),
>  	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
> +	BTRFS_ATTR_PTR(space_info, enospc_events),
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(space_info);
> -- 
> 2.26.3

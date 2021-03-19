Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4433423E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 18:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCSR7M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 13:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhCSR7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 13:59:05 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A48C06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 10:59:05 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id by2so5439262qvb.11
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RyfshZDl0/5l7pTiFmvpMnbccr4dpF3mBoIUyTTRxWk=;
        b=vIIHzkdj56Y3letOwgqMbTow7oYWBPCkvIg0EHmxebsicIQXJTNC2Ed5k5cX3SnHt0
         SYwJ7V7wjJ2PcoSX1uk53zWKbAn2qH3yLFtxhm3p5eyYeApGuXVeCmiO1grOm33ayrGb
         vIX8a0J6ryp1CnH9W4jI9iau3Qi95gF0SxZdz2bHcytJtHM1RXug8RWnl1lo14BCTlTp
         rB16oeb3s17LJVT7ii4u3o2h0c9tfbuFGiu0B32SCSEDvzZ3tBZgIACush8HMhT5vmbK
         XqK/BCUGY1FI2FLeMNlk1Ydg8+Btk7V9DvrauTGXL00PaZeDV5Ik1xSRiV1rR4eP18wJ
         +yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RyfshZDl0/5l7pTiFmvpMnbccr4dpF3mBoIUyTTRxWk=;
        b=H5BKcSXf+Xezzi4g5hYb8avua0HSOIOPeyCqYi16QULjvrY0A1WO8khRvXPB3mWrlZ
         50HiN5DQUQe7EQQfN6qgXpRJMkiXKT+cTXV6mKf9T3SeNRMMWA8cGbghPZ+BkjNMj2wZ
         orcEr4BkYzAthKRJTaAqkcS+xfHJdlfQvrbSc3YwxyyECw5eOSZGYaXk1W9ykoJ4cSj+
         htaFZAE5VKwS9poekyYq0LzapMrHjZcrpp/dEJLKy85Fjo0WnnC1FQakSFpGx+10cbv7
         vjIiXrHDhGLjAlhgEpK+j84AEIWyEHLqWPl6A/cFT768kewo5RucJ0gaOiK0RAYJQepl
         bplw==
X-Gm-Message-State: AOAM533cKmxDNO8TM2I7Bi4iW4Gcfq+UPYFJRRlMyWM8u6o4j9Z0TJnL
        VXLoxiisbw+diSV2i6P/d9fUcexshq36cuIM
X-Google-Smtp-Source: ABdhPJz+5yFOY772h5KLurm2ygFB1RZZgXMvLEDa8jocnl2Hd+5gXm/napxSk23IoDWy8cn/UFutvA==
X-Received: by 2002:a0c:a404:: with SMTP id w4mr10716384qvw.45.1616176744408;
        Fri, 19 Mar 2021 10:59:04 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w13sm4212946qtv.37.2021.03.19.10.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 10:59:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] btrfs: zoned: automatically reclaim zones
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1616149060.git.johannes.thumshirn@wdc.com>
 <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6611a836-72be-eada-1f2d-33454ce5fa04@toxicpanda.com>
Date:   Fri, 19 Mar 2021 13:59:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <58648eb48c6cb2b35d201518c8dc430b7797bcaa.1616149060.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/21 6:48 AM, Johannes Thumshirn wrote:
> When a file gets deleted on a zoned file system, the space freed is not
> returned back into the block group's free space, but is migrated to
> zone_unusable.
> 
> As this zone_unusable space is behind the current write pointer it is not
> possible to use it for new allocations. In the current implementation a
> zone is reset once all of the block group's space is accounted as zone
> unusable.
> 
> This behaviour can lead to premature ENOSPC errors on a busy file system.
> 
> Instead of only reclaiming the zone once it is completely unusable,
> kick off a reclaim job once the amount of unusable bytes exceeds a user
> configurable threshold between 51% and 100%. It can be set per mounted
> filesystem via the sysfs tunable bg_reclaim_threshold which is set to 75%
> per default.
> 
> Similar to reclaiming unused block groups, these dirty block groups are
> added to a to_reclaim list and then on a transaction commit, the reclaim
> process is triggered but after we deleted unused block groups, which will
> free space for the relocation process.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 
> AFAICT sysfs_create_files() does not have the ability to provide a is_visible
> callback, so the bg_reclaim_threshold sysfs file is visible for non zoned
> filesystems as well, even though only for zoned filesystems we're adding block
> groups to the reclaim list. I'm all ears for a approach that is sensible in
> this regard.
> 
> 
>   fs/btrfs/block-group.c       | 84 ++++++++++++++++++++++++++++++++++++
>   fs/btrfs/block-group.h       |  2 +
>   fs/btrfs/ctree.h             |  3 ++
>   fs/btrfs/disk-io.c           | 11 +++++
>   fs/btrfs/free-space-cache.c  |  9 +++-
>   fs/btrfs/sysfs.c             | 35 +++++++++++++++
>   fs/btrfs/volumes.c           |  2 +-
>   fs/btrfs/volumes.h           |  1 +
>   include/trace/events/btrfs.h | 12 ++++++
>   9 files changed, 157 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9ae3ac96a521..af9026795ddd 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1485,6 +1485,80 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>   	spin_unlock(&fs_info->unused_bgs_lock);
>   }
>   
> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_block_group *bg;
> +	struct btrfs_space_info *space_info;
> +	int ret = 0;
> +
> +	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
> +		return;
> +
> +	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
> +		return;
> +
> +	mutex_lock(&fs_info->reclaim_bgs_lock);
> +	while (!list_empty(&fs_info->reclaim_bgs)) {
> +		bg = list_first_entry(&fs_info->reclaim_bgs,
> +				      struct btrfs_block_group,
> +				      bg_list);
> +		list_del_init(&bg->bg_list);
> +
> +		space_info = bg->space_info;
> +		mutex_unlock(&fs_info->reclaim_bgs_lock);
> +
> +		/* Don't want to race with allocators so take the groups_sem */
> +		down_write(&space_info->groups_sem);
> +
> +		spin_lock(&bg->lock);
> +		if (bg->reserved || bg->pinned || bg->ro) {

How do we deal with backup supers in zoned again?  Will they show up as 
readonly?  If so we may not want the bg->ro check, but I may be insane.

> +			/*
> +			 * We want to bail if we made new allocations or have
> +			 * outstanding allocations in this block group.  We do
> +			 * the ro check in case balance is currently acting on
> +			 * this block group.
> +			 */
> +			spin_unlock(&bg->lock);
> +			up_write(&space_info->groups_sem);
> +			goto next;
> +		}
> +		spin_unlock(&bg->lock);
> +
> +		ret = inc_block_group_ro(bg, 0);
> +		up_write(&space_info->groups_sem);
> +		if (ret < 0) {
> +			ret = 0;
> +			goto next;
> +		}
> +
> +		btrfs_info(fs_info, "reclaiming chunk %llu", bg->start);
> +		trace_btrfs_reclaim_block_group(bg);
> +		ret = btrfs_relocate_chunk(fs_info, bg->start);
> +		if (ret)
> +			btrfs_err(fs_info, "error relocating chunk %llu",
> +				  bg->start);
> +
> +next:
> +		btrfs_put_block_group(bg);
> +		mutex_lock(&fs_info->reclaim_bgs_lock);
> +	}
> +	mutex_unlock(&fs_info->reclaim_bgs_lock);
> +	btrfs_exclop_finish(fs_info);
> +}
> +
> +void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = bg->fs_info;
> +
> +	mutex_lock(&fs_info->reclaim_bgs_lock);
> +	if (list_empty(&bg->bg_list)) {
> +		btrfs_get_block_group(bg);
> +		trace_btrfs_add_reclaim_block_group(bg);
> +		list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
> +	}
> +	mutex_unlock(&fs_info->reclaim_bgs_lock);
> +}
> +
>   static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
>   			   struct btrfs_path *path)
>   {
> @@ -3390,6 +3464,16 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>   	}
>   	spin_unlock(&info->unused_bgs_lock);
>   
> +	mutex_lock(&info->reclaim_bgs_lock);
> +	while (!list_empty(&info->reclaim_bgs)) {
> +		block_group = list_first_entry(&info->reclaim_bgs,
> +					       struct btrfs_block_group,
> +					       bg_list);
> +		list_del_init(&block_group->bg_list);
> +		btrfs_put_block_group(block_group);
> +	}
> +	mutex_unlock(&info->reclaim_bgs_lock);
> +
>   	spin_lock(&info->block_group_cache_lock);
>   	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
>   		block_group = rb_entry(n, struct btrfs_block_group,
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 3ecc3372a5ce..e75c79676241 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -264,6 +264,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>   			     u64 group_start, struct extent_map *em);
>   void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
>   void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info);
> +void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg);
>   int btrfs_read_block_groups(struct btrfs_fs_info *info);
>   int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   			   u64 type, u64 chunk_offset, u64 size);
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 34ec82d6df3e..0b438b97fed4 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -938,6 +938,7 @@ struct btrfs_fs_info {
>   	struct list_head unused_bgs;
>   	struct mutex unused_bg_unpin_mutex;
>   	struct mutex reclaim_bgs_lock;
> +	struct list_head reclaim_bgs;
>   
>   	/* Cached block sizes */
>   	u32 nodesize;
> @@ -978,6 +979,8 @@ struct btrfs_fs_info {
>   	spinlock_t treelog_bg_lock;
>   	u64 treelog_bg;
>   
> +	int bg_reclaim_threshold;
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f9250f14fc1e..d4fccf113df1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1815,6 +1815,13 @@ static int cleaner_kthread(void *arg)
>   		 * unused block groups.
>   		 */
>   		btrfs_delete_unused_bgs(fs_info);
> +
> +		/*
> +		 * Reclaim block groups in the reclaim_bgs list after we deleted
> +		 * all unused block_groups. This possibly gives us some more free
> +		 * space.
> +		 */
> +		btrfs_reclaim_bgs(fs_info);

Reclaim can be a super long process, and we use the cleaner to keep up with 
other things, like delayed iputs and deleted snapshots.  I'd rather offload this 
to it's own worker thread so that the cleaner doesn't get bogged down in the 
relocation work.

>   sleep:
>   		clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags);
>   		if (kthread_should_park())
> @@ -2797,12 +2804,14 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   	mutex_init(&fs_info->reloc_mutex);
>   	mutex_init(&fs_info->delalloc_root_mutex);
>   	mutex_init(&fs_info->zoned_meta_io_lock);
> +	mutex_init(&fs_info->reclaim_bgs_lock);

You did this already in the first patch (in fact I had to go check I was so 
confused.)

<snip>

> +static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
> +					       struct kobj_attribute *a,
> +					       char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	ssize_t ret;
> +
> +	ret = scnprintf(buf, PAGE_SIZE, "%d\n", fs_info->bg_reclaim_threshold);
> +
> +	return ret;
> +}
> +
> +static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
> +						struct kobj_attribute *a,
> +						const char *buf, size_t len)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	int thresh;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 10, &thresh);
> +	if (ret)
> +		return ret;
> +
> +	if (thresh <= 50 || thresh > 100)
> +		return -EINVAL;

I think having an arbitrary floor is kind of user unfriendly, especially if say 
your workload is such that you end up with a bunch of 30% free chunks that keep 
you from doing anything.  If we're going to enforce a minimum min then we should 
at least have a printk if the thresh is below that minimum, and I think the min 
thresh should be at most 5 or 10%.  Thanks,

Josef

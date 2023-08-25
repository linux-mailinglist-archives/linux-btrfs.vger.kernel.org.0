Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA1787D14
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 03:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjHYBYI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 21:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjHYBX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 21:23:59 -0400
Received: from trager.us (trager.us [52.5.81.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D5E7D
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 18:23:57 -0700 (PDT)
Received: from c-73-11-250-112.hsd1.wa.comcast.net ([73.11.250.112] helo=[192.168.1.226])
        by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
        (Exim 4.92.3)
        (envelope-from <lee@trager.us>)
        id 1qZLYJ-0006OP-Ug
        for linux-btrfs@vger.kernel.org; Fri, 25 Aug 2023 01:23:56 +0000
Message-ID: <3127979c-8324-feda-4250-13c61117d0bf@trager.us>
Date:   Thu, 24 Aug 2023 18:23:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs: Allow online resize to use "min" shortcut
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20230825010542.4158944-1-lee@trager.us>
From:   Lee Trager <lee@trager.us>
In-Reply-To: <20230825010542.4158944-1-lee@trager.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> btrfs already supports online resize and has a "max" shortcut to expand to
> all available space on the disk. This creates a "min" shortcut which shrinks
> the filesystem to allocated space.
> Signed-off-by: Lee Trager <lee@trager.us>
> ---
>   fs/btrfs/ioctl.c   |  10 ++--
>   fs/btrfs/volumes.c | 123 ++++++++++++++++++++++++++++++++++++---------
>   fs/btrfs/volumes.h |   3 +-
>   3 files changed, 109 insertions(+), 27 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a895d105464b..c2bb6e18d80f 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1108,6 +1108,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   	int ret = 0;
>   	int mod = 0;
>   	bool cancel;
> +	bool to_min = false;
>   
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
> @@ -1165,9 +1166,12 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   		goto out_finish;
>   	}
>   
> -	if (!strcmp(sizestr, "max"))
> +	if (!strcmp(sizestr, "max")) {
>   		new_size = bdev_nr_bytes(device->bdev);
> -	else {
> +	} else if (!strcmp(sizestr, "min")) {
> +		to_min = true;
> +		new_size = SZ_256M;
> +	} else {
>   		if (sizestr[0] == '-') {
>   			mod = -1;
>   			sizestr++;
> @@ -1223,7 +1227,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
>   		ret = btrfs_grow_device(trans, device, new_size);
>   		btrfs_commit_transaction(trans);
>   	} else if (new_size < old_size) {
> -		ret = btrfs_shrink_device(device, new_size);
> +		ret = btrfs_shrink_device(device, &new_size, to_min);
>   	} /* equal, nothing need to do */
>   
>   	if (ret == 0 && new_size != old_size)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 733842136163..257e7f004ce7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2145,7 +2145,8 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
>   		mutex_unlock(&fs_info->chunk_mutex);
>   	}
>   
> -	ret = btrfs_shrink_device(device, 0);
> +	u64 size = 0;
> +	ret = btrfs_shrink_device(device, &size, false);
>   	if (ret)
>   		goto error_undo;
>   
> @@ -4816,12 +4817,74 @@ int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info)
>   	return 0;
>   }
>   
> +u64 btrfs_get_allocated_space(struct btrfs_fs_info *fs_info)
> +{
> +	u64 ret = 0;
> +	u64 metadata_ratio = 1;
> +	static const u64 types[] = {
> +		BTRFS_BLOCK_GROUP_DATA,
> +		BTRFS_BLOCK_GROUP_SYSTEM,
> +		BTRFS_BLOCK_GROUP_METADATA,
> +		BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_METADATA
> +	};
> +
> +	for (int i = 0; i < 4; i++) {
> +		struct btrfs_space_info *tmp = NULL;
> +		struct btrfs_space_info *info = NULL;
> +
> +		list_for_each_entry(tmp, &fs_info->space_info, list) {
> +			if (tmp->flags == types[i]) {
> +				info = tmp;
> +				break;
> +			}
> +		}
> +
> +		if (!info)
> +			continue;
> +
> +		down_read(&info->groups_sem);
> +		for (int c = 0; c < BTRFS_NR_RAID_TYPES; c++) {
> +			if (list_empty(&info->block_groups[c]))
> +				continue;
> +
> +			struct btrfs_block_group *bg;
> +			list_for_each_entry(bg, &info->block_groups[c], list) {
> +				enum btrfs_raid_types i;
> +				u64 ratio;
> +				i = btrfs_bg_flags_to_raid_index(bg->flags);
> +				ratio = btrfs_raid_array[i].ncopies;
> +				if (bg->flags & BTRFS_BLOCK_GROUP_DATA)
> +					ret += bg->length * ratio;
> +				if (bg->flags & BTRFS_BLOCK_GROUP_METADATA) {
> +					metadata_ratio = max(metadata_ratio, ratio);
> +					ret += bg->length * ratio;
> +				}
> +				if (bg->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +					ret += bg->length * ratio;
> +			}
> +		}
> +		up_read(&info->groups_sem);
> +	}
> +	/*
> +	* btrfs_shrink_device relocates chunks to shrink the filesystem. In
> +	* order to do so extra space must be reserved for metadata operations
> +	* which require 3 + num of devices with a minimum of metadata
> +	* duplication(default 2) as discovered above. See comment in
> +	* btrfs_trans_handle for a full explination.
> +	*/
> +	ret += btrfs_calc_insert_metadata_size(
> +		fs_info,
> +		3 + max(metadata_ratio, fs_info->fs_devices->total_devices));
> +
> +	return ret;
> +}
> +
>   /*
>    * shrinking a device means finding all of the device extents past
>    * the new size, and then following the back refs to the chunks.
>    * The chunk relocation code actually frees the device extent
>    */
> -int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
> +int btrfs_shrink_device(struct btrfs_device *device, u64 *new_size, bool to_min)
>   {
>   	struct btrfs_fs_info *fs_info = device->fs_info;
>   	struct btrfs_root *root = fs_info->dev_root;
> @@ -4842,10 +4905,6 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>   	u64 diff;
>   	u64 start;
>   
> -	new_size = round_down(new_size, fs_info->sectorsize);
> -	start = new_size;
> -	diff = round_down(old_size - new_size, fs_info->sectorsize);
> -
>   	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
>   		return -EINVAL;
>   
> @@ -4855,6 +4914,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>   
>   	path->reada = READA_BACK;
>   
> +again:
>   	trans = btrfs_start_transaction(root, 0);
>   	if (IS_ERR(trans)) {
>   		btrfs_free_path(path);
> @@ -4863,28 +4923,45 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>   
>   	mutex_lock(&fs_info->chunk_mutex);
>   
> -	btrfs_device_set_total_bytes(device, new_size);
> -	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> -		device->fs_devices->total_rw_bytes -= diff;
> -		atomic64_sub(diff, &fs_info->free_chunk_space);
> -	}
> -
>   	/*
> -	 * Once the device's size has been set to the new size, ensure all
> -	 * in-memory chunks are synced to disk so that the loop below sees them
> -	 * and relocates them accordingly.
> +	 * Ensure all in-memory chunks are synced to disk before calculating the
> +	 * new size to ensure the loop below can relocate them.
>   	 */
> -	if (contains_pending_extent(device, &start, diff)) {
> +	start = 0;
> +	if (contains_pending_extent(device, &start, old_size)) {
>   		mutex_unlock(&fs_info->chunk_mutex);
>   		ret = btrfs_commit_transaction(trans);
> -		if (ret)
> -			goto done;
> +		if (ret) {
> +			btrfs_free_path(path);
> +			return PTR_ERR(trans);
> +		}
> +		mutex_lock(&fs_info->chunk_mutex);
>   	} else {
> -		mutex_unlock(&fs_info->chunk_mutex);
>   		btrfs_end_transaction(trans);
>   	}
>   
> -again:
> +	if (to_min)
> +		*new_size = btrfs_get_allocated_space(fs_info);
> +
> +	*new_size = round_down(*new_size, fs_info->sectorsize);
> +	diff = round_down(old_size - *new_size, fs_info->sectorsize);
> +
> +	trans = btrfs_start_transaction(root, 0);
> +	if (IS_ERR(trans)) {
> +		mutex_unlock(&fs_info->chunk_mutex);
> +		btrfs_free_path(path);
> +		return PTR_ERR(trans);
> +	}
> +
> +	btrfs_device_set_total_bytes(device, *new_size);
> +	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> +		device->fs_devices->total_rw_bytes -= diff;
> +		atomic64_sub(diff, &fs_info->free_chunk_space);
> +	}
> +
> +	btrfs_end_transaction(trans);
> +	mutex_unlock(&fs_info->chunk_mutex);
> +
>   	key.objectid = device->devid;
>   	key.offset = (u64)-1;
>   	key.type = BTRFS_DEV_EXTENT_KEY;
> @@ -4920,7 +4997,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>   		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
>   		length = btrfs_dev_extent_length(l, dev_extent);
>   
> -		if (key.offset + length <= new_size) {
> +		if (key.offset + length <= *new_size) {
>   			mutex_unlock(&fs_info->reclaim_bgs_lock);
>   			btrfs_release_path(path);
>   			break;
> @@ -4973,10 +5050,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
>   
>   	mutex_lock(&fs_info->chunk_mutex);
>   	/* Clear all state bits beyond the shrunk device size */
> -	clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
> +	clear_extent_bits(&device->alloc_state, *new_size, (u64)-1,
>   			  CHUNK_STATE_MASK);
>   
> -	btrfs_device_set_disk_total_bytes(device, new_size);
> +	btrfs_device_set_disk_total_bytes(device, *new_size);
>   	if (list_empty(&device->post_commit_list))
>   		list_add_tail(&device->post_commit_list,
>   			      &trans->transaction->dev_update_list);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 2128a032c3b7..db8000b4cf94 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -636,7 +636,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
>   		      struct btrfs_device *device, u64 new_size);
>   struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
>   				       const struct btrfs_dev_lookup_args *args);
> -int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
> +int btrfs_shrink_device(struct btrfs_device *device, u64 *new_size, bool to_min);
>   int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
>   int btrfs_balance(struct btrfs_fs_info *fs_info,
>   		  struct btrfs_balance_control *bctl,
> @@ -648,6 +648,7 @@ int btrfs_pause_balance(struct btrfs_fs_info *fs_info);
>   int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset);
>   int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
>   int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
> +u64 btrfs_get_allocated_space(struct btrfs_fs_info *fs_info);
>   int btrfs_uuid_scan_kthread(void *data);
>   bool btrfs_chunk_writeable(struct btrfs_fs_info *fs_info, u64 chunk_offset);
>   void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
I plan on sending a follow up patch to optionally resize block groups to 
the amount of space used by data and metadata. This will allow the 
creation of small distributed btrfs OS images.

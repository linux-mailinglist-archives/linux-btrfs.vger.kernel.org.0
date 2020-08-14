Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94C52446A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHNIxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 04:53:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgHNIxY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 04:53:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6FABB64B;
        Fri, 14 Aug 2020 08:53:45 +0000 (UTC)
Subject: Re: [PATCH 4/7] btrfs: cleanup unused return in btrfs_close_devices
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20200814000352.124179-1-anand.jain@oracle.com>
 <20200814000352.124179-5-anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <31859c3a-f3b2-2628-f003-6fb243f71ff4@suse.com>
Date:   Fri, 14 Aug 2020 11:53:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814000352.124179-5-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.08.20 г. 3:03 ч., Anand Jain wrote:
> In the function btrfs_close_devices() and its helper function
> close_fs_devices(), the return value aren't used as there isn't error
> return from these functions. So clean up the return argument.
> 
> Also in the function btrfs_remove_chunk() remove the local variable
> %fs_devices, instead use the assigned pointer directly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 21 ++++++++-------------
>  fs/btrfs/volumes.h |  2 +-
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 66691416ca8f..dd867375478b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1148,12 +1148,12 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>  	ASSERT(atomic_read(&device->reada_in_flight) == 0);
>  }
>  
> -static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
> +static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
>  {
>  	struct btrfs_device *device, *tmp;
>  
>  	if (--fs_devices->opened > 0)
> -		return 0;
> +		return;
>  
>  	mutex_lock(&fs_devices->device_list_mutex);
>  	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list) {
> @@ -1165,17 +1165,14 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
>  	WARN_ON(fs_devices->rw_devices);
>  	fs_devices->opened = 0;
>  	fs_devices->seeding = false;
> -
> -	return 0;
>  }
>  
> -int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
> +void btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
>  {
>  	struct btrfs_fs_devices *seed_devices = NULL;
> -	int ret;
>  
>  	mutex_lock(&uuid_mutex);
> -	ret = close_fs_devices(fs_devices);
> +	close_fs_devices(fs_devices);
>  	if (!fs_devices->opened) {
>  		seed_devices = fs_devices->seed;
>  		fs_devices->seed = NULL;
> @@ -1188,7 +1185,6 @@ int btrfs_close_devices(struct btrfs_fs_devices *fs_devices)
>  		close_fs_devices(fs_devices);
>  		free_fs_devices(fs_devices);
>  	}
> -	return ret;
>  }
>  

This is the relevant portions which implement what's documented. Also I
have already sent similar cleanup on 15.07.

>  static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
> @@ -2933,7 +2929,6 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  	struct map_lookup *map;
>  	u64 dev_extent_len = 0;
>  	int i, ret = 0;
> -	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>  
>  	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
>  	if (IS_ERR(em)) {
> @@ -2955,14 +2950,14 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  	 * a device replace operation that replaces the device object associated
>  	 * with map stripes (dev-replace.c:btrfs_dev_replace_finishing()).
>  	 */
> -	mutex_lock(&fs_devices->device_list_mutex);
> +	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>  	for (i = 0; i < map->num_stripes; i++) {
>  		struct btrfs_device *device = map->stripes[i].dev;
>  		ret = btrfs_free_dev_extent(trans, device,
>  					    map->stripes[i].physical,
>  					    &dev_extent_len);
>  		if (ret) {
> -			mutex_unlock(&fs_devices->device_list_mutex);
> +			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>  			btrfs_abort_transaction(trans, ret);
>  			goto out;
>  		}
> @@ -2978,12 +2973,12 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
>  
>  		ret = btrfs_update_device(trans, device);
>  		if (ret) {
> -			mutex_unlock(&fs_devices->device_list_mutex);
> +			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>  			btrfs_abort_transaction(trans, ret);
>  			goto out;
>  		}
>  	}
> -	mutex_unlock(&fs_devices->device_list_mutex);
> +	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>  
>  	ret = btrfs_free_chunk(trans, chunk_offset);
>  	if (ret) {

This is unrelated cleanup...

> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 5eea93916fbf..76e5470e19a8 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -435,7 +435,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  struct btrfs_device *btrfs_scan_one_device(const char *path,
>  					   fmode_t flags, void *holder);
>  int btrfs_forget_devices(const char *path);
> -int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
> +void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
>  void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step);
>  void btrfs_assign_next_active_device(struct btrfs_device *device,
>  				     struct btrfs_device *this_dev);
> 

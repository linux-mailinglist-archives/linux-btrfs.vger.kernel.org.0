Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 359ED13451C
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgAHOfg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 09:35:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37669 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgAHOfg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 09:35:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so2932296qtk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jan 2020 06:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Oak77saPFh9FpbrA/8r7UTMXrGHB24DXlgFtM76HnAY=;
        b=KWkt231QEUirJIGrf4s4YPvvPBGS+3ll4a1V2rnrpu2Abr+o8tendtYPaAe671LMNl
         9lH7Dhz4mwzGsYs+2RdcSUpmXyWsyd1XVW8SeS5Avt76CGMrTb7p7anQT2GgxE5qv1Dp
         XFDdXe5XCnHx1Xw3U7WzLqaA8G/pYgom493yh7GWaFDsHQkzvDbrtvhUSgXzLlGA4kh6
         4qSS+vivGSmOQLwZazR5K96CLTDe13KjpWP/kmLzwQ9hH+VXbRzKRKFtBIqfqGpxA6uv
         Y4sj1EiDFFSYrQOXkTz5W94COuVVnif7tJVL4vBnFZF2a/xy2n9VdZHEqBcbFgvOt3RJ
         QLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oak77saPFh9FpbrA/8r7UTMXrGHB24DXlgFtM76HnAY=;
        b=Ky+JeivpuItM1/OaCfQW5XO9D+CLVbFVA9SLkJJWCtEWm37H/LwJGMxadY9P5zk8ZO
         boKb8Ex5RQwJ+1+3KR91c9+nCkt2NYkG8kpx1LwfEAkGUjH6C3lXBf4T4VMbSvBYhG7f
         KVdZ425ddFbiO5t3X2jKajLrizXYT/rAu2cbFbi6h1q3G8VOLAKP1mhWArMSwAeD6LEs
         bf8RzuJN0o1r5Ndsw8QQwgVm2jLeESZotuMYFMjiLZo85pEvEPsVbC4s9F/c/+8VzGsj
         FOkvgAoTKqUVyXgiLdW6Bi0mZ4ol1zMlP9CQYrpX3bXjgUW0kIhNKnGPr1P/ClZKlXPf
         ZdXw==
X-Gm-Message-State: APjAAAWqCERPHwqllPctYbqSV4PkxwOd4ogW6bRWVnx7XPdV/MfrOSRW
        aHagNZonGGax7KN7uenWCzYEcDOvdMvXRw==
X-Google-Smtp-Source: APXvYqw7+7W1AKqp/11XRcX2HQafexGJ9nxX1paWUh25YJUbidtjTMSS+9qzWCXS7VpcBlJBEUqZwg==
X-Received: by 2002:ac8:3946:: with SMTP id t6mr3796142qtb.278.1578494134549;
        Wed, 08 Jan 2020 06:35:34 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::f832])
        by smtp.gmail.com with ESMTPSA id r6sm1601507qtm.63.2020.01.08.06.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:35:33 -0800 (PST)
Subject: Re: [PATCH v4 3/3] btrfs: statfs: Use virtual chunk allocation to
 calculation available data space
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200108070509.25483-1-wqu@suse.com>
 <20200108070509.25483-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <81df707c-2286-0505-6f1b-2295e864238f@toxicpanda.com>
Date:   Wed, 8 Jan 2020 09:35:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108070509.25483-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/8/20 2:05 AM, Qu Wenruo wrote:
> Although btrfs_calc_avail_data_space() is trying to do an estimation
> on how many data chunks it can allocate, the estimation is far from
> perfect:
> 
> - Metadata over-commit is not considered at all
> - Chunk allocation doesn't take RAID5/6 into consideration
> 
> This patch will change btrfs_calc_avail_data_space() to use
> pre-calculated per-profile available space.
> 
> This provides the following benefits:
> - Accurate unallocated data space estimation, including RAID5/6
>    It's as accurate as chunk allocator, and can handle RAID5/6.
> 
> Although it still can't handle metadata over-commit that accurately, we
> still have fallback method for over-commit, by using factor based
> estimation.
> 
> The good news is, over-commit can only happen when we have enough
> unallocated space, so even we may not report byte accurate result when
> the fs is empty, the result will get more and more accurate when
> unallocated space is reducing.
> 
> So the metadata over-commit shouldn't cause too many problem.
> 
> Since we're keeping the old lock-free design, statfs should not experience
> any extra delay.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/super.c   | 174 +++++++++++----------------------------------
>   fs/btrfs/volumes.h |   4 ++
>   2 files changed, 47 insertions(+), 131 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f452a94abdc3..ecca25c40637 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1894,118 +1894,53 @@ static inline void btrfs_descending_sort_devices(
>    * The helper to calc the free space on the devices that can be used to store
>    * file data.
>    */
> -static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
> -					      u64 *free_bytes)
> +static u64 btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
> +				       u64 free_meta)
>   {
> -	struct btrfs_device_info *devices_info;
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> -	struct btrfs_device *device;
> -	u64 type;
> -	u64 avail_space;
> -	u64 min_stripe_size;
> -	int num_stripes = 1;
> -	int i = 0, nr_devices;
> -	const struct btrfs_raid_attr *rattr;
> +	enum btrfs_raid_types data_type;
> +	u64 data_profile = btrfs_data_alloc_profile(fs_info);
> +	u64 data_avail;
> +	u64 meta_rsv;
>   
> -	/*
> -	 * We aren't under the device list lock, so this is racy-ish, but good
> -	 * enough for our purposes.
> -	 */
> -	nr_devices = fs_info->fs_devices->open_devices;
> -	if (!nr_devices) {
> -		smp_mb();
> -		nr_devices = fs_info->fs_devices->open_devices;
> -		ASSERT(nr_devices);
> -		if (!nr_devices) {
> -			*free_bytes = 0;
> -			return 0;
> -		}
> -	}
> -
> -	devices_info = kmalloc_array(nr_devices, sizeof(*devices_info),
> -			       GFP_KERNEL);
> -	if (!devices_info)
> -		return -ENOMEM;
> -
> -	/* calc min stripe number for data space allocation */
> -	type = btrfs_data_alloc_profile(fs_info);
> -	rattr = &btrfs_raid_array[btrfs_bg_flags_to_raid_index(type)];
> -
> -	if (type & BTRFS_BLOCK_GROUP_RAID0)
> -		num_stripes = nr_devices;
> -	else if (type & BTRFS_BLOCK_GROUP_RAID1)
> -		num_stripes = 2;
> -	else if (type & BTRFS_BLOCK_GROUP_RAID1C3)
> -		num_stripes = 3;
> -	else if (type & BTRFS_BLOCK_GROUP_RAID1C4)
> -		num_stripes = 4;
> -	else if (type & BTRFS_BLOCK_GROUP_RAID10)
> -		num_stripes = 4;
> +	spin_lock(&fs_info->global_block_rsv.lock);
> +	meta_rsv = fs_info->global_block_rsv.size;
> +	spin_unlock(&fs_info->global_block_rsv.lock);
>   
> -	/* Adjust for more than 1 stripe per device */
> -	min_stripe_size = rattr->dev_stripes * BTRFS_STRIPE_LEN;
> +	data_type = btrfs_bg_flags_to_raid_index(data_profile);
>   
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
> -		if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
> -						&device->dev_state) ||
> -		    !device->bdev ||
> -		    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
> -			continue;
> +	spin_lock(&fs_devices->per_profile_lock);
> +	data_avail = fs_devices->per_profile_avail[data_type];
> +	spin_unlock(&fs_devices->per_profile_lock);
>   
> -		if (i >= nr_devices)
> -			break;
> -
> -		avail_space = device->total_bytes - device->bytes_used;
> -
> -		/* align with stripe_len */
> -		avail_space = rounddown(avail_space, BTRFS_STRIPE_LEN);
> -
> -		/*
> -		 * In order to avoid overwriting the superblock on the drive,
> -		 * btrfs starts at an offset of at least 1MB when doing chunk
> -		 * allocation.
> -		 *
> -		 * This ensures we have at least min_stripe_size free space
> -		 * after excluding 1MB.
> -		 */
> -		if (avail_space <= SZ_1M + min_stripe_size)
> -			continue;
> -
> -		avail_space -= SZ_1M;
> -
> -		devices_info[i].dev = device;
> -		devices_info[i].max_avail = avail_space;
> -
> -		i++;
> -	}
> -	rcu_read_unlock();
> -
> -	nr_devices = i;
> -
> -	btrfs_descending_sort_devices(devices_info, nr_devices);
> -
> -	i = nr_devices - 1;
> -	avail_space = 0;
> -	while (nr_devices >= rattr->devs_min) {
> -		num_stripes = min(num_stripes, nr_devices);
> -
> -		if (devices_info[i].max_avail >= min_stripe_size) {
> -			int j;
> -			u64 alloc_size;
> -
> -			avail_space += devices_info[i].max_avail * num_stripes;
> -			alloc_size = devices_info[i].max_avail;
> -			for (j = i + 1 - num_stripes; j <= i; j++)
> -				devices_info[j].max_avail -= alloc_size;
> -		}
> -		i--;
> -		nr_devices--;
> +	/*
> +	 * We have meta over-committed, do some wild guess using factor.
> +	 *
> +	 * To get an accurate result, we should allocate a metadata virtual
> +	 * chunk first, then allocate data virtual chunks to get real
> +	 * estimation.
> +	 * But that needs chunk_mutex, which could be very slow to accquire.
> +	 *
> +	 * So here we trade for non-blocking statfs. And meta over-committing is
> +	 * less a problem because:
> +	 * - Meta over-commit only happens when we have unallocated space
> +	 *   So no over-commit if we're low on available space.
> +	 *
> +	 * This may not be as accurate as virtual chunk based one, but it
> +	 * should be good enough for statfs usage.
> +	 */
> +	if (free_meta < meta_rsv) {
> +		u64 meta_needed = meta_rsv - free_meta;
> +		int data_factor = btrfs_bg_type_to_factor(data_profile);
> +		int meta_factor = btrfs_bg_type_to_factor(
> +				btrfs_metadata_alloc_profile(fs_info));
> +
> +		if (data_avail < meta_needed * meta_factor / data_factor)
> +			data_avail = 0;
> +		else
> +			data_avail -= meta_needed * meta_factor / data_factor;
>   	}
> -
> -	kfree(devices_info);
> -	*free_bytes = avail_space;
> -	return 0;
> +	return data_avail;
>   }
>   
>   /*
> @@ -2033,8 +1968,6 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>   	__be32 *fsid = (__be32 *)fs_info->fs_devices->fsid;
>   	unsigned factor = 1;
>   	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
> -	int ret;
> -	u64 thresh = 0;
>   	int mixed = 0;
>   
>   	rcu_read_lock();
> @@ -2082,31 +2015,10 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>   		buf->f_bfree = 0;
>   	spin_unlock(&block_rsv->lock);
>   
> -	buf->f_bavail = div_u64(total_free_data, factor);
> -	ret = btrfs_calc_avail_data_space(fs_info, &total_free_data);
> -	if (ret)
> -		return ret;
> -	buf->f_bavail += div_u64(total_free_data, factor);
> +	buf->f_bavail = btrfs_calc_avail_data_space(fs_info, total_free_meta);
> +	if (buf->f_bavail > 0)
> +		buf->f_bavail += total_free_data;

I'm not sure I understand this, we're only including the free space of already 
allocated data extents _if_ we have free data chunks?  That doesn't seem right, 
shouldn't we always have buf->f_bavail = total_free_data and then we add 
whatever comes from btrfs_calc_avail_data_space()?  Thanks,

Josef

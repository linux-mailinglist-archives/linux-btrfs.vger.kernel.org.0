Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5077B19B74B
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbgDAUxs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 16:53:48 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:45212 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732345AbgDAUxr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 16:53:47 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id JkMqjcb9cMAUpJkMqj6HL8; Wed, 01 Apr 2020 22:53:44 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1585774424; bh=Y+go1Ynp4WhnSnPYIxdYLIB9NkSr5bslyu7dkey5m+8=;
        h=From;
        b=XB3v1OhrYomslxmnwm1X8G79kmrscfQR6OFgp8t9I+3KjjM7RH41VrJb+syo4/srH
         tdagOoGohWrcqULjFFi0QcF22EaDYpqqA79g8o/ukubW5WyUi+Fee3I9C58nOr162r
         FgSuXPCqKYZ8w/nkwx0WQNtQzLmxA2qzrTgk/rHXUMAw9rmyv2elAs08/kV9hcfTk7
         +6G2JM9PjMvtNmFrQyFlZfyRaeO/qySfEmXLrYCN6tVMkOlcwNvpfQFv5UShgGQCsQ
         EC3T7ienpWylF0Ub3x6w6n4i1otRL5iA1gbBMuHY3BnHiH4LrgnsB3X6bh8w34ccD0
         yLeXx/t3OCEIw==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=nL03y3121NLUYnUhPDEA:9
 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
References: <20200401200316.9917-1-kreijack@libero.it>
 <20200401200316.9917-2-kreijack@libero.it>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <bf452ce0-84f6-a1da-f583-cce409d47138@inwind.it>
Date:   Wed, 1 Apr 2020 22:53:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401200316.9917-2-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFVrsBd4TKgIJFYOfZtCa6n9auVkw9SyJ8JHOuL/Pn94o0hYaKxIPI0bY7UCwoUv42hj1/53/Fyue0woi5CIZguVgqBk1tGslvbg9fxLbK8GR+N397qk
 9ZDODJLqgIsLH+lGwynUBUS2G/1c9nWPamOe0nJegZBNAf4gtqnj38yxQF9IYI84tyRcYLy5wOQhiTug+eM4lGU3BtfN+ijwiP0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/1/20 10:03 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> When this mode is enabled, the allocation policy of the chunk
> is so modified:
> - when a metadata chunk is allocated, priority is given to
> ssd disk.
> - When a data chunk is allocated, priority is given to a
> rotational disk.
> 
> When a striped profile is involved (like RAID0,5,6), the logic
> is a bit more complex. If there are enough disks, the data profiles
> are stored on the rotational disks only; the metadata profiles
> are stored on the non rotational disk only.
> If the disks are not enough, then the profiles is stored on all
> the disks.
> 
> Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are
> rotational ones.
> A data profile raid5, will be stored on sda, sdb, sdc, sde, sdf (sde
> and sdf are not enough to host a raid5 profile).
> A metadata profile raid5, will be stored on sda, sdb, sdc (these
> are enough to host a raid5 profile).

The example is a bit wrong. Replace raid5 with raid6. However I
hope that the sense is still understandable.

> 
> To enable this mode pass -o ssd_metadata at mount time.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>   fs/btrfs/ctree.h   |  1 +
>   fs/btrfs/super.c   |  8 +++++
>   fs/btrfs/volumes.c | 89 ++++++++++++++++++++++++++++++++++++++++++++--
>   fs/btrfs/volumes.h |  1 +
>   4 files changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2e9f938508e9..0f3c09cc4863 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1187,6 +1187,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>   #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
>   #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>   #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
> +#define BTRFS_MOUNT_SSD_METADATA	(1 << 29)
>   
>   #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>   #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index c6557d44907a..d0a5cf496f90 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -346,6 +346,7 @@ enum {
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	Opt_ref_verify,
>   #endif
> +	Opt_ssd_metadata,
>   	Opt_err,
>   };
>   
> @@ -416,6 +417,7 @@ static const match_table_t tokens = {
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	{Opt_ref_verify, "ref_verify"},
>   #endif
> +	{Opt_ssd_metadata, "ssd_metadata"},
>   	{Opt_err, NULL},
>   };
>   
> @@ -853,6 +855,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>   			btrfs_set_opt(info->mount_opt, REF_VERIFY);
>   			break;
>   #endif
> +		case Opt_ssd_metadata:
> +			btrfs_set_and_info(info, SSD_METADATA,
> +					"enabling ssd_metadata");
> +			break;
>   		case Opt_err:
>   			btrfs_info(info, "unrecognized mount option '%s'", p);
>   			ret = -EINVAL;
> @@ -1369,6 +1375,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>   #endif
>   	if (btrfs_test_opt(info, REF_VERIFY))
>   		seq_puts(seq, ",ref_verify");
> +	if (btrfs_test_opt(info, SSD_METADATA))
> +		seq_puts(seq, ",ssd_metadata");
>   	seq_printf(seq, ",subvolid=%llu",
>   		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
>   	seq_puts(seq, ",subvol=");
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a8b71ded4d21..678dc3366711 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4758,6 +4758,58 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
>   	return 0;
>   }
>   
> +/*
> + * sort the devices in descending order by rotational,
> + * max_avail, total_avail
> + */
> +static int btrfs_cmp_device_info_metadata(const void *a, const void *b)
> +{
> +	const struct btrfs_device_info *di_a = a;
> +	const struct btrfs_device_info *di_b = b;
> +
> +	/* metadata -> non rotational first */
> +	if (!di_a->rotational && di_b->rotational)
> +		return -1;
> +	if (di_a->rotational && !di_b->rotational)
> +		return 1;
> +	if (di_a->max_avail > di_b->max_avail)
> +		return -1;
> +	if (di_a->max_avail < di_b->max_avail)
> +		return 1;
> +	if (di_a->total_avail > di_b->total_avail)
> +		return -1;
> +	if (di_a->total_avail < di_b->total_avail)
> +		return 1;
> +	return 0;
> +}
> +
> +/*
> + * sort the devices in descending order by !rotational,
> + * max_avail, total_avail
> + */
> +static int btrfs_cmp_device_info_data(const void *a, const void *b)
> +{
> +	const struct btrfs_device_info *di_a = a;
> +	const struct btrfs_device_info *di_b = b;
> +
> +	/* data -> non rotational last */
> +	if (!di_a->rotational && di_b->rotational)
> +		return 1;
> +	if (di_a->rotational && !di_b->rotational)
> +		return -1;
> +	if (di_a->max_avail > di_b->max_avail)
> +		return -1;
> +	if (di_a->max_avail < di_b->max_avail)
> +		return 1;
> +	if (di_a->total_avail > di_b->total_avail)
> +		return -1;
> +	if (di_a->total_avail < di_b->total_avail)
> +		return 1;
> +	return 0;
> +}
> +
> +
> +
>   static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
>   {
>   	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> @@ -4805,6 +4857,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	int i;
>   	int j;
>   	int index;
> +	int nr_rotational;
>   
>   	BUG_ON(!alloc_profile_is_valid(type, 0));
>   
> @@ -4860,6 +4913,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   	 * about the available holes on each device.
>   	 */
>   	ndevs = 0;
> +	nr_rotational = 0;
>   	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
>   		u64 max_avail;
>   		u64 dev_offset;
> @@ -4911,14 +4965,45 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>   		devices_info[ndevs].max_avail = max_avail;
>   		devices_info[ndevs].total_avail = total_avail;
>   		devices_info[ndevs].dev = device;
> +		devices_info[ndevs].rotational = !test_bit(QUEUE_FLAG_NONROT,
> +				&(bdev_get_queue(device->bdev)->queue_flags));
> +		if (devices_info[ndevs].rotational)
> +			nr_rotational++;
>   		++ndevs;
>   	}
>   
> +	BUG_ON(nr_rotational > ndevs);
>   	/*
>   	 * now sort the devices by hole size / available space
>   	 */
> -	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> -	     btrfs_cmp_device_info, NULL);
> +	if (((type & BTRFS_BLOCK_GROUP_DATA) &&
> +	     (type & BTRFS_BLOCK_GROUP_METADATA)) ||
> +	    !btrfs_test_opt(info, SSD_METADATA)) {
> +		/* mixed bg or SSD_METADATA not set */
> +		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +			     btrfs_cmp_device_info, NULL);
> +	} else {
> +		/*
> +		 * if SSD_METADATA is set, sort the device considering also the
> +		 * kind (ssd or not). Limit the availables devices to the ones
> +		 * of the same kind, to avoid that a striped profile like raid5
> +		 * spans to all kind of devices (ssd and rotational).
> +		 * It is allowed to span different kind of devices if the ones of
> +		 * the same kind are not enough alone.
> +		 */
> +		if (type & BTRFS_BLOCK_GROUP_DATA) {
> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +				     btrfs_cmp_device_info_data, NULL);
> +			if (nr_rotational > devs_min)

It should be
			if (nr_rotational >= devs_min)

> +				ndevs = nr_rotational;
> +		} else {
> +			int nr_norot = ndevs - nr_rotational;
> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +				     btrfs_cmp_device_info_metadata, NULL);
> +			if (nr_norot > devs_min)

It should be
			if (nr_nonrot >= devs_min)



> +				ndevs = nr_norot;
> +		}
> +	}
>   
>   	/*
>   	 * Round down to number of usable stripes, devs_increment can be any
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index fc1b564b9cfe..bc1cfa0c27ea 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -340,6 +340,7 @@ struct btrfs_device_info {
>   	u64 dev_offset;
>   	u64 max_avail;
>   	u64 total_avail;
> +	int rotational:1;
>   };
>   
>   struct btrfs_raid_attr {
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

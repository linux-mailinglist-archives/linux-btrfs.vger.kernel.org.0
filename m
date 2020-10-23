Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81011296A48
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374119AbgJWHXa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 03:23:30 -0400
Received: from out20-110.mail.aliyun.com ([115.124.20.110]:60655 "EHLO
        out20-110.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374114AbgJWHXa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 03:23:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436283|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.032776-0.000749784-0.966474;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.InK4HsI_1603437805;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.InK4HsI_1603437805)
          by smtp.aliyun-inc.com(10.147.40.2);
          Fri, 23 Oct 2020 15:23:26 +0800
Date:   Fri, 23 Oct 2020 15:23:30 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Goffredo Baroncelli <kreijack@libero.it>
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
Cc:     linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <20200405082636.18016-2-kreijack@libero.it>
References: <20200405082636.18016-1-kreijack@libero.it> <20200405082636.18016-2-kreijack@libero.it>
Message-Id: <20201023152329.E7FF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Goffredo Baroncelli 

We can move 'rotational of struct btrfs_device_info' to  'bool rotating
of struct btrfs_device'.

1, it will be more close to 'bool rotating of struct btrfs_fs_devices'.

2, it maybe used to enhance the path of '[PATCH] btrfs: balance RAID1/RAID10 mirror selection'.
https://lore.kernel.org/linux-btrfs/3bddd73e-cb60-b716-4e98-61ff24beb570@oracle.com/T/#t

Best Regards
王玉贵
2020/10/23

> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> When this mode is enabled, the allocation policy of the chunk
> is so modified:
> - allocation of metadata chunk: priority is given to ssd disk.
> - allocation of data chunk: priority is given to a rotational disk.
> 
> When a striped profile is involved (like RAID0,5,6), the logic
> is a bit more complex. If there are enough disks, the data profiles
> are stored on the rotational disks only; instead the metadata profiles
> are stored on the non rotational disk only.
> If the disks are not enough, then the profiles is stored on all
> the disks.
> 
> Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are
> rotational ones.
> A data profile raid6, will be stored on sda, sdb, sdc, sde, sdf (sde
> and sdf are not enough to host a raid5 profile).
> A metadata profile raid6, will be stored on sda, sdb, sdc (these
> are enough to host a raid6 profile).
> 
> To enable this mode pass -o ssd_metadata at mount time.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/super.c   |  8 +++++
>  fs/btrfs/volumes.c | 89 ++++++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/volumes.h |  1 +
>  4 files changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 36df977b64d9..773c7f8b0b0d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1236,6 +1236,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>  #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
> +#define BTRFS_MOUNT_SSD_METADATA	(1 << 30)
>  
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 67c63858812a..4ad14b0a57b3 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -350,6 +350,7 @@ enum {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	Opt_ref_verify,
>  #endif
> +	Opt_ssd_metadata,
>  	Opt_err,
>  };
>  
> @@ -421,6 +422,7 @@ static const match_table_t tokens = {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	{Opt_ref_verify, "ref_verify"},
>  #endif
> +	{Opt_ssd_metadata, "ssd_metadata"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -872,6 +874,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  			btrfs_set_opt(info->mount_opt, REF_VERIFY);
>  			break;
>  #endif
> +		case Opt_ssd_metadata:
> +			btrfs_set_and_info(info, SSD_METADATA,
> +					"enabling ssd_metadata");
> +			break;
>  		case Opt_err:
>  			btrfs_info(info, "unrecognized mount option '%s'", p);
>  			ret = -EINVAL;
> @@ -1390,6 +1396,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  #endif
>  	if (btrfs_test_opt(info, REF_VERIFY))
>  		seq_puts(seq, ",ref_verify");
> +	if (btrfs_test_opt(info, SSD_METADATA))
> +		seq_puts(seq, ",ssd_metadata");
>  	seq_printf(seq, ",subvolid=%llu",
>  		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
>  	seq_puts(seq, ",subvol=");
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9cfc668f91f4..ffb2bc912c43 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4761,6 +4761,58 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
>  	return 0;
>  }
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
>  static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
>  {
>  	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> @@ -4808,6 +4860,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>  	int i;
>  	int j;
>  	int index;
> +	int nr_rotational;
>  
>  	BUG_ON(!alloc_profile_is_valid(type, 0));
>  
> @@ -4863,6 +4916,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>  	 * about the available holes on each device.
>  	 */
>  	ndevs = 0;
> +	nr_rotational = 0;
>  	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
>  		u64 max_avail;
>  		u64 dev_offset;
> @@ -4914,14 +4968,45 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>  		devices_info[ndevs].max_avail = max_avail;
>  		devices_info[ndevs].total_avail = total_avail;
>  		devices_info[ndevs].dev = device;
> +		devices_info[ndevs].rotational = !test_bit(QUEUE_FLAG_NONROT,
> +				&(bdev_get_queue(device->bdev)->queue_flags));
> +		if (devices_info[ndevs].rotational)
> +			nr_rotational++;
>  		++ndevs;
>  	}
>  
> +	BUG_ON(nr_rotational > ndevs);
>  	/*
>  	 * now sort the devices by hole size / available space
>  	 */
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
> +		 * spread to all kind of devices (ssd and rotational).
> +		 * It is allowed to use different kinds of devices if the ones
> +		 * of the same kind are not enough alone.
> +		 */
> +		if (type & BTRFS_BLOCK_GROUP_DATA) {
> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +				     btrfs_cmp_device_info_data, NULL);
> +			if (nr_rotational >= devs_min)
> +				ndevs = nr_rotational;
> +		} else {
> +			int nr_norot = ndevs - nr_rotational;
> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +				     btrfs_cmp_device_info_metadata, NULL);
> +			if (nr_norot >= devs_min)
> +				ndevs = nr_norot;
> +		}
> +	}
>  
>  	/*
>  	 * Round down to number of usable stripes, devs_increment can be any
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index f01552a0785e..285d71d54a03 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -343,6 +343,7 @@ struct btrfs_device_info {
>  	u64 dev_offset;
>  	u64 max_avail;
>  	u64 total_avail;
> +	int rotational:1;
>  };
>  
>  struct btrfs_raid_attr {
> -- 
> 2.26.0

--------------------------------------
北京京垓科技有限公司
王玉贵	wangyugui@e16-tech.com
电话：+86-136-71123776


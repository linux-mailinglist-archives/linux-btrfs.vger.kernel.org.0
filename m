Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2681E6E4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 00:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436838AbgE1WCt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 18:02:49 -0400
Received: from syrinx.knorrie.org ([82.94.188.77]:53358 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436834AbgE1WCa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 18:02:30 -0400
X-Greylist: delayed 3531 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 18:02:28 EDT
Received: from [IPv6:2a02:a213:2b80:f000::12] (unknown [IPv6:2a02:a213:2b80:f000::12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 15AA260924D04;
        Fri, 29 May 2020 00:02:24 +0200 (CEST)
Subject: Re: [PATCH 4/4] btrfs: add preferred_metadata mode
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200528183451.16654-1-kreijack@libero.it>
 <20200528183451.16654-5-kreijack@libero.it>
From:   Hans van Kranenburg <hans@knorrie.org>
Autocrypt: addr=hans@knorrie.org; keydata=
 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
Message-ID: <61d2188a-290c-5d6f-ec32-6cacd3f63ce8@knorrie.org>
Date:   Fri, 29 May 2020 00:02:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200528183451.16654-5-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 5/28/20 8:34 PM, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> When this mode is enabled,

The commit message does not mention if this is either only a convenience
during development and testing of the feature to be able to quickly turn
it on/off, or if you intend to have this into the final change set.

> the allocation policy of the chunk
> is so modified:
> - allocation of metadata chunk: priority is given to preferred_metadata
>   disks.
> - allocation of data chunk: priority is given to a non preferred_metadata
>   disk.
> 
> When a striped profile is involved (like RAID0,5,6), the logic
> is a bit more complex. If there are enough disks, the data profiles
> are stored on the non preferred_metadata disks; instead the metadata
> profiles are stored on the preferred_metadata disk.
> If the disks are not enough, then the profile is allocated on all
> the disks.
> 
> Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are
> non preferred_metadata ones.
> A data profile raid6, will be stored on sda, sdb, sdc, sde, sdf (sde
> and sdf are not enough to host a raid5 profile).
> A metadata profile raid6, will be stored on sda, sdb, sdc (these
> are enough to host a raid6 profile).
> 
> To enable this mode pass -o dedicated_metadata at mount time.

Is it dedicated_metadata or preferred_metadata?

> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/super.c   |  8 +++++
>  fs/btrfs/volumes.c | 89 ++++++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/volumes.h |  1 +
>  4 files changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 03ea7370aea7..779760fd27b1 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1239,6 +1239,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>  #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
> +#define BTRFS_MOUNT_PREFERRED_METADATA	(1 << 30)
>  
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 438ecba26557..80700dc9dcf8 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -359,6 +359,7 @@ enum {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	Opt_ref_verify,
>  #endif
> +	Opt_preferred_metadata,
>  	Opt_err,
>  };
>  
> @@ -430,6 +431,7 @@ static const match_table_t tokens = {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	{Opt_ref_verify, "ref_verify"},
>  #endif
> +	{Opt_preferred_metadata, "preferred_metadata"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -881,6 +883,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
>  			btrfs_set_opt(info->mount_opt, REF_VERIFY);
>  			break;
>  #endif
> +		case Opt_preferred_metadata:
> +			btrfs_set_and_info(info, PREFERRED_METADATA,
> +					"enabling preferred_metadata");
> +			break;
>  		case Opt_err:
>  			btrfs_err(info, "unrecognized mount option '%s'", p);
>  			ret = -EINVAL;
> @@ -1403,6 +1409,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  #endif
>  	if (btrfs_test_opt(info, REF_VERIFY))
>  		seq_puts(seq, ",ref_verify");
> +	if (btrfs_test_opt(info, PREFERRED_METADATA))
> +		seq_puts(seq, ",preferred_metadata");
>  	seq_printf(seq, ",subvolid=%llu",
>  		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
>  	seq_puts(seq, ",subvol=");
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5265f54c2931..c68efb15e473 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4770,6 +4770,56 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
>  	return 0;
>  }
>  
> +/*
> + * sort the devices in descending order by preferred_metadata,
> + * max_avail, total_avail
> + */
> +static int btrfs_cmp_device_info_metadata(const void *a, const void *b)
> +{
> +	const struct btrfs_device_info *di_a = a;
> +	const struct btrfs_device_info *di_b = b;
> +
> +	/* metadata -> preferred_metadata first */
> +	if (di_a->preferred_metadata && !di_b->preferred_metadata)
> +		return -1;
> +	if (!di_a->preferred_metadata && di_b->preferred_metadata)
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
> + * sort the devices in descending order by !preferred_metadata,
> + * max_avail, total_avail
> + */
> +static int btrfs_cmp_device_info_data(const void *a, const void *b)
> +{
> +	const struct btrfs_device_info *di_a = a;
> +	const struct btrfs_device_info *di_b = b;
> +
> +	/* data -> preferred_metadata last */
> +	if (di_a->preferred_metadata && !di_b->preferred_metadata)
> +		return 1;
> +	if (!di_a->preferred_metadata && di_b->preferred_metadata)
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
>  static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
>  {
>  	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> @@ -4885,6 +4935,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  	int ndevs = 0;
>  	u64 max_avail;
>  	u64 dev_offset;
> +	int nr_preferred_metadata = 0;
>  
>  	/*
>  	 * in the first pass through the devices list, we gather information
> @@ -4937,15 +4988,49 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>  		devices_info[ndevs].max_avail = max_avail;
>  		devices_info[ndevs].total_avail = total_avail;
>  		devices_info[ndevs].dev = device;
> +		devices_info[ndevs].preferred_metadata = !!(device->type &
> +			BTRFS_DEV_PREFERRED_METADATA);
> +		if (devices_info[ndevs].preferred_metadata)
> +			nr_preferred_metadata++;
>  		++ndevs;
>  	}
>  	ctl->ndevs = ndevs;
>  
> +	BUG_ON(nr_preferred_metadata > ndevs);
>  	/*
>  	 * now sort the devices by hole size / available space
>  	 */
> -	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> -	     btrfs_cmp_device_info, NULL);
> +	if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
> +	     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
> +	    !btrfs_test_opt(info, PREFERRED_METADATA)) {
> +		/* mixed bg or PREFERRED_METADATA not set */
> +		sort(devices_info, ctl->ndevs, sizeof(struct btrfs_device_info),
> +			     btrfs_cmp_device_info, NULL);
> +	} else {
> +		/*
> +		 * if PREFERRED_METADATA is set, sort the device considering
> +		 * also the kind (preferred_metadata or not). Limit the
> +		 * availables devices to the ones of the same kind, to avoid
> +		 * that a striped profile, like raid5, spreads to all kind of
> +		 * devices.
> +		 * It is allowed to use different kinds of devices if the ones
> +		 * of the same kind are not enough alone.
> +		 */
> +		if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
> +			int nr_data = ctl->ndevs - nr_preferred_metadata;
> +			sort(devices_info, ctl->ndevs,
> +				     sizeof(struct btrfs_device_info),
> +				     btrfs_cmp_device_info_data, NULL);
> +			if (nr_data >= ctl->devs_min)
> +				ctl->ndevs = nr_data;
> +		} else { /* non data -> metadata and system */
> +			sort(devices_info, ctl->ndevs,
> +				     sizeof(struct btrfs_device_info),
> +				     btrfs_cmp_device_info_metadata, NULL);
> +			if (nr_preferred_metadata >= ctl->devs_min)
> +				ctl->ndevs = nr_preferred_metadata;
> +		}
> +	}
>  
>  	return 0;
>  }
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 0ac5bf2b95e6..d39c3b0e7569 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -347,6 +347,7 @@ struct btrfs_device_info {
>  	u64 dev_offset;
>  	u64 max_avail;
>  	u64 total_avail;
> +	int preferred_metadata:1;
>  };
>  
>  struct btrfs_raid_attr {
> 


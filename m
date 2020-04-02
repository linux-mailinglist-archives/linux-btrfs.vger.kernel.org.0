Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9599A19C887
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388714AbgDBSHf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 14:07:35 -0400
Received: from corp-mailer.zoner.com ([217.198.120.77]:47095 "EHLO
        corp-mailer.zoner.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBSHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 14:07:34 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 14:07:31 EDT
Received: from [10.1.0.143] (gw-sady.zoner.com [217.198.112.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by corp-mailer.zoner.com (Postfix) with ESMTPSA id 8ABC51F02A;
        Thu,  2 Apr 2020 20:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoner.cz;
        s=zcdkim1-3eaw95axkb5rfp; t=1585850517;
        bh=rMKWnC7qSKsuMHsmAH/vJHCXjIpr2Xkz6HPJe9/ZduE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vhbPlLo3jgu75fPhtlVp/Ji8txAVnDz0xoPi7JaSCtDURH3Lk6StPOeaAFeUi2o+K
         yfGjSy9+OVnx0sFqhBqGVesS0ljcjS6XnTXHGVps7oGvTsKw8TNwOEchJtirNAYKcL
         cwvrvnVkas2zWskmAJkV6zZdaaQX0TjG3Y6x9vuBsnIRCOGasP3rziPYupMSWqVyJh
         69TtfwK+eKxUbbDNCFZHM5stwzlFGVCdObO9yX5LmnW90Dk5M76Y9YETqqwVkJTLT3
         Q+cIprRT+LhAoBWHDGXGbKFxdbQJyHEgv6g4iplXoY6fuRoVx+pWFNJey3BIupsHa1
         ETQBNaXHW+VkA==
Subject: Re: [PATCH] btrfs: add ssd_metadata mode
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
References: <20200401200316.9917-1-kreijack@libero.it>
 <20200401200316.9917-2-kreijack@libero.it>
From:   Martin Svec <martin.svec@zoner.cz>
Autocrypt: addr=martin.svec@zoner.cz; prefer-encrypt=mutual; keydata=
 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
 KvHiauE9QtI=
Message-ID: <2e9ce481-3d6f-67d3-06fc-afa89563aff0@zoner.cz>
Date:   Thu, 2 Apr 2020 20:01:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401200316.9917-2-kreijack@libero.it>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Content-Language: cs
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Goffredo,

we're using similar in-house patch on our backup servers for years and th=
e performance impact is
HUGE. Or backup workload includes rsyncs of mailservers/webservers and im=
age-based CBT vSphere
backups, we've hundreds of millions of files and thousands of daily snaps=
hots on every backup
server. Nothing of this would be possible without dedicated metadata SSDs=
=2E A typical btrfs backup
server has two 500 GB NVMe SSDs in btrfs RAID1 and twelve 10TB SATA drive=
s in hardware RAID6.

Our chunk allocation logic is fairly simple: if btrfs contains both rotat=
ional and non-rotational
drives and there's a metadata chunk allocation request, ignore rotational=
 drives in
__btrfs_alloc_chunk(); in the same way, ignore non-rotational drives when=
 allocating a data chunk.
If the allocation request cannot be satisfied, fallback to the standard _=
_btrfs_alloc_chunk()
implementation which uses all available drives.

Martin

Dne 1.4.2020 v 22:03 Goffredo Baroncelli napsal(a):
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
>
> To enable this mode pass -o ssd_metadata at mount time.
>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/super.c   |  8 +++++
>  fs/btrfs/volumes.c | 89 ++++++++++++++++++++++++++++++++++++++++++++--=

>  fs/btrfs/volumes.h |  1 +
>  4 files changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2e9f938508e9..0f3c09cc4863 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1187,6 +1187,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const stru=
ct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
>  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
> +#define BTRFS_MOUNT_SSD_METADATA	(1 << 29)
> =20
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index c6557d44907a..d0a5cf496f90 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -346,6 +346,7 @@ enum {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	Opt_ref_verify,
>  #endif
> +	Opt_ssd_metadata,
>  	Opt_err,
>  };
> =20
> @@ -416,6 +417,7 @@ static const match_table_t tokens =3D {
>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	{Opt_ref_verify, "ref_verify"},
>  #endif
> +	{Opt_ssd_metadata, "ssd_metadata"},
>  	{Opt_err, NULL},
>  };
> =20
> @@ -853,6 +855,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info=
, char *options,
>  			btrfs_set_opt(info->mount_opt, REF_VERIFY);
>  			break;
>  #endif
> +		case Opt_ssd_metadata:
> +			btrfs_set_and_info(info, SSD_METADATA,
> +					"enabling ssd_metadata");
> +			break;
>  		case Opt_err:
>  			btrfs_info(info, "unrecognized mount option '%s'", p);
>  			ret =3D -EINVAL;
> @@ -1369,6 +1375,8 @@ static int btrfs_show_options(struct seq_file *se=
q, struct dentry *dentry)
>  #endif
>  	if (btrfs_test_opt(info, REF_VERIFY))
>  		seq_puts(seq, ",ref_verify");
> +	if (btrfs_test_opt(info, SSD_METADATA))
> +		seq_puts(seq, ",ssd_metadata");
>  	seq_printf(seq, ",subvolid=3D%llu",
>  		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
>  	seq_puts(seq, ",subvol=3D");
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a8b71ded4d21..678dc3366711 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4758,6 +4758,58 @@ static int btrfs_cmp_device_info(const void *a, =
const void *b)
>  	return 0;
>  }
> =20
> +/*
> + * sort the devices in descending order by rotational,
> + * max_avail, total_avail
> + */
> +static int btrfs_cmp_device_info_metadata(const void *a, const void *b=
)
> +{
> +	const struct btrfs_device_info *di_a =3D a;
> +	const struct btrfs_device_info *di_b =3D b;
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
> +	const struct btrfs_device_info *di_a =3D a;
> +	const struct btrfs_device_info *di_b =3D b;
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
>  static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64=
 type)
>  {
>  	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> @@ -4805,6 +4857,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans=
_handle *trans,
>  	int i;
>  	int j;
>  	int index;
> +	int nr_rotational;
> =20
>  	BUG_ON(!alloc_profile_is_valid(type, 0));
> =20
> @@ -4860,6 +4913,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans=
_handle *trans,
>  	 * about the available holes on each device.
>  	 */
>  	ndevs =3D 0;
> +	nr_rotational =3D 0;
>  	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) =
{
>  		u64 max_avail;
>  		u64 dev_offset;
> @@ -4911,14 +4965,45 @@ static int __btrfs_alloc_chunk(struct btrfs_tra=
ns_handle *trans,
>  		devices_info[ndevs].max_avail =3D max_avail;
>  		devices_info[ndevs].total_avail =3D total_avail;
>  		devices_info[ndevs].dev =3D device;
> +		devices_info[ndevs].rotational =3D !test_bit(QUEUE_FLAG_NONROT,
> +				&(bdev_get_queue(device->bdev)->queue_flags));
> +		if (devices_info[ndevs].rotational)
> +			nr_rotational++;
>  		++ndevs;
>  	}
> =20
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
> +		 * spans to all kind of devices (ssd and rotational).
> +		 * It is allowed to span different kind of devices if the ones of
> +		 * the same kind are not enough alone.
> +		 */
> +		if (type & BTRFS_BLOCK_GROUP_DATA) {
> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +				     btrfs_cmp_device_info_data, NULL);
> +			if (nr_rotational > devs_min)
> +				ndevs =3D nr_rotational;
> +		} else {
> +			int nr_norot =3D ndevs - nr_rotational;
> +			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +				     btrfs_cmp_device_info_metadata, NULL);
> +			if (nr_norot > devs_min)
> +				ndevs =3D nr_norot;
> +		}
> +	}
> =20
>  	/*
>  	 * Round down to number of usable stripes, devs_increment can be any
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index fc1b564b9cfe..bc1cfa0c27ea 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -340,6 +340,7 @@ struct btrfs_device_info {
>  	u64 dev_offset;
>  	u64 max_avail;
>  	u64 total_avail;
> +	int rotational:1;
>  };
> =20
>  struct btrfs_raid_attr {




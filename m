Return-Path: <linux-btrfs+bounces-21310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG6WD7/wgWlAMwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21310-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 13:57:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF072D977B
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B728230268EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 12:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC0346AFC;
	Tue,  3 Feb 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWA9psnI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EBA3446A7
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123434; cv=none; b=InnWD+ns0zLuHK2Mh56VYag8WyCKYGXD5NsSPDTNwiYuq2vuXBgU0lMF+mXushI981FevXuo/Xt32hL7Qj0m9d9jcvGbr7t1m7u89NhPAurwZWxAwNBg/9tBIz5ROf1x8azIzyWEyGJmcxF+jzldGtLL8Pl+jCMk45st4Akpsro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123434; c=relaxed/simple;
	bh=7TxOSXZ8HOkaRBT/XMQjWKq8ate6yhweBjDsr4qdF/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZubNOz0kngFAzPoV1Kihx9VuRv2vl5aSyty/Z3KTU3aYbaR7CQT5VrdJFTm8qrrN/jjWcowaG4ybbJk2hQ9WbHOkj9qOZDvOnc+u/KNmRVrut6n/yJq17DRB/CUAd0yx14Nk+ptO3+P50gUpFEWylBEeLZrZMXV2oswkHZkjvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWA9psnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED32C116D0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770123434;
	bh=7TxOSXZ8HOkaRBT/XMQjWKq8ate6yhweBjDsr4qdF/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CWA9psnIRDdrAh15bqXrdPNRCKfQWFQqXlns2Dc8VRfCzCaBag5IDWfSgeqCLmMqp
	 2/fF9wUvbtXRlC3XkBQ2O0CD43loEx4OLddZMTbHLfOEnd9mzW97miStRGRrizsIjB
	 B3BIM7WQsv1ewUtBRjOwm+DVQuTF3VJ0MIRFsjddk8+WOcBrkIYf3LzjEOx4SKzwgj
	 4X0cke9mcrLRPDrW7wWePfH0JqI4/h4LUeghyWGzVyPTh0Jaz0LCOP8SW2Au0J8Ezb
	 Wqxksdlc6G2ugNk3i0uCmm/jROdvx3Tt4dd0z/GtatZj7bDK7KAdQYrCTG4inRuC2h
	 SVKLbpiomPoAQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-659428faa2bso431714a12.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 04:57:14 -0800 (PST)
X-Gm-Message-State: AOJu0Yx0QcK3yOl5Dy06mW7ZuE4JkbhXukJhUHridIcMVrf6AoikdDJN
	zo3fVNnH0O9RmqIvti8c818M88GRUDfAYv5sFr+qxvfsa4WHAm4INZWR0VlYw+SPqwGsGlx7RUc
	dAYyyRZrb2qiuh/UUR3hCO2hW4dFNndQ=
X-Received: by 2002:a17:907:846:b0:b7d:1cbb:5deb with SMTP id
 a640c23a62f3a-b8dff5bfd66mr981521866b.27.1770123432580; Tue, 03 Feb 2026
 04:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770087101.git.wqu@suse.com> <eb573bac21a16092d8e9f64533c6b0d6ed6b16a4.1770087101.git.wqu@suse.com>
In-Reply-To: <eb573bac21a16092d8e9f64533c6b0d6ed6b16a4.1770087101.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Feb 2026 12:56:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6udGEXLxX_GWcSzD+T8hChfA5bPC5aYysqp9zOeuu3hA@mail.gmail.com>
X-Gm-Features: AZwV_QgDh3DCHDbPq1fb5Gj9ofwUVohU3TvK-WxXIknVadBmmoJLs8g_AafaN6I
Message-ID: <CAL3q7H6udGEXLxX_GWcSzD+T8hChfA5bPC5aYysqp9zOeuu3hA@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: introduce the device layout aware per-profile
 available space
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21310-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: CF072D977B
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:01=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a long known bug that if metadata is using RAID1 on two disks
> with unbalanced sizes, there is a very high chance to hit ENOSPC related
> transaction abort.
>
> [CAUSE]
> The root cause is in the available space estimation code:
>
> - Factor based calculation
>   Just use all unallocated space, divide by the profile factor
>   One obvious user is can_overcommit().
>
> This can not handle the following example:
>
>   devid 1 unallocated:  1GiB
>   devid 2 unallocated:  50GiB
>   metadata type:        RAID1
>
> If using factor based estimation, we can use (1GiB + 50GiB) / 2 =3D 25.5G=
iB
> free space for metadata.
> Thus we can continue allocating metadata (over-commit) way beyond the
> 1GiB limit.
>
> But this estimation is completely wrong, in reality we can only allocate
> one single 1GiB RAID1 block group, thus if we continue over-commit, at
> one time we will hit ENOSPC at some critical path and flips the fs
> read-only.
>
> [SOLUTION]
> This patch will introduce per-profile available space estimation,
> which can provide chunk-allocator like behavior to give a (mostly)
> accurate result, with under-estimate corner cases.
>
> There are some differences between the estimation and real chunk
> allocator:
>
> - No consideration on hole size
>   It's fine for most cases, as all data/metadata strips are in 1GiB size
>   thus there should not be any hole wasting much space.
>
>   And chunk allocator is able to use smaller stripes when there is
>   really no other choice.
>
>   Although in theory this means it can lead to some over-estimation, it
>   should not cause too much hassle in the real world.
>
>   The other benefit of such behavior is, we avoid dev-extent tree search
>   completely, thus the overhead is very small.
>
> - No true balance for certain cases
>   If we have 3 disks RAID1, and each device has 2GiB unallocated space,
>   we can load balance the chunk allocation so that we can allocate 3GiB
>   RAID1 chunks, and that's what chunk allocator will do.
>
>   But this current estimation code is using the largest available space
>   to do a single allocation. Meaning the estimation will be 2GiB, thus
>   under estimate.
>
>   Such under estimation is fine and after the first chunk allocation, the
>   estimation will be updated and still give a correct 2GiB
>   estimation.
>   So this only means the estimation will be a little conservative, which
>   is safer for call sites like metadata over-commit check.
>
> With that facility, for above 1GiB + 50GiB case, it will give a RAID1
> estimation of 1GiB, instead of the incorrect 25.5GiB.
>
> Or for a more complex example:
>   devid 1 unallocated:  1T
>   devid 2 unallocated:  1T
>   devid 3 unallocated:  10T
>
> We will get an array of:
>   RAID10:       2T
>   RAID1:        2T
>   RAID1C3:      1T
>   RAID1C4:      0  (not enough devices)
>   DUP:          6T
>   RAID0:        3T
>   SINGLE:       12T
>   RAID5:        1T
>   RAID6:        0  (not enough devices)
>
> [IMPLEMENTATION]
> And for the each profile , we go chunk allocator level calculation:
> The pseudo code looks like:
>
>   clear_virtual_used_space_of_all_rw_devices();
>   do {
>         /*
>          * The same as chunk allocator, despite used space,
>          * we also take virtual used space into consideration.
>          */
>         sort_device_with_virtual_free_space();
>
>         /*
>          * Unlike chunk allocator, we don't need to bother hole/stripe
>          * size, so we use the smallest device to make sure we can
>          * allocated as many stripes as regular chunk allocator
>          */
>         stripe_size =3D device_with_smallest_free->avail_space;
>         stripe_size =3D min(stripe_size, to_alloc / ndevs);
>
>         /*
>          * Allocate a virtual chunk, allocated virtual chunk will
>          * increase virtual used space, allow next iteration to
>          * properly emulate chunk allocator behavior.
>          */
>         ret =3D alloc_virtual_chunk(stripe_size, &allocated_size);
>         if (ret =3D=3D 0)
>                 avail +=3D allocated_size;
>   } while (ret =3D=3D 0)
>
> As we always select the device with least free space, the device with
> the most space will be the first to be utilized, just like chunk
> allocator.
> For above 1T + 10T device, we will allocate a 1T virtual chunk
> in the first iteration, then run out of device in next iteration.
>
> Thus only get 1T free space for RAID1 type, just like what chunk
> allocator would do.
>
> This minimal available space based calculation is not perfect, but the
> important part is, the estimation is never exceeding the real available
> space.
>
> This patch just introduces the infrastructure, no hooks are executed
> yet.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 153 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  30 +++++++++
>  2 files changed, 183 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f281d113519b..2348d4d5e0b5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5372,6 +5372,159 @@ static int btrfs_cmp_device_info(const void *a, c=
onst void *b)
>         return 0;
>  }
>
> +/*
> + * Return 0 if we allocated any ballon(*) chunk, and restore the size to
> + * @allocated (the last parameter).
> + * Return -ENOSPC if we have no more space to allocate virtual chunk
> + *
> + * *: Ballon chunks are space holder for per-profile available space all=
ocator.
> + *    Ballon chunks won't really take on-disk space, but only to emulate
> + *    chunk allocator behavior to get accurate estimation on available s=
pace.
> + */
> +static int alloc_virtual_chunk(struct btrfs_fs_info *fs_info,
> +                              struct btrfs_device_info *devices_info,
> +                              enum btrfs_raid_types type,
> +                              u64 *allocated)
> +{
> +       const struct btrfs_raid_attr *raid_attr =3D &btrfs_raid_array[typ=
e];
> +       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> +       struct btrfs_device *device;
> +       u64 stripe_size;
> +       int i;

Can and should be declared in the loop.

> +       int ndevs =3D 0;
> +
> +       lockdep_assert_held(&fs_info->chunk_mutex);
> +
> +       /* Go through devices to collect their unallocated space */

Sentences should end with punctuation.

> +       list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_li=
st) {
> +               u64 avail;
> +
> +               if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
> +                                       &device->dev_state) ||
> +                   test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_st=
ate))
> +                       continue;
> +
> +               if (device->total_bytes > device->bytes_used +
> +                               device->per_profile_allocated)
> +                       avail =3D device->total_bytes - device->bytes_use=
d -
> +                               device->per_profile_allocated;
> +               else
> +                       avail =3D 0;
> +
> +               /* And exclude the [0, 1M) reserved space */

End with punctuation.

> +               if (avail > SZ_1M)
> +                       avail -=3D SZ_1M;

Use BTRFS_DEVICE_RANGE_RESERVED instead.

> +               else
> +                       avail =3D 0;
> +
> +               if (avail < fs_info->sectorsize)
> +                       continue;
> +               /*
> +                * Unlike chunk allocator, we don't care about stripe or =
hole
> +                * size, so here we use @avail directly

Same here, missing ending punctuation.

> +                */
> +               devices_info[ndevs].dev_offset =3D 0;
> +               devices_info[ndevs].total_avail =3D avail;
> +               devices_info[ndevs].max_avail =3D avail;
> +               devices_info[ndevs].dev =3D device;
> +               ++ndevs;
> +       }
> +       sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
> +            btrfs_cmp_device_info, NULL);
> +       ndevs =3D rounddown(ndevs, raid_attr->devs_increment);
> +       if (ndevs < raid_attr->devs_min)
> +               return -ENOSPC;
> +       if (raid_attr->devs_max)
> +               ndevs =3D min(ndevs, (int)raid_attr->devs_max);
> +       else
> +               ndevs =3D min(ndevs, (int)BTRFS_MAX_DEVS(fs_info));
> +
> +       /*
> +        * Now allocate a virtual chunk using the unallocated space of th=
e
> +        * device with the least unallocated space.
> +        */
> +       stripe_size =3D round_down(devices_info[ndevs - 1].total_avail,
> +                                fs_info->sectorsize);
> +       for (i =3D 0; i < ndevs; i++)

for (int i =3D 0; ....

> +               devices_info[i].dev->per_profile_allocated +=3D stripe_si=
ze;
> +       *allocated =3D stripe_size * (ndevs - raid_attr->nparity) /
> +                    raid_attr->ncopies;
> +       return 0;
> +}
> +
> +static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
> +                                 enum btrfs_raid_types type,
> +                                 u64 *result_ret)
> +{
> +       struct btrfs_device_info *devices_info =3D NULL;
> +       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> +       struct btrfs_device *device;
> +       u64 allocated;
> +       u64 result =3D 0;
> +       int ret =3D 0;
> +
> +       lockdep_assert_held(&fs_info->chunk_mutex);
> +       ASSERT(type >=3D 0 && type < BTRFS_NR_RAID_TYPES);
> +
> +       /* Not enough devices, quick exit, just update the result */

End with punctuation.

> +       if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min)
> +               goto out;

Misses setting ret to -ENOSPC.

> +
> +       devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_=
info),
> +                              GFP_NOFS);
> +       if (!devices_info) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +       /* Clear virtual chunk used space for each device */

Missing punctuation again.

> +       list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_li=
st)
> +               device->per_profile_allocated =3D 0;
> +
> +       while (!alloc_virtual_chunk(fs_info, devices_info, type, &allocat=
ed))
> +               result +=3D allocated;

This can take some time, so:

1) Have a cond_resched() call here somewhere.

2) Compute only for the profiles we are using instead of all possible
profiles - we can determine which ones are in use by oring
fs_info->avail_data_alloc_bits, fs_info->avail_metadata_alloc_bits and
fs_info->avail_system_alloc_bits.


> +
> +out:
> +       kfree(devices_info);
> +       if (ret < 0 && ret !=3D -ENOSPC)
> +               return ret;
> +       *result_ret =3D result;
> +       return 0;
> +}
> +
> +/* Update the per-profile available space array. */
> +void btrfs_update_per_profile_avail(struct btrfs_fs_info *fs_info)
> +{
> +       u64 results[BTRFS_NR_RAID_TYPES];
> +       int i =3D 0;

Can and should be declared in the loop.

> +       int ret;
> +
> +       /*
> +        * Zoned is more complex as we can not simply get the amount of
> +        * available space for each device.
> +        */
> +       if (btrfs_is_zoned(fs_info))
> +               goto error;
> +
> +       for (; i < BTRFS_NR_RAID_TYPES; i++) {

for (int i =3D 0; ....

> +               ret =3D calc_one_profile_avail(fs_info, i, &results[i]);
> +               if (ret < 0)
> +                       goto error;
> +       }
> +
> +       spin_lock(&fs_info->fs_devices->per_profile_lock);
> +       for (i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {

for (int i =3D 0; ...

> +               fs_info->fs_devices->per_profile_avail[i] =3D results[i];
> +               set_bit(i, &fs_info->fs_devices->per_profile_uptodate);

There's no need for the bitfield.
To indicate the values are not computed/valid we could set each
element of fs_info->fs_devices->per_profile_avail[] to U64_MAX for
example, it would avoid increasing further the size of struct fs_info.

Thanks.

> +       }
> +       spin_unlock(&fs_info->fs_devices->per_profile_lock);
> +       return;
> +error:
> +       spin_lock(&fs_info->fs_devices->per_profile_lock);
> +       bitmap_clear(&fs_info->fs_devices->per_profile_uptodate, 0,
> +                    BTRFS_NR_RAID_TYPES);
> +       spin_unlock(&fs_info->fs_devices->per_profile_lock);
> +}
> +
>  static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 t=
ype)
>  {
>         if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index ebc85bf53ee7..ecb5ad9cf249 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -22,6 +22,7 @@
>  #include <uapi/linux/btrfs_tree.h>
>  #include "messages.h"
>  #include "extent-io-tree.h"
> +#include "fs.h"
>
>  struct block_device;
>  struct bdev_handle;
> @@ -213,6 +214,12 @@ struct btrfs_device {
>
>         /* Bandwidth limit for scrub, in bytes */
>         u64 scrub_speed_max;
> +
> +       /*
> +        * A temporary number of allocated space during per-profile
> +        * available space calculation.
> +        */
> +       u64 per_profile_allocated;

As this is used temporarily only for the calculation, I wonder if this
could be placed in struct btrfs_device_info instead.
Because btrfs_device is long lived while btrfs_device_info is always
short lived (and we use an array of such and allocate it in
calc_one_profile_avail()).

Thanks.

>  };
>
>  /*
> @@ -458,6 +465,11 @@ struct btrfs_fs_devices {
>         /* Device to be used for reading in case of RAID1. */
>         u64 read_devid;
>  #endif
> +
> +       u64 per_profile_avail[BTRFS_NR_RAID_TYPES];
> +       /* Records per-type available space estimation. */
> +       spinlock_t per_profile_lock;
> +       unsigned long per_profile_uptodate;
>  };
>
>  #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)       \
> @@ -886,6 +898,24 @@ int btrfs_bg_type_to_factor(u64 flags);
>  const char *btrfs_bg_type_to_raid_name(u64 flags);
>  int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
>  bool btrfs_verify_dev_items(const struct btrfs_fs_info *fs_info);
> +void btrfs_update_per_profile_avail(struct btrfs_fs_info *fs_info);
> +
> +static inline bool btrfs_get_per_profile_avail(struct btrfs_fs_info *fs_=
info,
> +                                              u64 profile, u64 *avail_re=
t)
> +{
> +       enum btrfs_raid_types index =3D btrfs_bg_flags_to_raid_index(prof=
ile);
> +       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> +       bool uptodate =3D false;
> +
> +       spin_lock(&fs_devices->per_profile_lock);
> +       if (test_bit(index, &fs_devices->per_profile_uptodate)) {
> +               uptodate =3D true;
> +               *avail_ret =3D fs_devices->per_profile_avail[index];
> +       }
> +       spin_unlock(&fs_info->fs_devices->per_profile_lock);
> +       return uptodate;
> +}
> +
>  bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
>
>  bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
> --
> 2.52.0
>
>


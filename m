Return-Path: <linux-btrfs+bounces-21365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPjgCzpqg2l+mgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21365-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:48:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5DE9630
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 179F63051560
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E5A41B357;
	Wed,  4 Feb 2026 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR5xhzKn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2142D8DA8
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219742; cv=none; b=CG7sGdXDzzZ5Qq4BmCji1+nyimz7c7/7vmsKilDzU8lmK/GeRxfgFuAeOmZuSIMJrUhTBW4krNtLohdHkKghbvkbdTxVnT3jG5acgbGLdOXb8ejINVCZFjCsgwKG/WeVLtYA7io569I6F5BznHMRqDT8uLWg33gmxkykscBKoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219742; c=relaxed/simple;
	bh=3SyugdkbB82VK81UmdhG60igoVE4RR++NsDRvL3zjA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ44V2UDtEsS5laXpN9+AWE2VLfO/yXU1POSr/LYTWa3cBQREpcokJne0cs2czrYCcVSvjNlUjADb+rbP8WwOPnNQnX7fvHY+EU2+0fS7V5EJUf7DjN7bNUV338btqeHdeXLOeZj8g3MLy5WSrM7nFhCd1j00usGtZLoMM+LU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR5xhzKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AD6C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770219741;
	bh=3SyugdkbB82VK81UmdhG60igoVE4RR++NsDRvL3zjA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dR5xhzKngbT66ZPCE2S1anJh0mHnjFTqhRWXMuymth1usA3LzSn5475oQK5bJBqGR
	 DBjY1cwyStulqByh+LofKwevqe1SlITxW3QzLjkYpvv6Fc5sIhJ9Y85uIOq5oXAI0+
	 z7du4R+qLmz6GIyi0jpzSEVOzUS6MKZ14oRbyRjy6SLKzcfnYhO4+kCSDjiZhRHeN7
	 i6sPNZPVJgPSm8VdaDZ/ndAmZl2h1Rg47kGIB3XC1b4fU0JYmIm4Mnynp1i2IT9mJk
	 NP6s74qMVq8AGY4x3n3cflSqu1Omc/3tfCIWarL44peePt6Zi1b3d66BpEi2ONmGLq
	 vshKdbPRzQjLg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8838339fc6so329966b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 07:42:21 -0800 (PST)
X-Gm-Message-State: AOJu0YyPPoRGhj7w/KJIxzFRTv4f55puzGyauYlMRYF09mHn7TR2dBHb
	THC+h+LlmmgcYDx+pfDfN5FQt3pptB2tyvO6bC3Tr5nJ4jMu3slxbjNGo7MnZJPfUaAAIWnpDFh
	04rBfocGK8HCGlh1xZK/9rTSQmLc7VYM=
X-Received: by 2002:a17:907:6095:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b8e83478f9amr485137566b.0.1770219740364; Wed, 04 Feb 2026
 07:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770173615.git.wqu@suse.com> <ef73e5bf75b19e839f68c018596f10437a8ba23b.1770173615.git.wqu@suse.com>
In-Reply-To: <ef73e5bf75b19e839f68c018596f10437a8ba23b.1770173615.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 4 Feb 2026 15:41:41 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7jbOvQbeWMpJjvA8tUiQYFwTB-GBpHY4=v4dvQZUyxnw@mail.gmail.com>
X-Gm-Features: AZwV_QgnD6auABIBoiI8d0OGJpMz0e9C8uFOv6q-PC9l1wjZe44Q8s3qLa7w9do
Message-ID: <CAL3q7H7jbOvQbeWMpJjvA8tUiQYFwTB-GBpHY4=v4dvQZUyxnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btrfs: introduce the device layout aware
 per-profile available space
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21365-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AF5DE9630
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 2:55=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
>   RAID5:        2T
>   RAID6:        1T
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
> This minimal available space based calculation is not perfect, but the
> important part is, the estimation is never exceeding the real available
> space.
>
> This patch just introduces the infrastructure, no hooks are executed
> yet.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 163 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  34 ++++++++++
>  2 files changed, 197 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f281d113519b..a28e7400e8dc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5372,6 +5372,169 @@ static int btrfs_cmp_device_info(const void *a, c=
onst void *b)
>         return 0;
>  }
>
> +/*
> + * Return 0 if we allocated any virtual(*) chunk, and restore the size t=
o
> + * @allocated.
> + * Return -ENOSPC if we have no more space to allocate virtual chunk
> + *
> + * *: A virtual chunk is a chunk that only exists during per-profile ava=
ilable
> + *    estimation.
> + *    Those numbers won't really take on-disk space, but only to emulate
> + *    chunk allocator behavior to get accurate estimation on available s=
pace.
> + *
> + *    Another different is, a virtual chunk has no size limit and doesn'=
t care

different -> difference

> + *    about the hole size in device tree, allowing us to exhause device =
space

just say "doesn't care about holes in the device tree".

exhause -> exhaust

Otherwise it looks fine, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> + *    much faster.
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
> +       int ndevs =3D 0;
> +
> +       lockdep_assert_held(&fs_info->chunk_mutex);
> +
> +       /* Go through devices to collect their unallocated space. */
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
> +               avail =3D round_down(avail, fs_info->sectorsize);
> +
> +               /* And exclude the [0, 1M) reserved space. */
> +               if (avail > BTRFS_DEVICE_RANGE_RESERVED)
> +                       avail -=3D BTRFS_DEVICE_RANGE_RESERVED;
> +               else
> +                       avail =3D 0;
> +
> +               /*
> +                * Not enough to support a single stripe, this device
> +                * can not be utilized for chunk allocation.
> +                */
> +               if (avail < BTRFS_STRIPE_LEN)
> +                       continue;
> +
> +               /*
> +                * Unlike chunk allocator, we don't care about stripe or =
hole
> +                * size, so here we use @avail directly.
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
> +        * Stripe size will be determined by the device with the least
> +        * unallocated space.
> +        */
> +       stripe_size =3D devices_info[ndevs - 1].total_avail;
> +
> +       for (int i =3D 0; i < ndevs; i++)
> +               devices_info[i].dev->per_profile_allocated +=3D stripe_si=
ze;
> +       *allocated =3D div_u64(stripe_size * (ndevs - raid_attr->nparity)=
,
> +                            raid_attr->ncopies);
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
> +       /* Not enough devices, quick exit, just update the result. */
> +       if (fs_devices->rw_devices < btrfs_raid_array[type].devs_min) {
> +               ret =3D -ENOSPC;
> +               goto out;
> +       }
> +
> +       devices_info =3D kcalloc(fs_devices->rw_devices, sizeof(*devices_=
info),
> +                              GFP_NOFS);
> +       if (!devices_info) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +       /* Clear virtual chunk used space for each device. */
> +       list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_li=
st)
> +               device->per_profile_allocated =3D 0;
> +
> +       while (!alloc_virtual_chunk(fs_info, devices_info, type, &allocat=
ed))
> +               result +=3D allocated;
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
> +       int ret;
> +
> +       /*
> +        * Zoned is more complex as we can not simply get the amount of
> +        * available space for each device.
> +        */
> +       if (btrfs_is_zoned(fs_info))
> +               goto error;
> +
> +       for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
> +               ret =3D calc_one_profile_avail(fs_info, i, &results[i]);
> +               if (ret < 0)
> +                       goto error;
> +       }
> +
> +       spin_lock(&fs_info->fs_devices->per_profile_lock);
> +       for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++)
> +               fs_info->fs_devices->per_profile_avail[i] =3D results[i];
> +       spin_unlock(&fs_info->fs_devices->per_profile_lock);
> +       return;
> +error:
> +       spin_lock(&fs_info->fs_devices->per_profile_lock);
> +       for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++)
> +               fs_info->fs_devices->per_profile_avail[i] =3D U64_MAX;
> +       spin_unlock(&fs_info->fs_devices->per_profile_lock);
> +}
> +
>  static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 t=
ype)
>  {
>         if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index ebc85bf53ee7..3dde32143058 100644
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
>  };
>
>  /*
> @@ -458,6 +465,15 @@ struct btrfs_fs_devices {
>         /* Device to be used for reading in case of RAID1. */
>         u64 read_devid;
>  #endif
> +
> +       /*
> +        * Each value indicates the available space for that profile.
> +        * U64_MAX means the estimation is unavailable.
> +        *
> +        * Protected by per_profile_lock;
> +        */
> +       u64 per_profile_avail[BTRFS_NR_RAID_TYPES];
> +       spinlock_t per_profile_lock;
>  };
>
>  #define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)       \
> @@ -886,6 +902,24 @@ int btrfs_bg_type_to_factor(u64 flags);
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
> +       if (fs_devices->per_profile_avail[index] !=3D U64_MAX) {
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


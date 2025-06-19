Return-Path: <linux-btrfs+bounces-14781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F972AE0277
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 12:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1A65A0FA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B42021FF3E;
	Thu, 19 Jun 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a89g0nwr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B081321E08B
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328142; cv=none; b=uYECpmZb3wwMxZcfkImfNp3zKcH0hmqmkTxg8oAx9xq6Y2BWTBMhaIQnCMMbQL9mIwssy7pxZED+LVw7VEKOL6IG0MdooPSrK/sqLKbD64Sb6XyIuffpkN1jez1/aJ+3NbLa44MuKm2NRVcFbg46nTnCEz6UAHidDDBH6sKZ/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328142; c=relaxed/simple;
	bh=srBJP86Q27CsOhHG1iOek/1aAPiBY7r4cWNPaDM6fUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZjDsptMiR130T/6LbvVrRxa6dJQWwEeX3pxJPVv+G93pLQHZ9/MIZ9ZzyKYi1WsYWVaWzSDJp3mTg5ob6SS/rJHLdzg1u/FAYfA8q+hW2II2reXR49RbfPZeSvFer+ykWtNyJIa8wxfwhA9phu1YZlK3TW7d6JKQQorIBqoEV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a89g0nwr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-adb4e36904bso121894066b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750328137; x=1750932937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M7fOpUChmMFiK47PAsHqzJpTdgemGmW6O5AILNxZmhc=;
        b=a89g0nwrEBBnM1bcw2NeF+OSSBfdZPIPqyN/vSfZDPUmZF4j2CKxhNFocZeGxsm+R/
         7Hil8ScEfGor0jeuliuQ0vvi/cHMNQXoYj2qumiawYZfxPKQepjIgIe8ZDBE25vjiX0e
         BzgXBNhejLhgS4tdKSYbRRti7cn9NG3Ri+ZZ9QWcbkabTv5Zs3so34LhHxrnEhhIC+mb
         5hqtHEdP1shMGPYNavVNK+6vmFuxVCbZqTNPAivAQKZaSpEe2HSlZl4nkFjkSFvZq09R
         fiCcIWPJJenKMgpyKSZ++DOmjqcX5C7WXEQyju5BC/eP+SEJjjZGBKpFaX4WUDZz0P+L
         F6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750328137; x=1750932937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7fOpUChmMFiK47PAsHqzJpTdgemGmW6O5AILNxZmhc=;
        b=bwxq40ZNzTJg3f4lBBeeNluEVbCXyJgI+1m8q+zt2PBBeso7j1aOJftZB540DJml5s
         4iYKZFXO8iUr/T2bYlwygUeY4iSfLaluWVqGnOH7fOP+qhu+WoSn15Xb1YaD9pto7+Sw
         lEM6dLg7qAdWQn8+iDF4zPZyV1mZKYw2ZBiZOnfF5qPC5FAYN1psUN9ThWJdIqf0CJ6L
         RDD0UsdSQlsYa4NXn7s+pHtuuxspF8UmJvaqULOMiDYE60pn9F4Q2ICn6i3C2m3yKn72
         V6Vpqa9/lvqqTZD1TS6NeIBwMuA2qzl4oqvw5yqp/0nmz7QXabjG8TSYd+pi/UKM/rg4
         fFnw==
X-Gm-Message-State: AOJu0Yz5uz+S27huPFuYRVFYDPr2i5dwNjFKPmqmd8Dsy7f1q3qb8Dpo
	kERriy+whJzzK4GTd4g58gGyGlVpG0uGGIdyWyNhLWslrQrOllOXc41kMP6YTst+AI5mGP8FJzR
	iRFLMBO3JjROmwLAlQ+tSxiz7UNbv5qYR0AahKbjVfQ==
X-Gm-Gg: ASbGncv951EHMvHo9ySINKEcOv1afU2uYP2isCf5SeBYSTyWoYjYAFUYSi1rUE4V+4u
	H4TiV7lrXtsg/oaO643BT4UecEoOiDkaagwCO7eDdfbE4+yeIqzhHogF8jU7UqQOsd1bXtvPl8V
	Fl+DfZj2w7tYUuRmLDVlDRf9xbBf7SHeHmFrLndFdvgg==
X-Google-Smtp-Source: AGHT+IFSjI2voKpAZl2R+oSR0hLkjHotp7ifSU171ctOX+K9mvUpajrRbigSx9bXPcUYi3VDhI+0bZD/aoHkSqRvkzo=
X-Received: by 2002:a17:907:3e06:b0:ad8:a512:a9ea with SMTP id
 a640c23a62f3a-adfad3eac68mr1513369866b.8.1750328136713; Thu, 19 Jun 2025
 03:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750244832.git.dsterba@suse.com> <6d43001159c86467bfa1afe928deade5805af8fe.1750244832.git.dsterba@suse.com>
In-Reply-To: <6d43001159c86467bfa1afe928deade5805af8fe.1750244832.git.dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 19 Jun 2025 12:15:25 +0200
X-Gm-Features: Ac12FXyYAS1E-LuNdAH2ZrUwTFJwOgPug-GrGPz4HlihsBdampnFSQ8lmYDQsrU
Message-ID: <CAPjX3FeGLSJ2WFJqdN12saSEAeBYObsoJdttYiA=iDZNMKM1HQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: open code RCU for device name
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jun 2025 at 13:10, David Sterba <dsterba@suse.com> wrote:
>
> The RCU protected string is only used for a device name, and RCU is used
> so we can print the name and eventually synchronize against the rare
> device rename in device_list_add().
>
> We don't need the whole API just for that. Open code all the helpers and
> access to the string itself.
>
> Notable change is in device_list_add() when the device name is changed,
> which is the only place that can actually happen at the same time as
> message prints using the device name under RCU read lock.
>
> Previously there was kfree_rcu() which used the embedded rcu_head to
> delay freeing the object depending on the RCU mechanism. Now there's
> kfree_rcu_mightsleep() which does not need the rcu_head and waits for
> the grace period.
>
> Sleeping is safe in this context and as this is a rare event it won't
> interfere with the rest as it's holding the device_list_mutex.
>
> Straightforward changes:
>
> - rcu_string_strdup -> kstrdup
> - rcu_str_deref -> rcu_dereference
> - drop ->str from safe contexts
>
> Historical notes:
>
> Introduced in 606686eeac45 ("Btrfs: use rcu to protect device->name")
> with a vague reference of the potential problem described in
> https://lore.kernel.org/all/20120531155304.GF11775@ZenIV.linux.org.uk/ .
>
> The RCU protection looks like the easiest and most lightweight way of
> protecting the rare event of device rename racing device_list_add()
> with a random printk() that uses the device name.
>
> Alternatives: a spin lock would require to protect the printk
> anyway, a fixed buffer for the name would be eventually wrong in case
> the new name is overwritten when being printed, an array switching
> pointers and cleaning them up eventually resembles RCU too much.
>
> The cleanups up to this patch should hide special case of RCU to the
> minimum that only the name needs rcu_dereference(), which can be further
> cleaned up to use btrfs_dev_name().
>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/volumes.c | 26 +++++++++++++++-----------
>  fs/btrfs/volumes.h |  5 +++--
>  fs/btrfs/zoned.c   | 22 +++++++++++-----------
>  3 files changed, 29 insertions(+), 24 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a5fbbd6bb1ed..002a215176ca 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -658,7 +658,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>         if (!device->name)
>                 return -EINVAL;
>
> -       ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
> +       ret = btrfs_get_bdev_and_sb(device->name, flags, holder, 1,
>                                     &bdev_file, &disk_super);
>         if (ret)
>                 return ret;
> @@ -702,7 +702,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>         if (device->devt != device->bdev->bd_dev) {
>                 btrfs_warn(NULL,
>                            "device %s maj:min changed from %d:%d to %d:%d",
> -                          device->name->str, MAJOR(device->devt),
> +                          device->name, MAJOR(device->devt),
>                            MINOR(device->devt), MAJOR(device->bdev->bd_dev),
>                            MINOR(device->bdev->bd_dev));
>
> @@ -750,7 +750,7 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
>                 goto out;
>
>         rcu_read_lock();
> -       ret = strscpy(old_path, rcu_str_deref(device->name), PATH_MAX);
> +       ret = strscpy(old_path, rcu_dereference(device->name), PATH_MAX);
>         rcu_read_unlock();
>         if (ret < 0)
>                 goto out;
> @@ -783,7 +783,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  {
>         struct btrfs_device *device;
>         struct btrfs_fs_devices *fs_devices = NULL;
> -       struct rcu_string *name;
> +       const char *name;
>         u64 found_transid = btrfs_super_generation(disk_super);
>         u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
>         dev_t path_devt;
> @@ -891,6 +891,8 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>                                 current->comm, task_pid_nr(current));
>
>         } else if (!device->name || !is_same_device(device, path)) {
> +               const char *old_name;
> +
>                 /*
>                  * When FS is already mounted.
>                  * 1. If you are here and if the device->name is NULL that
> @@ -958,13 +960,15 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>                                           task_pid_nr(current));
>                 }
>
> -               name = rcu_string_strdup(path, GFP_NOFS);
> +               name = kstrdup(path, GFP_NOFS);
>                 if (!name) {
>                         mutex_unlock(&fs_devices->device_list_mutex);
>                         return ERR_PTR(-ENOMEM);
>                 }
> -               kfree_rcu(device->name, rcu);
> +               old_name = rcu_dereference(device->name);
>                 rcu_assign_pointer(device->name, name);
> +               kfree_rcu_mightsleep(old_name);
> +
>                 if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
>                         fs_devices->missing_devices--;
>                         clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
> @@ -1013,7 +1017,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>                  * uuid mutex so nothing we touch in here is going to disappear.
>                  */
>                 if (orig_dev->name)
> -                       dev_path = orig_dev->name->str;
> +                       dev_path = orig_dev->name;
>
>                 device = btrfs_alloc_device(NULL, &orig_dev->devid,
>                                             orig_dev->uuid, dev_path);
> @@ -1415,7 +1419,7 @@ static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
>
>                 list_for_each_entry(device, &fs_devices->devices, dev_list) {
>                         if (device->bdev && (device->bdev->bd_dev == devt) &&
> -                           strcmp(device->name->str, path) != 0) {
> +                           strcmp(device->name, path) != 0) {
>                                 mutex_unlock(&fs_devices->device_list_mutex);
>
>                                 /* Do not skip registration. */
> @@ -2167,7 +2171,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
>         btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
>
>         /* Update ctime/mtime for device path for libblkid */
> -       update_dev_time(device);
> +       update_dev_time(device;

This looks like a mistake. I believe the hunk should be removed,
otherwise it won't compile.

>  }
>
>  int btrfs_rm_device(struct btrfs_fs_info *fs_info,
> @@ -6927,9 +6931,9 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>                 generate_random_uuid(dev->uuid);
>
>         if (path) {
> -               struct rcu_string *name;
> +               const char *name;
>
> -               name = rcu_string_strdup(path, GFP_KERNEL);
> +               name = kstrdup(path, GFP_KERNEL);
>                 if (!name) {
>                         btrfs_free_device(dev);
>                         return ERR_PTR(-ENOMEM);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 6a2f9c73c685..cc270787d0ce 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -114,7 +114,8 @@ struct btrfs_device {
>         struct btrfs_fs_devices *fs_devices;
>         struct btrfs_fs_info *fs_info;
>
> -       struct rcu_string __rcu *name;
> +       /* Device path or NULL if missing. */
> +       const char __rcu *name;
>
>         u64 generation;
>
> @@ -847,7 +848,7 @@ static inline const char *btrfs_dev_name(const struct btrfs_device *device)
>         if (!device || test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>                 return "<missing disk>";
>         else
> -               return rcu_str_deref(device->name);
> +               return rcu_dereference(device->name);
>  }
>
>  static inline void btrfs_warn_unknown_chunk_allocation(enum btrfs_chunk_allocation_policy pol)
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index bd987c90a05c..27264db4b7ca 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -266,7 +266,7 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>         if (ret < 0) {
>                 btrfs_err(device->fs_info,
>                                  "zoned: failed to read zone %llu on %s (devid %llu)",
> -                                pos, rcu_str_deref(device->name),
> +                                pos, rcu_dereference(device->name),
>                                  device->devid);
>                 return ret;
>         }
> @@ -398,14 +398,14 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>         if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
>                 btrfs_err(fs_info,
>                 "zoned: %s: zone size %llu larger than supported maximum %llu",
> -                                rcu_str_deref(device->name),
> +                                rcu_dereference(device->name),
>                                  zone_info->zone_size, BTRFS_MAX_ZONE_SIZE);
>                 ret = -EINVAL;
>                 goto out;
>         } else if (zone_info->zone_size < BTRFS_MIN_ZONE_SIZE) {
>                 btrfs_err(fs_info,
>                 "zoned: %s: zone size %llu smaller than supported minimum %u",
> -                                rcu_str_deref(device->name),
> +                                rcu_dereference(device->name),
>                                  zone_info->zone_size, BTRFS_MIN_ZONE_SIZE);
>                 ret = -EINVAL;
>                 goto out;
> @@ -421,7 +421,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>         if (max_active_zones && max_active_zones < BTRFS_MIN_ACTIVE_ZONES) {
>                 btrfs_err(fs_info,
>  "zoned: %s: max active zones %u is too small, need at least %u active zones",
> -                                rcu_str_deref(device->name), max_active_zones,
> +                                rcu_dereference(device->name), max_active_zones,
>                                  BTRFS_MIN_ACTIVE_ZONES);
>                 ret = -EINVAL;
>                 goto out;
> @@ -463,7 +463,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>                 if (!zone_info->zone_cache) {
>                         btrfs_err(device->fs_info,
>                                 "zoned: failed to allocate zone cache for %s",
> -                               rcu_str_deref(device->name));
> +                               rcu_dereference(device->name));
>                         ret = -ENOMEM;
>                         goto out;
>                 }
> @@ -500,7 +500,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>         if (nreported != zone_info->nr_zones) {
>                 btrfs_err(device->fs_info,
>                                  "inconsistent number of zones on %s (%u/%u)",
> -                                rcu_str_deref(device->name), nreported,
> +                                rcu_dereference(device->name), nreported,
>                                  zone_info->nr_zones);
>                 ret = -EIO;
>                 goto out;
> @@ -510,7 +510,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>                 if (nactive > max_active_zones) {
>                         btrfs_err(device->fs_info,
>                         "zoned: %u active zones on %s exceeds max_active_zones %u",
> -                                        nactive, rcu_str_deref(device->name),
> +                                        nactive, rcu_dereference(device->name),
>                                          max_active_zones);
>                         ret = -EIO;
>                         goto out;
> @@ -578,7 +578,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>
>         btrfs_info(fs_info,
>                 "%s block device %s, %u %szones of %llu bytes",
> -               model, rcu_str_deref(device->name), zone_info->nr_zones,
> +               model, rcu_dereference(device->name), zone_info->nr_zones,
>                 emulated, zone_info->zone_size);
>
>         return 0;
> @@ -1186,7 +1186,7 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>                 btrfs_warn(
>                         device->fs_info,
>                 "zoned: resetting device %s (devid %llu) zone %llu for allocation",
> -                       rcu_str_deref(device->name), device->devid, pos >> shift);
> +                       rcu_dereference(device->name), device->devid, pos >> shift);
>                 WARN_ON_ONCE(1);
>
>                 ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
> @@ -1348,7 +1348,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
>         if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL) {
>                 btrfs_err(fs_info,
>                 "zoned: unexpected conventional zone %llu on device %s (devid %llu)",
> -                       zone.start << SECTOR_SHIFT, rcu_str_deref(device->name),
> +                       zone.start << SECTOR_SHIFT, rcu_dereference(device->name),
>                         device->devid);
>                 up_read(&dev_replace->rwsem);
>                 return -EIO;
> @@ -1362,7 +1362,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
>                 btrfs_err(fs_info,
>                 "zoned: offline/readonly zone %llu on device %s (devid %llu)",
>                           (info->physical >> device->zone_info->zone_size_shift),
> -                         rcu_str_deref(device->name), device->devid);
> +                         rcu_dereference(device->name), device->devid);
>                 info->alloc_offset = WP_MISSING_DEV;
>                 break;
>         case BLK_ZONE_COND_EMPTY:
> --
> 2.47.1
>
>


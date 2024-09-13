Return-Path: <linux-btrfs+bounces-8006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545739782DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD4E1C22815
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50BA1DFDE;
	Fri, 13 Sep 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnYYaxrS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30126289
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238743; cv=none; b=n6zfh1eTdfo2SwbAExAfZz7a/PSW030CQ8Q6qd5PcLvuCeueWU1W7Q+YOAtdDb+dOhf2szNIPAyEmHMaFQTy/hO8ai5K37twp929oc5g2LNNKj8+uCFXvaeIiQ29wf7ANo8SphHCRAGhw+mPHkiyJytLjfTn1qtkaAtg2pEbs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238743; c=relaxed/simple;
	bh=n8QW5j0pOBA/qoIjKB9qoNmP9HHhE/I8b/7AZBl26PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptktzxWMWqU325CjjXeWHyJvSTTWp/IC5iRl5pjSIPkIBtUR+c+pyfmtqztfbl432u1n/6rvozWYRcJuSpwpRC8sPbqGjD6IaGTbWKf9SkO43KyIi7sZN0WWl6XKfd4d1xKv4wMnFyVbptuA9hreZ8uZw5NlOV4yo/3+6wnsIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnYYaxrS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb2191107so18418285e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726238739; x=1726843539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIzmfmMPssK2CFQt+oAaceJ4s0+SsJ+PqKFXrS8YL6U=;
        b=ZnYYaxrS66LRZ+DPTeNhvP+NSvP6/sVZYHMflRO4GVKRWYNZikquIg92Zas4an4ba5
         xH4Je7BYQ1YdKegQM1YmVcI1FwpXlKDqDZzP2drmpGpiTRzN0zwMoextYX31/BqU9DeO
         nh162GgFwf/T8BXGp70nqMvtnxjIvZhHQM8wGGKNmPoZ3dmXR7bEbmNDC3bchQ2QakHL
         kYUmERXwIw0QZtZeJ6VcyHAne3RwryqHjhlEUoxTW38IRsL5QCEnjb+RX8azqmuSpE50
         4eTQJeW4/xcRGz43ztuNFNiEBI/RAXZi28mcaaSSXErVFkW6uxtIlV5ZYqpkVgOUMNBb
         U3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238739; x=1726843539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIzmfmMPssK2CFQt+oAaceJ4s0+SsJ+PqKFXrS8YL6U=;
        b=LDdT7j54Fn1ttIqP08MPzV4yBC9SaHqUqhb1S91MKoA1ha0MqZ2p6PENhkSs5l9QTL
         piirOTM1HNws4Scybt08ARQDBmv/2dm7ZK33aJv2k0Aqd/7qHRXxvDTRQSXneoMUU89c
         XSgM+CfLzoA0KLV+euvXNjmGimd/YqcMY5VF5oGk/Tvj4ymzE3KLh73yVMY1qrZMoSvu
         B+CHi0fZCCraTahc9RiH1+ddCBtRa/ZNgGG8fUY4AQdu8IitCW/e0M57gstmP+DV76ml
         mD5MzK5jOKd3vyK5SsoT5lRi98x30G5/L4JRcjxYGzEncLfdKZOF6lK2fCNt2IQ6xN8V
         ud8A==
X-Gm-Message-State: AOJu0YzoWywANSYlUtFKJktJzMEFj0JsR8NDSgsCGP3A6vPbLQw7SzLH
	yxD3by5Td4QC0gH9+hiLEblxdDa8or296D5GAezj7QLWZ1oxMxqZpC+f+qecgsrAfUUsnb0s0xk
	I6JCib9bu4+f8WXg5z3MO2IOmAS6ybiyY
X-Google-Smtp-Source: AGHT+IG9u9+AJDenPdDGkSTfr5v0zCBeD0LLJrJaeSU8jRRIIzwmgIYir9pJvp1YMtVQvpXGsIzEGkBDeIYmof5ut5Y=
X-Received: by 2002:a5d:66ce:0:b0:374:c92e:f6b1 with SMTP id
 ffacd0b85a97d-378c2cfc126mr4279667f8f.23.1726238739009; Fri, 13 Sep 2024
 07:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98ef25697d52cd3e17b44a846e60eba9e5dfb39c.1726193590.git.naohiro.aota@wdc.com>
In-Reply-To: <98ef25697d52cd3e17b44a846e60eba9e5dfb39c.1726193590.git.naohiro.aota@wdc.com>
From: Xuefer <xuefer@gmail.com>
Date: Fri, 13 Sep 2024 22:45:27 +0800
Message-ID: <CAMs-qv8q1z1Qtg_ze750SP_WQ0KrR08-s7POqz+JJhvG36vRJQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: clear SB magic on conventional zone
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. applied on 6.10.9-gentoo and works for me
# btrfs device add /dev/sdd /d/ -f
# btrfs de remove /dev/sdd /d/
# lsblk -f
NAME   FSTYPE FSVER LABEL     UUID
FSAVAIL FSUSE% MOUNTPOINTS
sdd
sde    btrfs        downloads 8d4bcd03-3f85-4aae-a7dc-a302f1d6d8bb
5.9T    53% /d
sdf    btrfs        downloads 8d4bcd03-3f85-4aae-a7dc-a302f1d6d8bb

# dmesg | tail
[31061.373787] BTRFS info (device sde): host-managed zoned block
device /dev/sdd, 52156 zones of 268435456 bytes
[31061.430513] BTRFS info (device sde): disk added /dev/sdd
[31068.855965] BTRFS info (device sde): device deleted: /dev/sdd

no more error, no dd needed to clear manually

On Fri, Sep 13, 2024 at 10:16=E2=80=AFAM Naohiro Aota <naohiro.aota@wdc.com=
> wrote:
>
> btrfs_reset_sb_log_zones() properly resets a zone if the first zone of SB
> log zones is not a conventional zone, which clears a SB magic
> properly. However, it leaves SB magic on a conventional zone intact. As a
> result, "btrfs delete" cannot remove the SB magic on a conventional
> zone. So, re-adding the disk results in an error.
>
> Use the same logic as btrfs_scratch_superblock() to remove the magic, if
> the first zone is conventional.
>
> Reported-by: Xuefer <xuefer@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219170
> Fixes: 12659251ca5d ("btrfs: implement log-structured superblock for ZONE=
D mode")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/volumes.c |  6 ++--
>  fs/btrfs/volumes.h |  2 ++
>  fs/btrfs/zoned.c   | 80 ++++++++++++++++++++++++++++++++++------------
>  fs/btrfs/zoned.h   |  4 +--
>  4 files changed, 67 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4a259bdaa21c..140c4ca74d4f 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1270,8 +1270,8 @@ void btrfs_release_disk_super(struct btrfs_super_bl=
ock *super)
>         put_page(page);
>  }
>
> -static struct btrfs_super_block *btrfs_read_disk_super(struct block_devi=
ce *bdev,
> -                                                      u64 bytenr, u64 by=
tenr_orig)
> +struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bde=
v, u64 bytenr,
> +                                               u64 bytenr_orig)
>  {
>         struct btrfs_super_block *disk_super;
>         struct page *page;
> @@ -2101,7 +2101,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info=
 *fs_info, struct btrfs_devic
>
>         for (copy_num =3D 0; copy_num < BTRFS_SUPER_MIRROR_MAX; copy_num+=
+) {
>                 if (bdev_is_zoned(bdev))
> -                       btrfs_reset_sb_log_zones(bdev, copy_num);
> +                       btrfs_reset_sb_log_zones(device, copy_num);
>                 else
>                         btrfs_scratch_superblock(fs_info, bdev, copy_num)=
;
>         }
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 03d2d60afe0c..176aa916fc05 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -758,6 +758,8 @@ struct btrfs_chunk_map *btrfs_get_chunk_map(struct bt=
rfs_fs_info *fs_info,
>                                             u64 logical, u64 length);
>  void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_=
chunk_map *map);
>  void btrfs_release_disk_super(struct btrfs_super_block *super);
> +struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bde=
v, u64 bytenr,
> +                                               u64 bytenr_orig);
>
>  static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
>                                       int index)
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 41ce252bb8fe..39d37a246b3e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -989,30 +989,70 @@ int btrfs_advance_sb_log(struct btrfs_device *devic=
e, int mirror)
>         return -EIO;
>  }
>
> -int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
> +int btrfs_reset_sb_log_zones(struct btrfs_device *device, int mirror)
>  {
> -       unsigned int nofs_flags;
> -       sector_t zone_sectors;
> -       sector_t nr_sectors;
> -       u8 zone_sectors_shift;
> -       u32 sb_zone;
> -       u32 nr_zones;
> -       int ret;
> -
> -       zone_sectors =3D bdev_zone_sectors(bdev);
> -       zone_sectors_shift =3D ilog2(zone_sectors);
> -       nr_sectors =3D bdev_nr_sectors(bdev);
> -       nr_zones =3D nr_sectors >> zone_sectors_shift;
> +       struct btrfs_zoned_device_info *zinfo =3D device->zone_info;
> +       u32 sb_zone =3D sb_zone_number(zinfo->zone_size_shift, mirror);
> +       struct blk_zone *zone;
> +       int ret =3D 0;
>
> -       sb_zone =3D sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mir=
ror);
> -       if (sb_zone + 1 >=3D nr_zones)
> +       if (sb_zone + BTRFS_NR_SB_LOG_ZONES > zinfo->nr_zones)
>                 return -ENOENT;
>
> -       nofs_flags =3D memalloc_nofs_save();
> -       ret =3D blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
> -                              zone_start_sector(sb_zone, bdev),
> -                              zone_sectors * BTRFS_NR_SB_LOG_ZONES);
> -       memalloc_nofs_restore(nofs_flags);
> +       zone =3D &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
> +       if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {
> +               /*
> +                * If the first zone is conventional, the SB is placed at=
 the
> +                * first zone.
> +                */
> +
> +               u64 bytenr =3D zone->start << SECTOR_SHIFT;
> +               u64 bytenr_orig =3D btrfs_sb_offset(mirror);
> +               struct btrfs_super_block *disk_super;
> +               const size_t len =3D sizeof(disk_super->magic);
> +
> +               disk_super =3D btrfs_read_disk_super(device->bdev, bytenr=
, bytenr_orig);
> +               if (IS_ERR(disk_super))
> +                       return PTR_ERR(disk_super);
> +
> +               memset(&disk_super->magic, 0, len);
> +               folio_mark_dirty(virt_to_folio(disk_super));
> +               btrfs_release_disk_super(disk_super);
> +
> +               ret =3D sync_blockdev_range(device->bdev, bytenr, bytenr =
+ len - 1);
> +       } else {
> +               unsigned int nofs_flags;
> +
> +               /*
> +                * For the other case, all zones must be a sequential req=
uired
> +                * zone.
> +                */
> +#ifdef CONFIG_BTRFS_ASSERT
> +               for (int i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> +                       ASSERT(zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL=
);
> +                       zone++;
> +               }
> +               zone =3D &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror]=
;
> +#endif
> +
> +               nofs_flags =3D memalloc_nofs_save();
> +               ret =3D blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET,=
 zone->start,
> +                                      zone->len * BTRFS_NR_SB_LOG_ZONES)=
;
> +               memalloc_nofs_restore(nofs_flags);
> +
> +               if (!ret) {
> +                       for (int i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++)=
 {
> +                               zone->cond =3D BLK_ZONE_COND_EMPTY;
> +                               zone->wp =3D zone->start;
> +                               zone++;
> +                       }
> +               }
> +       }
> +
> +       if (ret)
> +               btrfs_warn(device->fs_info, "error clearing superblock nu=
mber %d (%d)", mirror,
> +                          ret);
> +
>         return ret;
>  }
>
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 7612e6572605..eef3272b087c 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -65,7 +65,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bde=
v, int mirror, int rw,
>  int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int r=
w,
>                           u64 *bytenr_ret);
>  int btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
> -int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
> +int btrfs_reset_sb_log_zones(struct btrfs_device *device, int mirror);
>  u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_s=
tart,
>                                  u64 hole_end, u64 num_bytes);
>  int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
> @@ -155,7 +155,7 @@ static inline int btrfs_advance_sb_log(struct btrfs_d=
evice *device, int mirror)
>         return 0;
>  }
>
> -static inline int btrfs_reset_sb_log_zones(struct block_device *bdev, in=
t mirror)
> +static inline int btrfs_reset_sb_log_zones(struct btrfs_device *device, =
int mirror)
>  {
>         return 0;
>  }
> --
> 2.46.0
>


Return-Path: <linux-btrfs+bounces-15324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84830AFCD3F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 16:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A836188ECBD
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED62DFA24;
	Tue,  8 Jul 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOby+lAM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAA1EB5FE
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984310; cv=none; b=um+lCab0+7Jd4zdVO0VM7HBiA8HYz29Gdsjh/Swii4pswTjOHFe3kKuf09zlPGtL3jmY6Xzc9RrlhwE2SO6Axv3wae39CEm1I8+y2PHqzRwWQHR7HH/Zm2+KkKf/vljHGGEs6tKSj5iy3qO+XMWn2m+B0Moz4Gp+izqD34/8Gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984310; c=relaxed/simple;
	bh=OlpmMpDK9fbLsCRfdfgHD3fEVCIaHP0j6ltokMiqMx0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sKD0kr8PiBwUzgTvWqMSiFmF2i5g2P5LbkHX1E52Ho2p7gJ5/QVzpjUdUtGEyxXvAy6Ak+o52oZ979pzwVBs5ASiUZTIC6/TSvQPLpwAmEo+BcBlO4PMYOdkdMkIPgi2apAhx6nllARFcNiS6LxPkPwl5sRDI0x5gmtl/TgtQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOby+lAM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167b30so44329675ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984308; x=1752589108; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kkmwqScGcVn9f0TGK3q29ZdgLfKo21SXHPoBb1pAAc=;
        b=JOby+lAMeB5ICn77qcYDt5i3cIIYdFTiF9sMCjwgxFldLAuuD3ztShl/kDQGuqKMLC
         oAvUVdp0t2JM874KBQA3GK/XI1PTOloPw7cgV//n9BYxDkZKDCCIAm5VZUZeEiXXsVic
         5M9YyLyADJpnskkfusPWUZIOQpOoKgrrgd5VfwY8U6GIyiplmyLvBpMWAyUDEl9QW1zv
         tO1coMWsnkAjo9PVzllwoBQSHEKffQde7sxJLp7exUpPHnw8inrJ/aiyTijt4z/LCqWL
         UA16nLR1F0/GGEiuGPiyqKXPBwFLp3fxXJPb0+f64pLAs/UIe5J2zzMfHGkuq3A8hwFz
         E+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984308; x=1752589108;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kkmwqScGcVn9f0TGK3q29ZdgLfKo21SXHPoBb1pAAc=;
        b=P6jD1IFhLcqBo8p4TlRA3wFNq6ef8lLqFUtOa4DJrUHDi1F5eiF32NMHHxhIjs9hRX
         xgGI8/1ogpG0mLJzK+iafnHqve1dY5edrvwRwBYxGN502E3aaS/qYTHWUuM/HOuU/VA8
         NmFSU9BVlsfW8KZZ8kgk/IAhEiOV8sqyR2AODjpQrSEAtnGSFQwUQVL2xfLectID6U3Q
         1G+aJYOre15SxYIOZ5Ci2dUm3EG6ZjypGvNb65/cDAQy52sTtWIRyXV7wW3LcRJms0rR
         yfFEmlH9kOF/YfP0MnbOn4dNOiT4YgWTTEFzUMZnireCmZeCab+jRLoMbfGPc1aNH2+5
         x1CQ==
X-Gm-Message-State: AOJu0YyYSfKBQ+bwmuLW+Mi1yE2c9+Ex9kTQhkX1gk3SqiYFavINeTml
	VTgJaNTZkVEjp+GVUqzTp77hYlpqB8cHREVxTUzjP0S9zAb9deiO/o501qhJx8LB
X-Gm-Gg: ASbGncuTpZvRZ3a+UY/kaslzSnyeALQKsrIObBjpq6XCz0c41i0BfYMNJffpFFtXdPJ
	sD9ZttgQMxmC5ToDK6xDiZU2CWyYrXNh4KVcdFB4F06qup+gemUjFgPVWjysnBtWDTOwBa4lsA8
	aw63w445qW93jit3nmVLR0bjKeOWYnesbVMCrrVyd9nb+foRQ/T0LOJ+8McVf3LlKWF0qGjNU6O
	0/BVR3HjE0HwRaWmL4wtcrndujsmSPGV3J58UbOhZgX+HCMIDmRQe2MDh/6VjHRDYlpHxfQSNC8
	LJWlL7IgJSYEMJuBXvP2ivPrOoaN7dcQVlezIaiQDlPtISV8gS0HARtM
X-Google-Smtp-Source: AGHT+IExwLcb2rvz42Rxy6GvLJMjuy9U+fcoxHiikwU26uuPoR5obsJd3lv9R/mx+6hBbBg56Fl1Kg==
X-Received: by 2002:a17:902:f78a:b0:234:bfcb:5bfa with SMTP id d9443c01a7336-23c85de488emr229455875ad.15.1751984308236;
        Tue, 08 Jul 2025 07:18:28 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a3f1sm114035055ad.18.2025.07.08.07.18.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:18:27 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20250708132540.28285-1-dsterba@suse.com>
Date: Tue, 8 Jul 2025 22:18:09 +0800
Cc: linux-btrfs@vger.kernel.org,
 wqu@suse.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <23A10F0D-C9CD-4A92-AEEB-8AF8E092DB4E@gmail.com>
References: <20250708132540.28285-1-dsterba@suse.com>
To: David Sterba <dsterba@suse.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

On Jul 8, 2025, at 21:25, David Sterba <dsterba@suse.com> wrote:
>=20
> Implement sb->freeze_super that can instruct our threads to pause
> themselves. In case of (read-write) scrub this means to undo
> mnt_want_write, implemented as sb_start_write()/sb_end_write().
> The freeze_super callback is necessary otherwise the call
> sb_want_write() inside the generic implementation hangs.
>=20
> This works with concurrent scrub running and 'fsfreeze --freeze', not
> with process freezing (like with suspend).
>=20
> References: https://lwn.net/Articles/1018341/
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
> fs/btrfs/fs.h    |  2 ++
> fs/btrfs/scrub.c | 21 +++++++++++++++++++++
> fs/btrfs/super.c | 36 ++++++++++++++++++++++++++++++++----
> 3 files changed, 55 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 8cc07cc70b12..005828a6ab17 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -137,6 +137,8 @@ enum {
> BTRFS_FS_QUOTA_OVERRIDE,
> /* Used to record internally whether fs has been frozen */
> BTRFS_FS_FROZEN,
> + /* Started freezing, pause your progress. */
> + BTRFS_FS_FREEZING,
> /*
> * Indicate that balance has been set up from the ioctl and is in the
> * main phase. The fs_info::balance_ctl is initialized.
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 6776e6ab8d10..9a6bce6ea191 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2250,6 +2250,27 @@ static int scrub_simple_mirror(struct scrub_ctx =
*sctx,
> ret =3D -ECANCELED;
> break;
> }
> +
> + /* Freezing? */
> + if (test_bit(BTRFS_FS_FREEZING, &fs_info->flags)) {
> + atomic_inc(&fs_info->scrubs_paused);
> + smp_mb();

The memory barrier before wake_up seems not needed

> + wake_up(&fs_info->scrub_pause_wait);
> +
> + if (!sctx->readonly)
> + sb_end_write(fs_info->sb);
> +
> + try_to_freeze();
> + wait_on_bit(&fs_info->flags, BTRFS_FS_FREEZING, =
TASK_UNINTERRUPTIBLE);
> +
> + if (!sctx->readonly)
> + sb_start_write(fs_info->sb);
> +
> + atomic_dec(&fs_info->scrubs_paused);
> + smp_mb();
> + wake_up(&fs_info->scrub_pause_wait);
> + }
> +
> /* Paused? */
> if (atomic_read(&fs_info->scrub_pause_req)) {
> /* Push queued extents */
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index e4ce2754cfde..c049d145db66 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2279,7 +2279,33 @@ static long btrfs_control_ioctl(struct file =
*file, unsigned int cmd,
> return ret;
> }
>=20
> -static int btrfs_freeze(struct super_block *sb)
> +static int btrfs_freeze_super(struct super_block *sb, enum =
freeze_holder who,
> +      const void *freeze_owner)
> +{
> + struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> + int ret;
> +
> + set_bit(BTRFS_FS_FREEZING, &fs_info->flags);
> + ret =3D freeze_super(sb, who, freeze_owner);
> + if (ret < 0)
> + clear_bit(BTRFS_FS_FREEZING, &fs_info->flags);
> + return ret;
> +}
> +
> +static int btrfs_thaw_super(struct super_block *sb, enum =
freeze_holder who,
> +    const void *freeze_owner)
> +{
> + struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> + int ret;
> +
> + ret =3D thaw_super(sb, who, freeze_owner);
> + clear_bit(BTRFS_FS_FREEZING, &fs_info->flags);
> + smp_mb();
> + wake_up_bit(&fs_info->flags, BTRFS_FS_FREEZING);
> + return ret;
> +}
> +
> +static int btrfs_freeze_fs(struct super_block *sb)
> {
> struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>=20
> @@ -2345,7 +2371,7 @@ static int check_dev_super(struct btrfs_device =
*dev)
> return ret;
> }
>=20
> -static int btrfs_unfreeze(struct super_block *sb)
> +static int btrfs_unfreeze_fs(struct super_block *sb)
> {
> struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> struct btrfs_device *device;
> @@ -2426,8 +2452,10 @@ static const struct super_operations =
btrfs_super_ops =3D {
> .destroy_inode =3D btrfs_destroy_inode,
> .free_inode =3D btrfs_free_inode,
> .statfs =3D btrfs_statfs,
> - .freeze_fs =3D btrfs_freeze,
> - .unfreeze_fs =3D btrfs_unfreeze,
> + .freeze_super   =3D btrfs_freeze_super,
> + .thaw_super     =3D btrfs_thaw_super,
> + .freeze_fs =3D btrfs_freeze_fs,
> + .unfreeze_fs =3D btrfs_unfreeze_fs,
> .nr_cached_objects =3D btrfs_nr_cached_objects,
> .free_cached_objects =3D btrfs_free_cached_objects,
> };
> --=20
> 2.49.0
>=20
>=20



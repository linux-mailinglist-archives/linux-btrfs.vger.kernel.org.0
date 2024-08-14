Return-Path: <linux-btrfs+bounces-7191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB617951CCF
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 16:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA7C1C211AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D271B3722;
	Wed, 14 Aug 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIEd5oDt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C313C684;
	Wed, 14 Aug 2024 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644807; cv=none; b=C/4DNQcKhBR49IwZKw0CydnUW0soj8ejS9c+TjbJ2a0gsImNCrZvbXcer/zpvERFQ0SyJ43TDMcjBMAQ2yYkWRvMb9vYQYoYhr/BtuBEdGLvsnsIHEJMo3fWRl3RM6+F2tbR35qpUa/Vkaw+2YYhdTb1ilqsmLIKbTUYKsjzi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644807; c=relaxed/simple;
	bh=aDyWYjRPgcuPSmE1TFfREtuFm0o4NQr3LAUjszQbTpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyAfWV8D8JKO+kdQjtXABFXmTytmm+BkKjVyQSyEn0hIAGK6mdTePFeFrT1E/rGLe6gi0yIYoYVnGywt8fzlEZa8HapSAG06rZBwu2RqoNZYj+pRjesm6TBdA3Xibm0RD4TH9J17Mbx486JFlun1837ROhTU6xPB5szK5tkboWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIEd5oDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9E7C32786;
	Wed, 14 Aug 2024 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644806;
	bh=aDyWYjRPgcuPSmE1TFfREtuFm0o4NQr3LAUjszQbTpI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jIEd5oDtH8j2A0HR/h2GMDruYWCtZjhJr+bYalcJrhuIrVCzdalDv6aY/L52/bogz
	 bwztLEfB+SvvWC5PohdN1O6WtrJa3nhY4iYlwWYwzW8J2Q62PkM7YSzI+BwQjyMBx/
	 1gpF3AH4Dsh05/9E8SSanizBMlcFHBunZpd1pLHXVXlLi+1VqXuYippdwz0wc3nuOG
	 OOYuLcJh3AOApt0pX8t2gOBp1n7IG34jAZ5AJHEfB2v1ibezNh5hmM+JgsfL6iVHun
	 9TyZLlt38UDzjJdf+BO9vYx1eCFbc2yGqKGIzuxcLn+NggCIwHF0RwLpcZNiyhq65b
	 a7wJmC3rN9ofw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso632232366b.3;
        Wed, 14 Aug 2024 07:13:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4mHm92Bm6A3bQIeQtfwE5vsdo6C9o/cpZeZSLGYfuJxhr33v0wturAxPevRarJOIMQLNJTEnL9cJceg==@vger.kernel.org, AJvYcCVyxGzcqQL0NiMTq++o8dUtDOTM6MEJweP/2+EFIpj53mNaT4PvZZ7rT5MXta5ai91MiTRP1LNaGMqaYhAI@vger.kernel.org
X-Gm-Message-State: AOJu0YxoTu5lv75007NMmYe31nMzOTO2VOMewnyEMkYDEJ3dQlYGUMii
	39chIoSnkUKupJ7qZiOAAyVGJanIV2chaBHTVedVb6pvTizHimb5elW9mk8GMx4ZVs17KwqNI4e
	9euCXDw4Pw3NZlYg77ZvmBBCIsf4=
X-Google-Smtp-Source: AGHT+IEJF3IMiQrWpt6B0IMhmK5eKP4UZOP0BPSXfS/FKlz+2+KBXh2i/KSofnO7RxOAVzIiLiX3kErNV1OgBac5Q1I=
X-Received: by 2002:a17:907:3fa0:b0:a7d:3617:b5f5 with SMTP id
 a640c23a62f3a-a8366ff1506mr170985966b.42.1723644804725; Wed, 14 Aug 2024
 07:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-dev_replace_rwsem-new-v1-1-c42120994ce6@kernel.org> <CAL3q7H45Ym_QHPYaregfVvUDzaVpm5i62G8==yNQ3Bfd63Ffmw@mail.gmail.com>
In-Reply-To: <CAL3q7H45Ym_QHPYaregfVvUDzaVpm5i62G8==yNQ3Bfd63Ffmw@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 14 Aug 2024 15:12:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5L-j6Pe2zBmd07K1MyRXbEOO6C=-SB93PdoOQ+4spSOA@mail.gmail.com>
Message-ID: <CAL3q7H5L-j6Pe2zBmd07K1MyRXbEOO6C=-SB93PdoOQ+4spSOA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: relax dev_replace rwsem usage on scrub with rst
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 2:31=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Wed, Aug 14, 2024 at 1:46=E2=80=AFPM Johannes Thumshirn <jth@kernel.or=
g> wrote:
> >
> > From: Johannes Thumshin <johannes.thumshirn@wdc.com>
> >
> > Running fstests btrfs/011 with MKFS_OPTIONS=3D"-O rst" to force the usa=
ge of
> > the RAID stripe-tree, we get the following splat from lockdep:
> >
> >  BTRFS info (device sdd): dev_replace from /dev/sdd (devid 1) to /dev/s=
db started
> >
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  WARNING: possible recursive locking detected
> >  6.11.0-rc3+ #592 Not tainted
> >  --------------------------------------------
> >  btrfs/4203 is trying to acquire lock:
> >  ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_=
map_block+0x39f/0x2250
> >
> >  but task is already holding lock:
> >  ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_=
map_block+0x39f/0x2250
> >
> >  other info that might help us debug this:
> >   Possible unsafe locking scenario:
> >
> >         CPU0
> >         ----
> >    lock(&fs_info->dev_replace.rwsem);
> >    lock(&fs_info->dev_replace.rwsem);
> >
> >   *** DEADLOCK ***
>
> Is this really the full splat?
> There should be a stack trace showing that the problem happens when
> btrfs_map_block() is called within the scrub/dev replace code, no?
>
>
> >
> >   May be due to missing lock nesting notation
> >
> >  1 lock held by btrfs/4203:
> >   #0: ffff888103f35c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: b=
trfs_map_block+0x39f/0x2250
> >
> > This fixes a deadlock on RAID stripe-tree where device replace performs=
 a
> > scrub operation, which in turn calls into btrfs_map_block() to find the
> > physical location of the block.
> >
> > Cc: Filipe Manana <fdmanana@suse.com>
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >
> >
> > Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> > ---
> >  fs/btrfs/volumes.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 4b9b647a7e29..e5bd2bee912d 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -6459,6 +6459,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
> >         int dev_replace_is_ongoing =3D 0;
> >         u16 num_alloc_stripes;
> >         u64 max_len;
> > +       bool rst;
>
> The name is a bit confusing, something like "update_rst" is more
> meaningful and clearly indicates it's a boolean/condition.
>
> >
> >         ASSERT(bioc_ret);
> >
> > @@ -6475,6 +6476,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
> >         if (io_geom.mirror_num > num_copies)
> >                 return -EINVAL;
> >
> > +       rst =3D btrfs_need_stripe_tree_update(fs_info, map->type);
> > +
> >         map_offset =3D logical - map->start;
> >         io_geom.raid56_full_stripe_start =3D (u64)-1;
> >         max_len =3D btrfs_max_io_len(map, map_offset, &io_geom);
> > @@ -6597,13 +6600,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_in=
fo, enum btrfs_map_op op,
> >                  * For all other non-RAID56 profiles, just copy the tar=
get
> >                  * stripe into the bioc.
> >                  */
> > +               if (rst && dev_replace_is_ongoing)
> > +                       up_read(&dev_replace->rwsem);
> >                 for (int i =3D 0; i < io_geom.num_stripes; i++) {
> >                         ret =3D set_io_stripe(fs_info, logical, length,
> >                                             &bioc->stripes[i], map, &io=
_geom);
>
> So, why is this safe? The change log doesn't mention anything about
> the chosen fix.
>
> So even if this is called while we are not in the device replace code,
> btrfs_need_stripe_tree_update() can return true.
> In that case we unlock the device replace semaphore and can result in
> a use-after-free on a device, like this:
>
> 1) btrfs_map_block() called while not in the device replace code
> callchain, and there's a device replace for device X running in
> parallel;
>
> 2) btrfs_need_stripe_tree_update() returns true;
>
> 3) we unlock device replace semaphore;
>
> 4) we call set_io_stripe() which makes bioc point to device X, which
> is the old device (the one being replaced);
>
> 5) before we read lock the device replace semaphore at
> btrfs_map_block(), the device replace finishes and frees device X;
>
> 6) the bioc still points to device X... and then it's used for doing IO l=
ater
>
> Can't this happen? I don't see why not.
> If this is safe we should have an explanation in the changelog about
> the details.

And, how actually does this patch fixes the double locking problem?

Isn't the problem that the replace code ends calling btrfs_map_block()
while holding a read lock on the semaphore and then btrfs_map_block()
does a read lock on it again?

I would suggest a different fix:

Make the device replace code store a pointer (or pid) of to the task
running device replace, and at btrfs_map_block() don't take the
semaphore if "current" matches that pointer/pid.

Wouldn't that work? Seems safe and simple to me.

>
> Thanks.
>
>
> > +
> >                         if (ret < 0)
> >                                 break;
> >                         io_geom.stripe_index++;
> >                 }
> > +               if (rst && dev_replace_is_ongoing)
> > +                       down_read(&dev_replace->rwsem);
> > +
> >         }
> >
> >         if (ret) {
> >
> > ---
> > base-commit: 4ce21d87ae81a86b488e0d326682883485317dcb
> > change-id: 20240814-dev_replace_rwsem-new-91c160579246
> >
> > Best regards,
> > --
> > Johannes Thumshirn <jth@kernel.org>
> >
> >


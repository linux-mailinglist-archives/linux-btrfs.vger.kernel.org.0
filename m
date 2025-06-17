Return-Path: <linux-btrfs+bounces-14755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B820FADDE51
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 23:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959533B70BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30908292B4F;
	Tue, 17 Jun 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpftGm9K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D12F530F
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197583; cv=none; b=D4NsohS1WrUWKqBHzCTgyEePfQizv1c6TY/XvQ53j+xn/mk5xQKcIzvm+VWh5DuyoXoN+nvBpuoQHwHECXxDk6I2p5sYq3oOskI/va/20eZNWfI7taQFvFzPXMVj17XTdtaJWTZY472l+EDhou7KUsUYHaQ1gL8VGbMGvje1HGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197583; c=relaxed/simple;
	bh=yL1IfZbbv7ObMh7M9fByxtkETfV14Wz+vcJFNWDkjEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRGERI4sUWq8+4BQSoZGC5l//WD2dP4sgpLQMWxm+LYMzKIuE6l7F4yjq8VakbiQT+ftyIrWsaYp6yVNuPvEY7ef1UFfz+Lyx+Yfz44B0zZbD9MUxuhHkxLfuLlvF5K8QcaQGgHIU+nzgEjI5nArj8CvweWdm8jaR+r1o4e9hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpftGm9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9E4C4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 21:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750197583;
	bh=yL1IfZbbv7ObMh7M9fByxtkETfV14Wz+vcJFNWDkjEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NpftGm9KYzaiFkZcm5IJ5wZCVRz14qzAjrzQzeezMLCf/dfhUvavDavca1pMrMH4c
	 Cpcq6d6GOCYzIxvaT/3nCUx4PC4Nudq0bFQixBrMCPUzPKK49c+j5wvAQvlt3kIAFK
	 8IzI4XXK3LrVuuMFxW9QZtemUpibm/7YFslw4a2mLowGQUZYtnpXICmjOvGW0lMN9a
	 xgcrPP+d4oTROLA+uy0OMZ1rGfZA2XivsQASKlFSM0Ezy3KM0RS+bkl5Js5eqbbxoy
	 oI3nRj+c++LsT3pKS0eaYA9u8vJcDk/pswlTun73u6CnvFRwhnuYLrHW+RsB1iaryD
	 JgmY1yQR1ZcXA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso10401756a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 14:59:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw8FrunFY0lwkpB8scYqPTtp20cI0ke8FHtSmGO7l0aYcAfJWcn
	k8at/wSH6KGVUsyKMqzsxh6+RcSmiUwWp5MHJx+SlzTHwoFVV5+503ac9maHajHh7a6BcRTH7xH
	awhHEPmk8fONXhjTqcgau18ngYF8RIZo=
X-Google-Smtp-Source: AGHT+IHxWCmr9KZTkddQGAzRglmyV1nGryLFrpuXipQVG7rlBdEMoJfDNwnADiXWhziGoxdbqy+oIWQwKR39RBEDFHE=
X-Received: by 2002:a17:907:1b22:b0:ad5:6337:ba42 with SMTP id
 a640c23a62f3a-adfad4a4b05mr1341083366b.46.1750197581655; Tue, 17 Jun 2025
 14:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750075579.git.fdmanana@suse.com> <b8dfd9adca4be0d65661e90e7c742b1c66ff4fe9.1750075579.git.fdmanana@suse.com>
 <20250617215239.GB2330659@zen.localdomain>
In-Reply-To: <20250617215239.GB2330659@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 17 Jun 2025 22:59:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4RGxg7D8hvSC72JnHEKssvdYBanEfxT8fnFX=L26pE+Q@mail.gmail.com>
X-Gm-Features: AX0GCFu8lXfD6wDdQ3_tql2KPEDpcO9-_9E1NOHmNTj3sIoMpNW4C6OlVjzhtzE
Message-ID: <CAL3q7H4RGxg7D8hvSC72JnHEKssvdYBanEfxT8fnFX=L26pE+Q@mail.gmail.com>
Subject: Re: [PATCH 16/16] btrfs: cache if we are using free space bitmaps for
 a block group
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 10:51=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Tue, Jun 17, 2025 at 05:13:11PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Every time we add free space to the free space tree or we remove free
> > space from the free space tree, we do a lookup for the block group's fr=
ee
> > space info item in the free space tree. This takes time, navigating the
> > btree and we may block either on IO when reading extent buffers from di=
sk
> > or on extent buffer lock contention due to concurrency.
> >
> > Instead of doing this lookup everytime, cache the result in the block
> > structure and use it after the first lookup. This adds two boolean memb=
ers
> > to the block group structure but doesn't increase the structure's size.
> >
> > The following script that runs fs_mark was used to measure the time spe=
nt
> > on run_delayed_tree_ref(), since down that call chain we have calls to
> > add and remove free space to/from the free space tree (calls to
> > btrfs_add_to_free_space_tree() and btrfs_remove_from_free_space_tree())=
:
> >
> >   $ cat test.sh
> >   #!/bin/bash
> >
> >   DEV=3D/dev/nullb0
> >   MNT=3D/mnt
> >   FILES=3D100000
> >   THREADS=3D$(nproc --all)
> >
> >   echo "performance" | \
> >       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> >
> >   umount $DEV &> /dev/null
> >   mkfs.btrfs -f $DEV
> >   mount -o ssd $DEV $MNT
> >
> >   OPTS=3D"-S 0 -L 5 -n $FILES -s 0 -t $THREADS -k"
> >   for ((i =3D 1; i <=3D $THREADS; i++)); do
> >       OPTS=3D"$OPTS -d $MNT/d$i"
> >   done
> >
> >   fs_mark $OPTS
> >
> >   umount $MNT
> >
> > This is a heavy metadata test as it's exercising only file creation, so=
 a
> > lot of allocations of metadata extents, creating delayed refs for addin=
g
> > new metadata extents and dropping existing ones due to COW. The results
> > of the times it took to execute run_delayed_tree_ref(), in nanoseconds,
> > are the following.
> >
> > Before this change:
> >
> >   Range: 1868.000 - 6482857.000; Mean: 10231.430; Median: 7005.000; Std=
dev: 27993.173
> >   Percentiles:  90th: 13342.000; 95th: 23279.000; 99th: 82448.000
> >   1868.000 - 4222.038: 270696 ############
> >   4222.038 - 9541.029: 1201327 ########################################=
#############
> >   9541.029 - 21559.383: 385436 #################
> >   21559.383 - 48715.063: 64942 ###
> >   48715.063 - 110073.800: 31454 #
> >   110073.800 - 248714.944:  8218 |
> >   248714.944 - 561977.042:  1030 |
> >   561977.042 - 1269798.254:   295 |
> >   1269798.254 - 2869132.711:   116 |
> >   2869132.711 - 6482857.000:    28 |
> >
> > After this change:
> >
> >   Range: 1554.000 - 4557014.000; Mean: 9168.164; Median: 6391.000; Stdd=
ev: 21467.060
> >   Percentiles:  90th: 12478.000; 95th: 20964.000; 99th: 72234.000
> >   1554.000 - 3453.820: 219004 ############
> >   3453.820 - 7674.743: 980645 #########################################=
############
> >   7674.743 - 17052.574: 552486 ##############################
> >   17052.574 - 37887.762: 68558 ####
> >   37887.762 - 84178.322: 31557 ##
> >   84178.322 - 187024.331: 12102 #
> >   187024.331 - 415522.355:  1364 |
> >   415522.355 - 923187.626:   256 |
> >   923187.626 - 2051092.468:   125 |
> >   2051092.468 - 4557014.000:    21 |
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/block-group.h     |  5 +++++
> >  fs/btrfs/free-space-tree.c | 12 +++++++++++-
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> > index aa176cc9a324..8a8f1fff7e5b 100644
> > --- a/fs/btrfs/block-group.h
> > +++ b/fs/btrfs/block-group.h
> > @@ -246,6 +246,11 @@ struct btrfs_block_group {
> >       /* Lock for free space tree operations. */
> >       struct mutex free_space_lock;
> >
> > +     /* Protected by @free_space_lock. */
> > +     bool use_free_space_bitmaps;
> > +     /* Protected by @free_space_lock. */
> > +     bool use_free_space_bitmaps_cached;
> > +
> >       /*
> >        * Number of extents in this block group used for swap files.
> >        * All accesses protected by the spinlock 'lock'.
> > diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> > index 3c8bb95fa044..1bd07e91fd5a 100644
> > --- a/fs/btrfs/free-space-tree.c
> > +++ b/fs/btrfs/free-space-tree.c
> > @@ -287,6 +287,8 @@ int btrfs_convert_free_space_to_bitmaps(struct btrf=
s_trans_handle *trans,
> >       leaf =3D path->nodes[0];
> >       flags =3D btrfs_free_space_flags(leaf, info);
> >       flags |=3D BTRFS_FREE_SPACE_USING_BITMAPS;
> > +     block_group->use_free_space_bitmaps =3D true;
> > +     block_group->use_free_space_bitmaps_cached =3D true;
> >       btrfs_set_free_space_flags(leaf, info, flags);
> >       expected_extent_count =3D btrfs_free_space_extent_count(leaf, inf=
o);
> >       btrfs_release_path(path);
> > @@ -434,6 +436,8 @@ int btrfs_convert_free_space_to_extents(struct btrf=
s_trans_handle *trans,
> >       leaf =3D path->nodes[0];
> >       flags =3D btrfs_free_space_flags(leaf, info);
> >       flags &=3D ~BTRFS_FREE_SPACE_USING_BITMAPS;
> > +     block_group->use_free_space_bitmaps =3D false;
> > +     block_group->use_free_space_bitmaps_cached =3D true;
> >       btrfs_set_free_space_flags(leaf, info, flags);
> >       expected_extent_count =3D btrfs_free_space_extent_count(leaf, inf=
o);
> >       btrfs_release_path(path);
> > @@ -796,13 +800,19 @@ static int use_bitmaps(struct btrfs_block_group *=
bg, struct btrfs_path *path)
> >       struct btrfs_free_space_info *info;
> >       u32 flags;
> >
> > +     if (bg->use_free_space_bitmaps_cached)
> > +             return bg->use_free_space_bitmaps;
> > +
>
> I'm a little worried about what happens if the reader observes the
> writes out of order.
>
> i.e., say T1 is calling btrfs_convert_free_space_to_bitmaps() and T2 is
> calling use_bitmaps(). Then if T2 observes use_free_space_bitmaps_cached
> set to true but not use_free_space_bitmaps set to true, it will get the
> wrong value.
>
> Or is there some higher level locking that I missed protecting us?

Yes, there is. It's the block group's free_space_lock mutex, taken at
any entry point that modifies the free space tree.

Thanks.

>
> Thanks,
> Boris
>
> >       info =3D btrfs_search_free_space_info(NULL, bg, path, 0);
> >       if (IS_ERR(info))
> >               return PTR_ERR(info);
> >       flags =3D btrfs_free_space_flags(path->nodes[0], info);
> >       btrfs_release_path(path);
> >
> > -     return (flags & BTRFS_FREE_SPACE_USING_BITMAPS) ? 1 : 0;
> > +     bg->use_free_space_bitmaps =3D (flags & BTRFS_FREE_SPACE_USING_BI=
TMAPS);
> > +     bg->use_free_space_bitmaps_cached =3D true;
> > +
> > +     return bg->use_free_space_bitmaps;
> >  }
> >
> >  EXPORT_FOR_TESTS
> > --
> > 2.47.2
> >


Return-Path: <linux-btrfs+bounces-2041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B2884617B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 20:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7944B26C54
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684DD85653;
	Thu,  1 Feb 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="on5MoVEm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF7F43AC7
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706817134; cv=none; b=bG1FnfmiSln+Qj1TcfdcugdeMyxH3f36nKCLBO5DSPL5ZAsrW2Tdq/rbTGALfYgJWtco936hbdY6ZtasyVRxouXEVVubozXWNBDM36JTPN9J6CLhGXhkhUO1+/XrqmnYd0p5LSEyHf4KBPul68vy/Un2/1MVPb/3p0+UrB6JzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706817134; c=relaxed/simple;
	bh=OasYF+zlylORE2O3KAkExVcWOxjf9Q8KU0Fw3IY4iV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqmnFLQ69pb6Yii2HuajpyYYTg0mO5gMGQymoK9Ktu92fV0qE4eqcAVCgRz7sW71IFra43kR0K8xaTc9RVL0gZQlP9AVcDv7bTrcBO2f9x+rSAeitwRERtasvUBVZeRP8eOT1Mq3DjlRqfKB15ostILVVKyWPilhXv6mZ1rUggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=on5MoVEm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8a398cb2so9656411cf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Feb 2024 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706817131; x=1707421931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uZlbPq0yn3oDKkOHnN/FRnM/8DWWvfC/B/kVP978mqk=;
        b=on5MoVEmcFMfpfQ682nyaHDvBaQiU/V0Q+uIWY5+Qn05uIy3NH70ojD2jP7ECdcgUt
         jz68R43jtooHMdR7ctqHeyMiAsPCeRhla8WjyxqVLGHxudvTlac4jZPOSXo6k2X7prTt
         ZuLVsdBmbgQFY/94Cbg3PAkEhEgSoE57Nv5/d0JbnlNr1uQ1XytcSww2Rch4mk5WKDjy
         dHYcCcZqWRpGJ/l5aBw6hVqEiQYqk08y7gJrAChOUFzxoIIjffUgAph3fiNx7+LbOjYT
         wu/bE2bDnvxBRIGS6lYi8/NFIlSiWVP2mASQFW46jUNFKTqgoOmcfBt1Dq2OQm+vAo91
         dmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706817131; x=1707421931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZlbPq0yn3oDKkOHnN/FRnM/8DWWvfC/B/kVP978mqk=;
        b=a9zEu7mrid1DmAwTNpntL186LuYKsTm6schzsxK1HUgyKsqhpL3JWenWf4dP1nylM6
         Dz2WGGDD4iPHdnGFDZS4beMIHyDq/P28rq3ORfEfRaytc+sFPdEsc8cAaw07XldQKXJC
         vpB4cXorBJefAu6RPXsvYQyhg3c9HZy1xmV3hjQ1BAQo8Fy+tQR+R9lxFRSctglW+AHE
         l1IflWt+vavPbyVEnPSieqhb/527Tn6cmhhF4bYim8MFCDNXj4GqIcRaIaCdi1uM222E
         6tqmHz92JHy2BT1+uK2Ol6rxTC6bGbopunzjGiVvvPberkNPpkELeZx0gtyFTbJXPyuQ
         dXKg==
X-Gm-Message-State: AOJu0YziPVR3rLKteOjcQsX5TZsNioVjG+/uvTs/GjD2ACPGdW4DvD99
	f/UEleKmonyCW3Jf1lEw7yU7HjpG4cA41ZiZ42Yfh2P2XMpPYDH8JqMGSTbkYT5U+mh+OblBOOx
	N
X-Google-Smtp-Source: AGHT+IF1jpDDpfZiHFNwaj9Foug0eMoToPss0+BWuIzYzetNG9vKTiqy6LvFEVj9+cwIuxEtY5XYQQ==
X-Received: by 2002:a05:622a:652:b0:42a:9a69:b40a with SMTP id a18-20020a05622a065200b0042a9a69b40amr6279549qtb.30.1706817131324;
        Thu, 01 Feb 2024 11:52:11 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fx12-20020a05622a4acc00b0042a6e6792basm78837qtb.69.2024.02.01.11.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:52:10 -0800 (PST)
Date: Thu, 1 Feb 2024 14:52:09 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: preallocate temporary extent buffer for inode
 logging when needed
Message-ID: <20240201195209.GA3232474@perftesting>
References: <1ef0997eee1fbe194ab2546f34052cd4e27c6ef4.1706612525.git.fdmanana@suse.com>
 <20240131204148.GA3203388@perftesting>
 <CAL3q7H60nJ5ir3-64u78FyGaj5KTw5KQdtY4Vhz=uDutUaFgEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H60nJ5ir3-64u78FyGaj5KTw5KQdtY4Vhz=uDutUaFgEQ@mail.gmail.com>

On Wed, Jan 31, 2024 at 08:55:43PM +0000, Filipe Manana wrote:
> On Wed, Jan 31, 2024 at 8:41 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Jan 30, 2024 at 11:05:44AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When logging an inode and we require to copy items from subvolume leaves
> > > to the log tree, we clone each subvolume leaf and than use that clone to
> > > copy items to the log tree. This is required to avoid possible deadlocks
> > > as stated in commit 796787c978ef ("btrfs: do not modify log tree while
> > > holding a leaf from fs tree locked").
> > >
> > > The cloning requires allocating an extent buffer (struct extent_buffer)
> > > and then allocating pages (folios) to attach to the extent buffer. This
> > > may be slow in case we are under memory pressure, and since we are doing
> > > the cloning while holding a read lock on a subvolume leaf, it means we
> > > can be blocking other operations on that leaf for significant periods of
> > > time, which can increase latency on operations like creating other files,
> > > renaming files, etc. Similarly because we're under a log transaction, we
> > > may also cause extra delay on other tasks doing an fsync, because syncing
> > > the log requires waiting for tasks that joined a log transaction to exit
> > > the transaction.
> > >
> > > So to improve this, for any inode logging operation that needs to copy
> > > items from a subvolume leaf ("full sync" or "copy everything" bit set
> > > in the inode), preallocate a dummy extent buffer before locking any
> > > extent buffer from the subvolume tree, and even before joining a log
> > > transaction, add it to the log context and then use it when we need to
> > > copy items from a subvolume leaf to the log tree. This avoids making
> > > other operations get extra latency when waiting to lock a subvolume
> > > leaf that is used during inode logging and we are under heavy memory
> > > pressure.
> > >
> > > The following test script with bonnie++ was used to test this:
> > >
> > >   $ cat test.sh
> > >   #!/bin/bash
> > >
> > >   DEV=/dev/sdh
> > >   MNT=/mnt/sdh
> > >   MOUNT_OPTIONS="-o ssd"
> > >
> > >   MEMTOTAL_BYTES=`free -b | grep Mem: | awk '{ print $2 }'`
> > >   NR_DIRECTORIES=20
> > >   NR_FILES=20480
> > >   DATASET_SIZE=$((MEMTOTAL_BYTES * 2 / 1048576))
> > >   DIRECTORY_SIZE=$((MEMTOTAL_BYTES * 2 / NR_FILES))
> > >   NR_FILES=$((NR_FILES / 1024))
> > >
> > >   echo "performance" | \
> > >       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> > >
> > >   umount $DEV &> /dev/null
> > >   mkfs.btrfs -f $MKFS_OPTIONS $DEV
> > >   mount $MOUNT_OPTIONS $DEV $MNT
> > >
> > >   bonnie++ -u root -d $MNT \
> > >       -n $NR_FILES:$DIRECTORY_SIZE:$DIRECTORY_SIZE:$NR_DIRECTORIES \
> > >       -r 0 -s $DATASET_SIZE -b
> > >
> > >   umount $MNT
> > >
> > > The results of this test on a 8G VM running a non-debug kernel (Debian's
> > > default kernel config), were the following.
> > >
> > > Before this change:
> > >
> > >   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
> > >                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> > >   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> > >   debian0       7501M  376k  99  1.4g  96  117m  14 1510k  99  2.5g  95 +++++ +++
> > >   Latency             35068us   24976us    2944ms   30725us   71770us   26152us
> > >   Version 2.00a       ------Sequential Create------ --------Random Create--------
> > >   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
> > >   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> > >   20:384100:384100/20 20480  32 20480  58 20480  48 20480  39 20480  56 20480  61
> > >   Latency               411ms   11914us     119ms     617ms   10296us     110ms
> > >
> > > After this change:
> > >
> > >   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
> > >                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> > >   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> > >   debian0       7501M  375k  99  1.4g  97  117m  14 1546k  99  2.3g  98 +++++ +++
> > >   Latency             35975us  20945us    2144ms   10297us    2217us    6004us
> > >   Version 2.00a       ------Sequential Create------ --------Random Create--------
> > >   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
> > >   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
> > >   20:384100:384100/20 20480  35 20480  58 20480  48 20480  40 20480  57 20480  59
> > >   Latency               320ms   11237us   77779us     518ms    6470us   86389us
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/file.c     | 12 ++++++
> > >  fs/btrfs/tree-log.c | 93 +++++++++++++++++++++++++++------------------
> > >  fs/btrfs/tree-log.h | 25 ++++++++++++
> > >  3 files changed, 94 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > > index f8e1a7ce3d39..fd5e23035a28 100644
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -1912,6 +1912,8 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> > >               goto out_release_extents;
> > >       }
> > >
> > > +     btrfs_init_log_ctx_scratch_eb(&ctx);
> > > +
> > >       /*
> > >        * We use start here because we will need to wait on the IO to complete
> > >        * in btrfs_sync_log, which could require joining a transaction (for
> > > @@ -1931,6 +1933,15 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> > >       trans->in_fsync = true;
> > >
> > >       ret = btrfs_log_dentry_safe(trans, dentry, &ctx);
> > > +     /*
> > > +      * Scratch eb no longer needed, release before syncing log or commit
> > > +      * transaction, to avoid holding unnecessary memory during such long
> > > +      * operations.
> > > +      */
> > > +     if (ctx.scratch_eb) {
> > > +             free_extent_buffer(ctx.scratch_eb);
> > > +             ctx.scratch_eb = NULL;
> > > +     }
> > >       btrfs_release_log_ctx_extents(&ctx);
> > >       if (ret < 0) {
> > >               /* Fallthrough and commit/free transaction. */
> > > @@ -2006,6 +2017,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> > >
> > >       ret = btrfs_commit_transaction(trans);
> > >  out:
> > > +     free_extent_buffer(ctx.scratch_eb);
> > >       ASSERT(list_empty(&ctx.list));
> > >       ASSERT(list_empty(&ctx.conflict_inodes));
> > >       err = file_check_and_advance_wb_err(file);
> > > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > > index 331fc7429952..761b13b3d342 100644
> > > --- a/fs/btrfs/tree-log.c
> > > +++ b/fs/btrfs/tree-log.c
> > > @@ -3619,6 +3619,30 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
> > >       return ret;
> > >  }
> > >
> > > +static int clone_leaf(struct btrfs_path *path, struct btrfs_log_ctx *ctx)
> > > +{
> > > +     const int slot = path->slots[0];
> > > +
> > > +     if (ctx->scratch_eb) {
> > > +             copy_extent_buffer_full(ctx->scratch_eb, path->nodes[0]);
> > > +     } else {
> > > +             ctx->scratch_eb = btrfs_clone_extent_buffer(path->nodes[0]);
> > > +             if (!ctx->scratch_eb)
> > > +                     return -ENOMEM;
> > > +     }
> > > +
> > > +     btrfs_release_path(path);
> > > +     path->nodes[0] = ctx->scratch_eb;
> >
> > Here we put the scratch_b into path->nodes[0], so if we go do the next leaf in
> > the copy_items loop we'll drop our reference for this scratch_eb, and then we're
> > just writing into free'd memory.  Am I missing something here?  Thanks,
> 
> That's why below we take an extra reference on the scratch_eb, it's
> even commented.

My eyes just glazed right over that, I looked through all the callsites and
didn't read this function closely enough.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef


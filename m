Return-Path: <linux-btrfs+bounces-14496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C40EACF495
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A451886776
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416E205ABB;
	Thu,  5 Jun 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b="xewap3Ln"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5C2749C0
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141837; cv=none; b=Idw55LCNoZp69eFhnK/due9znKyp8eB8mrDSICmRBhVapLtHKpDwUInYVZIUnX0rVbFJkraitPmuJ0HwecYCdm6u9Djr0bBtwkTZ0Q1LHyqVSaUaHIFeyqez3VBi0dx453+CsZqRazZLKXrhRFTtS6CVFSRaxGExzyXANYk/b7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141837; c=relaxed/simple;
	bh=CyHI0erxVu+LRiA2EhXmWtBLQFawk9FivkiGkKmX7WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE0vm4MvrIYCb9dur31THosDyVxXsm9yZwwmHrcWKkBycdyPwDpeYNsxQYjuBsdg4gY3sTeugTOzzf1tSbMVDdz0ngkIKIsh1RPk/UTBrbc05zteFRwZVlmIn2Aa8h2RFgsYr1kWZLPt+8ePSeNuO/4RBVPYCkxuzwnhfqQdqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io; spf=pass smtp.mailfrom=jse.io; dkim=pass (2048-bit key) header.d=jse-io.20230601.gappssmtp.com header.i=@jse-io.20230601.gappssmtp.com header.b=xewap3Ln; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jse.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jse.io
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7dae2a8121so158178276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20230601.gappssmtp.com; s=20230601; t=1749141834; x=1749746634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvyqmJnBnFH07m3tAcX0yPC9n8yuCsH9W8QjK/gdVf4=;
        b=xewap3Ln154EnS6Zb7cZMk/81fcfYHGJsmSjhzSJwWPtvM2oiEiyr6N/I7liAa7B/m
         /oBGiTgT2ilwPlwKMJTtzfAg3ypUBqGnReBvtT2I5ZbgLeHj11MzjL87LFWB3Uk/sfUG
         gXQ8tuKlZgQjXhCruwdJI8ZHS9nS78DVsb5trPjJ9hyjKA52fP7m68NFJY2XHVLIimcC
         6K1WtvPnDH3zwdck9dl/GS1XsRMeIKyBRAk2qbs7SkrncJjD5o0a0zvDnUNWDgwk+Mt8
         SiKmMIaiTTk0NnaC/Fay/ZfprrI5CIcTBCNPv9FpZCEp84uFz+zFkB5srLXOvvPG50aK
         rSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749141834; x=1749746634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvyqmJnBnFH07m3tAcX0yPC9n8yuCsH9W8QjK/gdVf4=;
        b=bv1/AzIEQALdiEecTe73vbzA5KWyauN4k8hHePJlm1gHHQ9kYLoq/1xnZhzsmrS0J8
         ZbtAs9MQ+S8sSynblP6pZHqsFiyho0SEZlRvCOsofrctOxktp6TY+9GQvnwcC5r5SHIi
         NWv594SbmQY8t8CDSUsoBpLAw7hiamd9VFJHz5Dyrjwk2as7/GMF878KmFlYE/ZCFre8
         kKTi4ViOgFYuq5JeJWqbajrJTA9DSRZOSGlnXKEaNpXcpRkBLuqpAl5UBgl4l9C4ri4q
         Up8Ol45ddlXH4TEV88Gindjl4pbPMK1C3t6dJs6hrRNtqILuMpWSCzWLwRwGfNc1uBAD
         YC+A==
X-Gm-Message-State: AOJu0Yw/9jUoOmJA5oKt8LLxoNgv5MFxAKIKhwSMiDspKL5bI9CbaDb4
	ZqQ/DDit5UpNEIWEfRXPUj2vNIQF5CE3k9kxb6sgy1vDAlp6IMjUBXGKvwb8i1nEVDs6xor8Gov
	QOXbHE5wDCDTZ8Nzp6dE2bTbQ9fTzXjtk8SrcI0xmsg==
X-Gm-Gg: ASbGnctI6QhRh5f1SYpY45E+FBUNzwX0VTl6ruO8TlgXl4bleMkjlpCHhjxBljo6+m1
	r0s8pCEZzbDjqmJ7iNWe3l8Dy+z7PZhEOVAqtlcENk2uTpZypV4zoKJDO8oAb5fNivMCWRwuOwc
	PhnSmrf2M3jOAHiYsVbHxSG1Ry2CtJQ4w=
X-Google-Smtp-Source: AGHT+IGgajcAM6+v4kskuCqoqRzLwkYuv/GDzPbnNcFk5aU55h0LEl8bhwd4AR9EirBinP2g15puem1Iq5nxuoXyMDw=
X-Received: by 2002:a05:6902:2842:b0:e81:75a2:d69 with SMTP id
 3f1490d57ef6-e81a28baeadmr203314276.9.1749141833878; Thu, 05 Jun 2025
 09:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605162345.2561026-1-maharmstone@fb.com>
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>
From: Jonah Sabean <jonah@jse.io>
Date: Thu, 5 Jun 2025 13:43:18 -0300
X-Gm-Features: AX0GCFtR3ig0KezavNxs-ot4jvQgKrAYq15y23yRaTsA3FM7z901AfxuJh-UeHs
Message-ID: <CAFMvigdEQVj-uJqfCVqYXf8a51xY48gsYg+tvFNFrC3gPyF-gA@mail.gmail.com>
Subject: Re: [PATCH 00/12] btrfs: remap tree
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 1:25=E2=80=AFPM Mark Harmstone <maharmstone@fb.com> =
wrote:
>
> This patch series adds a disk format change gated behind
> CONFIG_BTRFS_EXPERIMENTAL to add a "remap tree", which acts as a layer of
> indirection when doing I/O. When doing relocation, rather than fixing up =
every
> tree, we instead record the old and new addresses in the remap tree. This=
 should
> hopefully make things more reliable and flexible, as well as enabling som=
e
> future changes we'd like to make, such as larger data extents and reducin=
g
> write amplification by removing cow-only metadata items.
>
> The remap tree lives in a new REMAP chunk type. This is because bootstrap=
ping
> means that it can't be remapped itself, and has to be relocated by COWing=
 it as
> at present. It can't go in the SYSTEM chunk as we are then limited by the=
 chunk
> item needing to fit in the superblock.
>
> For more on the design and rationale, please see my RFC sent last month[1=
], as
> well as Josef Bacik's original design document[2]. The main change from J=
osef's
> design is that I've added remap backrefs, as we need to be able to move a
> chunk's existing remaps before remapping it.
>
> You will also need my patches to btrfs-progs[3] to make
> `mkfs.btrfs -O remap-tree` work, as well as allowing `btrfs check` to rec=
ognize
> the new format.
>
> Changes since the RFC:
>
> * I've reduce the REMAP chunk size from the normal 1GB to 32MB, to match =
the
>   SYSTEM chunk. For a filesystem with 4KB sectors and 16KB node size, the=
 worst
>   case is that one leaf covers ~1MB of data, and the best case ~250GB. Fo=
r a
>   chunk, that implies a worst case of ~2GB and a best case of ~500TB.
>   This isn't a disk-format change, so we can always adjust it if it prove=
s too
>   big or small in practice. mkfs creates 8MB chunks, as it does for every=
thing.

One thing I'd like to see fixed is the fragmentation of dev_extents on
stripped profiles when you have less than 1G left of space, as btrfs
will allocate these smaller chunks across a stripped array (ie raid0,
10, 5 or 6), otherwise being able to support larger extents can be
made moot because you can end up with chunks being less as small as
1MiB. Depending on if you add/remove devices often and balance often
you can end up with a lot of chunks across all disks that can be made
smaller, so one hacky way I've got around this is to align partitions
and force the system chunk to 1G with this patch:
https://pastebin.com/4PWbgEXV

Ideally, I'd like this problem solved, but it seems to me this will
just add yet another small chunk in the mix that makes alignment
harder in this case. Really makes striping a curse on btrfs.

>
> * You can't make new allocations from remapped block groups, so I've chan=
ged
>   it so there's no free-space entries for these (thanks to Boris Burkov f=
or the
>   suggestion).
>
> * The remap tree doesn't have metadata items in the extent tree (thanks t=
o Josef
>   for the suggestion). This was to work around some corruption that delay=
ed refs
>   were causing, but it also fits it with our future plans of removing all
>   metadata items for COW-only trees, reducing write amplification.
>   A knock-on effect of this is that I've had to disable balancing of the =
remap
>   chunk itself. This is because we can no longer walk the extent tree, an=
d will
>   have to walk the remap tree instead. When we remove the COW-only metada=
ta
>   items, we will also have to do this for the chunk and root trees, as
>   bootstrapping means they can't be remapped.
>
> * btrfs_translate_remap() uses search_commit_root when doing metadata loo=
kups,
>   to avoid nested locking issues. This also seems to be a lot quicker (bt=
rfs/187
>   went from ~20mins to ~90secs).
>
> * Unused remapped block groups should now get cleaned up more aggressivel=
y
>
> * Other miscellaneous cleanups and fixes
>
> Known issues:
>
> * Relocation still needs to be implemented for the remap tree itself (see=
 above)
>
> * Some test failures: btrfs/156, btrfs/170, btrfs/226, btrfs/250
>
> * nodatacow extents aren't safe, as they can race with the relocation thr=
ead.
>   We either need to follow the btrfs_inc_nocow_writers() approach, which =
COWs
>   the extent, or change it so that it blocks here.
>
> * When initially marking a block group as remapped, we are walking the fr=
ee-
>   space tree and creating the identity remaps all in one transaction. For=
 the
>   worst-case scenario, i.e. a 1GB block group with every other sector all=
ocated
>   (131,072 extents), this can result in transaction times of more than 10=
 mins.
>   This needs to be changed to allow this to happen over multiple transact=
ions.
>
> * All this is disabled for zoned devices for the time being, as I've not =
been
>   able to test it. I'm planning to make it compatible with zoned at a lat=
er
>   date.
>
> Thanks
>
> [1] https://lwn.net/Articles/1021452/
> [2] https://github.com/btrfs/btrfs-todo/issues/54
> [3] https://github.com/maharmstone/btrfs-progs/tree/remap-tree
>
> Mark Harmstone (12):
>   btrfs: add definitions and constants for remap-tree
>   btrfs: add REMAP chunk type
>   btrfs: allow remapped chunks to have zero stripes
>   btrfs: remove remapped block groups from the free-space tree
>   btrfs: don't add metadata items for the remap tree to the extent tree
>   btrfs: add extended version of struct block_group_item
>   btrfs: allow mounting filesystems with remap-tree incompat flag
>   btrfs: redirect I/O for remapped block groups
>   btrfs: handle deletions from remapped block group
>   btrfs: handle setting up relocation of block group with remap-tree
>   btrfs: move existing remaps before relocating block group
>   btrfs: replace identity maps with actual remaps when doing relocations
>
>  fs/btrfs/Kconfig                |    2 +
>  fs/btrfs/accessors.h            |   29 +
>  fs/btrfs/block-group.c          |  202 +++-
>  fs/btrfs/block-group.h          |   15 +-
>  fs/btrfs/block-rsv.c            |    8 +
>  fs/btrfs/block-rsv.h            |    1 +
>  fs/btrfs/discard.c              |   11 +-
>  fs/btrfs/disk-io.c              |   91 +-
>  fs/btrfs/extent-tree.c          |  152 ++-
>  fs/btrfs/free-space-tree.c      |    4 +-
>  fs/btrfs/free-space-tree.h      |    5 +-
>  fs/btrfs/fs.h                   |    7 +-
>  fs/btrfs/relocation.c           | 1897 ++++++++++++++++++++++++++++++-
>  fs/btrfs/relocation.h           |    8 +-
>  fs/btrfs/space-info.c           |   22 +-
>  fs/btrfs/sysfs.c                |    4 +
>  fs/btrfs/transaction.c          |    7 +
>  fs/btrfs/tree-checker.c         |   37 +-
>  fs/btrfs/volumes.c              |  115 +-
>  fs/btrfs/volumes.h              |   17 +-
>  include/uapi/linux/btrfs.h      |    1 +
>  include/uapi/linux/btrfs_tree.h |   29 +-
>  22 files changed, 2444 insertions(+), 220 deletions(-)
>
> --
> 2.49.0
>
>


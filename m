Return-Path: <linux-btrfs+bounces-1678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F8E83A9B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 13:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FA22843B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EEA6312B;
	Wed, 24 Jan 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNAKH8EN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366C63104;
	Wed, 24 Jan 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099219; cv=none; b=dO9JdoTUhtSWKi3gdM92R9oi/TYV7EHkm5vmxKha6cbNzseuBUENrjGXhbRbiH7eSMr2bZZHOYbsyBWNsQWxeISIcu1OjeMl3OaHF2KCHP+IL/0s9e76lBqQqZW4lLcAgRhRlZehzDz21pd8zHS71599w5kLXB+QxRr56vxNrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099219; c=relaxed/simple;
	bh=sokFyt3mSuavzepIH7e9kSFnlRXWMgM/efjYmTGdEBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ts9Q420y1WrmnkEmA9XmhjesQqWf9YX3P4M4ONzE8CwBQ5noizQjz7/uTrakP8KR71DhoBkca6V6cu7OMhkBh3oUy92UWNc4kyOuBfbTTiKDNIO84SzWJVJ3pC4dbZadQQgCyxTYkaKAabJA6dDzpd0yk2x83bAy3Mc5hxKBWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNAKH8EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52A0C43394;
	Wed, 24 Jan 2024 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706099218;
	bh=sokFyt3mSuavzepIH7e9kSFnlRXWMgM/efjYmTGdEBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YNAKH8ENctzvFtyObrHXkiG/CNZaVZsah9AfZsp3JgLGizhSmpr3mOruLohnnB+Uo
	 I3qKcEWc5Y1/OK9JTcYbEpx6RK+LyVSsUlCl8MtNhabf1/dGzsrUxM+iu146OR/ZCe
	 IT8kR6e9IPakekAPvlPvdxwsAf2Tggk/qGYyPO3ZhJSohIsWwwCu1LsCPFhZEOAfWY
	 B/OM/TgaBIuJZh3gNQjVjVaRapq/6LGYTPx4EZ1wbQ+YpNn61R2Olv3+e2KxTEIYcI
	 gPD6GnuAtO7UwOUXz7Q9JjTC7AyqnZazh9rZiSVQzZf6HzSsXXIPiBUo5XVwQMatuM
	 gi2bePigJKRCQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5100c3f7df1so1759464e87.0;
        Wed, 24 Jan 2024 04:26:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yy1GqbzKaL0yFtnQchtV/zFoMmG41gMByRJ5hZjYg/imIVED0yp
	4HCJ2/b1cnPr2tCABvjiFkm6XmEpFRAYfYZRAjBAK+wegF+jkU7jxNxJckSoiN1b6JXJb1EFVyk
	yCp8qkKKeDwD75TviNPiNeZz3dvM=
X-Google-Smtp-Source: AGHT+IFI/0Fnjm4/qIY5JfFqEhqxq6/gfaLIPVxiqu15KyWN+qWSvw62ZLnZ7jNdrU6QcxMAnZex6fwa4tv2cx6gJ9Y=
X-Received: by 2002:a19:670c:0:b0:50e:8eff:3980 with SMTP id
 b12-20020a19670c000000b0050e8eff3980mr3418693lfc.30.1706099216896; Wed, 24
 Jan 2024 04:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ce4a79cafb6790ef6d1e141d65195f72f469ae4d.1706035378.git.boris@bur.io>
In-Reply-To: <ce4a79cafb6790ef6d1e141d65195f72f469ae4d.1706035378.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 24 Jan 2024 12:26:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H60vbgsv_2RD6DacdV7Um+httPRW6ccqG6qgoYJojya4w@mail.gmail.com>
Message-ID: <CAL3q7H60vbgsv_2RD6DacdV7Um+httPRW6ccqG6qgoYJojya4w@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/310: test qgroup deletion
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 6:44=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> When using squotas, an extent's OWNER_REF can long outlive the subvolume
> that is the owner, since it could pick up a different reference that
> keeps it around, but the subvolume can go away.
>
> Test this case, as originally, it resulted in a read only btrfs.
>
> Since we can blow up the subvolume in the same transaction as the extent
> is written, we can also increment the usage of a non-existent subvolume.
>
> This leaves an OWNER_REF behind with no corresponding incremented usage
> in a qgroup, so if we re-create that qgroup, we can then underflow its
> usage.
>
> Both of these cases are fixed in the kernel by disallowing
> creating subvol qgroups and by disallowing deleting qgroups that still
> have usage.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - removed enable quota helper
> - removed unneeded commented cleanup boilerplate
> - change test number 304 -> 310 (based on v2024.01.14)
>
>  tests/btrfs/301     | 14 ++------
>  tests/btrfs/310     | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out |  6 ++++
>  3 files changed, 91 insertions(+), 12 deletions(-)
>  create mode 100755 tests/btrfs/310
>  create mode 100644 tests/btrfs/310.out
>
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index db4697247..4c1127aa0 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -157,16 +157,6 @@ do_enospc_falloc()
>         do_falloc $file $sz
>  }
>
> -enable_quota()
> -{
> -       local mode=3D$1
> -
> -       [ $mode =3D=3D "n" ] && return
> -       arg=3D$([ $mode =3D=3D "s" ] && echo "--simple")
> -
> -       $BTRFS_UTIL_PROG quota enable $arg $SCRATCH_MNT
> -}
> -
>  get_subvid()
>  {
>         _btrfs_get_subvolid $SCRATCH_MNT subv
> @@ -186,7 +176,7 @@ prepare()
>  {
>         _scratch_mkfs >> $seqres.full
>         _scratch_mount
> -       enable_quota "s"
> +       $BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
>         $BTRFS_UTIL_PROG subvolume create $subv >> $seqres.full
>         local subvid=3D$(get_subvid)
>         set_subvol_limit $subvid $limit
> @@ -397,7 +387,7 @@ enable_mature()
>         # Sync before enabling squotas to reliably *not* count the writes
>         # we did before enabling.
>         sync
> -       enable_quota "s"
> +       $BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
>         set_subvol_limit $subvid $limit
>         _scratch_cycle_mount
>         usage=3D$(get_subvol_usage $subvid)

What's the relation of this change with the new test case?
This is an independent change that should be in its own separate patch.

> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 000000000..02714d261
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Test various race conditions between qgroup deletion and squota writes
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup subvol clone
> +
> +# Import common functions.
> +. ./common/reflink
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_reflink
> +_require_cp_reflink
> +_require_scratch_enable_simple_quota
> +_require_no_compress
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: forbid deleting live subvol=
 qgroup"
> +_fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: forbid creating subvol qgro=
ups"
> +
> +subv1=3D$SCRATCH_MNT/subv1
> +subv2=3D$SCRATCH_MNT/subv2
> +
> +prepare()
> +{
> +    _scratch_mkfs >> $seqres.full
> +    _scratch_mount
> +    $BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
> +    $BTRFS_UTIL_PROG subvolume create $subv1 >> $seqres.full
> +    $BTRFS_UTIL_PROG subvolume create $subv2 >> $seqres.full
> +    $XFS_IO_PROG -fc "pwrite -q 0 128K" $subv1/f
> +    _cp_reflink $subv1/f $subv2/f
> +}
> +
> +# An extent can long outlive its owner. Test this by deleting the owning
> +# subvolume, committing the transaction, then deleting the reflinked cop=
y.
> +# Deleting the copy will attempt to free space from the missing owner, w=
hich
> +# should be a no-op.
> +free_from_deleted_owner()
> +{
> +    echo "free from deleted owner"
> +    prepare
> +    subvid1=3D$(_btrfs_get_subvolid $SCRATCH_MNT subv1)

Should be made local.

> +
> +    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +    $BTRFS_UTIL_PROG subvolume delete $subv1 >> $seqres.full
> +    $BTRFS_UTIL_PROG qgroup destroy 0/$subvid1 $SCRATCH_MNT >> $seqres.f=
ull
> +    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +    rm $subv2/f
> +    _scratch_unmount
> +}
> +
> +# A race where we delete the owner in the same transaction as writing th=
e
> +# extent leads to incrementing the squota usage of the missing qgroup.
> +# This leaves behind an owner ref with an owner id that cannot exist, so
> +# freeing the extent now frees from that qgroup, but there has never
> +# been a corresponding usage to free.
> +add_to_deleted_owner()
> +{
> +    echo "add to deleted owner"
> +    prepare
> +    subvid1=3D$(_btrfs_get_subvolid $SCRATCH_MNT subv1)

Should be made local as well.

Thanks.

> +
> +    $BTRFS_UTIL_PROG subvolume delete $subv1 >> $seqres.full
> +    $BTRFS_UTIL_PROG qgroup destroy 0/$subvid1 $SCRATCH_MNT >> $seqres.f=
ull
> +    $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +    $BTRFS_UTIL_PROG qgroup create 0/$subvid1 $SCRATCH_MNT >> $seqres.fu=
ll
> +    rm $subv2/f
> +    _scratch_unmount
> +}
> +
> +free_from_deleted_owner
> +add_to_deleted_owner
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 000000000..d7d4bc0ae
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,6 @@
> +QA output created by 310
> +free from deleted owner
> +ERROR: unable to destroy quota group: Device or resource busy
> +add to deleted owner
> +ERROR: unable to destroy quota group: Device or resource busy
> +ERROR: unable to create quota group: Invalid argument
> --
> 2.43.0
>
>


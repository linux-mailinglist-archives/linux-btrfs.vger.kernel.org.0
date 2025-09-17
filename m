Return-Path: <linux-btrfs+bounces-16888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539EB80B3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 17:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078D652783C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60F314D24;
	Wed, 17 Sep 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/qxYTyq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753C314D15
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123742; cv=none; b=GDB6GSp6Ys4Az5hAswD4BbXIhw3cXnqxoDSZ55OnhAP+0frVBKRU6TXq73ZGJ7MOP0QCcrUS0NaAlswypIIYtIkpuCdMbhrNRAV2sKjs2sbpRESAXzDbz9o7u9ZMgqXs/tT+4LgqYK0qE3nhBHTbo8DlGJJ6smkb8f5SVZPbnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123742; c=relaxed/simple;
	bh=AfmoQIEBkUMfDodnI9YLP228cWyjWe1vTqyKEapVVQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6dV8ZEsLzfqvC4E6DbrnLL0Ssl6btLBaPnC2Q5Wypl9OWYMvHJMfBSb8kD8zUk7xvG/x7PH02NhIdZJ6VNveKvon9vas2nnjXZxlFk5MBF8ymbwVxB1gw0AKjqSQ6TLUhw8+CKDi4aG++F9edAivxY+X4eTjzFOBiN92Yxsmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/qxYTyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76CFC4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123741;
	bh=AfmoQIEBkUMfDodnI9YLP228cWyjWe1vTqyKEapVVQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E/qxYTyq9F34vVgbVO6cpvsKfeyJFE0xW5/LfhspBF6qN7YMIAtFix1uD5ggNW6XM
	 uHyuwKDB205bQhUoUzF8MMC8WJ0DATKotaCVw4kb4VVOauwqsM+6Ka2nWPIQf1bhFd
	 lBRHP52Ghhf+zGegRnwzC4NopQ5cK/rvB5Q8uL/oX9KRIQvJc62eEqtEVu8vuCN6Rn
	 iiz95FSpA7Axi1BW5y44c9dtzzVYdo7Cr1fRT4JoT+G4svikQjUpR/NXhOdTCglKoc
	 4qBTM6QRvguOI2bFTpMn28K15xl3REkWhfxoCXD1DWIYLEas4FRN7sjYsKV62Abzwh
	 MImQYaotyJqtQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f2b27a751so5558699a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 08:42:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YxL+qdMCwKzDNslAEwnLwpI6IEVI0ZZo3yiuCfUUsxSv7d1iD31
	H2Nap0fnA4wRaBHuXIFmy4bGdwxP8u89ooh27bMVqtuevhIoU/j61RmiE6MIRZNDVj55OtI7bvt
	KTJ8ZKv/2iTErf8jlTFCLxfIyxe1oF3c=
X-Google-Smtp-Source: AGHT+IGtJ7TnH6Y0u3ZPLQilbf3vELhCRenlom2XkwwJoQjO+AFhCxqsem2zw7EWCX8sC27n2DokJviF+qbkD9q3l04=
X-Received: by 2002:a17:907:c0a:b0:b04:74d1:a561 with SMTP id
 a640c23a62f3a-b1bb6239b15mr392383466b.25.1758123740215; Wed, 17 Sep 2025
 08:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910175007.23176-1-dsterba@suse.com>
In-Reply-To: <20250910175007.23176-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 17 Sep 2025 16:41:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4vXmz4pGXayq98XZqPbFh6H6Z4=eaM-gFX7fsRLnFfEQ@mail.gmail.com>
X-Gm-Features: AS18NWDumFLaal85sT6gB01QjdrN7S8z-Bdvmsa7r2a4uzjHghkvHz1ZTifi_0Y
Message-ID: <CAL3q7H4vXmz4pGXayq98XZqPbFh6H6Z4=eaM-gFX7fsRLnFfEQ@mail.gmail.com>
Subject: Re: Btrfs progs release 6.16.1
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, Mark Harmstone <maharmstone@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 7:15=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> Hi,
>
> btrfs-progs version 6.16.1 have been released. This is a minor feature up=
date
> (mkfs.btrfs) and bugfix release.
>
> Changelog:
>
> * mkfs:
>    * add option --reflink, when used with --rootdir clone file extents in=
stead
>      of copying (requires source and target image on the same filesystem)
>    * improved tracking of inodes and subvolumes for option --inode-flags
>    * fix initializing raid-stripe-tree
>    * extend what is trimmed/discarded during initialization (temporary ch=
unks,
>      free space)
> * check: detect duplicate file names in directory items
> * inspect tree-stats: accept string names for option -t
> * receive: allow to dump stream from different user
> * other:
>    * updated documentation
>    * new and updated tests

With this btrfs-progs release, running 'btrfs check' fails on a
filesystem created by an older mkfs.btrfs.

For example, create an empty fs with 6.14:

$ mkfs.btrfs -f /dev/sdc
btrfs-progs v6.14
See https://btrfs.readthedocs.io for more information.

Performing full device TRIM /dev/sdc (100.00GiB) ...
NOTE: several default settings have changed in version 5.15, please make su=
re
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               86a7103b-88eb-4a6a-b542-05523067d6f9
Node size:          16384
Sector size:        4096 (CPU page size: 4096)
Filesystem size:    100.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP               1.00GiB
  System:           DUP               8.00MiB
SSD detected:       no
Zoned device:       no
Features:           extref, skinny-metadata, no-holes, free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1   100.00GiB  /dev/sdc

Now run 'btrfs check' from this release and it fails:

$ btrfs check /dev/sdc
Opening filesystem to check...
Checking filesystem on /dev/sdc
UUID: 86a7103b-88eb-4a6a-b542-05523067d6f9
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
We have a space info key for a block group that doesn't exist
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 147456 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 147456
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 140530
file data blocks allocated: 0
 referenced 0

A bisection points to:

commit e2cf6a03796b73d446b086022c0dfcf6a6552928
Author: Mark Harmstone <maharmstone@fb.com>
Date:   Fri Jul 18 15:26:27 2025 +0100

    btrfs-progs: use btrfs_lookup_block_group() in check_free_space_tree()




>
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-prog=
s/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
> Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.16.1
>


Return-Path: <linux-btrfs+bounces-124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974107EABAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03731B20BAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Nov 2023 08:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2E125AB;
	Tue, 14 Nov 2023 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFiZMNRI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2575BE60;
	Tue, 14 Nov 2023 08:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306B5C433C8;
	Tue, 14 Nov 2023 08:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699950881;
	bh=/ZPh84xGNHaChkwC9/BKraA3PiWHlPqYWr4xuPZnq1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KFiZMNRIhr1deVzG/AqaASx+11Z3cKa88YF+cRWuV4KmrAYpCNTN3TZRyBfc7FYha
	 +LqHqMNxv39MXJyXsSuhsf0t7AODDqPojkQ/Q8MJ6UJKn+QrySXPat9E682WlPClp6
	 xQRB4/mBkPyT/UA0hz3J0eDGChp34GpAmpCdevsVTqon+lw0i9aWq18Gik6Xox3txZ
	 Hpur4ChPQ5Rf7b8MCw72B1jwLRt7t693lG8lm9C5/+zOW3GexITH/cwaOHj7rCVEhY
	 R1bYyvgwk/6Fk0Hl4TKffm/9lkLwf7xN/H5OmC8yeAN8k6bn9IXtjAUzP+a0NaWyQc
	 HyK9H6gSauwAg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9e62b14c9eeso563418166b.2;
        Tue, 14 Nov 2023 00:34:41 -0800 (PST)
X-Gm-Message-State: AOJu0Ywq7uQ+kfGBEAZnDo3n5dn56DPg+GwWiN7oLcesj5qbwc2Yjpdh
	AdxuSlbI+sfjnwGKkQVHI5ugZWby47aoxP/WZk0=
X-Google-Smtp-Source: AGHT+IE0E8YvCbmdETt2XZR2wIMsqWOrTZ2Yjps9vBTlR689saqDcSlKQgqvJffxBHzdh+5L0klTnPMp/amfhzVTwjQ=
X-Received: by 2002:a17:906:234d:b0:9d3:f436:6809 with SMTP id
 m13-20020a170906234d00b009d3f4366809mr6562591eja.39.1699950879545; Tue, 14
 Nov 2023 00:34:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114025913.83171-1-wqu@suse.com>
In-Reply-To: <20231114025913.83171-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 14 Nov 2023 08:34:02 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7+S65_0dSsoSjHpJwCwNZOD96+7HfEAO25Va5h0GzHUQ@mail.gmail.com>
Message-ID: <CAL3q7H7+S65_0dSsoSjHpJwCwNZOD96+7HfEAO25Va5h0GzHUQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: test snapshot creation with existing qgroup
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 2:59=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is a sysbot regression report about transaction abort during
> snapshot creation, which is caused by the new timing of qgroup creation
> and too strict error check.
>
> [FIX]
> The proper fix is already submitted, with the title "btrfs: do not abort
> transaction if there is already an existing qgroup".
>
> [TEST]
> The new test case would reproduce the regression by:
>
> - Create a subvolume and a snapshot of it
>
> - Record the subvolumeid of the snapshot
>
> - Re-create the fs
>   Since btrfs won't reuse the subvolume id, we have to re-create the fs.
>
> - Enable quota and create a qgroup with the same subvolumeid
>
> - Create a subvolume and a snapshot of it
>   For unpatched and affected kernel (thankfully no release is affected),
>   the snapshot creation would fail due to aborted transaction.
>
> - Make sure the subvolume id doesn't change for the snapshot
>   There is one very hacky attempt to fix it by avoiding using the
>   subvolume id, which is completely wrong and would be caught by this
>   extra check.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Now it looks good, thanks.

> ---
> Changelog:
> v2:
> - Add to 'snapshot' and 'subvol' groups
>
> - Remove one unnecessary sync
>   The sync after qgroup creation is not needed, the qgroup id conflicts
>   doesn't need qgroup tree to be committed anyway.
>
> - Remove one unnecessary unmount
>   The final scratch unmount is not needed as the framework would unmount
>   it automatically.
> ---
>  tests/btrfs/303     | 77 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/303.out |  2 ++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/btrfs/303
>  create mode 100644 tests/btrfs/303.out
>
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> new file mode 100755
> index 00000000..b9d6c61d
> --- /dev/null
> +++ b/tests/btrfs/303
> @@ -0,0 +1,77 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 303
> +#
> +# A regression test to make sure snapshot creation won't cause transacti=
on
> +# abort if there is already an existing qgroup.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot subvol qgroup
> +
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_scratch
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: do not abort transaction if there is already an existing =
qgroup"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# Create the first subvolume and get its id.
> +# This subvolume id should not change no matter if there is an existing
> +# qgroup for it.
> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> +       "$SCRATCH_MNT/snapshot">> $seqres.full
> +
> +init_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> +
> +if [ -z "$init_subvolid" ]; then
> +       _fail "Unable to get the subvolid of the first snapshot"
> +fi
> +
> +echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
> +
> +_scratch_unmount
> +
> +# Re-create the fs, as btrfs won't reuse the subvolume id.
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >> $seqres.full
> +
> +# Create a qgroup for the first subvolume, this would make the later
> +# subvolume creation to find an existing qgroup, and abort transaction.
> +$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $seq=
res.full
> +
> +# Now create the first snapshot, which should have the same subvolid no =
matter
> +# if the quota is enabled.
> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> +       "$SCRATCH_MNT/snapshot" >> $seqres.full
> +
> +# Either the snapshot create failed and transaction is aborted thus no
> +# snapshot here, or we should be able to create the snapshot.
> +new_subvolid=3D$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> +
> +echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
> +
> +if [ -z "$new_subvolid" ]; then
> +       _fail "Unable to get the subvolid of the first snapshot"
> +fi
> +
> +# Make sure the subvolumeid for the first snapshot didn't change.
> +if [ "$new_subvolid" -ne "$init_subvolid" ]; then
> +       _fail "Subvolumeid for the first snapshot changed, has ${new_subv=
olid} expect ${init_subvolid}"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> new file mode 100644
> index 00000000..d48808e6
> --- /dev/null
> +++ b/tests/btrfs/303.out
> @@ -0,0 +1,2 @@
> +QA output created by 303
> +Silence is golden
> --
> 2.42.0
>
>


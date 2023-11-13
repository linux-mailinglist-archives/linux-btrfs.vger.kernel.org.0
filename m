Return-Path: <linux-btrfs+bounces-91-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2AC7E9D40
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 14:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997981C2028E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB73208A1;
	Mon, 13 Nov 2023 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+zI5kus"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2421E524;
	Mon, 13 Nov 2023 13:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9683C433C7;
	Mon, 13 Nov 2023 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699882427;
	bh=3nUy2UR0toQ7Pz+9xZLpGfauoIU4z10oKrhZ78CIuas=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I+zI5kusvqvRQmENbsiHp/6mXvMuFOV2XNeKJJCXhJhe9Ghr0iJ8FJeBvcyZ8Vfvu
	 J0V9vV0JjImt1c5rH3a7LA3xK5ml51vIzhyRc2c72JQQG4UlY6ri9PzGKLRdaOQO3a
	 QSQob9EqIGYDekqRWtL+GAKx/m3FCBywBYIfKvP3LhaNaupxL3l5HFGRbvxNTqPVKU
	 I/gH4Il89zdEJNhqF7xq4Ss81woXmGBhMbDSPRr/SIkVnonmWILDRN9U2MU7ns3p+/
	 f/UbdFaSKRLHYcVfUyDjWjoNfbEX1vRHpammURojj1YLBidYo1no81hX8mTRd46mZJ
	 CSUiwK8uKyG2Q==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9d242846194so654971266b.1;
        Mon, 13 Nov 2023 05:33:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yz+IrfeVU7KVgHejgtnqIooQTWgjYtnYEEoEhVzm1+oHGWjess3
	DKr4VsuUrH+8h6JZrnPlpyGywOWHgo0PGgWTttY=
X-Google-Smtp-Source: AGHT+IGsIoSo8vMd1f4oncvbMF+CC3aiNGO3JXU73BLMmh1iCZp2XdulJYUS1UOaWpCdMYV+j9T/7BkcyIIQ7EjJ5Ys=
X-Received: by 2002:a17:906:4ecb:b0:9bf:d70b:9873 with SMTP id
 i11-20020a1709064ecb00b009bfd70b9873mr3726806ejv.39.1699882426257; Mon, 13
 Nov 2023 05:33:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112233325.103250-1-wqu@suse.com>
In-Reply-To: <20231112233325.103250-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 13 Nov 2023 13:33:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5so2=7MojMydXZfxQPCYmFrcNMvqA8fBxtKfEZ5hhsNA@mail.gmail.com>
Message-ID: <CAL3q7H5so2=7MojMydXZfxQPCYmFrcNMvqA8fBxtKfEZ5hhsNA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: test snapshot creation with existing qgroup
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 11:33=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
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
> ---
>  tests/btrfs/303     | 80 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/303.out |  2 ++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/btrfs/303
>  create mode 100644 tests/btrfs/303.out
>
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> new file mode 100755
> index 00000000..fe924496
> --- /dev/null
> +++ b/tests/btrfs/303
> @@ -0,0 +1,80 @@
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
> +_begin_fstest auto quick qgroup

Also 'snapshot' and 'subvol' groups.

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
> +sync

This sync is not needed. An unpatched kernel still fails, and a
patched kernel passes this test without the sync.

Also, please always comment on why a sync is needed.
In this case it can be removed because it's redundant.

> +
> +# Now create the first snapshot, which should have the same subvolid no =
matter
> +# if the quota is enabled.
> +$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> +       "$SCRATCH_MNT/snapshot">> $seqres.full
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
> +_scratch_unmount

This explicit unmount is not needed, the fstests framework
automatically does that.

Otherwise it looks fine, thanks.

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


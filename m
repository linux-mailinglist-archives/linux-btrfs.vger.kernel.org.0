Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57089737D5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 10:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjFUIT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 04:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjFUITY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 04:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4841733;
        Wed, 21 Jun 2023 01:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB13D614AE;
        Wed, 21 Jun 2023 08:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E7CC433C9;
        Wed, 21 Jun 2023 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687335560;
        bh=mdDAjvND6Rjw38ur1Tpm014buZes1ZofRgu+Jt4Q3Fg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WnKNhW31qGA0PBN2Dz5MSdIOTspbhNY7avNr9fP6G0vlAlmEb45BoEjG19EpCJDTD
         4netKq9UWCFHkbXBzlOVMSeoHKeh1ypL/TxjiG/16qhv9noF67tyQ7oTMpMoZXs27+
         wDS3heNQbOq9XpTsw9IOmmkKyTy12EkAP0akOlkow07LWmPsVetf8Pz/G4o8p76B6R
         5y/8lGBxt5s0MxCweOqUoNmdsyUdxE2uIVZx/wBGC4atWPjyLrV2KGCVqkxe2sczN+
         earn06NW9sr3zoIOPBB29ilyfW3MY0AX6EP2/J5K7zHCchC6n72X2RNiU9Z5zb2wAG
         /4ePQTIP3ie9g==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1a998a2e7a6so5814935fac.1;
        Wed, 21 Jun 2023 01:19:20 -0700 (PDT)
X-Gm-Message-State: AC+VfDyLhbxfQBuR5Z7Xtfewsr0TGWP+JATndfLGHGzsXHzDmccuMbjS
        8u2T5H/JCWVZmW6vzi0dXE9hQUOEf8P9OntCXts=
X-Google-Smtp-Source: ACHHUZ4xAsC3ndS9mPl2aSJIrElv/yCLhRNJlasAFunERL4BXNTPLk8KITvhYQNQsz7bXSW1z4EVd5zFk8Tb+jnRVYc=
X-Received: by 2002:a05:6870:7c18:b0:1ad:7fb:da58 with SMTP id
 je24-20020a0568707c1800b001ad07fbda58mr2609538oab.12.1687335559174; Wed, 21
 Jun 2023 01:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230621070744.199846-1-wqu@suse.com>
In-Reply-To: <20230621070744.199846-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 21 Jun 2023 09:18:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H48SsJvj6ZtqhJj94F9O3gJbSo6Ydg4g_zQvfwS2DMppA@mail.gmail.com>
Message-ID: <CAL3q7H48SsJvj6ZtqhJj94F9O3gJbSo6Ydg4g_zQvfwS2DMppA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add test case to verify the behavior with large
 RAID0 data chunks
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 21, 2023 at 8:24=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a recent regression during v6.4 merge window, that a u32 left
> shift overflow can cause problems with large data chunks (over 4G
> sized).
>
> This is the regression test case for it.
>
> The test case itself would:
>
> - Create a RAID0 chunk with a single 6G data chunk
>   This requires at least 6 devices from SCRATCH_DEV_POOL, and each
>   should be larger than 2G.
>
> - Fill the fs with 5G data
>
> - Make sure everything is fine
>   Including the data csums.
>
> - Delete half of the data
>
> - Do a fstrim
>   This would lead to out-of-boundary trim if the kernel is not patched.
>
> - Make sure everything is fine again
>   If not patched, we may have corrupted data due to the bad fstrim
>   above.
>
> For now, this test case only checks the behavior for RAID0.
> As for RAID10, we need 12 devices, which is out-of-reach for a lot of
> test envionrments.
>
> For RAID56, they would have a different test case, as they don't support
> discard inside the RAID56 chunks.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add requirement for fstrim and batched discard support
> - Add some comments on why it's safe as long as each device is larger
>   than 2G
> - Use nodiscard mount option to increase the possibility of
>   crash/corruption
>   Newer kernel go with async discard by default and has extra trim cache
>   to avoid duplicated trim commands.
>   Disable such discard behavior so that fstrim can always trigger the
>   bug.
> ---
>  tests/btrfs/292     | 87 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/292.out |  2 ++
>  2 files changed, 89 insertions(+)
>  create mode 100755 tests/btrfs/292
>  create mode 100644 tests/btrfs/292.out
>
> diff --git a/tests/btrfs/292 b/tests/btrfs/292
> new file mode 100755
> index 00000000..c7b9fe92
> --- /dev/null
> +++ b/tests/btrfs/292
> @@ -0,0 +1,87 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 292
> +#
> +# Test btrfs behavior with large chunks (size beyond 4G) for basic read-=
write
> +# and discard.
> +# This test focus on RAID0.
> +#
> +. ./common/preamble
> +_begin_fstest auto raid volume trim
> +
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch_dev_pool 6
> +_require_fstrim
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: fix u32 overflows when left shifting @stripe_nr"

The patch was merged into Linus' tree, so please put the commit id:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Da7299a18a179a9713651fce9ad00972a633c14a9

I think you missed this, because you also sent a v3 of the patch yet
v2 was sent to Linus and pulled before you sent it (as well as this
test case).

> +
> +_scratch_dev_pool_get 6
> +
> +
> +datasize=3D$((5 * 1024 * 1024 * 1024))
> +filesize=3D$((8 * 1024 * 1024))
> +nr_files=3D$(($datasize / $filesize))
> +
> +# Make sure each device has at least 2G.
> +# Btrfs has a limits on per-device stripe length of 1G.
> +# Double that so that we can ensure a RAID0 data chunk with 6G size.
> +for i in $SCRATCH_DEV_POOL; do
> +       devsize=3D$(blockdev --getsize64 "$i")
> +       if [ $devsize -lt $((2 * 1024 * 1024 * 1024)) ]; then
> +               _notrun "device $i is too small, need at least 2G"

here need a _scratch_dev_pool_put before _notrun

> +       fi
> +done
> +
> +_scratch_pool_mkfs -m raid1 -d raid0 >> $seqres.full 2>&1
> +
> +# We disable async/sync auto discard, so that btrfs won't try to
> +# cache the discard result which can cause unexpected skip for some trim=
 range.
> +_scratch_mount -o nodiscard
> +_require_batched_discard $SCRATCH_MNT
> +
> +# Fill the data chunk with 5G data.
> +for (( i =3D 0; i < $nr_files; i++ )); do
> +       xfs_io -f -c "pwrite -i /dev/urandom 0 $filesize" $SCRATCH_MNT/fi=
le_$i > /dev/null

Use $XFS_IO_PROG instead of xfs_io.

> +done
> +sync
> +echo "=3D=3D=3D With initial 5G data written =3D=3D=3D" >> $seqres.full
> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +
> +_scratch_unmount
> +
> +# Make sure we haven't corrupted anything.
> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>=
&1
> +if [ $? -ne 0 ]; then
> +       _fail "data corruption detected after initial data filling"

here need a _scratch_dev_pool_put before calling _fail

> +fi
> +
> +_scratch_mount -o nodiscard
> +# Delete half of the data, and do discard
> +rm -rf - "$SCRATCH_MNT/*[02468]"
> +sync
> +$FSTRIM_PROG $SCRATCH_MNT
> +
> +echo "=3D=3D=3D With 2.5G data trimmed =3D=3D=3D" >> $seqres.full
> +$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
> +_scratch_unmount
> +
> +# Make sure fstrim didn't corrupte anything.

corrupte -> corrupt
didn't -> doesn't

> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>=
&1
> +if [ $? -ne 0 ]; then
> +       _fail "data corruption detected after initial data filling"

here need a _scratch_dev_pool_put before calling _fail

Also, the message is pasted from the previous check, so here it should
be something like:
"data corruption detected after running fsstrim"

Thanks.

> +fi
> +
> +_scratch_dev_pool_put
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/292.out b/tests/btrfs/292.out
> new file mode 100644
> index 00000000..627309d3
> --- /dev/null
> +++ b/tests/btrfs/292.out
> @@ -0,0 +1,2 @@
> +QA output created by 292
> +Silence is golden
> --
> 2.39.0
>

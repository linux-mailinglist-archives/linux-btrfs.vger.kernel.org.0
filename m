Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A091737E33
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 11:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjFUIw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFUIw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 04:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82CE60;
        Wed, 21 Jun 2023 01:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 522A661474;
        Wed, 21 Jun 2023 08:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B884EC433C8;
        Wed, 21 Jun 2023 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687337544;
        bh=1bD2s1sWUVk8X5eU+hSrBrIE7tznKvLa65HrV/PdYF0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TPdg9kQZTXisGkcYvnBiVFe1PW4BomJnPy335ANx93JKvEZcXlcD8VG5hKjiP7Pwy
         R6DZIvukRxBLHu2LDygw7MqExbTvZLhf1rXIKVFTfX6mdaRtqhd3HlJFOCf1CG2Q3z
         3dgL7dFkYalGJx2+N1JyPEGqESkuReSvms3dm3g0Kju4zyazvC+9o+GyCnkRS48txn
         RBA9I65pklTKU4uIcXV5konK8bF+t3kmNfzE4SIjZcu3DZUqodQX+UKI3hshXcRKsR
         CwwXAG9mI6hpR0kpo9O+2zH8StwfFqjkAKhvjFTih9LfyG9ULSgNIAQ9PeZaTrWH9V
         Yc3hPdgIsohBw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-55e1a9ff9d4so3055929eaf.1;
        Wed, 21 Jun 2023 01:52:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDxCMsYQWTabEVK41Gvf4L9g4wl2Ke/y5dbiHLJBAPdx3QAytweB
        QGX/R+Kd+3DxIFw7ldCUS+fEvAFd3UNaaHGuDpw=
X-Google-Smtp-Source: ACHHUZ5dqkAyK/XqK23bwB8zfeym0qHi1fHCESYh3E/A6PziOMudTKO/AgsWIq4C3x+vISAEkrygwsgd5XVgVAc4aew=
X-Received: by 2002:aca:d882:0:b0:39a:98b9:8829 with SMTP id
 p124-20020acad882000000b0039a98b98829mr10121200oig.28.1687337543817; Wed, 21
 Jun 2023 01:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230621084031.209727-1-wqu@suse.com>
In-Reply-To: <20230621084031.209727-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 21 Jun 2023 09:51:47 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4Mhgoqh-eyf3mdeePM5qGXu=RGoHvzph7=oNF1ujb3Yw@mail.gmail.com>
Message-ID: <CAL3q7H4Mhgoqh-eyf3mdeePM5qGXu=RGoHvzph7=oNF1ujb3Yw@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: add test case to verify the behavior with large
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

On Wed, Jun 21, 2023 at 9:46=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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

Looks good now, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


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
>
> v3:
> - Use the merged fix commit in _fixed_by_kernel_commit
> - Add the missing _scratch_dev_pool_put() calls before _fail()/_notrun()
> - Fix the spell and grammar of a comment
> - Update the error message if we detected a corruption after fstrim
> - Use $XFS_IO_PROG instead of direct xfs_io calls
> ---
>  tests/btrfs/292     | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/292.out |  2 +
>  2 files changed, 93 insertions(+)
>  create mode 100755 tests/btrfs/292
>  create mode 100644 tests/btrfs/292.out
>
> diff --git a/tests/btrfs/292 b/tests/btrfs/292
> new file mode 100755
> index 00000000..32a7c3c5
> --- /dev/null
> +++ b/tests/btrfs/292
> @@ -0,0 +1,91 @@
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
> +_fixed_by_kernel_commit a7299a18a179 \
> +       "btrfs: fix u32 overflows when left shifting @stripe_nr"
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
> +               _scratch_dev_pool_put
> +               _notrun "device $i is too small, need at least 2G"
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
> +       $XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $filesize" \
> +               $SCRATCH_MNT/file_$i > /dev/null
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
> +       _scratch_dev_pool_put
> +       _fail "data corruption detected after initial data filling"
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
> +# Make sure fstrim doesn't corrupt anything.
> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>=
&1
> +if [ $? -ne 0 ]; then
> +       _scratch_dev_pool_put
> +       _fail "data corruption detected after running fstrim"
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

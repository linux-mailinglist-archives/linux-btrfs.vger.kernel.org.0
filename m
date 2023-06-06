Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A23723E18
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjFFJp6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 05:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjFFJp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 05:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728DDE40;
        Tue,  6 Jun 2023 02:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88386260F;
        Tue,  6 Jun 2023 09:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E446C433EF;
        Tue,  6 Jun 2023 09:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686044755;
        bh=vxo0Q7/PaNRS0d8CJcjo+TcABy2jHL/uWIxfmA2lfuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VSJWPlZj5MTKL8OU8ymujT8VqmaTqtSucF61qTfgkoij/KV0G5j1eIIegDFovm5jI
         /qkTShqADUt1TV/B8NyoR7paNUZMBBvkSgUfe/sTIDtCv2Y4/VQJIYuOV+QdbS/esw
         PqXrBwXoucgQT8aFr7TT96QefPX3lSRnHfYfS9joq4ojhgyLgKl+VBLmNi7rHZD+ll
         xvkBiIUcPaU6fwvyb6PjP3xN3mtqYFRLaWcg3+CeN4HYm8/992OO/zI/HUXOgAByIb
         2Ztm2BsqbNTTJmXkzZzgTwAczuxJNNsVdG5i8CJAi5HPyrdGXZnCu2Td2WhIEhwCDQ
         POt6QGS5Insbw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-541f4ee6f89so3956431eaf.2;
        Tue, 06 Jun 2023 02:45:55 -0700 (PDT)
X-Gm-Message-State: AC+VfDxlWs+vstiD76zZtCtGgV9S+KFVbG+B39itDXktItG5Pt4vwYwD
        uauGQvHkUs8l3ZrCvTV/dJOtb0XMV8YikjL8kdQ=
X-Google-Smtp-Source: ACHHUZ5x67MyKnGVgkbB/PoWKQdZhnxgjj1MtfU5L1OVp5HeTjbkjFmSNGf7UeUwex8efk8LLQFRazEQ8Anbn7KZ8AY=
X-Received: by 2002:a05:6820:302:b0:558:a4cd:8813 with SMTP id
 l2-20020a056820030200b00558a4cd8813mr1183244ooe.9.1686044754372; Tue, 06 Jun
 2023 02:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073233.75900-1-wqu@suse.com>
In-Reply-To: <20230606073233.75900-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 10:45:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7z7Cutdrm5f2VmqFHCbkO9wic_45GYre+9uOFKtdgsXA@mail.gmail.com>
Message-ID: <CAL3q7H7z7Cutdrm5f2VmqFHCbkO9wic_45GYre+9uOFKtdgsXA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add a test case to verify the scrub error reports
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

On Tue, Jun 6, 2023 at 8:41=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a regression in recent v6.4 cycle where a scrub rewrite changed
> how we report errors, especially repairable errors.
>
> Before the rewrite, we report the initial errors hit, and the amount of
> repairable errors.
> While after the rewrite, we no longer report the initial errors, but
> only the number of repairable errors.
>
> This behavior change is a regression, thus needs a test case to prevent
> such problem from happening again.
>
> The test case itself would:
>
> - Create a btrfs using DUP data profile and 4K sector size
>
> - Create a file with one 128K extent
>
> - Corrupt the first mirror of that 128K extent
>
> - Scrub and checks the detailed report
>   Both corrected errors and csum errors should be 32.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/289     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/289.out |  2 ++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/btrfs/289
>  create mode 100644 tests/btrfs/289.out
>
> diff --git a/tests/btrfs/289 b/tests/btrfs/289
> new file mode 100755
> index 00000000..914b6280
> --- /dev/null
> +++ b/tests/btrfs/289
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 289
> +#
> +# Make sure btrfs-scrub reports errors correctly for repaired sectors.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick scrub repair
> +
> +# For filedefrag and all the filters

So almost the same comment as in the other test:

This comment is a bit confusing. File defrag? The test doesn't exercise def=
rag.
I'm not seeing the test using filters either, the test is redirecting
xfs_io's stdout to /dev/null

> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_require_odirect
> +# Overwriting data is forbidden on a zoned block device
> +_require_non_zoned_device "${SCRATCH_DEV}"
> +
> +# The errors reported would be in the unit of sector, thus the number
> +# is dependent on the sectorsize.
> +_require_btrfs_support_sectorsize 4096

So same as before, can we please get a _fixed_by_kernel_commit to
identify the patch that fixes the regression?

> +
> +# Create a single btrfs with DUP data profile, and create one 128K file.
> +_scratch_mkfs -s 4k -d dup -b 1G >> $seqres.full 2>&1
> +_scratch_mount
> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/foob=
ar" \
> +       > /dev/null
> +sync
> +
> +logical=3D$(_btrfs_get_first_logical "$SCRATCH_MNT/foobar")
> +
> +physical1=3D$(_btrfs_get_physical ${logical} 1)
> +devpath1=3D$(_btrfs_get_device_path ${logical} 1)
> +_scratch_unmount
> +
> +echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
> +       >> $seqres.full
> +$XFS_IO_PROG -d -c "pwrite -S 0xf1 -b 64K $physical1 128K" $devpath1 \
> +       > /dev/null
> +
> +# Mount and do a scrub and compare the ouput

ouput -> output

> +_scratch_mount
> +$BTRFS_UTIL_PROG scrub start -BR $SCRATCH_MNT >> $tmp.scrub_report 2>&1
> +cat $tmp.scrub_report >> $seqres.full
> +
> +# Csum errors should be 128K/4K =3D 32
> +csum_errors=3D$(grep "csum_errors" $tmp.scrub_report | awk '{print $2}')

Use $AWK_PROG instead.

> +if [ $csum_errors -ne 32 ]; then
> +       echo "csum_errors incorrect, expect 32 has $csum_errors"
> +fi
> +
> +# And all errors should be repaired, thus corrected errors should also b=
e 32.
> +corrected_errors=3D$(grep "corrected_errors" $tmp.scrub_report | awk '{p=
rint $2}')

Same here, $AWK_PROG instead.

Otherwise, it looks fine, thanks.

> +if [ $corrected_errors -ne 32 ]; then
> +       echo "csum_errors incorrect, expect 32 has $corrected_errors"
> +fi
> +
> +echo "Silence is golden"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/289.out b/tests/btrfs/289.out
> new file mode 100644
> index 00000000..7d3b7f80
> --- /dev/null
> +++ b/tests/btrfs/289.out
> @@ -0,0 +1,2 @@
> +QA output created by 289
> +Silence is golden
> --
> 2.39.0
>

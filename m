Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5985472455A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjFFOLI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbjFFOLE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 10:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C2E10D4;
        Tue,  6 Jun 2023 07:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5260061230;
        Tue,  6 Jun 2023 14:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC668C433D2;
        Tue,  6 Jun 2023 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686060661;
        bh=/J1/vJlOyrDXpsefNJXUpTzvvg0WZqhcW6UI6DDTwQE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QDM3NGnk2gaXroUpntTKssCT9luxQvgmHDHPuhh26oLldGU+mLXXQBd7LTYmD+TMN
         2+AFFpqlp9anNpIAuU8oMhamDxX7o+pDSYz8+rmxJPNDplc/JaAL3s3Y33RFojkP0p
         iT9YSkJjG0Q1h/MkLGeuAwGvGPYbUtc7+j07EF7ajxikYkN4BZCToOJlUQ2kMgzSg8
         65voRRmPlA5x5/Z0qzbVkmPaKJEmHCc/nkkjgeHOHKNUC1Nf/wNF1ZQs+SfKv/TbqK
         5iYiAr0PFbEf3oxM28kTSjtEtbwxEjV7tWkQucrguMQDxCnfSMB9535v1spF4ki260
         QK0wkkLfIHEJw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-19f45faedfbso5137120fac.0;
        Tue, 06 Jun 2023 07:11:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDzApd7n71vUY32ZC6etdHbqzgqr2hQn5BhsDyalGBJxelcybNha
        bTpJLGR07l6MYBNnT/iR40qL+V5el5sAsWy+uAU=
X-Google-Smtp-Source: ACHHUZ7wuapON9VdTY70S0CXb5qFgwe36oVEcQUJq3jj0XrMFU1RimHidzu6+BnhpFgO9zshBcPBHBSHqMFynffCvHs=
X-Received: by 2002:a05:6870:9484:b0:19a:2178:ee94 with SMTP id
 w4-20020a056870948400b0019a2178ee94mr1220700oal.26.1686060660713; Tue, 06 Jun
 2023 07:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230606110123.130226-1-wqu@suse.com>
In-Reply-To: <20230606110123.130226-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 15:10:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H71Puc=zdSqPmnFKkmVExxH9AKwkeaGJOtb36imy+QYmg@mail.gmail.com>
Message-ID: <CAL3q7H71Puc=zdSqPmnFKkmVExxH9AKwkeaGJOtb36imy+QYmg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add a test case to verify the scrub error reports
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 6, 2023 at 12:05=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.


> ---
> Changelog:
> v2:
> - Add _fixed_by_kernel_commit
> - Remove the confusing comments on common/filter
> - Use $AWK_PROG instead of calling awk directly
> - Fix an error prompt which uses a copied string without updating
> ---
>  tests/btrfs/289     | 69 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/289.out |  2 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/btrfs/289
>  create mode 100644 tests/btrfs/289.out
>
> diff --git a/tests/btrfs/289 b/tests/btrfs/289
> new file mode 100755
> index 00000000..0d20109a
> --- /dev/null
> +++ b/tests/btrfs/289
> @@ -0,0 +1,69 @@
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
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: scrub: also report errors hit during the initial read"
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
> +       >> $seqres.full
> +
> +# Mount and do a scrub and compare the output
> +_scratch_mount
> +$BTRFS_UTIL_PROG scrub start -BR $SCRATCH_MNT >> $tmp.scrub_report 2>&1
> +cat $tmp.scrub_report >> $seqres.full
> +
> +# Csum errors should be 128K/4K =3D 32
> +csum_errors=3D$(grep "csum_errors" $tmp.scrub_report | $AWK_PROG '{print=
 $2}')
> +if [ $csum_errors -ne 32 ]; then
> +       echo "csum_errors incorrect, expect 32 has $csum_errors"
> +fi
> +
> +# And all errors should be repaired, thus corrected errors should also b=
e 32.
> +corrected_errors=3D$(grep "corrected_errors" $tmp.scrub_report | $AWK_PR=
OG '{print $2}')
> +if [ $corrected_errors -ne 32 ]; then
> +       echo "corrected_errors incorrect, expect 32 has $corrected_errors=
"
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

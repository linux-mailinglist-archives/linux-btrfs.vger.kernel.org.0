Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F3723FD5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjFFKmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 06:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjFFKlj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 06:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829FF10D7;
        Tue,  6 Jun 2023 03:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 169AC61A7F;
        Tue,  6 Jun 2023 10:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A848C433D2;
        Tue,  6 Jun 2023 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686047958;
        bh=5zTYXpWIms4m9elPaWeT+t3Je02MrJp1wlx28y9uYfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t193a0/7RX0G9jCvKXRfFZFuQQ6RdfIm/545971XZnlN+AwVf6wwyGm/TDbDeLH7p
         Xlfqc0Ap2Ikj6IwCNvNpj7DYnkWNe15uWj/6TGJcRCOuHDMjJ+cxXJJhZW1+WV9rXr
         ZhrhrwYU9X1NFhoqxpn3ZbS/5Gu6Pws2qIN11lkZXCtAnFhx30Ua0H8n8MZx6whCWJ
         um7SswRnL9XPdXx9NMwOgTa5qiRjE0x6r9NPgUp3u4bedvqx4Ec0+nyLxR/ra8+RBV
         x2Aj0DKKfYPjAjnbbV9hRc5uniYVtQ1+3DZv81uBjlvUT1ICxMIscj34Wzl1JFVMvf
         vyCUHm9F+bAXA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-19f22575d89so3271632fac.0;
        Tue, 06 Jun 2023 03:39:18 -0700 (PDT)
X-Gm-Message-State: AC+VfDxhakT9N+YoYiCNBirauvVVP7qqRgMYASCkT2zyGJbCIPIzL6va
        fiXyPK8Oyc8C41i3CPYpNuFHXAPDyVRyNYsoB0o=
X-Google-Smtp-Source: ACHHUZ5ZJ9m+kHHbvDy4HW7Kj67n2ht4fV3DoHcD19W8ZhCscOljv/0M4EWmROKp1BxF1OEHpRTBjK6n5n3ZZO1wGfo=
X-Received: by 2002:a05:6870:3a08:b0:186:d9e3:e268 with SMTP id
 du8-20020a0568703a0800b00186d9e3e268mr980585oab.42.1686047957577; Tue, 06 Jun
 2023 03:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230606022354.48911-1-wqu@suse.com> <CAL3q7H6teZ0MyWWO-xsYk7cP+TyQw5WKdPKE-ra0+zxp_dDMzg@mail.gmail.com>
 <7f251b2a-da6c-da9d-933b-b441dda01b64@gmx.com>
In-Reply-To: <7f251b2a-da6c-da9d-933b-b441dda01b64@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 6 Jun 2023 11:38:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6PobZL56sWejh6+kwKvKY2d4T=y4=JXAcQiyRbBEpeaQ@mail.gmail.com>
Message-ID: <CAL3q7H6PobZL56sWejh6+kwKvKY2d4T=y4=JXAcQiyRbBEpeaQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add a test case to verify read-only scrub
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
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

On Tue, Jun 6, 2023 at 11:34=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/6/6 17:35, Filipe Manana wrote:
> > On Tue, Jun 6, 2023 at 4:20=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> There is a regression on btrfs read-only scrub behavior.
> >>
> >> The commit e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() t=
o
> >> scrub_stripe infrastructure") makes btrfs scrub to ignore the read-onl=
y
> >> flag completely, causing scrub to always fix the corruption.
> >>
> >> This test case would create an fs with repairable corruptions, then ru=
n
> >> a read-only scrub, and finally to make sure the corruption is not
> >> repaired.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   tests/btrfs/288     | 65 +++++++++++++++++++++++++++++++++++++++++++=
++
> >>   tests/btrfs/288.out | 39 +++++++++++++++++++++++++++
> >>   2 files changed, 104 insertions(+)
> >>   create mode 100755 tests/btrfs/288
> >>   create mode 100644 tests/btrfs/288.out
> >>
> >> diff --git a/tests/btrfs/288 b/tests/btrfs/288
> >> new file mode 100755
> >> index 00000000..7795bdd9
> >> --- /dev/null
> >> +++ b/tests/btrfs/288
> >> @@ -0,0 +1,65 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> >> +#
> >> +# FS QA Test 288
> >> +#
> >> +# Make sure btrfs-scrub respects the read-only flag.
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto repair quick volume scrub
> >> +
> >> +# For filedefrag and all the filters
> >
> > This comment is a bit confusing. File defrag? The test doesn't exercise=
 defrag.
> > Probably just leaving the comment out is better, it's obvious since we
> > are using filters.
> >
> >> +. ./common/filter
> >> +
> >> +# real QA test starts here
> >> +
> >> +# Modify as appropriate.
> >> +_supported_fs btrfs
> >> +_require_scratch_dev_pool 2
> >> +
> >> +_require_odirect
> >> +# Overwriting data is forbidden on a zoned block device
> >> +_require_non_zoned_device "${SCRATCH_DEV}"
> >
> > Can we please get a _fixed_by_kernel_commit call to identify the patch
> > that fixes the regression?
>
> Unfortunately it's not yet merged, we only have the offending commit.

Yes, I know. But you can still use it, and we normally do it.
Just use "xxxxxxxxxxxx" as the commit id and leave the patch's subject.

>
> >
> >> +
> >> +_scratch_dev_pool_get 2
> >> +
> >> +# Step 1, create a raid btrfs with one 128K file
> >> +echo "step 1......mkfs.btrfs"
> >> +_scratch_pool_mkfs -d raid1 -b 1G >> $seqres.full 2>&1
> >> +_scratch_mount
> >> +
> >> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" "$SCRATCH_MNT/f=
oobar" |\
> >> +       _filter_xfs_io_offset
> >
> > So why do we filter offsets?
> > Why not just a plain _filter_xfs_io as we most commonly do?
>
> Oh yep, that's better.
>
> Thanks for the review,
> Qu
>
> >
> > Thanks.
> >
> >> +
> >> +# Step 2, corrupt one mirror so we can still repair the fs.
> >> +echo "step 2......corrupt one mirror"
> >> +# ensure btrfs-map-logical sees the tree updates
> >> +sync
> >> +
> >> +logical=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> >> +
> >> +physical1=3D$(_btrfs_get_physical ${logical} 1)
> >> +devpath1=3D$(_btrfs_get_device_path ${logical} 1)
> >> +
> >> +_scratch_unmount
> >> +
> >> +echo " corrupt stripe #1, devpath $devpath1 physical $physical1" \
> >> +       >> $seqres.full
> >> +$XFS_IO_PROG -d -c "pwrite -S 0xf1 -b 64K $physical1 64K" $devpath1 \
> >> +       > /dev/null
> >> +
> >> +
> >> +# Step 3, do a read-only scrub, which should not fix the corruption.
> >> +_scratch_mount -o ro
> >> +$BTRFS_UTIL_PROG scrub start -BRrd $SCRATCH_MNT >> $seqres.full 2>&1
> >> +_scratch_unmount
> >> +
> >> +# Step 4, make sure the corruption is still there
> >> +$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
> >> +       _filter_xfs_io_offset
> >> +
> >> +_scratch_dev_pool_put
> >> +# success, all done
> >> +status=3D0
> >> +exit
> >> diff --git a/tests/btrfs/288.out b/tests/btrfs/288.out
> >> new file mode 100644
> >> index 00000000..c6c8e886
> >> --- /dev/null
> >> +++ b/tests/btrfs/288.out
> >> @@ -0,0 +1,39 @@
> >> +QA output created by 288
> >> +step 1......mkfs.btrfs
> >> +wrote 131072/131072 bytes
> >> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> +step 2......corrupt one mirror
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +XXXXXXXX:  f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1  .........=
.......
> >> +read 512/512 bytes
> >> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> --
> >> 2.39.0
> >>

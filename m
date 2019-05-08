Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F72217AE0
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfEHNlJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 09:41:09 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46319 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfEHNlI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 May 2019 09:41:08 -0400
Received: by mail-ua1-f66.google.com with SMTP id a95so2305733uaa.13;
        Wed, 08 May 2019 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/cA5dHuj/QXB1U9ibshBReemqtnTV9s/Pf6/3KA8/o4=;
        b=CmnQpGcD+qVLh/EWay6F2EePiBSwzaW6zpl2fy04ZTZJhrN+99zwqVVQG4tufIVGQ/
         2GSOL2LfixqSxbZF6imwZ0pibI+IPKFCuG97jB/gs+IlrXJU3K2fQl8C37eUxrMYCR+q
         SJGVZE77wf2APxxQA/q/BYVSXykpd4Na+cMSMTau+ROmsOwfsQhiELjLDO9Sr8aDpoAd
         Dw0ntmv34nKuEZ6LLpmmixvLOQvyrWHaxmxAqcceFW0UIF2tTaeklbKviIUwIZ/zKA10
         F6Cj7i57pauP52Ll/Yvsrj7H/jB7qbZEfY+oi+D9CnlwPnHDy87K3semjeeQYWDZjjTD
         loRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/cA5dHuj/QXB1U9ibshBReemqtnTV9s/Pf6/3KA8/o4=;
        b=WVwU8cFa8N9oXAR/ygkd0r5vMxwiQYe/EToZlSpeIR19LJbMfVyINnWU+zBTsb5J0R
         vsuOdcRIoLe4z3CfxDvtBBHnUuFYV8IX9qVzKBQqK2ltcb13M4tSdasnKcV5wR8RFxII
         HaE2YlR7Rf0NjhPI/EWB42G6HH2qFDTs7uznUBpIJgeRe1VO2E+09lz5pS5zGPZYD5Sd
         yRFGgzvY4vwY8z3EbAN9ShX8lp+RZ5Kmndn4lszrV56ENaUBHqD6jGilyDgy7G0/S9OK
         CeG8dYx5ldoDlF0Xb22Da36eUFYEJpOlR4lk33AoVe65aSmbiVUi40aJWllGkmBHtp1J
         M2+w==
X-Gm-Message-State: APjAAAXYM0GFDw/6yoF08eH7k/ponEuwFT4IKmE85mKReqj0ZkVa2++3
        zayHpH8JtzCVRr1cVN0felw45EI2+S/9jX+/rUsfa7x3
X-Google-Smtp-Source: APXvYqy67P+JDr/isWh5CoMgC27D/EkNhq3zwf/e7+A13eC+u1TVv5QeuxFHwcWlQHJUsDwUYOm8ShKNtCY484lf1Ak=
X-Received: by 2002:ab0:1e2:: with SMTP id 89mr20356137ual.0.1557322867285;
 Wed, 08 May 2019 06:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190508124610.20135-1-wqu@suse.com>
In-Reply-To: <20190508124610.20135-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 8 May 2019 14:40:56 +0100
Message-ID: <CAL3q7H7E0rf2uxqVKOUOvF5Mq95E06rfcUNoRBKZJTeAcQEDNA@mail.gmail.com>
Subject: Re: [PATCH v3] fstests: generic: Test if we can still do certain
 operations which doesn't take data space on full fs
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 8, 2019 at 2:27 PM Qu Wenruo <wqu@suse.com> wrote:
>
> This test will test if we can still do the following operations when a
> full is full:
> - buffered write into unpopulated preallocated extent
> - clone the untouched preallocated extent
> - fsync
> - no data loss if power loss happens after above fsync
> Above operations should not fail, as they takes no extra data space.
>
> Xfs passes the test, while btrfs fails at fsync and has data loss.
> The fix for btrfs is:
> "btrfs: Flush before reflinking any extent to prevent NOCOW write falling
>  back to CoW without data reservation"
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
> - Change the comment and commit message to make it describe the test
>   itself, not the btrfs specific part.
> - Use $XFS_IO_PROG to replace xfs_io.
> v3:
> - Move the current test result and btrfs fix to commit message
> - Also test if data is consistent after power loss and log recovery
> ---
>  tests/generic/545     | 92 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/545.out |  2 +
>  tests/generic/group   |  1 +
>  3 files changed, 95 insertions(+)
>  create mode 100755 tests/generic/545
>  create mode 100644 tests/generic/545.out
>
> diff --git a/tests/generic/545 b/tests/generic/545
> new file mode 100755
> index 00000000..e8419585
> --- /dev/null
> +++ b/tests/generic/545
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 545
> +#
> +# Test when a fs is full we can still:
> +# - Do buffered write into a unpopulated preallocated extent
> +# - Clone the untouched part of that preallocated extent
> +# - Fsync
> +# - No data loss even power loss happens after fsync
> +# All operations above should not fail.
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       _cleanup_flakey
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/reflink
> +. ./common/dmflakey
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_reflink
> +_require_dm_target flakey
> +
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1

Missing here:  _require_metadata_journaling $SCRATCH_DEV

> +_init_flakey
> +_mount_flakey
> +
> +# Create preallocated extent where we can write into
> +$XFS_IO_PROG -f -c 'falloc 8k 64m' "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +# Use up all data space, to test later write-into-preallocate behavior
> +_pwrite_byte 0x00 0 512m "$SCRATCH_MNT/padding" >> $seqres.full 2>&1
> +
> +# Sync to ensure that padding file reach disk so that at log recovery we
> +# still have no data space
> +sync
> +
> +# This should not fail
> +_pwrite_byte 0xcd 1m 16m "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +# Do reflink here, we shouldn't use extra data space, thus it should not=
 fail
> +$XFS_IO_PROG -c "reflink ${SCRATCH_MNT}/foobar 8k 0 4k" "$SCRATCH_MNT/fo=
obar" \
> +       >> $seqres.full
> +
> +# Checkpoint before power loss

checkpoint -> checksum

> +c1foobar=3D$(_md5_checksum "$SCRATCH_MNT/foobar")
> +echo "md5 foobar before:  $c1foobar" >> $seqres.full
> +c1padding=3D$(_md5_checksum "$SCRATCH_MNT/padding")
> +echo "md5 padding before: $c1padding" >> $seqres.full

What's the point of verifying the checksum of the padding file?
We sync'ed before, and we aren't modifying it after the sync.
Just leave it... Doesn't add any value, and it falls out of the test
description.

> +
> +# Fsync to check if writeback is ok
> +$XFS_IO_PROG -c 'fsync'  "$SCRATCH_MNT/foobar"
> +
> +# Now emulate power loss
> +_flakey_drop_and_remount
> +
> +# Checkpoint after power loss

checkpoint -> checksum

> +c2foobar=3D$(_md5_checksum "$SCRATCH_MNT/foobar")
> +echo "md5 foobar after:  $c2foobar" >> $seqres.full
> +c2padding=3D$(_md5_checksum "$SCRATCH_MNT/padding")
> +echo "md5 padding after: $c2padding" >> $seqres.full

Same here.

> +
> +test $c1foobar =3D $c2foobar || echo "foobar doesn't match after log rec=
overy"
> +test $c1padding =3D $c2padding || echo "padding doesn't match after log =
recovery"

We generally verify things by making output of commands match what we
have on the golden ouput.
That is, just echo the checksum (before and after the power loss) and
have the golden output have the correct checksums.

If there are no complaints, I'm fine with it.

Thanks.

> +
> +echo "Silence is golden"
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/545.out b/tests/generic/545.out
> new file mode 100644
> index 00000000..920d7244
> --- /dev/null
> +++ b/tests/generic/545.out
> @@ -0,0 +1,2 @@
> +QA output created by 545
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 40deb4d0..84892a60 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -547,3 +547,4 @@
>  542 auto quick clone
>  543 auto quick clone
>  544 auto quick clone
> +545 auto quick clone enospc log
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

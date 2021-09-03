Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226E2400334
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbhICQYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbhICQYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 12:24:46 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A264C061575;
        Fri,  3 Sep 2021 09:23:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id u21so4957833qtw.8;
        Fri, 03 Sep 2021 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JlR0f9FtNXgJ4F4NabMbkKgfsQNe1xOl1rzU86pM1xs=;
        b=fA9gzx/fubG4zYdqRgqBNoJxftNYeMjPbw29938biNi2HuRfW0IcRg7fUaat/FEFTv
         Cyi2Q1Gj8tJDV9fF0ebW6kZ4Z/g3gHiZSTq2TLZ4qH7KbypmmBGAc8D/yDtL93OpyppS
         BMEiH79fz1BpPDFTYYuIDDS6N2fPNE3Cw7EflbO8d6Ekwlbg8MUHObqwxKArcuXMEaSU
         JTfnrakl7iSs9TVMx5hlN5b5+ACc1j3+zaJWi+i2WMf2+C68cAC+6acoETe9GTksP16K
         vgjakUCyRi1hhLX6weXN0BeumjdvuFrH5IcSGRujbKE6Bw43SaxFNGBcW/qeyJtsKu0q
         BWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JlR0f9FtNXgJ4F4NabMbkKgfsQNe1xOl1rzU86pM1xs=;
        b=o4JlI9UK7ZD5npAUiC1amBGvLqrumNe0qhTPRIYKX26RU3VIhRbk1Bg7/bE6EdiAvM
         P7uGOaJ2ZOKbHSkL9u011qCBH+6fAKWoWKeIvV7zAukk1v9etJlvoqP9nZZjEubUBX9+
         pkGmdqboL57uSI1qL0hiG7N0kDk+SZr47bUTlds9nf6f+fqNa4NkhL0b9cOXRov50gGw
         uoc4GVkK8KG0SGb3RbXfPPVAZ6UBj9QxFNXgz7Vbwf80tZQEYiSVOnaJa6E65DL+cS8p
         bFSIaxpyNSaJqVMUb+QqxUcEzmtVnXLiQyMKlT5+ir3oWkLQwbV3YiJfEkn4daxSRps6
         OQIw==
X-Gm-Message-State: AOAM533oARojEtmtQQZiWWaM2H52W8Sy9+vbTmb6AOTnzkDvsHJxXGwD
        VnKMOWt9PCaDSwqYk16jUydmmP/Ptzz36kcm/ScZCXPf
X-Google-Smtp-Source: ABdhPJz7lYFg23SpT9VZmTWFqlmIUQtIsM19Ylw8iXRCugCGtSWo84gh7GC8+U+6/SjWSXx0CEO/o01b6k2psyS7Eyo=
X-Received: by 2002:ac8:5417:: with SMTP id b23mr4706974qtq.140.1630686225379;
 Fri, 03 Sep 2021 09:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210830122306.882081-2-nborisov@suse.com> <20210830153641.893416-1-nborisov@suse.com>
In-Reply-To: <20210830153641.893416-1-nborisov@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 Sep 2021 17:23:09 +0100
Message-ID: <CAL3q7H6Ww7eU=aXEmOYpcT8Vrbnp=_iU8FBYPd4T4rrp1KCuCQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: Add test for rename/exchange behavior between subvolumes
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 4:38 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
> This tests ensures that renames/exchanges across subvolumes work only
> for other subvolumes and are otherwise forbidden and fail.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> This is the real v2.
>
> Changes in V2:
>  * Added cross-subvol rename tests
>  * Added cross-subvol subvolume rename test
>  * Added ordinary volume rename test
>  * Removed explicit sync
>
>
>  tests/btrfs/246     | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/246.out | 54 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100755 tests/btrfs/246
>  create mode 100644 tests/btrfs/246.out
>
> diff --git a/tests/btrfs/246 b/tests/btrfs/246
> new file mode 100755
> index 000000000000..53039df38993
> --- /dev/null
> +++ b/tests/btrfs/246
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 246
> +#
> +# Tests rename/exchange behavior when subvolumes are involved. Rename/ex=
changes
> +# across subvolumes are forbidden. This is also a regression test for
> +# 3f79f6f6247c ("btrfs: prevent rename2 from exchanging a subvol with a
> +# directory from different parents").
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rename subvol
> +
> +# Import common functions.
> + . ./common/renameat2
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_renameat2 exchange
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Create 2 subvols to use as parents for the rename ops
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 1>/dev/null
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 1>/dev/null
> +
> +# Ensure cross subvol ops are forbidden
> +_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/=
dst "cross-subvol" "-x"
> +
> +# Prepare a subvolume and a directory whose parents are different subvol=
umes
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev=
/null
> +mkdir $SCRATCH_MNT/subvol2/dir
> +
> +# Ensure exchanging a subvol with a dir when both parents are different =
fails
> +$here/src/renameat2 -x $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subv=
ol2/dir
> +
> +echo "ordinary rename"
> +# Test also ordinary renames
> +_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol2/=
dst "cross-subvol"
> +
> +echo "subvolumes rename"
> +# Rename subvol1/sub-subvol -> subvol2/sub-subvol
> +$here/src/renameat2  $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/subvol=
2/sub-subvol
> +# Now create another subvol under subvol1/
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/dev=
/null
> +# and exchange the two
> +$here/src/renameat2 -x $SCRATCH_MNT/subvol2/sub-subvol $SCRATCH_MNT/subv=
ol1/sub-subvol
> +
> +# simple rename of a subvolume in the same directory, should catch
> +# 4871c1588f92 ("Btrfs: use right root when checking for hash collision"=
)
> +mv $SCRATCH_MNT/subvol2/ $SCRATCH_MNT/subvol2.
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
> new file mode 100644
> index 000000000000..5db90cf2bd9a
> --- /dev/null
> +++ b/tests/btrfs/246.out
> @@ -0,0 +1,54 @@
> +QA output created by 246
> +cross-subvol none/none -> No such file or directory
> +cross-subvol none/regu -> No such file or directory
> +cross-subvol none/symb -> No such file or directory
> +cross-subvol none/dire -> No such file or directory
> +cross-subvol none/tree -> No such file or directory
> +cross-subvol regu/none -> No such file or directory
> +cross-subvol regu/regu -> Invalid cross-device link
> +cross-subvol regu/symb -> Invalid cross-device link
> +cross-subvol regu/dire -> Invalid cross-device link
> +cross-subvol regu/tree -> Invalid cross-device link
> +cross-subvol symb/none -> No such file or directory
> +cross-subvol symb/regu -> Invalid cross-device link
> +cross-subvol symb/symb -> Invalid cross-device link
> +cross-subvol symb/dire -> Invalid cross-device link
> +cross-subvol symb/tree -> Invalid cross-device link
> +cross-subvol dire/none -> No such file or directory
> +cross-subvol dire/regu -> Invalid cross-device link
> +cross-subvol dire/symb -> Invalid cross-device link
> +cross-subvol dire/dire -> Invalid cross-device link
> +cross-subvol dire/tree -> Invalid cross-device link
> +cross-subvol tree/none -> No such file or directory
> +cross-subvol tree/regu -> Invalid cross-device link
> +cross-subvol tree/symb -> Invalid cross-device link
> +cross-subvol tree/dire -> Invalid cross-device link
> +cross-subvol tree/tree -> Invalid cross-device link
> +Invalid cross-device link
> +ordinary rename
> +cross-subvol none/none -> No such file or directory
> +cross-subvol none/regu -> No such file or directory
> +cross-subvol none/symb -> No such file or directory
> +cross-subvol none/dire -> No such file or directory
> +cross-subvol none/tree -> No such file or directory
> +cross-subvol regu/none -> Invalid cross-device link
> +cross-subvol regu/regu -> Invalid cross-device link
> +cross-subvol regu/symb -> Invalid cross-device link
> +cross-subvol regu/dire -> Is a directory
> +cross-subvol regu/tree -> Is a directory
> +cross-subvol symb/none -> Invalid cross-device link
> +cross-subvol symb/regu -> Invalid cross-device link
> +cross-subvol symb/symb -> Invalid cross-device link
> +cross-subvol symb/dire -> Is a directory
> +cross-subvol symb/tree -> Is a directory
> +cross-subvol dire/none -> Invalid cross-device link
> +cross-subvol dire/regu -> Not a directory
> +cross-subvol dire/symb -> Not a directory
> +cross-subvol dire/dire -> Invalid cross-device link
> +cross-subvol dire/tree -> Invalid cross-device link
> +cross-subvol tree/none -> Invalid cross-device link
> +cross-subvol tree/regu -> Not a directory
> +cross-subvol tree/symb -> Not a directory
> +cross-subvol tree/dire -> Invalid cross-device link
> +cross-subvol tree/tree -> Invalid cross-device link
> +subvolumes rename
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319BB3FB8B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 17:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhH3PE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhH3PEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 11:04:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F61C061575;
        Mon, 30 Aug 2021 08:03:30 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d2so11898093qto.6;
        Mon, 30 Aug 2021 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RlmqBrRQxw4oGD15vw3l24aLsRM/DAQu4HO7McvpyxI=;
        b=YLZPviQ1F/FB6leqR646dKK+N2v24Lz1QCp1GXsD3doUhpt9RMg5rjbjNWXaFBZZDL
         u9bpWkA86t5vD/g6wuEeiwYce4nqDVKN1ZNJFS+IwHIdYdD7xfnlDFwkomlLhSWhktK6
         tUigAm6yCNqjXLEitK7QWcmcpFKla6TyQ521hbCMSZUo75h8gJ/tM53JCcg7mFg3cbUg
         F8cnf5iTeG7Jv5UA967QlRefngTRnbrcjRpAOqkbWa317nlzMIuqG0urNseqjcjLpysT
         nMhO+YFLhPlGEuT7K5JpJfVxICeSnKAY5Ew4/oJM224Z/NhDxbTXiNrtwuqaFBIZvdqL
         nVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RlmqBrRQxw4oGD15vw3l24aLsRM/DAQu4HO7McvpyxI=;
        b=udQichLl2UZJNqeQ75gPsBzzJ2vHPBTfplijtbPKFKkGxfhWGAbvt7AIicTiufoj+i
         z/xda3XS6RlnCrY0T+H6yLzfv7Ab4cis1c4ZRHpkIEMRx/g/mFaUwS2AmFRD+HPnXXoR
         +rLMp0WChqi2MdZSmqdAxsTkQIaI2g+o4mkezQTuRUum5yYaPdX7RH3Sj/JjCvQ1geVz
         W5X2w0K/y2GstE6pmPNTnXFmp572mlcQCD8XhAeGU2FWDOXfbeg1gLhyTE7fZVAJcibN
         jWxcy6PVvAAATNiURLtdD/L08hIyqJ/zxHtyycOR0AZTp40yQjXwCKjAkjb6X+Op9tGs
         2WUg==
X-Gm-Message-State: AOAM533vs/ISvvE0A+f97xVNavxaby5kM4uLeRJqPDSL1tBkUdp4B5vb
        Ueau/+V3vZ2zFrPZoy64M27FZlNqxFoVMZFHqIOCdyx/T8U=
X-Google-Smtp-Source: ABdhPJwPF/HHBeCZRkkYzK73gdm1ZkxjYvWVJRK5KJjJVKZX1J4exM8U9XR2wptLiwxAOvUdW2DmXixpHEcR4TgMjk4=
X-Received: by 2002:ac8:424c:: with SMTP id r12mr21245905qtm.183.1630335809755;
 Mon, 30 Aug 2021 08:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210830122306.882081-1-nborisov@suse.com> <20210830122306.882081-2-nborisov@suse.com>
 <CAL3q7H5Hv4c9z=W4a+NQXfiPUNU3KsTmuanYQ1G_EJrigbsACQ@mail.gmail.com>
In-Reply-To: <CAL3q7H5Hv4c9z=W4a+NQXfiPUNU3KsTmuanYQ1G_EJrigbsACQ@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 16:03:18 +0100
Message-ID: <CAL3q7H5qaYEsK5myLNzJ9YmNN_NFMr0gdOO9dXQyVxYAZeWssg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] btrfs: Add test for rename/exchange behavior
 between subvolumes
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 4:01 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Mon, Aug 30, 2021 at 1:23 PM Nikolay Borisov <nborisov@suse.com> wrote=
:
> >
> > This tests ensures that renames/exchanges across subvolumes work only
> > for other subvolumes and are otherwise forbidden and fail.
> >
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> > Changes in V2:
> >  * Added cross-subvol rename tests
> >  * Added cross-subvol subvolume rename test
> >  * Added ordinary volume rename test
> >  * Removed explicit sync
> >
> >  tests/btrfs/246     | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/246.out | 27 +++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> >  create mode 100755 tests/btrfs/246
> >  create mode 100644 tests/btrfs/246.out
> >
> > diff --git a/tests/btrfs/246 b/tests/btrfs/246
> > new file mode 100755
> > index 000000000000..eeb12bb457a8
> > --- /dev/null
> > +++ b/tests/btrfs/246
> > @@ -0,0 +1,43 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test 246
> > +#
> > +# Tests rename exchange behavior when subvolumes are involved. This is=
 also a
> > +# regression test for 3f79f6f6247c ("btrfs: prevent rename2 from excha=
nging a
> > +# subvol with a directory from different parents").
>
> And it's also a regression test for commit 3f79f6f6247c83 ("btrfs:
> prevent rename2 from exchanging a subvol with a directory from
> different parents"),

Actually, it's 4871c1588f92c6c13f4713a7009f25f217055807 ("Btrfs: use right
root when checking for hash collision"), mentioned in the reply for v1. My =
bad.

> which is actually the fix that motivated v1 of this test case.
>
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick rename subvol
> > +
> > +# Import common functions.
> > + . ./common/renameat2
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_require_renameat2 exchange
> > +_require_scratch
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Create 2 subvols to use as parents for the rename ops
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 1>/dev/null
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 1>/dev/null
> > +
> > +# Ensure cross subvol ops are forbidden
> > +_rename_tests_source_dest $SCRATCH_MNT/subvol1/src $SCRATCH_MNT/subvol=
2/dst "cross-subvol" "-x"
> > +
> > +# Prepare a subvolume and a directory whose parents are different subv=
olumes
> > +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1/sub-subvol 1>/d=
ev/null
> > +mkdir $SCRATCH_MNT/subvol2/dir
> > +
> > +# Ensure exchanging a subvol with a dir when both parents are differen=
t fails
> > +$here/src/renameat2 -x $SCRATCH_MNT/subvol1/sub-subvol $SCRATCH_MNT/su=
bvol2/dir
>
> Where is the test for renaming a subvolume and the test(s) for regular re=
names?
> The v2 changelog mentions those tests were added, but all the tests I
> see here are doing rename exchanges only.
>
> I must have missed something subtle.
>
> Thanks.
>
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
> > new file mode 100644
> > index 000000000000..d50dc28b1b40
> > --- /dev/null
> > +++ b/tests/btrfs/246.out
> > @@ -0,0 +1,27 @@
> > +QA output created by 246
> > +cross-subvol none/none -> No such file or directory
> > +cross-subvol none/regu -> No such file or directory
> > +cross-subvol none/symb -> No such file or directory
> > +cross-subvol none/dire -> No such file or directory
> > +cross-subvol none/tree -> No such file or directory
> > +cross-subvol regu/none -> No such file or directory
> > +cross-subvol regu/regu -> Invalid cross-device link
> > +cross-subvol regu/symb -> Invalid cross-device link
> > +cross-subvol regu/dire -> Invalid cross-device link
> > +cross-subvol regu/tree -> Invalid cross-device link
> > +cross-subvol symb/none -> No such file or directory
> > +cross-subvol symb/regu -> Invalid cross-device link
> > +cross-subvol symb/symb -> Invalid cross-device link
> > +cross-subvol symb/dire -> Invalid cross-device link
> > +cross-subvol symb/tree -> Invalid cross-device link
> > +cross-subvol dire/none -> No such file or directory
> > +cross-subvol dire/regu -> Invalid cross-device link
> > +cross-subvol dire/symb -> Invalid cross-device link
> > +cross-subvol dire/dire -> Invalid cross-device link
> > +cross-subvol dire/tree -> Invalid cross-device link
> > +cross-subvol tree/none -> No such file or directory
> > +cross-subvol tree/regu -> Invalid cross-device link
> > +cross-subvol tree/symb -> Invalid cross-device link
> > +cross-subvol tree/dire -> Invalid cross-device link
> > +cross-subvol tree/tree -> Invalid cross-device link
> > +Invalid cross-device link
> > --
> > 2.17.1
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

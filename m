Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB155A6604
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiH3OPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiH3OPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 10:15:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F321E27;
        Tue, 30 Aug 2022 07:15:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so16130689fac.4;
        Tue, 30 Aug 2022 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=q17D6EmyfosLypyEIB1U2Wc7PF2vdOWPkeWsLdqKEDw=;
        b=QbTAwVZGcOEDf6e84H3Jwy8u/umqAHZxGpAQwp5/Ki0u9ip8loOAfbct9LX6fWigmF
         4m8q5uyzU9ha+1ff34p10WvBfIxSAWnvXgHa587fgDxOqWrgqzU0oHeDSfuMd5cj21tw
         g2To+/fJF2IfPWdmWrbhruxIOUO6v/MFJ3BMtlbwMDhjXFpYZ8cI7PyaZbyfIM308dZ8
         x/LvdKdx1C8Il9YZof7DLiUI/kMoL4htaqkasjZV1i8hLex25jIdXigOVz8kK5Jwv4rs
         JfrTEGx3KXy2C3wMtp0aoZ6cQ91PApMc3slDUg6pykUtV5jqxIwRBVyuGdlWXlAAotL2
         /czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=q17D6EmyfosLypyEIB1U2Wc7PF2vdOWPkeWsLdqKEDw=;
        b=HIJy65m22TGrm2h9fLps7llUH8vneVcHyugkDfknfbQcbDjqgtWqiqOcaDErT4RGpR
         NmEV8dvvUKwwJ/gMHUUmA/2mnbLJbfFz18yZ5LaCNPwll5qPPZp54W6vVD1vAxYcQ2wR
         eXkk/aJBzIO5eHMibn8dpdAskH8m2QA6qeHZwM8fL9J7roR4+hLyX1KUSzFDfJUPn+8S
         ArKjKfxPRdxtY6FeIvA4Xgz1bguKga/zcNQG6EpQ9CcWzsgF+28jiQ0lSjvTf1IHKv6a
         dGvkXaTdXbetTBpl0PxCQ+aohT76HQ+dL7ht04c5I338xHkn6LJNkYDH5H/F1g/8zkvW
         SQYA==
X-Gm-Message-State: ACgBeo3Ywv2UNyQ5kdIxgBav19Q8Y3iKL/pf5YrIySSXlpyDg7JnzmqF
        zK4qv8evU2w6hxDHU/Hy1D/HlABz70l9vX4Cxpo=
X-Google-Smtp-Source: AA6agR6YvswpOv7vI0HIO4gtsdaIN0SiaP831p990O6f3oNum9TzUykM2cnQAmo70YCuHu3ABPVIR61hHhsS8guXNdc=
X-Received: by 2002:a05:6808:1312:b0:344:d504:3f25 with SMTP id
 y18-20020a056808131200b00344d5043f25mr9137703oiv.280.1661868912451; Tue, 30
 Aug 2022 07:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220824104202.2505-1-bingjingc@synology.com> <20220824134148.un2c2hq4xb6xmh7a@zlang-mailbox>
In-Reply-To: <20220824134148.un2c2hq4xb6xmh7a@zlang-mailbox>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Tue, 30 Aug 2022 22:15:00 +0800
Message-ID: <CAMmgxWGgotQy2UgT3_5WNQv6FW-6AHyOx6H3_yCbDZb4gOzgdw@mail.gmail.com>
Subject: Re: [PATCH v3] fstests: btrfs: test incremental send for changed
 reference paths
To:     Zorro Lang <zlang@redhat.com>
Cc:     bingjingc <bingjingc@synology.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Zorro & Filipe,

Zorro Lang <zlang@redhat.com> =E6=96=BC 2022=E5=B9=B48=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A9:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Aug 24, 2022 at 06:42:02PM +0800, bingjingc wrote:
> > From: BingJing Chang <bingjingc@synology.com>
> >
> > Normally btrfs stores file paths in an array of ref items. However, ite=
ms
> > for the same parent directory can not exceed the size of a leaf. So btr=
fs
> > also store the rest of them in extended ref items alternatively.
> >
> > In this test, it creates a large number of links under a directory caus=
ing
> > the file paths stored in these two ways to be the parent snapshot. And =
it
> > deletes and recreates just an amount of them that can be stored within =
an
> > array of ref items to be the send snapshot. Test that an incremental se=
nd
> > operation correctly issues link/unlink operations only against new/dele=
ted
> > paths, or the receive operation will fail due to a link on an existed p=
ath.
> >
> > This currently fails on btrfs but is fixed by a kernel patch with the
> > commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
> > existing file paths")
> >
> > Signed-off-by: BingJing Chang <bingjingc@synology.com>
> > ---
> >  tests/btrfs/272     | 91 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/272.out |  3 ++
> >  2 files changed, 94 insertions(+)
> >  create mode 100755 tests/btrfs/272
> >  create mode 100644 tests/btrfs/272.out
> >
> > diff --git a/tests/btrfs/272 b/tests/btrfs/272
> > new file mode 100755
> > index 00000000..57dd065c
> > --- /dev/null
> > +++ b/tests/btrfs/272
> > @@ -0,0 +1,91 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 BingJing Chang.
> > +#
> > +# FS QA Test No. btrfs/272
> > +#
> > +# Regression test for btrfs incremental send issue where a link instru=
ction
> > +# is sent against an existing path, causing btrfs receive to fail.
> > +#
> > +# This issue is fixed by the following linux kernel btrfs patch:
> > +#
> > +#   commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
> > +#   existing file paths")
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send
> > +
> > +# Import common functions.
> > +. ./common/filter
>
> I think this case doesn't use any helpers in common/filter, if so you can
> remove this line. Others looks good to me.
>

I removed the redundant import of common/filter and tested that the patch
can work. So I remove the line and provide the change log in patch v4.

> Reviewed-by: Zorro Lang <zlang@redhat.com>
>

Thank you both for your review.

> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_fixed_by_kernel_commit 3aa5bd367fa5a3 \
> > +     "btrfs: send: fix sending link commands for existing file paths"
> > +_require_test
> > +_require_scratch
> > +_require_fssum
> > +
> > +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> > +
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Create a file and 2000 hard links to the same inode
> > +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
> > +touch $SCRATCH_MNT/vol/foo
> > +for i in {1..2000}; do
> > +     link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> > +done
> > +
> > +# Create a snapshot for a full send operation
> > +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_M=
NT/snap1
> > +_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
> > +
> > +# Remove 2000 hard links and re-create the last 1000 links
> > +for i in {1..2000}; do
> > +     rm $SCRATCH_MNT/vol/$i
> > +done
> > +for i in {1001..2000}; do
> > +     link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> > +done
> > +
> > +# Create another snapshot for an incremental send operation
> > +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_M=
NT/snap2
> > +_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.s=
nap \
> > +                  $SCRATCH_MNT/snap2
> > +
> > +$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
> > +$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
> > +     -x $SCRATCH_MNT/snap2/snap1 $SCRATCH_MNT/snap2
> > +
> > +# Recreate the filesystem by receiving both send streams and verify we=
 get
> > +# the same content that the original filesystem had.
> > +_scratch_unmount
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Add the first snapshot to the new filesystem by applying the first s=
end
> > +# stream.
> > +_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> > +
> > +# The incremental receive operation below used to fail with the follow=
ing
> > +# error:
> > +#
> > +#    ERROR: link 1238 -> foo failed: File exists
> > +#
> > +# This is because the path "1238" was stored as an extended ref item i=
n the
> > +# original snapshot but as a normal ref item in the next snapshot. The=
 send
> > +# operation cannot handle the duplicated paths, which are stored in
> > +# different ways, well, so it decides to issue a link operation for th=
e
> > +# existing path. This results in the receiver to fail with the above e=
rror.
> > +_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
> > +
> > +$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
> > +$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
> > new file mode 100644
> > index 00000000..b009b87a
> > --- /dev/null
> > +++ b/tests/btrfs/272.out
> > @@ -0,0 +1,3 @@
> > +QA output created by 272
> > +OK
> > +OK
> > --
> > 2.37.1
> >
>

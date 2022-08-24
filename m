Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B587359F802
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 12:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiHXKnG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 06:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiHXKnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 06:43:02 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ABF82F9A;
        Wed, 24 Aug 2022 03:43:01 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11d7a859b3aso8910185fac.4;
        Wed, 24 Aug 2022 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=deBzEsXsvExh9r8DxnXuqzKJeOlOx98ndXkfWBI421Q=;
        b=q3igXZEa1IHhD0tCAfVmS0nRVbOtJOY0tS7qPUA2P9ZftqLRsrN/3geBxyMOXDz+5h
         D1HVDo5QOEpNpUM2a3w1/JaM1oMVtT82IHnXXkEH/vkhrrugXNgvx35a8DRzpalwbB/4
         zyqNYXgXG1q6s+HCfKpZn3+3eyxP5mBEZe7PeMPLOQaHCF//QwS7PFHeSZ+dDLdKBEAi
         Nf4QXaiQUrgNPa7gqIlySTVbMiPwB0J2WYt/wBqKCHGi9TJxIuIb09U8RInP0Cocvi+/
         v6gzk+vNjEMvfc3m+7ShQCuGfjEvDNx61uOyiKv6XNXuWqOJMiWGw9cIBFVomVbPQvLQ
         w1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=deBzEsXsvExh9r8DxnXuqzKJeOlOx98ndXkfWBI421Q=;
        b=vvq8hA/PHRLqHqJ9jDvJ0MamvrR7Axtk0TG1GzBQrS45TqKGfPfislY3PcX68LpuRx
         4EAfmFx8xThlsq7AeSocUEGRL3Ax5W0jiJxdMSUlN8MwC469a4Xet5XppSHcZ3ldvB6a
         qKsxNSdwRQ72wXsaCr2QfURz0ymtTDvn3eJhuNAtACtnfh579oy6jneToGvR6Vf4ZnUt
         1KTNy115LufoVI3SAxfRIQ9YpqhKHrun7YZpNNahmf3lg9KNRN8iuEfJI15QRQ5PgRvW
         BZ2XStHVes0K52uS5SkgJZxZ0nKPlJ7vsHFrc+Lnmvybrn1xMe2nXZMtdH0kbvC8r/Ay
         Fgbw==
X-Gm-Message-State: ACgBeo1jN2W4gyYkA2nHiBtSERcReCRDLwUigs1C8Gi/y3G5yvphtbGi
        xvCi4Ai9t58WvTxOOMvKTyAZJBCnTmXBIklhTKDYws2UbTMj8Q==
X-Google-Smtp-Source: AA6agR4kiJPfTDc3H0GERneozoOioFh8PLi1TDPmSl6BWuorrNmfq18By6F5gTLGIgsPzUySSR45QHpGYQnpj8TzKzU=
X-Received: by 2002:a05:6870:4250:b0:11d:2c26:3e90 with SMTP id
 v16-20020a056870425000b0011d2c263e90mr3255164oac.280.1661337780134; Wed, 24
 Aug 2022 03:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220822004932.1280053-1-bingjingc@synology.com> <20220823125234.j5mlgzbbq4pmvfub@zlang-mailbox>
In-Reply-To: <20220823125234.j5mlgzbbq4pmvfub@zlang-mailbox>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Wed, 24 Aug 2022 18:42:48 +0800
Message-ID: <CAMmgxWEK4LUp2VuJ=yKO36guB4qs==wFCNuzkji0TZp2ZNzCGg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: test incremental send for changed
 reference paths
To:     Zorro Lang <zlang@redhat.com>
Cc:     bingjingc <bingjingc@synology.com>,
        fstests <fstests@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
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

Hi Zorro,

Thank you for your review comments.

Zorro Lang <zlang@redhat.com> =E6=96=BC 2022=E5=B9=B48=E6=9C=8823=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E6=99=9A=E4=B8=8A8:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Aug 22, 2022 at 08:49:32AM +0800, bingjingc wrote:
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
> >  tests/btrfs/272     | 97 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/272.out |  3 ++
> >  2 files changed, 100 insertions(+)
> >  create mode 100755 tests/btrfs/272
> >  create mode 100644 tests/btrfs/272.out
> >
> > diff --git a/tests/btrfs/272 b/tests/btrfs/272
> > new file mode 100755
> > index 00000000..e1986de9
> > --- /dev/null
> > +++ b/tests/btrfs/272
> > @@ -0,0 +1,97 @@
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
>
> As Filipe said, welcome to use _fixed_by_kernel_commit and others related
> functions for a known regression test.

Thank you both for telling me this.

>
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -fr $send_files_dir
>
> Will things in $send_files_dir take much disk space? If not, we can keep =
it
> in $TEST_DIR (then remove this specific _cleanup), generally we don't nee=
d
> to keep $TEST_DIR clean (except it will affect later testing).
>

No, in this test, it only generates many hard links to an empty file.
It takes only a little space to store the btrfs send stream.
I'm not familiar with the testing framework, so I added the _cleanup()
as other tests. It makes sense to me, so I will remove it in patch v3.

> > +     rm -f $tmp.*
> > +}
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_test
> > +_require_scratch
> > +_require_fssum
> > +
> > +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> > +
> > +rm -fr $send_files_dir
> > +mkdir $send_files_dir
> > +
> > +_scratch_mkfs > /dev/null 2>&1
>
> What kind of stdout/stderr you need to fill out? Generally we can output =
it
> into .full file for later debug. Anyway, I can't say this's wrong.
>
No. I should have outputted it to $seqres.ful.
Thanks for reminding me.

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
> > +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/s=
nap2
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

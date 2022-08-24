Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332A159F804
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 12:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiHXKny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiHXKnx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 06:43:53 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A858287C;
        Wed, 24 Aug 2022 03:43:52 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so11510045otq.11;
        Wed, 24 Aug 2022 03:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=v/UQp8huwzpUIripPfKuy0uly3PFoDC3a0yqx/6OE1M=;
        b=SEvAvxIVAqb4gOhIzNb+GX7svnNeWUCWy9NPXPFlbzZSN9YRzWY4X+jNJU8BbNVxz9
         TLGko8Sl0jjVMRtzu5Bumz8nEsE5v6qpE6aRcNi1G1/jBxsUMcaJwATJkTNIzLA+J9wI
         7G4rGYnDwh1xH8DBBaiXICjgRe6faeArit3TLmcHpztZ18aPomBaRUb4ZABbaQSbgqu/
         ye8d3ia9L8eNFpNPSy/fAxF0yUx2avhWm5TL8/lTQyoUm4uAGURR4WTHfPeXcAyKWbhQ
         EWkbnnqxnpT4cF6JpuM59z0HGZ1I56KR0u4UVQN9+5GMKyNeY+91ejqKEpqd7RN2mrdq
         MzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=v/UQp8huwzpUIripPfKuy0uly3PFoDC3a0yqx/6OE1M=;
        b=0E7mjg4O01bW9N/Vj1WeVW67PHKB3C2w+0bLizldsQPVgBRa9NrFYMhzdjg+OtkHPJ
         1gHUAiTzleNyuyP64y0jcar2H1BV/bAkp0a9VZNsjRDh2RfdO8L3CmP5CkbLOhTp1KST
         x6MkqUabaC9bmOl9xkqYqEovnC2u2Q1OYCMUlNJRRc2PaSklWMpr/2NF68fv5Ckv7hOh
         hq16aa0xGsZ36mAhKA9hgtoyNJnlFaQNiyV/mKE4vWj110cdCiTDjllTj1c/NP1Nqfgd
         Nku8C2vP1670RCS1roXMV5nLteQT9dOJSeicXxIR/+LnZicz7mwD3WPXZ5WOfIiEgaU3
         N+WA==
X-Gm-Message-State: ACgBeo2ylpQqWXyaDU+VOttITFsWjKLEmn0gePEPwrEafkomiOYwYjTP
        GeVRUi1wWMM3wv3bJOA9SLWjQ/8K6/2/RvnNggMePyqPo64TPw==
X-Google-Smtp-Source: AA6agR7Ys7Ys4Q48FTJ/KsxlFT3BCHtV2TcxjWu1Ou9WbzxExfDEkYQll1lu1IT2pvEFY1bwMlVPgW16Yhrxtx84Ses=
X-Received: by 2002:a05:6830:44a3:b0:637:c53:5f55 with SMTP id
 r35-20020a05683044a300b006370c535f55mr10665546otv.256.1661337831278; Wed, 24
 Aug 2022 03:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220822004932.1280053-1-bingjingc@synology.com> <20220822112420.GA3115262@falcondesktop>
In-Reply-To: <20220822112420.GA3115262@falcondesktop>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Wed, 24 Aug 2022 18:43:39 +0800
Message-ID: <CAMmgxWFAcO3rD2jQfb6Rb-Xvs-CZvf1QctCUnCyg_2ZUNHt2PA@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: test incremental send for changed
 reference paths
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     bingjingc <bingjingc@synology.com>,
        fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, zlang@redhat.com
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

Hi Filipe,

Thank you for the review and the verification toward unpatched kernel.
I added these two small changes in patch v3, but I also fixed the
_scratch_mkfs output and  removed _cleanup() as Zorro suggested.

Since I did other changes in patch v3, could you take a look on it and
reply the Reviewed-by tag? Thanks.

Filipe Manana <fdmanana@kernel.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A7:24=E5=AF=AB=E9=81=93=EF=BC=9A
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
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -fr $send_files_dir
> > +     rm -f $tmp.*
> > +}
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
>
> I didn't tell you before, but I wasn't aware back then, that we now have
> an annotation to specify kernel commits, se here we should add:
>
> _fixed_by_kernel_commit 3aa5bd367fa5a3 \
>         "btrfs: send: fix sending link commands for existing file paths"
>
>
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
>
> So I ran the test on an unpatched kernel and it didn't fail!
>
> The reason is that that command is taking a snapshot of $SCRATCH_MNT, whe=
n it
> should be $SCRATCH_MNT/vol. So it wasn't testing what we were supposed to=
 test.
>
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
>
> Thanks for following the style of btrfs/241 and putting here an explanati=
on
> of why it failed!
>
> Btw, this patch didn't reach the btrfs mailing list, you typed the addres=
s as
> "linux-btrfs@vger.kernel.orgto", an extra "to" at the end.
>
> So I'm adding the list to cc.
>
> Anyway, with those two small changes, the patch will look good to me, the=
n
> you can add:
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks for doing this!
>
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

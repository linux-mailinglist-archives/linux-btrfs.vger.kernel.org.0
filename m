Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6D559B715
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 02:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiHVAud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Aug 2022 20:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiHVAub (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Aug 2022 20:50:31 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF608205DD;
        Sun, 21 Aug 2022 17:50:30 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso6740858otb.6;
        Sun, 21 Aug 2022 17:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ogrq44B5V+KfOIiTvQpD9mPl6lAvLeedqlMou1XN3vg=;
        b=imRtqRR61gODY5mNCubWjQbIZlKnz23YdkcDLY6Z6rhyC5IzDbGZForV6wONn79325
         bQT4ReFdV2fbkoDE5H6U+lpoc3gH5RPSv/EySNBODf78BETCKjeP9t7YVCJeXJBP2+gp
         8n2i2nkguW3jZoncGJZOJh7VS50yxqL4Lf/Y97SeQn1FsaeUFf8rxPcUjCLEh/uBr0pd
         KNODD/cwzw1326AiHTctIDh+3R7xN6fELEe/j3jr5n48wCjExyE8dsnb9J62Zk9S/bR5
         Q8WsgK1uOspHsd3bmopp4lUUopP8MtIgNzADVqd8kWz6UXINicTGOnoUB9WN4qCS4yyo
         3xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ogrq44B5V+KfOIiTvQpD9mPl6lAvLeedqlMou1XN3vg=;
        b=RxZ8c+ohst2kMfVCfz90WMemYczVTpRGGRVrOr7JZIwFyx5RbGiXENrWaN2AELcJvk
         krc3LPvet8FNbA1OZAtli5zpkEKviyhnVPYiGEZGeYzCIlyb/rooLaY1jtUBsMpAxq/X
         jrvMxnmEvWW5ihfqUvrzAwjalEvpklA3Fn0bpsnLH1cOUqe9Qid+2ArfU5eVKR7qHTcf
         5JbVMAWbLJW0XqYONNeIJjK1v9LJvRPXSy5qnsKq/jTWWG8CElkETqd008WYdstk8tlP
         zbmPwqnuM6nfgZabPQ9TwPosOfgk3kCnnIysV1MReTyjhLI9XG/XWNXwarkWYx9blixV
         kYYQ==
X-Gm-Message-State: ACgBeo3dYvn8DR5tFu4cERs5ZIqlP/V/RJ5vPo7OXZwrT5u3HQt4ZglC
        HT1vflekfxRsn6UwjpqvPFGNL7BS4J+zNVFHh1cHGeTZwSc=
X-Google-Smtp-Source: AA6agR7Vau4QCq0p7jQtEeqZIcAsHC4o9f3eIBjbmwgzFehSqNErevrrmoaY6C+3ZR+x9AaCp+O04oWqCfRDQuBxiQU=
X-Received: by 2002:a9d:3e5d:0:b0:639:2702:b9e8 with SMTP id
 h29-20020a9d3e5d000000b006392702b9e8mr1450708otg.337.1661129429822; Sun, 21
 Aug 2022 17:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220806143436.3501-1-bingjingc@synology.com> <CAL3q7H52=bJj7nGsso0zhD6kYHDtXGhR7FSM=aFkF2wUvtWOSQ@mail.gmail.com>
In-Reply-To: <CAL3q7H52=bJj7nGsso0zhD6kYHDtXGhR7FSM=aFkF2wUvtWOSQ@mail.gmail.com>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Mon, 22 Aug 2022 08:50:18 +0800
Message-ID: <CAMmgxWE4WQ2hbi_Fn5Zizpux=_R4ezPoi2Xc=+J7btw1pF_umw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: test incremental send for changed
 reference paths
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     bingjingc <bingjingc@synology.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
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

Thank you for your review comments and the clear example (btrfs/241) for me=
.
I've revised and submitted the patch v2 using fssum utility.

If there're still problems, please reply to that mail to let me know. Thank=
s!

Filipe Manana <fdmanana@kernel.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:30=E5=AF=AB=E9=81=93=EF=BC=9A

>
> On Sat, Aug 6, 2022 at 3:35 PM bingjingc <bingjingc@synology.com> wrote:
> >
> > From: BingJing Chang <bingjingc@synology.com>
> >
> > Normally btrfs stores reference paths in an array of ref items. However=
,
> > items for the same parent directory can not exceed the size of a leaf. =
So
> > btrfs also store the rest of them in extended ref items alternatively.
> >
> > In this test, it creates a large number of links under a directory
> > causing the reference paths stored in these two ways as the parent
> > snapshot. And it deletes and recreates just an amount of them that can =
be
> > stored within an array of ref items as the send snapshot. Test that an
> > incremental send operation correctly issues link/unlink operations only
> > against new/deleted reference paths, or the receive operation will fail
> > due to a link on an existed path.
> >
> > This currently fails on btrfs but is fixed by a kernel patch with the
> > following subject:
>
> Thanks for sending the test BingJing!
> Some comments below.
>
> >
> >   "btrfs: send: fix sending link commands for existing file paths"
>
> Since the patch already landed in Linus' tree last week, the preferred
> format here is:
>
> commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
> existing file paths")
>
> >
> > Signed-off-by: BingJing Chang <bingjingc@synology.com>
> > ---
> >  tests/btrfs/272     | 65 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/272.out |  2 ++
> >  2 files changed, 67 insertions(+)
> >  create mode 100755 tests/btrfs/272
> >  create mode 100644 tests/btrfs/272.out
> >
> > diff --git a/tests/btrfs/272 b/tests/btrfs/272
> > new file mode 100755
> > index 00000000..a362d943
> > --- /dev/null
> > +++ b/tests/btrfs/272
> > @@ -0,0 +1,65 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 BingJing Chang.
> > +#
> > +# FS QA Test No. btrfs/272
> > +#
> > +# Regression test for btrfs incremental send issue where a link instru=
ction
> > +# is sent against an existed file, causing btrfs receive to fail.
>
> existed file -> existing path
>
> > +#
> > +# This issue is fixed by the following linux kernel btrfs patch:
> > +#
> > +#   btrfs: send: fix sending link commands for existing file paths
>
> Same here.
>
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick send
> > +
> > +tmp=3D`mktemp -d`
>
> Overriding $tmp, which is set by the fstests framework is not a good idea=
.
> It's expected to be a file and not a directory.
>
> If you need a directory to store temporary files, you can use the test de=
vice.
> Take a look at btrfs/241 for example.
>
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +       rm -rf $tmp
>
> Then here leave the standard "rm -f $tmp.*" followed by a rm -rf of
> the temporary directory in the test mount point.
>
> > +}
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_test
> > +_require_scratch
> > +
> > +_scratch_mkfs > /dev/null 2>&1
> > +_scratch_mount
> > +
> > +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
> > +
> > +# create a file and 2000 hard links to the same inode
> > +touch $SCRATCH_MNT/vol/foo
> > +for i in {1..2000}; do
> > +       link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> > +done
> > +
> > +# take a snapshot for a parent snapshot
>
> "take a snapshot for a full send operation"
>
> > +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_M=
NT/snap1
> > +
> > +# remove 2000 hard links and re-create the last 1000 links
> > +for i in {1..2000}; do
> > +       rm $SCRATCH_MNT/vol/$i
> > +done
> > +for i in {1001..2000}; do
> > +       link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> > +done
> > +
> > +# take another one for a send snapshot
>
> "take a snapshot for an incremental send operation"
>
> > +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_M=
NT/snap2
> > +
> > +mkdir $SCRATCH_MNT/receive_dir
> > +_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $tmp/diff.snap \
> > +       $SCRATCH_MNT/snap2
> > +_run_btrfs_util_prog receive -f $tmp/diff.snap $SCRATCH_MNT/receive_di=
r
> > +_scratch_unmount
>
> Btw, there's no need to call _scratch_unmount, the fstests framework
> automatically does that when the test finishes.
>
> So, this tests that the send and receive commands do not fail.
>
> However it does not test that they produce the correct results: that
> after the receive we have the file with the same hardlinks, mtime,
> ctime, etc, as in the original subvolume.
> For send/receive tests (well, most tests actually), we always want to
> verify that the operations produce the expected results, not just that
> they don't fail with an error.
>
> The fssum utility can be used here to verify that, and we use it in
> many send/receive tests like btrfs/241 for example.
>
> Thanks for doing this!
>
> > +
> > +echo "Silence is golden"
> > +status=3D0 ; exit
> > diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
> > new file mode 100644
> > index 00000000..c18563ad
> > --- /dev/null
> > +++ b/tests/btrfs/272.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 272
> > +Silence is golden
> > --
> > 2.37.1
> >

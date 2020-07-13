Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5821D754
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgGMNhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 09:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgGMNhO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 09:37:14 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA6AC061755;
        Mon, 13 Jul 2020 06:37:14 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g4so4067068uaq.10;
        Mon, 13 Jul 2020 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GLkU34sJde24g+wf6WlZUo82RGuDrreNQl4BHmolOOU=;
        b=plsSah3o1fMBSHhfd8qYhvKXEErer2quMlnP7X0c1SKkjVYYxIIqH7jEwmyeNaDcjU
         mAaR7XaoKEqf44CgJTyPUdakVfYzCbjsUMv76GOr3g0RAhT8H0c68fd4kHGkPkcnfUn2
         W8SBOJQT6olmSP7qnmnzMYAnIDub+nCnVI/waxGfF2MHE04MULgi0leIBbsiTCdrz2Sj
         05wE6vy8pdJImn3r3/3rm0LJUi3aUa7BGvh0P/jM5ZWM98Nfa8HAxR2Ww8Tetki1vPEL
         5H81FawDlaGE7Iv9yvflhgiPVAxK3KozUg0NQ7PVf9qCjgS0vxw10WQzZ+YJHchMTHqG
         akIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=GLkU34sJde24g+wf6WlZUo82RGuDrreNQl4BHmolOOU=;
        b=faCPxveT0kjR5eC167Wuu2qhvYimEZ4WabJ5KIcgH+71/53JlFo1w3ZrZxFGEVg4Rl
         GG3FmQs7LMYJjdn2VwgdJ9ISKSrvTSOHiRTEiIa2kkEKZui9YYo10Y9ucum8jRSwG5un
         BhCRMFY8q4nDzOYAyhsr2l6zcVTPGqafZ529hjW/xSEP3n06tbzRwOcJ3nAlmc8sKcHu
         D0IDI9Euy4JKTvbnP1hLJvj30BzW28jVoCCCKXjnIKy0IWbns4EapV4tVYqNjE7xWy+z
         6aL7q7XLGNXtxsbBCEfu3nUJ0RlAAC62cfdxjFS4mJn+K6BDu4mPOCCKclQ9cvccHo4J
         umdQ==
X-Gm-Message-State: AOAM530RAgTvk9m/ORH09nIiWDkF2Zv64AtE84tqV1ftMbPbgiX/faL4
        7LUQwNHRZDRUF6YtO0iKE7UlPlwq2XYbsnOtygo=
X-Google-Smtp-Source: ABdhPJxinZZkWgH0/MxgmXttb2F0Mllc57Vz9W/bJ3chg9U+xIGEVue1ENeFdpkYAwMgabztsjkM9Y8JbeU6cgywDPI=
X-Received: by 2002:ab0:60b2:: with SMTP id f18mr58461546uam.123.1594647433513;
 Mon, 13 Jul 2020 06:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200710185519.10322-1-marcos@mpdesouza.com> <CAL3q7H4PswiXqS_Zy+w58Oj8cv6iBHj-LYDN4-EmU-Q5PAEubA@mail.gmail.com>
 <2eea62e0d90e6948ae5210bebad80c206314656f.camel@mpdesouza.com>
In-Reply-To: <2eea62e0d90e6948ae5210bebad80c206314656f.camel@mpdesouza.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 13 Jul 2020 14:37:02 +0100
Message-ID: <CAL3q7H7_TeP5e17i-k8OVJ1TzoQn96-VKk4QP7JEqeRW25Nw2w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Ignore output of "btrfs quota rescan"
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 1:22 PM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> On Mon, 2020-07-13 at 11:05 +0100, Filipe Manana wrote:
> > On Fri, Jul 10, 2020 at 7:57 PM Marcos Paulo de Souza
> > <marcos@mpdesouza.com> wrote:
> > >
> > > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > >
> > > Some recent test already ignore this output, while older ones do
> > not.
> > > It can sometimes make tests fail because "quota rescan" can show
> > the
> > > message "quota rescan started". Ignoring the output of the command
> > > solves this problem.
> >
> >
> > Hi Marcos,
> >
> > Can you elaborate exactly how it fails?
>
> QA output created by 210
> quota rescan started
> Silence is goldenSure, my fault to not clarifying the error I was
> facing. This only happens with btrfs/210, which fails for me:
>
> QA output created by 210
> quota rescan started
> Silence is golden

Then this patch should only touch 210.

>
> I've never seen those tests fail due to an unexpected "quota rescan
> > started" message.
> >
> > I also don't see how this change fixes anything, because:
> >
> > 1) The quota rescans are always executed - so we should always see
> > such failure;
>
> Yes, it's interesting because running other tests touched by this
> patchset do not trigger the issue, but I thought it would be nice to
> have this pattern among all tests that start a quota rescan. Any ideas
> why this happens?
>
> With this patch, specifically with the change on btrfs/210 solves the
> issue for me as the message is dropped.

So we should have a changelog that explains why the issue happens.

Looking at 210, my guess is that the rescan command starts the rescan
worker before the quota enable ioctl does (causing the message to be
printed),
as starting it is done asynchronously (iirc there were several bugs by
this in the past, I fixed some of them, others fixed other similar
problems).
This needs to be checked/confirmed and then mentioned in the change log.

Redirecting stdout to /dev/null or the .full file fixes the problem,
and I'm fine with it if the above is indeed the cause for the
unexpected message.

Thanks.

>
> Thanks,
>   Marcos
>
> >
> > 2) More importantly _run_btrfs_util_prog is:
> >
> > _run_btrfs_util_prog()
> > {
> >    run_check $BTRFS_UTIL_PROG $*
> > }
> >
> > and run_check:
> >
> > run_check()
> > {
> >    echo "# $@" >> $seqres.full 2>&1
> >    "$@" >> $seqres.full 2>&1 || _fail "failed: '$@'"
> > }
> >
> > So any output from _run_btrfs_util_prog is redirected to the test's
> > .full file.
> > It will not cause a mismatch with the golden output.
> >
> >
> > >
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > >  tests/btrfs/017 | 2 +-
> > >  tests/btrfs/022 | 4 ++--
> > >  tests/btrfs/028 | 2 +-
> > >  tests/btrfs/057 | 2 +-
> > >  tests/btrfs/091 | 2 +-
> > >  tests/btrfs/104 | 2 +-
> > >  tests/btrfs/123 | 2 +-
> > >  tests/btrfs/126 | 2 +-
> > >  tests/btrfs/139 | 2 +-
> > >  tests/btrfs/153 | 2 +-
> > >  tests/btrfs/193 | 2 +-
> > >  tests/btrfs/210 | 2 +-
> > >  12 files changed, 13 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tests/btrfs/017 b/tests/btrfs/017
> > > index 1bb8295b..a888b8db 100755
> > > --- a/tests/btrfs/017
> > > +++ b/tests/btrfs/017
> > > @@ -64,7 +64,7 @@ $CLONER_PROG -s 0 -d 0 -l $EXTENT_SIZE
> > $SCRATCH_MNT/foo \
> > >              $SCRATCH_MNT/snap/foo-reflink2
> > >
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> >
> > So this is pointless, as mentioned before, any output is already
> > redirected to the test's .full file.
> > The same applies to all changes below.
> >
> > So I fail to see what problem you are trying to solve.
> >
> > Thanks.
> >
> > >
> > >  rm -fr $SCRATCH_MNT/foo*
> > >  rm -fr $SCRATCH_MNT/snap/foo*
> > > diff --git a/tests/btrfs/022 b/tests/btrfs/022
> > > index aaa27aaa..442cc05c 100755
> > > --- a/tests/btrfs/022
> > > +++ b/tests/btrfs/022
> > > @@ -38,7 +38,7 @@ _basic_test()
> > >         echo "=3D=3D=3D basic test =3D=3D=3D" >> $seqres.full
> > >         _run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> > >         _run_btrfs_util_prog quota enable $SCRATCH_MNT/a
> > > -       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > >/dev/null
> > >         subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
> > >         $BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep
> > $subvolid >> \
> > >                 $seqres.full 2>&1
> > > @@ -77,7 +77,7 @@ _rescan_test()
> > >         echo "qgroup values before rescan: $output" >> $seqres.full
> > >         refer=3D$(echo $output | awk '{ print $2 }')
> > >         excl=3D$(echo $output | awk '{ print $3 }')
> > > -       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +       _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > >/dev/null
> > >         output=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT |
> > grep "0/$subvolid")
> > >         echo "qgroup values after rescan: $output" >> $seqres.full
> > >         [ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
> > > diff --git a/tests/btrfs/028 b/tests/btrfs/028
> > > index 98b9c8b9..4a574b8b 100755
> > > --- a/tests/btrfs/028
> > > +++ b/tests/btrfs/028
> > > @@ -42,7 +42,7 @@ _scratch_mkfs >/dev/null
> > >  _scratch_mount
> > >
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> > >
> > >  # Increase the probability of generating de-refer extent, and
> > decrease
> > >  # other.
> > > diff --git a/tests/btrfs/057 b/tests/btrfs/057
> > > index 82e3162e..aa1d429c 100755
> > > --- a/tests/btrfs/057
> > > +++ b/tests/btrfs/057
> > > @@ -47,7 +47,7 @@ run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w
> > -p 5 -n 1000 \
> > >         $FSSTRESS_AVOID >&/dev/null
> > >
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> > >
> > >  echo "Silence is golden"
> > >  # btrfs check will detect any qgroup number mismatch.
> > > diff --git a/tests/btrfs/091 b/tests/btrfs/091
> > > index 6d2a23c8..a4aeebc3 100755
> > > --- a/tests/btrfs/091
> > > +++ b/tests/btrfs/091
> > > @@ -59,7 +59,7 @@ _run_btrfs_util_prog subvolume create
> > $SCRATCH_MNT/subv2
> > >  _run_btrfs_util_prog subvolume create $SCRATCH_MNT/subv3
> > >
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> > >
> > >  # if we don't support noinode_cache mount option, then we should
> > double check
> > >  # whether inode cache is enabled before executing the real test
> > payload.
> > > diff --git a/tests/btrfs/104 b/tests/btrfs/104
> > > index f0cc67d6..d3338e35 100755
> > > --- a/tests/btrfs/104
> > > +++ b/tests/btrfs/104
> > > @@ -113,7 +113,7 @@ _explode_fs_tree 1 $SCRATCH_MNT/snap2/files-
> > snap2
> > >  # Enable qgroups now that we have our filesystem prepared. This
> > >  # will kick off a scan which we will have to wait for.
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> > >
> > >  # Remount to clear cache, force everything to disk
> > >  _scratch_cycle_mount
> > > diff --git a/tests/btrfs/123 b/tests/btrfs/123
> > > index 65177159..63b6d428 100755
> > > --- a/tests/btrfs/123
> > > +++ b/tests/btrfs/123
> > > @@ -56,7 +56,7 @@ sync
> > >
> > >  # enable quota and rescan to get correct number
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> > >
> > >  # now balance data block groups to corrupt qgroup
> > >  _run_btrfs_balance_start -d $SCRATCH_MNT >> $seqres.full
> > > diff --git a/tests/btrfs/126 b/tests/btrfs/126
> > > index 8635791e..eceaabb2 100755
> > > --- a/tests/btrfs/126
> > > +++ b/tests/btrfs/126
> > > @@ -41,7 +41,7 @@ _scratch_mkfs >/dev/null
> > >  _scratch_mount "-o enospc_debug"
> > >
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> > >  _run_btrfs_util_prog qgroup limit 512K 0/5 $SCRATCH_MNT
> > >
> > >  # The amount of written data may change due to different nodesize
> > at mkfs time,
> > > diff --git a/tests/btrfs/139 b/tests/btrfs/139
> > > index 1b636e81..44168e2a 100755
> > > --- a/tests/btrfs/139
> > > +++ b/tests/btrfs/139
> > > @@ -43,7 +43,7 @@ SUBVOL=3D$SCRATCH_MNT/subvol
> > >
> > >  _run_btrfs_util_prog subvolume create $SUBVOL
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> > >  _run_btrfs_util_prog qgroup limit -e 1G $SUBVOL
> > >
> > >
> > > diff --git a/tests/btrfs/153 b/tests/btrfs/153
> > > index f343da32..1f8e37e7 100755
> > > --- a/tests/btrfs/153
> > > +++ b/tests/btrfs/153
> > > @@ -41,7 +41,7 @@ _scratch_mkfs >/dev/null
> > >  _scratch_mount
> > >
> > >  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> > > -_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> > > +_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT >/dev/null
> > >  _run_btrfs_util_prog qgroup limit 100M 0/5 $SCRATCH_MNT
> > >
> > >  testfile1=3D$SCRATCH_MNT/testfile1
> > > diff --git a/tests/btrfs/193 b/tests/btrfs/193
> > > index 16b7650c..8bdc7566 100755
> > > --- a/tests/btrfs/193
> > > +++ b/tests/btrfs/193
> > > @@ -43,7 +43,7 @@ _scratch_mkfs > /dev/null
> > >  _scratch_mount
> > >
> > >  $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
> > > -$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
> > > +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >/dev/null
> > >  $BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
> > >
> > >  # Create a file with the following layout:
> > > diff --git a/tests/btrfs/210 b/tests/btrfs/210
> > > index daa76a87..a9a04951 100755
> > > --- a/tests/btrfs/210
> > > +++ b/tests/btrfs/210
> > > @@ -46,7 +46,7 @@ _pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" >
> > /dev/null
> > >  # by qgroup
> > >  sync
> > >  $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
> > > -$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT"
> > > +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >/dev/null
> > >  $BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
> > >
> > >  # Create a snapshot with qgroup inherit
> > > --
> > > 2.26.2
> > >
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

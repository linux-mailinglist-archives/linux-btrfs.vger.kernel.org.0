Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC31EA544
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFANs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 09:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgFANs2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Jun 2020 09:48:28 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17B8C05BD43;
        Mon,  1 Jun 2020 06:48:26 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id e1so9092vkd.1;
        Mon, 01 Jun 2020 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hsZFG2Pc7Y3pV9a/fbGgb3+JRht8JuSB85nLZin/uUQ=;
        b=GAdRdQZG5Z+DHxlvZRCHYnCU1KnKoofLXW681gYwt4mVM8n4iLjUo7CDiI2heUDkA6
         xCZzrYH/hXXZnEnEzqJ/VOv3+kYI5JosBe4hePZpKtlwp9P82b+RRoojAMj2fXmVRmzl
         iPKFQIVusMtCeT+lA2lhr4J4s4qlD4k0AcPQsKAZ7Ug5qO3euPemsPg2fMRS4IvwNMs9
         PuKVOgOqgxB36WiVDrDDYggvt6B69B8P2/WN2EqmA7+ZTBMam9Tg5WIQ1z1R/q6LcZFS
         6XFBqRk2luD/gNNNLaJQvPAbjkZRs+ibt/GyXZXn6G+KppFmoZxdjglnAAmLLHe8ZCbj
         cqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hsZFG2Pc7Y3pV9a/fbGgb3+JRht8JuSB85nLZin/uUQ=;
        b=tDfIdjEJpj119hsaDZ+4uWjedHXOeeOSiEIQmhQtm88m6/Wl/+sJTLziVbx0jrmmM6
         q1p9hvJuW0kth+mk3xMMpgRjtgtAilAyXL1LghdwCcFCU7CXIy48j1mRweZJLdmpaGdJ
         vqJG8pOWhfXNbJL9xLJEiPXaNQRND2yL8m3YwwFuxIR+iitdCQXCnBNa8/APf9MJQ/q3
         FUMHzNhvFMWdCJLzUOYVt1p3NvcjOXhpfmWOAQOPFbCvDkewA08yyKITQbaYCFiZXQW3
         TGm2wqn85Ef09ZTWVbpE1Oc630ZVrpnQkkLjES0O7BNiwTX+XaBzOAjVs5JzrMsquxc7
         z1Yg==
X-Gm-Message-State: AOAM5305WUm2krBf/4TV4Z5qq/8rpqdAPt6ak3wG1L/ii/IOqPGTlr92
        XA+blBdy6w6JTZLIN08HKq1vdCsw8Z/vyObcksjipg==
X-Google-Smtp-Source: ABdhPJzbewlGC4UG9fkDY9KYaXUsMkpwYO85ktvkFRDJRBz1CmJoti/ibKnYS7nrF0LujdFYoj9uLXSR2YeTpEbfdPM=
X-Received: by 2002:a1f:ae51:: with SMTP id x78mr14073016vke.24.1591019305687;
 Mon, 01 Jun 2020 06:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200508195548.25429-1-marcos@mpdesouza.com> <CAL3q7H5Xnk6Ds9inLY7xOeT_knq3ySghrYeXQk2z-nQkyr712Q@mail.gmail.com>
In-Reply-To: <CAL3q7H5Xnk6Ds9inLY7xOeT_knq3ySghrYeXQk2z-nQkyr712Q@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 1 Jun 2020 14:48:14 +0100
Message-ID: <CAL3q7H61dS6GQh29vL-Pq+jaDLA-z3dwAkXkBdOgiW2XYgB6PQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: test if the capability is kept on incremental send
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 11, 2020 at 12:52 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Fri, May 8, 2020 at 9:14 PM Marcos Paulo de Souza
> <marcos@mpdesouza.com> wrote:
> >
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> >
> > There is a situation where the incremental send can drop the capability
> > from the receiving side. If you have a file that changed the group, but
> > the capability was the same of before the group changed, the current
> > kernel code will only emit a chown, since the capability is the same.
> >
> > The steps bellow can reproduce the problem.
> >
> > $ mount /dev/sda fs1
> > $ mount /dev/sdb fs2
> >
> > $ touch fs1/foo.bar
> > $ setcap cap_sys_nice+ep fs1/foo.bar
> > $ btrfs subvol snap -r fs1 fs1/snap_init
> > $ btrfs send fs1/snap_init | btrfs receive fs2
> >
> > $ chgrp adm fs1/foo.bar
> > $ setcap cap_sys_nice+ep fs1/foo.bar
> >
> > $ btrfs subvol snap -r fs1 fs1/snap_complete
> > $ btrfs subvol snap -r fs1 fs1/snap_incremental
> >
> > $ btrfs send fs1/snap_complete | btrfs receive fs2
> > $ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2
>
> It's redundant to put here the steps to trigger the problem, that's
> what the test does.
>
> You just want to say this test exercises full send and incremental
> send operations for cases where files have capabilities, to verify the
> capabilities aren't lost.
>
> >
> > At this point, a chown was emitted by "btrfs send" since only the group
> > was changed. This makes the cap_sys_nice capability to be dropped from
> > fs2/snap_incremental/foo.bar
>
> Explaining in a changelog for a test case why exactly the bug happens
> is out of scope.
> We just want to know what bug are we testing for.
>
> The gory details about why the bug happens usually go the in the
> changelog of the patch that fixes btrfs.
>
> >
> > This test fails on current kernel, the fix was submitted to the btrfs
> > mailing list titled:
> >
> > "btrfs: send: Emit file capabilities after chown"
> >
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  tests/btrfs/211     | 153 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/211.out |   6 ++
> >  tests/btrfs/group   |   1 +
> >  3 files changed, 160 insertions(+)
> >  create mode 100755 tests/btrfs/211
> >  create mode 100644 tests/btrfs/211.out
> >
> > diff --git a/tests/btrfs/211 b/tests/btrfs/211
> > new file mode 100755
> > index 00000000..e9aeaef3
> > --- /dev/null
> > +++ b/tests/btrfs/211
> > @@ -0,0 +1,153 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 211
> > +#
> > +# Test if the file capabilities aren't lost after full and incremental=
 send
> > +#
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +status=3D1       # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_scratch
> > +_require_command "$SETCAP_PROG" setcap
> > +_require_command "$GETCAP_PROG" getcap
> > +
> > +_cleanup()
> > +{
> > +       cd /
> > +       rm -f $tmp.*
> > +}
> > +
> > +_check_xattr()
>
> Function names starting with '_' are usually reserved for functions
> provided by fstests, global functions (like the ones in common/*).
> Same comment applies to all the other function names.
>
> Also, a better name would be "check_capabilities" - that they are
> stored in a xattr it's irrelevant as we are using the getcap and
> setcap utilities to read and set them, and not accessing xattrs
> directly.
>
> > +{
> > +       local RET
> > +       local FILE
> > +       local CAP
> > +       FILE=3D"$1"
> > +       CAP=3D"$2"
>
> Variables in uppercase are meant to be used for global variables. Same
> comment applies to all the other functions.
>
> > +       RET=3D$($GETCAP_PROG "$FILE")
> > +       if [ -z "$RET" ]; then
> > +               echo "$RET"
> > +               _fail "missing capability in file $FILE"
>
> This is a practice generally discouraged, we should avoid "_fail"
> unless absolutely necessary.
> The right approach here is just to "echo" the message. That's enough
> to make the test fail as that message is not part of the golden
> output.
> Furthermore, not using _fail allows the test to proceed and
> potentially find other problems.
>
> > +       fi
> > +       if [[ "$RET" !=3D *$CAP* ]]; then
> > +               echo "$RET"
> > +               echo "$CAP"
> > +               _fail "Capability do not match. Output: $RET"
>
> Capability -> Capabilities
>
> > +       fi
> > +}
> > +
> > +_setup()
> > +{
> > +       _scratch_mkfs >/dev/null
> > +       _scratch_mount
> > +
> > +       FS1=3D"$SCRATCH_MNT/fs1"
> > +       FS2=3D"$SCRATCH_MNT/fs2"
>
> To make it easier to follow, perhaps declare this outside this
> function, as they are used by the other functions.
>
> > +
> > +       $BTRFS_UTIL_PROG subvolume create "$FS1" > /dev/null
> > +       $BTRFS_UTIL_PROG subvolume create "$FS2" > /dev/null
> > +}
> > +
> > +_full_nocap_inc_withcap_send()
> > +{
> > +       _setup
> > +
> > +       # Test full send containing a file with no capability
> > +       touch "$FS1/foo.bar"
> > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" =
>/dev/null
> > +       $BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG re=
ceive "$FS2" -q
> > +       # ensure that we don't have caps set
> > +       RET=3D$($GETCAP_PROG "$FS2/snap_init/foo.bar")
>
> Should be declared local (and lower case name).
>
> > +       if [ -n "$RET" ]; then
> > +               _fail "File contain capabilities when it shouldn't"
>
> echo and contain -> contains
>
> > +       fi
> > +
> > +       # Test if  incremental send bring the newly added capability
> > +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >=
/dev/null
> > +       $BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | =
\
> > +                                       $BTRFS_UTIL_PROG receive "$FS2"=
 -q
> > +       _check_xattr "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_ni=
ce+ep"
> > +
> > +       _scratch_unmount
> > +}
> > +
> > +_roundtrip_send()
> > +{
> > +       local FILES
> > +       local FS1
> > +       local FS2
>
> So FS1 and FS2 are declared local but never set. And they were
> previously set as global by "_setup".
> So those two declarations should be removed here.
>
> > +
> > +       # FILES should include foo.bar
> > +       FILES=3D"$1"
> > +
> > +       _setup
> > +
> > +       # create files on fs1, must contain foo.bar
> > +       for f in $FILES; do
> > +               touch "$FS1/$f"
> > +       done
> > +
> > +       # Test full send, checking if the receiving side keeps the capa=
bility
>
> capability -> capabilities (as the test sets 2)
>
> > +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" =
>/dev/null
> > +       $BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG re=
ceive "$FS2" -q
> > +       _check_xattr "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_sys_n=
ice+ep"
> > +
> > +       # Test incremental send with different owner/group but same cap=
ability
>
> capability -> capabilities (as the test sets 2)
>
> > +       chgrp 100 "$FS1/foo.bar"
> > +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >=
/dev/null
> > +       _check_xattr "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_ni=
ce+ep"
> > +       $BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | =
\
> > +                               $BTRFS_UTIL_PROG receive "$FS2" -q
> > +       _check_xattr "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_ni=
ce+ep"
> > +
> > +       # Test capability after incremental send with different capabil=
ity and group
>
> capability -> capabilities (as the test sets 2)
>
> > +       chgrp 0 "$FS1/foo.bar"
> > +       $SETCAP_PROG "cap_sys_time+ep cap_syslog+ep" "$FS1/foo.bar"
> > +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc2" =
>/dev/null
> > +       _check_xattr "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+=
ep"
> > +       $BTRFS_UTIL_PROG send -p "$FS1/snap_inc" "$FS1/snap_inc2" -q | =
\
> > +                               $BTRFS_UTIL_PROG receive "$FS2"  -q
> > +       _check_xattr "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+=
ep"
> > +
> > +       _scratch_unmount
> > +}
> > +
> > +# real QA test starts here
> > +
> > +echo "Test full send + file without caps, then inc send bringing a new=
 cap"
>
> inc -> incremental
>
> Also, the abbreviation "caps" is used but in other messages (below)
> the non-abbreviated name "capabilities" is used.
> We should be consistent and use only one form.
>
> > +_full_nocap_inc_withcap_send
> > +
> > +echo "Testing if foo.bar alone can keep it's capability"
>
> it's -> its
> capability -> capabilities (as the test sets 2)
>
> > +_roundtrip_send "foo.bar"
> > +
> > +echo "Test foo.bar being the first item among other files"
> > +_roundtrip_send "foo.bar foo.bax foo.baz"
> > +
> > +echo "Test foo.bar with objectid between two other files"
> > +_roundtrip_send "foo1 foo.bar foo3"
> > +
> > +echo "Test foo.bar being the last item among other files"
> > +_roundtrip_send "foo1 foo2 foo.bar"
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/211.out b/tests/btrfs/211.out
> > new file mode 100644
> > index 00000000..fc50c923
> > --- /dev/null
> > +++ b/tests/btrfs/211.out
> > @@ -0,0 +1,6 @@
> > +QA output created by 211
> > +Test full send + file without caps, then inc send bringing a new cap
> > +Testing if foo.bar alone can keep it's capability
> > +Test foo.bar being the first item among other files
> > +Test foo.bar with objectid between two other files
> > +Test foo.bar being the last item among other files
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index 9426fb17..437d4431 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -213,3 +213,4 @@
> >  208 auto quick subvol
> >  209 auto quick log
> >  210 auto quick qgroup snapshot
> > +211 auto quick snapshot
>
> Missing the 'send' group.
>
> Other that is looks good and it works as expected (with patched and
> unpatched btrfs)
> Thanks.

Marcos, ping. Anything I can help with?
We should really have this test case in fstests.

Thanks.

>
> > --
> > 2.25.1
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

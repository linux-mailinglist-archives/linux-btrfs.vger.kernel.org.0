Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B541CD8F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 13:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgEKLwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 07:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729309AbgEKLwt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 07:52:49 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDF7C061A0C;
        Mon, 11 May 2020 04:52:48 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x6so5393232vso.1;
        Mon, 11 May 2020 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7Dry/VmCqvDOvEMPGyU3c0AVpRNc04tYnK1hfrgb+No=;
        b=rCl9Gx79PfwNmgqe6LRTy2viCVkeAWfhiGrZzWf4iCd0PySg/CX5ym/1HIs/RTWH3g
         kjaEUgtYuKWrMWPSbZy0flrTA7iJJ32OcPTFCnPfIqAWrQ9mOn4KsSiqM3Gb9jHFy9LR
         eN1cKx+UFLnvOSRCI7QtYoIHYis9T1/9KHWKrEwzqQeGulrxJH+Mss0ewCf+XUJoYUlt
         rtytZiON+eoHXTejhQcKz/m9v/A0Cg/grroO2T+NNAL5qR2JP3Bq1BEj6mbsJx8IoOmg
         E/mDfxmV+08g/9xlZKzTXzdMqEQ/dDuF7jT8p6RdGNap6qC3TAJtd9igGOIUyWzC+F/1
         YhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7Dry/VmCqvDOvEMPGyU3c0AVpRNc04tYnK1hfrgb+No=;
        b=g48Bf9XVgOgYS6K4MhbP+aj3FpeUtkNOm4J7kECj8Iw7HDko05/bUe0Ui0fZIQpZTf
         3EC+/mQsE1xL76oXthqiwy7cNbLf07bVHbacp9cIE8aAyVwe6lNfWp79ptIidk/ceNmZ
         /UXf9S9XCsgoLwZqeXOq8/a9DTxXCXWU3ws3GvtcpY0Een/aLwMTCDd459879L7Qx05l
         LeAqOzmUHvblQ1v6o2VzQ0b6+nqg4MuLlb8E2KXcKi5G1q8wxG1RHHI7un/lQ62MkWiS
         vrSk3k/aFRO3bMbEPAv4fDfxKbi15D9GgsFEs3+/gMZXNT13kgctc7hZKbAW+LBlRjjm
         +u8Q==
X-Gm-Message-State: AGi0PuYzs/wkMFGnl2RXseXNTZvqyxm6ZzbaJH5lJIfE3tJqb2mv7/i7
        TY2RJpyda6HGyyQ/gDmtpFbPRcfwHye1+DvplnE=
X-Google-Smtp-Source: APiQypIDvBhP1p/QIikxxV0xz9NvzP0OPhBx+kFfLbCZnPEfeur3PAVizksjPMpYpYkFh7CfNwEQufhy3QcpPQfZ6tw=
X-Received: by 2002:a67:407:: with SMTP id 7mr10282007vse.95.1589197966361;
 Mon, 11 May 2020 04:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200508195548.25429-1-marcos@mpdesouza.com>
In-Reply-To: <20200508195548.25429-1-marcos@mpdesouza.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 11 May 2020 12:52:35 +0100
Message-ID: <CAL3q7H5Xnk6Ds9inLY7xOeT_knq3ySghrYeXQk2z-nQkyr712Q@mail.gmail.com>
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

On Fri, May 8, 2020 at 9:14 PM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> There is a situation where the incremental send can drop the capability
> from the receiving side. If you have a file that changed the group, but
> the capability was the same of before the group changed, the current
> kernel code will only emit a chown, since the capability is the same.
>
> The steps bellow can reproduce the problem.
>
> $ mount /dev/sda fs1
> $ mount /dev/sdb fs2
>
> $ touch fs1/foo.bar
> $ setcap cap_sys_nice+ep fs1/foo.bar
> $ btrfs subvol snap -r fs1 fs1/snap_init
> $ btrfs send fs1/snap_init | btrfs receive fs2
>
> $ chgrp adm fs1/foo.bar
> $ setcap cap_sys_nice+ep fs1/foo.bar
>
> $ btrfs subvol snap -r fs1 fs1/snap_complete
> $ btrfs subvol snap -r fs1 fs1/snap_incremental
>
> $ btrfs send fs1/snap_complete | btrfs receive fs2
> $ btrfs send -p fs1/snap_init fs1/snap_incremental | btrfs receive fs2

It's redundant to put here the steps to trigger the problem, that's
what the test does.

You just want to say this test exercises full send and incremental
send operations for cases where files have capabilities, to verify the
capabilities aren't lost.

>
> At this point, a chown was emitted by "btrfs send" since only the group
> was changed. This makes the cap_sys_nice capability to be dropped from
> fs2/snap_incremental/foo.bar

Explaining in a changelog for a test case why exactly the bug happens
is out of scope.
We just want to know what bug are we testing for.

The gory details about why the bug happens usually go the in the
changelog of the patch that fixes btrfs.

>
> This test fails on current kernel, the fix was submitted to the btrfs
> mailing list titled:
>
> "btrfs: send: Emit file capabilities after chown"
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tests/btrfs/211     | 153 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/211.out |   6 ++
>  tests/btrfs/group   |   1 +
>  3 files changed, 160 insertions(+)
>  create mode 100755 tests/btrfs/211
>  create mode 100644 tests/btrfs/211.out
>
> diff --git a/tests/btrfs/211 b/tests/btrfs/211
> new file mode 100755
> index 00000000..e9aeaef3
> --- /dev/null
> +++ b/tests/btrfs/211
> @@ -0,0 +1,153 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 211
> +#
> +# Test if the file capabilities aren't lost after full and incremental s=
end
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
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_command "$SETCAP_PROG" setcap
> +_require_command "$GETCAP_PROG" getcap
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +_check_xattr()

Function names starting with '_' are usually reserved for functions
provided by fstests, global functions (like the ones in common/*).
Same comment applies to all the other function names.

Also, a better name would be "check_capabilities" - that they are
stored in a xattr it's irrelevant as we are using the getcap and
setcap utilities to read and set them, and not accessing xattrs
directly.

> +{
> +       local RET
> +       local FILE
> +       local CAP
> +       FILE=3D"$1"
> +       CAP=3D"$2"

Variables in uppercase are meant to be used for global variables. Same
comment applies to all the other functions.

> +       RET=3D$($GETCAP_PROG "$FILE")
> +       if [ -z "$RET" ]; then
> +               echo "$RET"
> +               _fail "missing capability in file $FILE"

This is a practice generally discouraged, we should avoid "_fail"
unless absolutely necessary.
The right approach here is just to "echo" the message. That's enough
to make the test fail as that message is not part of the golden
output.
Furthermore, not using _fail allows the test to proceed and
potentially find other problems.

> +       fi
> +       if [[ "$RET" !=3D *$CAP* ]]; then
> +               echo "$RET"
> +               echo "$CAP"
> +               _fail "Capability do not match. Output: $RET"

Capability -> Capabilities

> +       fi
> +}
> +
> +_setup()
> +{
> +       _scratch_mkfs >/dev/null
> +       _scratch_mount
> +
> +       FS1=3D"$SCRATCH_MNT/fs1"
> +       FS2=3D"$SCRATCH_MNT/fs2"

To make it easier to follow, perhaps declare this outside this
function, as they are used by the other functions.

> +
> +       $BTRFS_UTIL_PROG subvolume create "$FS1" > /dev/null
> +       $BTRFS_UTIL_PROG subvolume create "$FS2" > /dev/null
> +}
> +
> +_full_nocap_inc_withcap_send()
> +{
> +       _setup
> +
> +       # Test full send containing a file with no capability
> +       touch "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/=
dev/null
> +       $BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG rece=
ive "$FS2" -q
> +       # ensure that we don't have caps set
> +       RET=3D$($GETCAP_PROG "$FS2/snap_init/foo.bar")

Should be declared local (and lower case name).

> +       if [ -n "$RET" ]; then
> +               _fail "File contain capabilities when it shouldn't"

echo and contain -> contains

> +       fi
> +
> +       # Test if  incremental send bring the newly added capability
> +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/d=
ev/null
> +       $BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
> +                                       $BTRFS_UTIL_PROG receive "$FS2" -=
q
> +       _check_xattr "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=
+ep"
> +
> +       _scratch_unmount
> +}
> +
> +_roundtrip_send()
> +{
> +       local FILES
> +       local FS1
> +       local FS2

So FS1 and FS2 are declared local but never set. And they were
previously set as global by "_setup".
So those two declarations should be removed here.

> +
> +       # FILES should include foo.bar
> +       FILES=3D"$1"
> +
> +       _setup
> +
> +       # create files on fs1, must contain foo.bar
> +       for f in $FILES; do
> +               touch "$FS1/$f"
> +       done
> +
> +       # Test full send, checking if the receiving side keeps the capabi=
lity

capability -> capabilities (as the test sets 2)

> +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/=
dev/null
> +       $BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG rece=
ive "$FS2" -q
> +       _check_xattr "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_sys_nic=
e+ep"
> +
> +       # Test incremental send with different owner/group but same capab=
ility

capability -> capabilities (as the test sets 2)

> +       chgrp 100 "$FS1/foo.bar"
> +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/d=
ev/null
> +       _check_xattr "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=
+ep"
> +       $BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
> +                               $BTRFS_UTIL_PROG receive "$FS2" -q
> +       _check_xattr "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sys_nice=
+ep"
> +
> +       # Test capability after incremental send with different capabilit=
y and group

capability -> capabilities (as the test sets 2)

> +       chgrp 0 "$FS1/foo.bar"
> +       $SETCAP_PROG "cap_sys_time+ep cap_syslog+ep" "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc2" >/=
dev/null
> +       _check_xattr "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep=
"
> +       $BTRFS_UTIL_PROG send -p "$FS1/snap_inc" "$FS1/snap_inc2" -q | \
> +                               $BTRFS_UTIL_PROG receive "$FS2"  -q
> +       _check_xattr "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_syslog+ep=
"
> +
> +       _scratch_unmount
> +}
> +
> +# real QA test starts here
> +
> +echo "Test full send + file without caps, then inc send bringing a new c=
ap"

inc -> incremental

Also, the abbreviation "caps" is used but in other messages (below)
the non-abbreviated name "capabilities" is used.
We should be consistent and use only one form.

> +_full_nocap_inc_withcap_send
> +
> +echo "Testing if foo.bar alone can keep it's capability"

it's -> its
capability -> capabilities (as the test sets 2)

> +_roundtrip_send "foo.bar"
> +
> +echo "Test foo.bar being the first item among other files"
> +_roundtrip_send "foo.bar foo.bax foo.baz"
> +
> +echo "Test foo.bar with objectid between two other files"
> +_roundtrip_send "foo1 foo.bar foo3"
> +
> +echo "Test foo.bar being the last item among other files"
> +_roundtrip_send "foo1 foo2 foo.bar"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/211.out b/tests/btrfs/211.out
> new file mode 100644
> index 00000000..fc50c923
> --- /dev/null
> +++ b/tests/btrfs/211.out
> @@ -0,0 +1,6 @@
> +QA output created by 211
> +Test full send + file without caps, then inc send bringing a new cap
> +Testing if foo.bar alone can keep it's capability
> +Test foo.bar being the first item among other files
> +Test foo.bar with objectid between two other files
> +Test foo.bar being the last item among other files
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 9426fb17..437d4431 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -213,3 +213,4 @@
>  208 auto quick subvol
>  209 auto quick log
>  210 auto quick qgroup snapshot
> +211 auto quick snapshot

Missing the 'send' group.

Other that is looks good and it works as expected (with patched and
unpatched btrfs)
Thanks.

> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

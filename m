Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3981EB9BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFBKjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 06:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgFBKjI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 06:39:08 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86C6C061A0E;
        Tue,  2 Jun 2020 03:39:07 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q2so1751215vsr.1;
        Tue, 02 Jun 2020 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=X0+2uYq8iHGOkFMcLDAGvrfjXzDfeE0e0hOMTI6ZNzU=;
        b=Jz7bA60Z9XxghnhoH50NfXtiYu4M46bZCCZE54lFVpk9tY4SRdAZBF4pCa//Z1bmaj
         g+GaZaflcLFGgoTeuhRPpv3Ocw7hgESaIQA1ky9p3TWrwmd8la7V31RE/QYZGwB+j3F4
         cmD5q42ewE9I5C1sif0T0DP8XmiN2k0IBxbNEaoHXGLpTHOioE+GXfEy0PCO3hE3xiST
         B/9RFnmnaxGHjvq8PVpBbVArf9fnP2SGCxdPycsBdcG/AfZmqL/MTIHnjNPXAKbas/sa
         Q8y44cPG8MG/R+vD8eQrkhfG5NYyBSd19y9YOwZuVJNQrd9fNMlPhjjLAq1PxcbccivO
         mXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=X0+2uYq8iHGOkFMcLDAGvrfjXzDfeE0e0hOMTI6ZNzU=;
        b=S1UIOYTHGEJt+2QsRAAVSGMFaHrf3QETVYUT7essKpOeTGwzHedkgb4N6CQu0eiiIr
         qbv0IMDJoD09/rSvzgXJiDOR6nvcLDE42moo5ixxiF/zIewZFG8/Hk+IaoCOsEThBYTF
         SuVnWpOoWzd6KUigvBAOEun9ejVDrRbeFLxO6qyAlZcNgoTtkxqc9M95jJNexHBmGZvu
         fapIbTs6ul4V3LsubJj4SGU/9+4P1jcucznWpTFRydgqwm6ewUYEPw4+IosPgJ8FeVi9
         qH2HiAWTVT3e9dLI7F3jOCF2fXgozFJC6WNpjamaijJc3Y1CzFU0SveswwLyFuMFcDMQ
         7xSg==
X-Gm-Message-State: AOAM5321w+hnwRA61HSqLxYhKBGtkOOW2Nci4LAY6uGbaPtYTeaOaSh5
        MSd84P793LJ22RsbFuYDQVzHEM0yXYxy8l+5TUi9wg==
X-Google-Smtp-Source: ABdhPJwD1/xPQHlWSKDvoEMa43FtS55bW+D35q4IcMC+VoITbIbK6ZzKU1Wu2eaV+ctDUesyupliZkze4BHrrwNETxc=
X-Received: by 2002:a67:2dc1:: with SMTP id t184mr4780521vst.90.1591094346941;
 Tue, 02 Jun 2020 03:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200601194845.11829-1-marcos@mpdesouza.com>
In-Reply-To: <20200601194845.11829-1-marcos@mpdesouza.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 2 Jun 2020 11:38:56 +0100
Message-ID: <CAL3q7H5oUVMqnk6ZcjiKzjqvqab8sPcBJWjaK6uoC0mXT5a26Q@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: test if the capability is kept on incremental send
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

On Mon, Jun 1, 2020 at 9:08 PM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> This test exercises full send and incremental send operations for cases
> where files have capabilities, ensuring the capabilities aren't lost in
> the process.
>
> There was a problem with kernel <=3D5.7 that was making capabilities to b=
e lost
> after a combination of full + incremental send. This behavior was fixed b=
y the
> following patch:
>
> btrfs: send: Emit file capabilities after chown
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>
>  Changes from v1:
>  * Remove the steps to reproduce a problem fixes in btrfs code. (Filipe)
>  * Remove the underscore from the local function names (Filipe)
>  * Change function name _check_xattr -> check_capabilities (Filipe)
>  * Rename all local variables to be lowercase (Filipe)
>  * Put FS1 and FS2 variables in the global context of the test (Filipe)
>  * Changes all occurrences of _fail into a simple echo (Filipe)
>  * Declare some local variables as "local" (Filipe)
>  * Some Capability -> Capabilities, since we are dealing with multiple ca=
pabilities (Filipe)
>  * Some cap -> capabilities, inc -> incremental (Filipe)
>  * Add missing "send group" (Filipe)
>
>  tests/btrfs/214     | 152 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/214.out |   6 ++
>  tests/btrfs/group   |   1 +
>  3 files changed, 159 insertions(+)
>  create mode 100755 tests/btrfs/214
>  create mode 100644 tests/btrfs/214.out
>
> diff --git a/tests/btrfs/214 b/tests/btrfs/214
> new file mode 100755
> index 00000000..113bbb27
> --- /dev/null
> +++ b/tests/btrfs/214
> @@ -0,0 +1,152 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 214
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
> +trap "cleanup; exit \$status" 0 1 2 3 15
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
> +FS1=3D"$SCRATCH_MNT/fs1"
> +FS2=3D"$SCRATCH_MNT/fs2"
> +
> +cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +check_capabilities()
> +{
> +       local file
> +       local cap
> +       local ret
> +       file=3D"$1"
> +       cap=3D"$2"
> +       ret=3D$($GETCAP_PROG "$file")
> +       if [ -z "$ret" ]; then
> +               echo "$ret"
> +               echo "missing capability in file $file"
> +       fi
> +       if [[ "$ret" !=3D *$cap* ]]; then
> +               echo "$cap"
> +               echo "Capabilities do not match. Output: $ret"
> +       fi
> +}
> +
> +setup()
> +{
> +       _scratch_mkfs >/dev/null
> +       _scratch_mount
> +
> +       $BTRFS_UTIL_PROG subvolume create "$FS1" > /dev/null
> +       $BTRFS_UTIL_PROG subvolume create "$FS2" > /dev/null
> +}
> +
> +full_nocap_inc_withcap_send()
> +{
> +       local ret
> +
> +       setup
> +
> +       # Test full send containing a file without capabilities
> +       touch "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/=
dev/null
> +       $BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG rece=
ive "$FS2" -q
> +       # ensure that we don't have capabilities set
> +       ret=3D$($GETCAP_PROG "$FS2/snap_init/foo.bar")
> +       if [ -n "$ret" ]; then
> +               echo "File contains capabilities when it shouldn't"
> +       fi
> +
> +       # Test if incremental send brings the newly added capability
> +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/d=
ev/null
> +       $BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
> +                                       $BTRFS_UTIL_PROG receive "$FS2" -=
q
> +       check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sy=
s_nice+ep"
> +
> +       _scratch_unmount
> +}
> +
> +roundtrip_send()
> +{
> +       local files
> +
> +       # files should include foo.bar
> +       files=3D"$1"
> +
> +       setup
> +
> +       # create files on fs1, must contain foo.bar
> +       for f in $files; do
> +               touch "$FS1/$f"
> +       done
> +
> +       # Test full send, checking if the receiving side keeps the capabi=
lities
> +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_init" >/=
dev/null
> +       $BTRFS_UTIL_PROG send "$FS1/snap_init" -q | $BTRFS_UTIL_PROG rece=
ive "$FS2" -q
> +       check_capabilities "$FS2/snap_init/foo.bar" "cap_sys_ptrace,cap_s=
ys_nice+ep"
> +
> +       # Test incremental send with different owner/group but same capab=
ilities
> +       chgrp 100 "$FS1/foo.bar"
> +       $SETCAP_PROG "cap_sys_ptrace+ep cap_sys_nice+ep" "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc" >/d=
ev/null
> +       check_capabilities "$FS1/snap_inc/foo.bar" "cap_sys_ptrace,cap_sy=
s_nice+ep"
> +       $BTRFS_UTIL_PROG send -p "$FS1/snap_init" "$FS1/snap_inc" -q | \
> +                               $BTRFS_UTIL_PROG receive "$FS2" -q
> +       check_capabilities "$FS2/snap_inc/foo.bar" "cap_sys_ptrace,cap_sy=
s_nice+ep"
> +
> +       # Test capabilities after incremental send with different group a=
nd capabilities
> +       chgrp 0 "$FS1/foo.bar"
> +       $SETCAP_PROG "cap_sys_time+ep cap_syslog+ep" "$FS1/foo.bar"
> +       $BTRFS_UTIL_PROG subvolume snapshot -r "$FS1" "$FS1/snap_inc2" >/=
dev/null
> +       check_capabilities "$FS1/snap_inc2/foo.bar" "cap_sys_time,cap_sys=
log+ep"
> +       $BTRFS_UTIL_PROG send -p "$FS1/snap_inc" "$FS1/snap_inc2" -q | \
> +                               $BTRFS_UTIL_PROG receive "$FS2"  -q
> +       check_capabilities "$FS2/snap_inc2/foo.bar" "cap_sys_time,cap_sys=
log+ep"
> +
> +       _scratch_unmount
> +}
> +
> +# real QA test starts here
> +
> +echo "Test full send + file without capabilities, then incremental send =
bringing a new capability"
> +full_nocap_inc_withcap_send
> +
> +echo "Testing if foo.bar alone can keep its capabilities"
> +roundtrip_send "foo.bar"
> +
> +echo "Test foo.bar being the first item among other files"
> +roundtrip_send "foo.bar foo.bax foo.baz"
> +
> +echo "Test foo.bar with objectid between two other files"
> +roundtrip_send "foo1 foo.bar foo3"
> +
> +echo "Test foo.bar being the last item among other files"
> +roundtrip_send "foo1 foo2 foo.bar"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/214.out b/tests/btrfs/214.out
> new file mode 100644
> index 00000000..197a39a9
> --- /dev/null
> +++ b/tests/btrfs/214.out
> @@ -0,0 +1,6 @@
> +QA output created by 214
> +Test full send + file without capabilities, then incremental send bringi=
ng a new capability
> +Testing if foo.bar alone can keep its capabilities
> +Test foo.bar being the first item among other files
> +Test foo.bar with objectid between two other files
> +Test foo.bar being the last item among other files
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 9e48ecc1..505665b5 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -216,3 +216,4 @@
>  211 auto quick log prealloc
>  212 auto balance dangerous
>  213 auto balance dangerous
> +214 auto quick send snapshot
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

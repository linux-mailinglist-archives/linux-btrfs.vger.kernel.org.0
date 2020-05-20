Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7621B1DB3B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgETMiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 08:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgETMiY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 08:38:24 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054BC061A0F;
        Wed, 20 May 2020 05:38:23 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id 134so720586vky.2;
        Wed, 20 May 2020 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=NgVLuQ2y0CB2iinhOIXXkEKAPC2B6UtavuYE3k93vuc=;
        b=D3BL5Btv8hYhfcaSb7+khiicmBDHi+brCerPTu+u6NgA1rTvlSX3r5CZh6hhxgFynw
         /QkpdOHJMwB068j9IrosoEhPGBR/0lHymYEDe7bj+lMfq8RHEr+/1uE+a2AtNtVwx69e
         gxKcRTL/AQBJ7I0ssg/wIxNKbGk/gBUdBlPOk+J0VByl5zRmZj2cJoKK/Z+Dx3Rs0G7P
         BXuSvgLi7tH+69xGzWyva2Z1bPBNbFiLa8kjji1Q2TpUeZUor1tZfns/kQ+FD7WphjDC
         xQBa0hnEurH9bIVyAMsuDxBa6LdfwPVOduRGGUVGBRLYM2mJ48kx4U5A2zerh7lcmZbp
         P+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=NgVLuQ2y0CB2iinhOIXXkEKAPC2B6UtavuYE3k93vuc=;
        b=RNF94wckcKbQozJeR/fsj8L2tvZvGvJJEgc6eXR5Qsx2lZsSDKtcl4PtIcLzf0xjiT
         Qj1Dr1+PITU4KHmmxwXsurYrPe5q8do/mftxIomF+hzBzDER5Z+CMHAdzfe/0zgCIw+M
         ICKV7ctn2aIohI0AQeKQ5mo5EGQmfi0dOP4ByNRFF9nYM8mJQXFcaWnuvDUf9RQXTC1B
         fezmpObgggJoPr6khdUOWVMsZlDfYtLb80v8EMq18tHqgD51fjcd+HsaKhnt2O807rip
         PEMq45jEiQWW74/rkO0xmo7P8mjdOzFgdiQeHHP0ZK0CYnc5yZApPD0o0LuJQm0x0Gcm
         1SqA==
X-Gm-Message-State: AOAM533VmJ+u3MqnJUXvvKwj58FBO0RPSjlDhYK4tfx4ecbJ7E/SAI2x
        /itgK1YLBTkLklKFbrIGx8SXSeG/OhLuxTZzn9k=
X-Google-Smtp-Source: ABdhPJzhw2GNiHTe90tJNaRt6DxRrIScGi12f1ChLdxSQXHzXOI6agyj8o2PjAOk3e2LQmNh8tDjnpzi1+tQuD0Ti20=
X-Received: by 2002:a1f:212:: with SMTP id 18mr3756529vkc.14.1589978302944;
 Wed, 20 May 2020 05:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200520075746.16245-1-wqu@suse.com> <CAL3q7H7fY0fyiPS=LiFYDxHBAXqQF_WuZu7z=jKQv8DTkPadMA@mail.gmail.com>
 <b109c38d-288b-3a4f-de7b-6a2d52c2be7a@gmx.com> <e374561f-397a-8ab3-e2d4-cac423da6636@gmx.com>
In-Reply-To: <e374561f-397a-8ab3-e2d4-cac423da6636@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 20 May 2020 13:38:11 +0100
Message-ID: <CAL3q7H7ofKeuRrsGDdBdzxjOqNcF03E9Z0fpPdpbf86=8eTwFQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: Add a test for dead looping balance after
 balance cancel
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 12:32 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/5/20 =E4=B8=8B=E5=8D=886:02, Qu Wenruo wrote:
> >
> >
> > On 2020/5/20 =E4=B8=8B=E5=8D=885:29, Filipe Manana wrote:
> >> On Wed, May 20, 2020 at 8:59 AM Qu Wenruo <wqu@suse.com> wrote:
> >>>
> >>> Test if canceling a running balance can cause later balance to dead
> >>> loop.
> >>>
> >>> The ifx is titled "btrfs: relocation: Clear the DEAD_RELOC_TREE bit f=
or
> >>>  orphan roots to prevent runaway balance".
> >>>
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>> ---
> >>> Changelog:
> >>> v2:
> >>> - Remove lsof debug output
> >>> v3:
> >>> - Remove ps debug output
> >>> ---
> >>>  tests/btrfs/213     | 64 +++++++++++++++++++++++++++++++++++++++++++=
++
> >>>  tests/btrfs/213.out |  2 ++
> >>>  tests/btrfs/group   |  1 +
> >>>  3 files changed, 67 insertions(+)
> >>>  create mode 100755 tests/btrfs/213
> >>>  create mode 100644 tests/btrfs/213.out
> >>>
> >>> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> >>> new file mode 100755
> >>> index 00000000..f56b0279
> >>> --- /dev/null
> >>> +++ b/tests/btrfs/213
> >>> @@ -0,0 +1,64 @@
> >>> +#! /bin/bash
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> >>> +#
> >>> +# FS QA Test 213
> >>> +#
> >>> +# Test if canceling a running balance can lead to dead looping balan=
ce
> >>> +#
> >>> +seq=3D`basename $0`
> >>> +seqres=3D$RESULT_DIR/$seq
> >>> +echo "QA output created by $seq"
> >>> +
> >>> +here=3D`pwd`
> >>> +tmp=3D/tmp/$$
> >>> +status=3D1       # failure is the default!
> >>> +trap "_cleanup; exit \$status" 0 1 2 3 15
> >>> +
> >>> +_cleanup()
> >>> +{
> >>> +       cd /
> >>> +       rm -f $tmp.*
> >>> +}
> >>> +
> >>> +# get standard environment, filters and checks
> >>> +. ./common/rc
> >>> +. ./common/filter
> >>> +
> >>> +# remove previous $seqres.full before test
> >>> +rm -f $seqres.full
> >>> +
> >>> +# Modify as appropriate.
> >>> +_supported_fs btrfs
> >>> +_supported_os Linux
> >>> +_require_scratch
> >>> +_require_command "$KILLALL_PROG" killall
> >>> +
> >>> +_scratch_mkfs >> $seqres.full
> >>> +_scratch_mount
> >>> +
> >>> +runtime=3D4
> >>> +
> >>> +# Create enough IO so that we need around $runtime seconds to reloca=
te it
> >>> +dd if=3D/dev/zero bs=3D1M of=3D"$SCRATCH_MNT/file" oflag=3Dsync stat=
us=3Dnone \
> >>> +       &> /dev/null &
> >>> +dd_pid=3D$!
> >>> +sleep $runtime
> >>> +"$KILLALL_PROG" -q dd &> /dev/null
> >>
> >> Do we really need the killall program? There's only one dd process.
> >>
> >> We should also kill the dd process at _cleanup(), as killing the test
> >> during the sleep above will result in the dd process not being killed.
> >
> > The main problem here is, I can't find a good way to kill dd.
> > plain 'kill $dd_pid' doesn't seem to kill it properly, as my debug
> > lsof/ps still shows dd running and failed to unmount the fs.
> >
> > 'kill -KILL $dd_pid' kills it well, but causes extra output for the
> > terminated dd.
> >
> > Only 'killall -q dd' works as expected.
> >
> > Any good advice on this?
>
> Oh, the fstests "kindly" overrides dd, "kill $dd_pid" only kills the
> child bash running that dd function, not the real dd command.
> I'll use xfs_io to ensure we get no extra wrapper.

Indeed, I was doing this in the test:

ps -eo pid,ppid,pgid,comm > /tmp/ps.txt
my_pid=3D$$
echo "dd_pid =3D $dd_pid mypid =3D $my_pid" >> /tmp/ps.txt
kill -9 $dd_pid
wait $dd_pid

And was noticing that the ps.txt file had:

23467   937 23467 check
...
23840 23467 23467 213
...
24034 23840 23467 213
24039 24034 23467 dd
...
dd_pid =3D 24034 mypid =3D 23840

So dd_pid matched a bash process running the test, which is a child of
the bash process that invoked dd.

Before digging further I saw your reply and checked that common/rc
provides a function named dd() which is a wrapper to dd and it invokes
dd twice, whence you needed killall.
Interesting, wasn't aware of that wrapper.

Thanks.



>
> Thanks,
> Qu
>
> >
> >>
> >>> +wait $dd_pid
> >>> +
> >>> +# Now balance should take at least $runtime seconds, we can cancel i=
t at
> >>> +# $runtime/2 to ensure a success cancel.
> >>> +$BTRFS_UTIL_PROG balance start -d --bg "$SCRATCH_MNT"
> >>> +sleep $(($runtime / 2))
> >>> +$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
> >>> +
> >>> +# Now check if we can finish relocating metadata, which should finis=
h very
> >>> +# quickly
> >>> +$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" >> $seqres.full
> >>
> >> Why redirect this one to $seqres.full and not the other balance? What
> >> kind of useful information it provides?
> >
> > Not really much, just an indicator to show that the balance finishes as
> > expected.
> > And we don't want to output it golden output, as mkfs change may create
> > more metadata chunks and cause difference.
> >
> > For other ones, like the one to be canceled, we don't really care that =
much.
> >
> > Thanks,
> > Qu
> >>
> >>> +
> >>> +echo "Silence is golden"
> >>> +
> >>> +# success, all done
> >>> +status=3D0
> >>> +exit
> >>> diff --git a/tests/btrfs/213.out b/tests/btrfs/213.out
> >>> new file mode 100644
> >>> index 00000000..bd8f2430
> >>> --- /dev/null
> >>> +++ b/tests/btrfs/213.out
> >>> @@ -0,0 +1,2 @@
> >>> +QA output created by 213
> >>> +Silence is golden
> >>> diff --git a/tests/btrfs/group b/tests/btrfs/group
> >>> index 8d65bddd..fe4d5bb3 100644
> >>> --- a/tests/btrfs/group
> >>> +++ b/tests/btrfs/group
> >>> @@ -215,3 +215,4 @@
> >>>  210 auto quick qgroup snapshot
> >>>  211 auto quick log prealloc
> >>>  212 auto balance dangerous
> >>> +213 auto fast balance dangerous
> >>
> >> fast -> quick
> >>
> >> Thanks.
> >>
> >>> --
> >>> 2.26.2
> >>>
> >>
> >>
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

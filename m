Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B5E26382
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfEVMMJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 08:12:09 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38667 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVMMJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 08:12:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id x184so1244492vsb.5;
        Wed, 22 May 2019 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=AJKkQtM2M6bBpPTx7GV1gAoBEbwlf3QmoEOOr2mvicM=;
        b=iEq1M8wKMpbRBAUtuRunFU6nwSRGt/gYZOIkDXS4Y7M+fZ0BE6192FcwB3xKVyMrwn
         a25x9cQQb3UN7V/OLzatq8uQ39uBqc/UoC/LNWeWECVPBOuGZVlnRtB0b01StJKJOj9L
         eHldpOi8OzbIv3x4X8uQEIBICuZpqFBTokj60TSNWRlJy0+5skiK1v/nGl39nwjtUQtO
         uZVt85f6SxhHuP7FgcoxIq9PvTJj5e5D50Wr9vOEl8WUyq2MSQLjmeYwY9N3iZ10ARVx
         qKKV1ooAkSEHVKfNXw+Iu0MAyZKtNWmVcwaIbRq+OZhwjdFoY7TZQ9d949otriN5goWS
         m/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=AJKkQtM2M6bBpPTx7GV1gAoBEbwlf3QmoEOOr2mvicM=;
        b=A0py4eveioGHmk7NzoSgPuqWMRnhL9Rd5N1bPgFdP2p1cXezKuUhlS8u1m03jdAu+l
         hnCD3YMfwhGsQBkbbwbOOypLA2n9tRZZ4aM/ZSSNgoAVOuWxIpwA6WHF4jtqvkTHr083
         Al71uV/bVsUNQ/kjvT09+Qvd/8CYEUT6MrewNqFh2nufP217FIjy6BWnboCTHNiXIgq8
         AanYHW9tAtA/GJOsF//ea4cNJ0A2awCQ3SJR5MHHWReGBce7MoYY8hLcgxXLc2zCc6I8
         Zg4AnqPP9FemSW9X7MASPgYvfP5ZMKjujvynZam0lO9C1DdvcCXtsOAPaC6TgfhPeK2I
         etlw==
X-Gm-Message-State: APjAAAVDY1NLuzUx4sp/Vi1rwmKbh69LsdFbG7shYSAmfEHeaVVBxOhD
        lrmmNI8gZiW3sm1JfShJJtvpcdBzxb2PsojAiHw=
X-Google-Smtp-Source: APXvYqynCYUTsFjcxLekRpMyJrk3EEuR3LZWGALBR569/oEmAGamJzmxsH6vTLAQ0P9aQJ+vkJpHRXDJT3l7ppdqMnQ=
X-Received: by 2002:a67:e891:: with SMTP id x17mr30861519vsn.206.1558527127728;
 Wed, 22 May 2019 05:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190522083944.32365-1-wqu@suse.com> <CAL3q7H48_ouBvEsuximFOjAxOSdu5FFfP0Dn8QAsM73xRG8PMg@mail.gmail.com>
 <36d703c3-3264-c12c-2721-c85b48a1faa8@suse.de>
In-Reply-To: <36d703c3-3264-c12c-2721-c85b48a1faa8@suse.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 22 May 2019 13:11:56 +0100
Message-ID: <CAL3q7H5-fdBVkUuARgUjrCioa8y-i7G59egOYoXBfd6LPbW+Tw@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: Test if btrfs will panic when mounting a
 partially balanced fs
To:     Qu Wenruo <wqu@suse.de>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 22, 2019 at 10:37 AM Qu Wenruo <wqu@suse.de> wrote:
>
>
>
> On 2019/5/22 =E4=B8=8B=E5=8D=885:32, Filipe Manana wrote:
> > On Wed, May 22, 2019 at 9:40 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> There are two regressions that when mounting a partially balance btrfs
> >> after v5.1 kernel:
> >> - Kernel NULL pointer dereference at mount time
> >> - Kernel BUG_ON() just after mount
> >>
> >> The kernel fixes are:
> >> "btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer
> >>  dereference"
> >> "btrfs: reloc: Also queue orphan reloc tree for cleanup to
> >>  avoid BUG_ON()"
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>  tests/btrfs/188     | 94 ++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  tests/btrfs/188.out |  2 +
> >>  tests/btrfs/group   |  1 +
> >>  3 files changed, 97 insertions(+)
> >>  create mode 100755 tests/btrfs/188
> >>  create mode 100644 tests/btrfs/188.out
> >>
> >> diff --git a/tests/btrfs/188 b/tests/btrfs/188
> >> new file mode 100755
> >> index 00000000..f43be007
> >> --- /dev/null
> >> +++ b/tests/btrfs/188
> >> @@ -0,0 +1,94 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> >> +#
> >> +# FS QA Test 188
> >> +#
> >> +# Test if btrfs mount will hit the following bugs when mounting
> >> +# a fs going through partial balance:
> >> +# - NULL pointer dereference
> >> +# - Kernel BUG_ON()
> >
> > I would make the description be closer to what the test is - a general
> > test to validate that balance and qgroups work correctly when balance
> > needs to be resumed on mount.
> > You can leave those specific problems in the change log.
> >
> >> +#
> >> +seq=3D`basename $0`
> >> +seqres=3D$RESULT_DIR/$seq
> >> +echo "QA output created by $seq"
> >> +
> >> +here=3D`pwd`
> >> +tmp=3D/tmp/$$
> >> +status=3D1       # failure is the default!
> >> +trap "_cleanup; exit \$status" 0 1 2 3 15
> >> +
> >> +_cleanup()
> >> +{
> >> +       cd /
> >> +       rm -f $tmp.*
> >> +}
> >> +
> >> +# get standard environment, filters and checks
> >> +. ./common/rc
> >> +. ./common/filter
> >> +. ./common/dmlogwrites
> >> +
> >> +# remove previous $seqres.full before test
> >> +rm -f $seqres.full
> >> +
> >> +# real QA test starts here
> >> +
> >> +# Modify as appropriate.
> >> +_supported_fs btrfs
> >> +_supported_os Linux
> >> +_require_scratch
> >> +# and we need extra device as log device
> >> +_require_log_writes
> >> +
> >> +nr_files=3D512                           # enough metadata to bump tr=
ee height
> >> +file_size=3D2048                         # small enough to be inlined
> >> +
> >> +_log_writes_init $SCRATCH_DEV
> >> +_log_writes_mkfs >> $seqres.full 2>&1
> >> +
> >> +_log_writes_mount
> >> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
> >> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> >> +
> >> +# Create enough metadata for later balance
> >> +for ((i =3D 0; i < $nr_files; i++)); do
> >> +       _pwrite_byte 0xcd 0 $file_size $SCRATCH_MNT/file_$i > /dev/nul=
l
> >> +done
> >> +
> >> +# Ensure we write all data/metadata back to disk so that later
> >> +# balance will do real I/O
> >
> > I don't understand this. Real I/O? Do we have any fake I/O? What is it?
>
> I mean to avoid things like delayed inode where we only have dirty pages
> but haven't written them onto disk.

You meant delalloc (delayed allocation) then (delayed inode is another thin=
g).
>
> In this case we want some metadata space to be really used. Dirty page
> caches can't do that.
>
> What's the proper expression for this?

Something like: "Flush delalloc so that balance has work to do."

>
> >
> >> +sync
> >> +
> >> +# Balance metadata so we will have at least one transaction committed=
 with
> >> +# valid reloc tree, and hopefully an orphan reloc tree.
> >> +$BTRFS_UTIL_PROG balance start -f -m $SCRATCH_MNT >> $seqres.full
> >> +_log_writes_unmount
> >> +_log_writes_remove
> >> +
> >> +cur=3D$(_log_writes_find_next_fua 0)
> >> +echo "cur=3D$cur" >> $seqres.full
> >> +while [ ! -z "$cur" ]; do
> >> +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqref.full
> >> +
> >> +       # If the fs contains valid reloc tree and kernel is not patche=
d,
> >> +       # we'll hit a NULL pointer dereference
> >> +       # Or if it contains orphan reloc tree and kernel is unpatched,
> >> +       # we'll hit a BUG_ON()
> >
> > # Test that no crashes happen or any other kind of failure.
> >
> >> +       _scratch_mount
> >> +       _scratch_unmount
> >> +
> >> +       # Don't trigger fsck here, as relocation get paused,
> >> +       # at that transistent state, qgroup number may differ
> >> +       # and cause false alert.
> >> +
> >> +       prev=3D$cur
> >> +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
> >> +       [ -z "$cur" ] && break
> >> +done
> >
> > After the balance finishes, can we verify that qgroup values are correc=
t?
>
> Isn't  that done automatically when the test is finished?
> As i'm using _require_scratch, not _require_scratch_no_check.

If fsck can accurately determine that, I'm fine with it.

Thanks.

>
> >
> >> +
> >> +echo "Silence is golden"
> >> +
> >> +# success, all done
> >> +status=3D0
> >> +exit
> >> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
> >> new file mode 100644
> >> index 00000000..6f23fda0
> >> --- /dev/null
> >> +++ b/tests/btrfs/188.out
> >> @@ -0,0 +1,2 @@
> >> +QA output created by 188
> >> +Silence is golden
> >> diff --git a/tests/btrfs/group b/tests/btrfs/group
> >> index 44ee0dd9..16a7c31e 100644
> >> --- a/tests/btrfs/group
> >> +++ b/tests/btrfs/group
> >> @@ -190,3 +190,4 @@
> >>  185 volume
> >>  186 auto quick send volume
> >>  187 auto send dedupe clone balance
> >> +188 auto quick replay
> >
> > "balance" and "qgroup" groups as well
>
> Forgot that.
>
> Thanks for comment,
> Qu
>
> >
> > Thanks.
> >> --
> >> 2.21.0
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8D41C169
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbhI2JQi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 05:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbhI2JQh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 05:16:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00179C06161C;
        Wed, 29 Sep 2021 02:14:56 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id jo30so1068401qvb.3;
        Wed, 29 Sep 2021 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=odrMg3ck/RyeVZR+UT0yECpW7rFz9JCiUePwgBb6Kd0=;
        b=c8St61AoJvmaJywwgLy6moLY4bBu0bNrt16jZktuRxVHq3rX4wGcHrEsdIYLPpPPeF
         xNSsh4PUtaTnmBrbRGmI1OG34b1tLqdwNRqlaiokYRPTOh+aw0W/0E5RJkEyed7s5fhE
         eqfavFYxacccUbNpJgl+KM+bY+sjY+PH8iXAH/Z9uR2WDWJotwthWVUwuD6SnOVkdqPi
         Sal+GlvT/oMvonebcjQN9q/uya45LwLZiFg1l2jgW848QI2ZaYC8P4laGEXX5Mt8S5Py
         rs+NKWr3IXtXIrBZv6zBGDwqCeRpcXdNOVIsg2Hz6o9o7pdEsNYGm55mpJuaWSBm/6W8
         lhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=odrMg3ck/RyeVZR+UT0yECpW7rFz9JCiUePwgBb6Kd0=;
        b=slCzBzJnsIl6kOfZh1NMmXrTcSXfRuH/9n+JRnFqdLtINwKkKu1mjE/la2yePy99XU
         ZOwWTcucPmYIvM+V8sz1TeZqVsf7DEqsNEwXdH+t7g8CwfCqthUsXgFUP/+V5hgtowdm
         aWOnujLa/q5vZ1CmCcNUDikoZmkGydWpIepInL7CJ630jnzZWRfFrJGur5jhu/BP1tOS
         Po1tHAOJpk9psWEhskMoqQsvHgmCBw4i9FqBmnB3HPNMo4HalS8yVEl5/rJOvGEiHTdV
         Z7KcTr+VLQLg77TcMCHlToPMf/hV+0x6WwpwNzp+ouqqI+tpKjAHBY/uFO9noxRWDKSj
         pgIg==
X-Gm-Message-State: AOAM530nt5dxYRYSac8bNnPJvae9aUhZnezc0V+f0tTOYf9BxfB6ciDF
        vi59GU6BS1E1cMn++STJmkNy+p1veYG/yB5oeUZ7ZPvaMJk=
X-Google-Smtp-Source: ABdhPJw+oFMLf7ih5nQnReo0dJ+XgS/W70PWzyIWIJW11H6Io+S8mTcbSFV676QIePTjm2eMHmBX0BTh36zwF+w8PAg=
X-Received: by 2002:a05:6214:1430:: with SMTP id o16mr9962383qvx.66.1632906896153;
 Wed, 29 Sep 2021 02:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210929004446.12654-1-wqu@suse.com>
In-Reply-To: <20210929004446.12654-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 29 Sep 2021 10:14:19 +0100
Message-ID: <CAL3q7H7=smEFy8UM9uRK202rCwnX6wUWN=TRAzPjethAKdJOew@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/248: test if btrfs receive can handle
 clone command on inodes with different NODATASUM flags
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 1:45 AM Qu Wenruo <wqu@suse.com> wrote:
>
> The planned fix is titled "btrfs-progs: receive: fallback to buffered
> copy if clone failed".
>
> The test case itself will create two send streams, and the 2nd stream is
> an incremental stream with a clone command in it.
>
> Using different mount options we are able to create a situation where
> clone source and destination have different NODATASUM flags, which is
> prohibited inside btrfs.
>
> The planned fix will make btrfs receive to fall back to buffered write
> to copy the data from the source file.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/248     | 74 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/248.out |  2 ++
>  2 files changed, 76 insertions(+)
>  create mode 100755 tests/btrfs/248
>  create mode 100644 tests/btrfs/248.out
>
> diff --git a/tests/btrfs/248 b/tests/btrfs/248
> new file mode 100755
> index 00000000..964d3e85
> --- /dev/null
> +++ b/tests/btrfs/248
> @@ -0,0 +1,74 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 248
> +#
> +# Make sure btrfs receive can still handle clone stream even if the sour=
ce

s/clone stream/clone operations/

> +# and destination has different NODATASUM flags

s/has/have/

> +#
> +. ./common/preamble
> +_begin_fstest quick send
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount -o datasum
> +
> +# Create the initial subvolume with a file
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/parent >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/parent/source \
> +       > /dev/null
> +sync

There's no need to call sync.

> +$BTRFS_UTIL_PROG prop set $SCRATCH_MNT/parent ro true
> +$BTRFS_UTIL_PROG send -q $SCRATCH_MNT/parent -f $tmp.parent_stream
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount -o datasum
> +
> +# Then create a new subvolume with cloned file from above send stream
> +$BTRFS_UTIL_PROG receive -q -f $tmp.parent_stream $SCRATCH_MNT
> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/parent $SCRATCH_MNT/des=
t \
> +       >> $seqres.full
> +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/parent/source 4k 0 128K" \

This will fail on a 64K sector size, so always use offsets and lengths
that are multiples of 64K, so that the test can run on all possible
sector sizes.

> +       $SCRATCH_MNT/dest/new > /dev/null
> +$BTRFS_UTIL_PROG prop set $SCRATCH_MNT/dest ro true
> +$BTRFS_UTIL_PROG send -q $SCRATCH_MNT/dest -p $SCRATCH_MNT/parent \
> +       -f $tmp.clone_stream

Man, this is so much more complicated than necessary.
Switching from RW to RO, having to create and mount another filesystem
to create the incremental stream, etc.

Why didn't you follow the simple steps that most of the other tests follow?

Example:

1) mkfs
2) mount with -o datacow or -o datasum
3) create file $SCRATCH_MNT/foo with some data
4) create a RO snapshot of the default subvolume as  $SCRATCH_MNT/snap1
5) clone  $SCRATCH_MNT/foo  into  $SCRATCH_MNT/bar for example
6) create another RO snapshot of the default subvolume as  $SCRATCH_MNT/sna=
p2
7) do a full send of $SCRATCH_MNT/snap1 and save the stream into a file
8) do an incremental send of $SCRATCH_MNT/snap2 using
$SCRATCH_MNT/snap1 as the parent and save the stream into another file

See, no need to mkfs and mount between creating the streams, and
neither the need to switch subvolumes or snapshots from RW to RO.


> +
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount -o datasum
> +
> +# Now try to receive both streams
> +$BTRFS_UTIL_PROG receive -q -f $tmp.parent_stream $SCRATCH_MNT/
> +
> +# Remount to NODATASUM, so that the 2nd stream will get all its inodes t=
o have
> +# NODATASUM flags due to mount option
> +_scratch_remount nodatasum
> +
> +# Patched receive may warn about the clone failure, so here we redirect =
all
> +# output
> +$BTRFS_UTIL_PROG receive -q -f $tmp.clone_stream $SCRATCH_MNT/ \
> +       >> $seqres.full 2>&1
> +
> +# We check the destination file's csum to verify if the clone is done pr=
operly
> +_md5_checksum $SCRATCH_MNT/dest/new
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/248.out b/tests/btrfs/248.out
> new file mode 100644
> index 00000000..b49cfad7
> --- /dev/null
> +++ b/tests/btrfs/248.out
> @@ -0,0 +1,2 @@
> +QA output created by 248
> +d48858312a922db7eb86377f638dbc9f

This is neither very friendly to debug nor easy to validate.

I suggest either:

1) Print the checksum on the original filesystem too, so that we can compar=
e:

echo "checksum in the source fs: $(_md5_checksum $SCRATCH_MNT/...)"
(...)
# Should match the checksum in the source fs.
echo "checksum in the destination fs: $(_md5_checksum $SCRATCH_MNT/...)"

2) Or just dump the file with 'od -A d -t x1' or hexdump.

As for having the test in fstests or btrfs-progs, I won't mind either optio=
n.

As Dave Chinner once mentioned in some threads in a distant past,
fstests is not exclusive for testing kernel only changes - it's a
testing framework for filesystems, which includes kernel and tools.
I would prefer if we could have all tests inside the same test suite,
but we already have things spread between fstests and btrfs-progs, and
just noticed that btrfs-progs has now at least 1 test case to cover a
kernel-only fix (misc-tests/041-subvolume-delete-during-send/test.sh).

Thanks.

> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

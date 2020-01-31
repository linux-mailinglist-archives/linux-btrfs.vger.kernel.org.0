Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5579714EA0E
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 10:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgAaJ0S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 04:26:18 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46834 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgAaJ0S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 04:26:18 -0500
Received: by mail-vs1-f66.google.com with SMTP id t12so3905174vso.13;
        Fri, 31 Jan 2020 01:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jTL72TXg3bN5vHOLpcvhPU7eU7vsRWaRTdWrDFrFA6E=;
        b=qNmV0c2IBWb7uTcYkqL5xTjczgYJkkZRAf2ZTQt7/rgANp9yrmUiTYRXdgO7yiQ/ho
         BMcQpuuyq2NQ2jR4JOg6Zc50HdVarY++dyK3J85pv2Gk87GzMFjF+zXYP1C1rtoMQ9Qy
         JD6BGz5VmKAXp62Hae/ciyp00BLSZ+INdjQwNntierNaoIFuMBP5V3Jn6MzflyN3KQ6t
         B5trd3wabLHb0DwX6sbSfw1d1qDi93VX1B9RIQpdndxYWYN+u+EwhpU8pOvMWK5Tk5Qm
         ZLqe04qqVVVWEENj8BRs6Bh78E4jV9i9DMIwJKCrQXOJm4Ru5bDfRMOB7JN7rgGKBltA
         YamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jTL72TXg3bN5vHOLpcvhPU7eU7vsRWaRTdWrDFrFA6E=;
        b=efUeOHJKrUQi9+SIJ8lSHJECd5PmxkX7bhdWNoaJFucGuUAA0hTsJaEOODim4cCgYU
         hluPk8ab+Eny50m8BRWEg5vZgaeomJYl1+9a1a7TCUAOc0RM6BSBNtKzaZfKL2NfALsn
         72snvJkLiFnbIK8Z1q/kyGABW8JwscpCtLjqAdBJY/SHuYAKW7A5iM0Syop2Tl5T/gSn
         DO/TPrITQo0yifaCYeb+7aIoGTn2hFdviH9Tg/yTCR5rqCs4tf+1z35pNkcgubJeGO82
         A0j49hBfWq89nHBWHIKEQHfZ+4oWjNGw0YtnoT/YsSYgaiEDogc9O6Zmp2Bo9VsCqjDL
         sfXw==
X-Gm-Message-State: APjAAAUWTMZakCW/CKQG5ZeP5/J4BzFn4BvdKyHu9IWkmgwDShBP7f9o
        2NtpVGf+20zLvAkjgdDe72ci5IU4E+xyNimG34vB+tT+
X-Google-Smtp-Source: APXvYqwnuMUqurW6w+LKrCHY/1dnj+/yuimSsLJgHntfcLpHFpzYRfpoT7fpD8/fCEZgBTbidKFP2c4lKw57ZDCqL/w=
X-Received: by 2002:a67:8010:: with SMTP id b16mr6075191vsd.90.1580462776667;
 Fri, 31 Jan 2020 01:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20200131060545.27904-1-wqu@suse.com>
In-Reply-To: <20200131060545.27904-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 31 Jan 2020 09:26:05 +0000
Message-ID: <CAL3q7H5PmesMLk8B1oxZ9LUcDtjXNZLvZaHxOqHiNeQxKVj8Mg@mail.gmail.com>
Subject: Re: [PATCH] fstests: generic: Introduce new test case to verify the
 NOCOW unaligned hole punch behavior
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Martin Doucha <mdoucha@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 31, 2020 at 6:06 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a new LTP test case (*) doing hole punching with the following
> conditions:
> - Hole is unaligned on exiting data
>   Which involves data writes to zero exiting data.
>
> - The fs is full
>
> - The involved file has NOCOW bit set
>   Even for fs like btrfs, such write should no allocate new space.
>   For other fses which don't support NOCOW bit, they either default to
>   NOCOW or don't support COW at all.
>   Thus the behavior should still be the same.
>
> Btrfs currently fails such test, the fix is titled
> "btrfs: Allow btrfs_truncate_block() to fallback to nocow for data space
>  reservation".
>
> XFS and EXT4 all pass.
>
> *: https://patchwork.ozlabs.org/patch/1224176/
>
> Reported-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Please note that, for EXT4 there seems to be a bug in mkfs.ext4, as it
> always output the version string ("mke2fs 1.45.5 (07-Jan-2020)") to
> stderr, polluting the golden output.
>
> But the unaligned hole punching behavior is still correct for EXT4.
> ---
>  tests/generic/593     | 75 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/593.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 78 insertions(+)
>  create mode 100755 tests/generic/593
>  create mode 100644 tests/generic/593.out
>
> diff --git a/tests/generic/593 b/tests/generic/593
> new file mode 100755
> index 00000000..884a142a
> --- /dev/null
> +++ b/tests/generic/593
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 593
> +#
> +# Test if a fs can still punch unaligned hole for NOCOW files when the f=
s
> +# is full.
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
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_command "$CHATTR_PROG" chattr
> +_require_command "$LSATTR_PROG" lsattr

_require_xfs_io_command "fpunch"

> +
> +# Create a small fs so filling it should be pretty fast
> +fssize=3D$(( 1024 * 1024 * 1024 )) # In bytes

(Repeating the fs size thing from the other mail since I forgot a few
more things)

Someone not so familiar with btrfs, looking at a generic test, might
ask, why 1Gb?
Why not 128Mb for example, that would make it even faster to fill the
fs... right?

You might add a comment mentioning that 1Gb is a safe value to
guarantee btrfs' mkfs will not use mixed block groups.
Because if it does, the hole punching might fail due to lack of
metadata space, that is, by not using mixed block groups we can be
sure we will have enough metadata free space while having exhausted
all data space.

> +
> +_scratch_mkfs_sized $fssize > $seqres.full
> +_scratch_mount
> +
> +blocksize=3D$(_get_block_size $SCRATCH_MNT)
> +echo "blocksize =3D $blocksize" >> $seqres.full
> +nr_blocks=3D5
> +
> +touch $SCRATCH_MNT/target
> +# - Completely ignore the error
> +#   Either the fs supports COW, this will success and mark the file NOCO=
W
> +#   Or the fs doesn't support COW, we can still go ahead.
> +$CHATTR_PROG +C $SCRATCH_MNT/target >> $seqres.full 2>&1
> +
> +$LSATTR_PROG $SCRATCH_MNT/target >> $seqres.full
> +
> +$XFS_IO_PROG -c "pwrite -b $blocksize 0 $(( $nr_blocks * $blocksize))" \
> +       $SCRATCH_MNT/target >> $seqres.full
> +
> +# ENOSPC expected
> +$XFS_IO_PROG -f -c "pwrite -b $blocksize 0 $fssize" \
> +       $SCRATCH_MNT/padding >> $seqres.full 2>&1
> +
> +# All these fpunch calls should success
> +for ((i =3D 0; i < $nr_blocks; i++)); do
> +       $XFS_IO_PROG -c "fpunch $(( $i * $blocksize)) $(( $blocksize / 2)=
)" \
> +               $SCRATCH_MNT/target >> $seqres.full
> +done
> +
> +echo "Silence is golden"
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/593.out b/tests/generic/593.out
> new file mode 100644
> index 00000000..bac4d7d9
> --- /dev/null
> +++ b/tests/generic/593.out
> @@ -0,0 +1,2 @@
> +QA output created by 593
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 6fe62505..ca4df435 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -595,3 +595,4 @@
>  590 auto prealloc preallocrw
>  591 auto quick rw pipe splice
>  592 auto quick encrypt
> +593 auto quick enospc

Also missing the group 'punch'.

Thanks.
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

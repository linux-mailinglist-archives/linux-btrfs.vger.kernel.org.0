Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45D314E9FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgAaJXg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 04:23:36 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:37020 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgAaJXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 04:23:35 -0500
Received: by mail-ua1-f67.google.com with SMTP id h32so2299070uah.4;
        Fri, 31 Jan 2020 01:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+u428zd+HvPiHtBT2tTXkN0WqlH7NBRC06ax8pVFchE=;
        b=GG95q3Niy+QYXR69TQ368ItwkOycfgv7f6F/2fZ7wkV3eUB+wF3L6pkGB4PEDaWxpq
         HsjY8hEEvgXxQKGa0MgEH8/OrwPD4ig1h2scAuGWP/wNmvTGX+rDcYDqlVuGtSw2hDow
         g10CKY/uDYql/TXOv9ycJ4aY9b0q5z6D8dl2OxJs/uv4ANGOcdcDp29el7sCqCPWNpTh
         KFWQyEU3Z0a0F7Z7TX6d2YrWW1euaAKjqOmi3v1irpSOi4wt+HuTML/FvhTv9M8b4DZN
         lZoe/cy9D+IYtyvqyyP/9DqoHbpMjGyFt8O/MTGRCEHj9dfvYDQWqTo8jKB/j1lyEfN5
         y6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+u428zd+HvPiHtBT2tTXkN0WqlH7NBRC06ax8pVFchE=;
        b=lfZx3L5/B5CfTQFZHZYc/SZTrtMgLxcG9XVbNToBu4tfXvMpdLrFhSI1uILBvFC57y
         LxfL0YTlcZUSzDsjsu5Bwy9l8bXlxKdw5Ju7s+d4Bd1UMWjS8x5Qw7wSCK5LtPilGrOh
         kimWRBjM0raFPR1355ZTBeUPSZqahNeoHJsiXhm8ye8JwRD2LtfjX5vST7unJiN8Bal3
         XbO5cKPmzW5dQeJT6UUvATVqvBRnnivhhoEdzgFJFDrN6SurmB/tl6ikxXb0Lt7jP+pd
         gXD+Jh2FkkuKtDPGVPJS3ZLi9dAqMUIr+R7fXFof7dcL3hh04UeD5Gvv/zeRnnppfxmG
         3u5w==
X-Gm-Message-State: APjAAAXNJGb0di9spww9OisZd80HFn1T+E1sAaeil95uJjogSNAr5JhH
        1XMaLo1+CyTQy9d5Y5BcDnhp8VkNF/lhhzj7REauNg==
X-Google-Smtp-Source: APXvYqw+Mbk/ctH/vJ8WegZsb8UjJIOg5Dgg/mxrPRAUUgRzU8G8vw+yni91Y2pOqt0mfKPmbgp4P962prwGW25MaxM=
X-Received: by 2002:ab0:738c:: with SMTP id l12mr5331420uap.135.1580462614239;
 Fri, 31 Jan 2020 01:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20200131060545.27904-1-wqu@suse.com>
In-Reply-To: <20200131060545.27904-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 31 Jan 2020 09:23:23 +0000
Message-ID: <CAL3q7H7pSYgvRNgW0-116imFDabTS8xQkP4Lku8K4HjaRqzL8w@mail.gmail.com>
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
> +
> +# Create a small fs so filling it should be pretty fast
> +fssize=3D$(( 1024 * 1024 * 1024 )) # In bytes

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

Other than that, it looks good to me.

Thanks.

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
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

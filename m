Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60A34B8C17
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 16:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiBPPKO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 10:10:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiBPPKO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 10:10:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA020BCE9;
        Wed, 16 Feb 2022 07:10:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CCEAB81F19;
        Wed, 16 Feb 2022 15:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4364CC004E1;
        Wed, 16 Feb 2022 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645024198;
        bh=GHVaJveWmDjBMZ7xg4UU2ecHkOgd2vl0isTo4bIg9h0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M7bLQ1H7OPp7VLKBjus/zM1dVvUxKkFd1dyEDRmYekBUuaHvdmg/BNX/9ir/ljDGv
         NG4CH5KDumtvj9oZnqjbQhNKzn+jT4m79r82uEtXJENyVrTqQdGwl73JUX4jxzgFN/
         DHKpFmxkek6aBXxegT/4OBgTRPzkUdrsAW7AW3+k3guY3NGE5Ft3gcICKQ9yOVuCnk
         2qR7BFXbarkB++UbG/2UMSiQ1tB0/llY2KAqzDCmTrkQHMjlYMUq2VjvHPIzVHEDe3
         dsMbH5gPMOngrZKeetFCmYGU+e88zpICkaD+cFVkUXFCb9v+UuPsSLqb7zMibQprF0
         9f7OD/UmOzFFQ==
Received: by mail-qv1-f47.google.com with SMTP id n6so2378862qvk.13;
        Wed, 16 Feb 2022 07:09:58 -0800 (PST)
X-Gm-Message-State: AOAM531bWDmOMRYZUn+mW+L05rDzwdrSbdKG7IIWh6toetwPjjgdYOwH
        PxCjPWnX7VYwv0F5ZeKgEKXz2HIP556zdZs/CTo=
X-Google-Smtp-Source: ABdhPJxCSRPgDhTUcFgD7yH2bYr+gnUjrJXEeZaCpLgRQ2RQBbOfByGDXwbhLJyTiX1daK0Xqe6cXBS0aiiMamVLvPQ=
X-Received: by 2002:a0c:c78b:0:b0:430:88a0:eeb0 with SMTP id
 k11-20020a0cc78b000000b0043088a0eeb0mr455706qvj.89.1645024197261; Wed, 16 Feb
 2022 07:09:57 -0800 (PST)
MIME-Version: 1.0
References: <164316310323.2594527.8578672050751235563.stgit@magnolia>
 <164316310910.2594527.6072232851001636761.stgit@magnolia> <20220127012701.GD13540@magnolia>
In-Reply-To: <20220127012701.GD13540@magnolia>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 16 Feb 2022 15:09:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H47iNQ=Wmk83WcGB-KBJVOEtR9+qGczzCeXJ9Y2KCV25Q@mail.gmail.com>
Message-ID: <CAL3q7H47iNQ=Wmk83WcGB-KBJVOEtR9+qGczzCeXJ9Y2KCV25Q@mail.gmail.com>
Subject: Re: [PATCH v1.1 1/2] generic: test suid/sgid behavior with reflink
 and dedupe
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>, xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 9:01 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Make sure that we drop the setuid and setgid bits any time reflink or
> dedupe change the file contents.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> v2: drop the congruent oplen checks, that was a mismerge
> ---
>  tests/generic/950     |  107 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/950.out |   49 +++++++++++++++++++++
>  tests/generic/951     |  117 +++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/951.out |   49 +++++++++++++++++++++
>  tests/generic/952     |   70 +++++++++++++++++++++++++++++
>  tests/generic/952.out |   13 +++++
>  6 files changed, 405 insertions(+)
>  create mode 100755 tests/generic/950
>  create mode 100644 tests/generic/950.out
>  create mode 100755 tests/generic/951
>  create mode 100644 tests/generic/951.out
>  create mode 100755 tests/generic/952
>  create mode 100644 tests/generic/952.out
>
> diff --git a/tests/generic/950 b/tests/generic/950
> new file mode 100755
> index 00000000..a7398cb5
> --- /dev/null
> +++ b/tests/generic/950
> @@ -0,0 +1,107 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 950
> +#
> +# Functional test for dropping suid and sgid bits as part of a reflink.
> +#
> +. ./common/preamble
> +_begin_fstest auto clone quick
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_user
> +_require_scratch_reflink
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +chmod a+rw $SCRATCH_MNT/
> +
> +setup_testfile() {
> +       rm -f $SCRATCH_MNT/a $SCRATCH_MNT/b
> +       _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
> +       _pwrite_byte 0x57 0 1m $SCRATCH_MNT/b >> $seqres.full
> +       chmod a+r $SCRATCH_MNT/b
> +       sync
> +}
> +
> +commit_and_check() {
> +       local user="$1"
> +
> +       md5sum $SCRATCH_MNT/a | _filter_scratch
> +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> +
> +       local cmd="$XFS_IO_PROG -c 'reflink $SCRATCH_MNT/b 0 0 1m' $SCRATCH_MNT/a"
> +       if [ -n "$user" ]; then
> +               su - "$user" -c "$cmd" >> $seqres.full
> +       else
> +               $SHELL -c "$cmd" >> $seqres.full
> +       fi
> +
> +       _scratch_cycle_mount
> +       md5sum $SCRATCH_MNT/a | _filter_scratch
> +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> +
> +       # Blank line in output
> +       echo
> +}
> +

Hi Darrick,

> +# Commit to a non-exec file by an unprivileged user clears suid but leaves
> +# sgid.
> +echo "Test 1 - qa_user, non-exec file"
> +setup_testfile
> +chmod a+rws $SCRATCH_MNT/a
> +commit_and_check "$qa_user"

So this test fails on btrfs, and after taking a look at it, I'm not
sure if this expected result is xfs specific or not.

On btrfs we get sgid cleared:

     310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
     6666 -rwSrwSrw- SCRATCH_MNT/a
     3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
    -2666 -rw-rwSrw- SCRATCH_MNT/a
    +666 -rw-rw-rw- SCRATCH_MNT/a

This happens because at btrfs_setattr() we use setattr_copy() to
change the inode's ->i_mode.
I see that xfs does not use it, instead it manipulates ->i_mode
directly with xfs_setattr_mode().

At setattr_copy() we get the sgid removed:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/attr.c?h=v5.17-rc4#n241

Testing this with buffered writes instead of reflink, to see how xfs,
btrfs and ext4 behave:

#!/bin/bash

DEV=/dev/sdj
MNT=/mnt/sdj
XFS_IO=/home/fdmanana/xfsprogs/sbin/xfs_io

mkfs.btrfs -f $DEV >/dev/null
#mkfs.ext4 -F $DEV >/dev/null
#mkfs.xfs -f $DEV >/dev/null
mount $DEV $MNT

$XFS_IO -f -c "pwrite -S 0xab 0 128K" $MNT/foo >/dev/null
chmod a+rws $MNT/foo

echo "Inode mode before: $(stat -c '%a %A %n' $MNT/foo)"

cmd="$XFS_IO -c 'pwrite -S 0xcd 64K 4K' $MNT/foo"
su - fsgqa -c "$cmd" >/dev/null

echo "Inode mode after:  $(stat -c '%a %A %n' $MNT/foo)"

umount $DEV

btrfs and ext4 give the same result, as both use the setattr_copy()
from generic code, where sgid gets removed:

Inode mode before: 6666 -rwSrwSrw- /mnt/sdj/foo
Inode mode after:  666 -rw-rw-rw- /mnt/sdj/foo

xfs gives the same behaviour as this test expects for reflinks, sgid
is preserved:

Inode mode before: 6666 -rwSrwSrw- /mnt/sdj/foo
Inode mode after:  2666 -rw-rwSrw- /mnt/sdj/foo

So I wonder if this is a behaviour that can be fs specific, if xfs is
behaving incorrectly, or the generic code, setattr_copy(), is not
correct.
Any thoughts?

Thanks.





> +
> +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 2 - qa_user, group-exec file"
> +setup_testfile
> +chmod g+x,a+rws $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +# Commit to a user-exec file by an unprivileged user clears suid but not sgid.
> +echo "Test 3 - qa_user, user-exec file"
> +setup_testfile
> +chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 4 - qa_user, all-exec file"
> +setup_testfile
> +chmod a+rwxs $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +# Commit to a non-exec file by root clears suid but leaves sgid.
> +echo "Test 5 - root, non-exec file"
> +setup_testfile
> +chmod a+rws $SCRATCH_MNT/a
> +commit_and_check
> +
> +# Commit to a group-exec file by root clears suid and sgid.
> +echo "Test 6 - root, group-exec file"
> +setup_testfile
> +chmod g+x,a+rws $SCRATCH_MNT/a
> +commit_and_check
> +
> +# Commit to a user-exec file by root clears suid but not sgid.
> +echo "Test 7 - root, user-exec file"
> +setup_testfile
> +chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> +commit_and_check
> +
> +# Commit to a all-exec file by root clears suid and sgid.
> +echo "Test 8 - root, all-exec file"
> +setup_testfile
> +chmod a+rwxs $SCRATCH_MNT/a
> +commit_and_check
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/950.out b/tests/generic/950.out
> new file mode 100644
> index 00000000..b42e4931
> --- /dev/null
> +++ b/tests/generic/950.out
> @@ -0,0 +1,49 @@
> +QA output created by 950
> +Test 1 - qa_user, non-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6666 -rwSrwSrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +2666 -rw-rwSrw- SCRATCH_MNT/a
> +
> +Test 2 - qa_user, group-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6676 -rwSrwsrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +676 -rw-rwxrw- SCRATCH_MNT/a
> +
> +Test 3 - qa_user, user-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6766 -rwsrwSrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +2766 -rwxrwSrw- SCRATCH_MNT/a
> +
> +Test 4 - qa_user, all-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6777 -rwsrwsrwx SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +777 -rwxrwxrwx SCRATCH_MNT/a
> +
> +Test 5 - root, non-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6666 -rwSrwSrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +6666 -rwSrwSrw- SCRATCH_MNT/a
> +
> +Test 6 - root, group-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6676 -rwSrwsrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +6676 -rwSrwsrw- SCRATCH_MNT/a
> +
> +Test 7 - root, user-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6766 -rwsrwSrw- SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +6766 -rwsrwSrw- SCRATCH_MNT/a
> +
> +Test 8 - root, all-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6777 -rwsrwsrwx SCRATCH_MNT/a
> +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> +6777 -rwsrwsrwx SCRATCH_MNT/a
> +
> diff --git a/tests/generic/951 b/tests/generic/951
> new file mode 100755
> index 00000000..8484f225
> --- /dev/null
> +++ b/tests/generic/951
> @@ -0,0 +1,117 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 951
> +#
> +# Functional test for dropping suid and sgid bits as part of a deduplication.
> +#
> +. ./common/preamble
> +_begin_fstest auto clone quick
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_user
> +_require_scratch_reflink
> +_require_xfs_io_command dedupe
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +chmod a+rw $SCRATCH_MNT/
> +
> +setup_testfile() {
> +       rm -f $SCRATCH_MNT/a $SCRATCH_MNT/b
> +       _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
> +       _pwrite_byte 0x58 0 1m $SCRATCH_MNT/b >> $seqres.full
> +       chmod a+r $SCRATCH_MNT/b
> +       sync
> +}
> +
> +commit_and_check() {
> +       local user="$1"
> +
> +       md5sum $SCRATCH_MNT/a | _filter_scratch
> +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> +
> +       local before_freesp=$(_get_available_space $SCRATCH_MNT)
> +
> +       local cmd="$XFS_IO_PROG -c 'dedupe $SCRATCH_MNT/b 0 0 1m' $SCRATCH_MNT/a"
> +       if [ -n "$user" ]; then
> +               su - "$user" -c "$cmd" >> $seqres.full
> +       else
> +               $SHELL -c "$cmd" >> $seqres.full
> +       fi
> +
> +       _scratch_cycle_mount
> +       md5sum $SCRATCH_MNT/a | _filter_scratch
> +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> +
> +       local after_freesp=$(_get_available_space $SCRATCH_MNT)
> +
> +       echo "before: $before_freesp; after: $after_freesp" >> $seqres.full
> +       if [ $after_freesp -le $before_freesp ]; then
> +               echo "expected more free space after dedupe"
> +       fi
> +
> +       # Blank line in output
> +       echo
> +}
> +
> +# Commit to a non-exec file by an unprivileged user clears suid but leaves
> +# sgid.
> +echo "Test 1 - qa_user, non-exec file"
> +setup_testfile
> +chmod a+rws $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 2 - qa_user, group-exec file"
> +setup_testfile
> +chmod g+x,a+rws $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +# Commit to a user-exec file by an unprivileged user clears suid but not sgid.
> +echo "Test 3 - qa_user, user-exec file"
> +setup_testfile
> +chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> +echo "Test 4 - qa_user, all-exec file"
> +setup_testfile
> +chmod a+rwxs $SCRATCH_MNT/a
> +commit_and_check "$qa_user"
> +
> +# Commit to a non-exec file by root clears suid but leaves sgid.
> +echo "Test 5 - root, non-exec file"
> +setup_testfile
> +chmod a+rws $SCRATCH_MNT/a
> +commit_and_check
> +
> +# Commit to a group-exec file by root clears suid and sgid.
> +echo "Test 6 - root, group-exec file"
> +setup_testfile
> +chmod g+x,a+rws $SCRATCH_MNT/a
> +commit_and_check
> +
> +# Commit to a user-exec file by root clears suid but not sgid.
> +echo "Test 7 - root, user-exec file"
> +setup_testfile
> +chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> +commit_and_check
> +
> +# Commit to a all-exec file by root clears suid and sgid.
> +echo "Test 8 - root, all-exec file"
> +setup_testfile
> +chmod a+rwxs $SCRATCH_MNT/a
> +commit_and_check
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/951.out b/tests/generic/951.out
> new file mode 100644
> index 00000000..f7099ea2
> --- /dev/null
> +++ b/tests/generic/951.out
> @@ -0,0 +1,49 @@
> +QA output created by 951
> +Test 1 - qa_user, non-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6666 -rwSrwSrw- SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6666 -rwSrwSrw- SCRATCH_MNT/a
> +
> +Test 2 - qa_user, group-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6676 -rwSrwsrw- SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6676 -rwSrwsrw- SCRATCH_MNT/a
> +
> +Test 3 - qa_user, user-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6766 -rwsrwSrw- SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6766 -rwsrwSrw- SCRATCH_MNT/a
> +
> +Test 4 - qa_user, all-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6777 -rwsrwsrwx SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6777 -rwsrwsrwx SCRATCH_MNT/a
> +
> +Test 5 - root, non-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6666 -rwSrwSrw- SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6666 -rwSrwSrw- SCRATCH_MNT/a
> +
> +Test 6 - root, group-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6676 -rwSrwsrw- SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6676 -rwSrwsrw- SCRATCH_MNT/a
> +
> +Test 7 - root, user-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6766 -rwsrwSrw- SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6766 -rwsrwSrw- SCRATCH_MNT/a
> +
> +Test 8 - root, all-exec file
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6777 -rwsrwsrwx SCRATCH_MNT/a
> +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> +6777 -rwsrwsrwx SCRATCH_MNT/a
> +
> diff --git a/tests/generic/952 b/tests/generic/952
> new file mode 100755
> index 00000000..86443dcc
> --- /dev/null
> +++ b/tests/generic/952
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 952
> +#
> +# Functional test for dropping suid and sgid capabilities as part of a reflink.
> +#
> +. ./common/preamble
> +_begin_fstest auto clone quick
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/reflink
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_user
> +_require_command "$GETCAP_PROG" getcap
> +_require_command "$SETCAP_PROG" setcap
> +_require_scratch_reflink
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +chmod a+rw $SCRATCH_MNT/
> +
> +setup_testfile() {
> +       rm -f $SCRATCH_MNT/a $SCRATCH_MNT/b
> +       _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
> +       _pwrite_byte 0x57 0 1m $SCRATCH_MNT/b >> $seqres.full
> +       chmod a+rwx $SCRATCH_MNT/a $SCRATCH_MNT/b
> +       $SETCAP_PROG cap_setgid,cap_setuid+ep $SCRATCH_MNT/a
> +       sync
> +}
> +
> +commit_and_check() {
> +       local user="$1"
> +
> +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> +       _getcap -v $SCRATCH_MNT/a | _filter_scratch
> +
> +       local cmd="$XFS_IO_PROG -c 'reflink $SCRATCH_MNT/b 0 0 1m' $SCRATCH_MNT/a"
> +       if [ -n "$user" ]; then
> +               su - "$user" -c "$cmd" >> $seqres.full
> +       else
> +               $SHELL -c "$cmd" >> $seqres.full
> +       fi
> +
> +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> +       _getcap -v $SCRATCH_MNT/a | _filter_scratch
> +
> +       # Blank line in output
> +       echo
> +}
> +
> +# Commit by an unprivileged user clears capability bits.
> +echo "Test 1 - qa_user"
> +setup_testfile
> +commit_and_check "$qa_user"
> +
> +# Commit by root leaves capability bits.
> +echo "Test 2 - root"
> +setup_testfile
> +commit_and_check
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/952.out b/tests/generic/952.out
> new file mode 100644
> index 00000000..eac9e76a
> --- /dev/null
> +++ b/tests/generic/952.out
> @@ -0,0 +1,13 @@
> +QA output created by 952
> +Test 1 - qa_user
> +777 -rwxrwxrwx SCRATCH_MNT/a
> +SCRATCH_MNT/a cap_setgid,cap_setuid=ep
> +777 -rwxrwxrwx SCRATCH_MNT/a
> +SCRATCH_MNT/a
> +
> +Test 2 - root
> +777 -rwxrwxrwx SCRATCH_MNT/a
> +SCRATCH_MNT/a cap_setgid,cap_setuid=ep
> +777 -rwxrwxrwx SCRATCH_MNT/a
> +SCRATCH_MNT/a
> +

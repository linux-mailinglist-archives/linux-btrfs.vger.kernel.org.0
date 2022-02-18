Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0374BB16E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 06:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiBRF0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 00:26:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiBRF0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 00:26:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD9B60CD2;
        Thu, 17 Feb 2022 21:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE73BB82584;
        Fri, 18 Feb 2022 05:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576AAC340E9;
        Fri, 18 Feb 2022 05:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645161976;
        bh=pKDBiJ2cXpJU5T9ABdI9ztLbFEUGKqM+Hlg++EujMm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEIy+dU17/bXw0WkM5Xp3wogi73I5wh7OuBaYaf/rk7UzPRr+cCyeidJfQ7jA+y1L
         NRDyFYGSQBABxEvRLwXQuSchVwoI+mD2a550VOUPbzZsUz4GbKMEbibwIFchJcmqIK
         3xbt816xTYkYP4+2PM3Xxec4RTobRYfUtdTFl5r6ZXs9ybH6gfdJo8YyRxKN4K3Dxv
         fOLCkKkGFJZwdz0QM/fOol34avIf9wOajxMyy6Ke3crqPe6UDVBTMg+TqDyNOgJO+b
         OxnZKFY/0mLnAMkNSjmGN7Y6CaeRFbQ43IXl7eaqmYCISXR6wMWKE/cS7xhLEWVCnS
         h81bz0/4BddLQ==
Date:   Thu, 17 Feb 2022 21:26:15 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>, xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>, Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v1.1 1/2] generic: test suid/sgid behavior with reflink
 and dedupe
Message-ID: <20220218052615.GN8313@magnolia>
References: <164316310323.2594527.8578672050751235563.stgit@magnolia>
 <164316310910.2594527.6072232851001636761.stgit@magnolia>
 <20220127012701.GD13540@magnolia>
 <CAL3q7H47iNQ=Wmk83WcGB-KBJVOEtR9+qGczzCeXJ9Y2KCV25Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H47iNQ=Wmk83WcGB-KBJVOEtR9+qGczzCeXJ9Y2KCV25Q@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 16, 2022 at 03:09:20PM +0000, Filipe Manana wrote:
> On Thu, Jan 27, 2022 at 9:01 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Make sure that we drop the setuid and setgid bits any time reflink or
> > dedupe change the file contents.
> >
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> > v2: drop the congruent oplen checks, that was a mismerge
> > ---
> >  tests/generic/950     |  107 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/950.out |   49 +++++++++++++++++++++
> >  tests/generic/951     |  117 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/951.out |   49 +++++++++++++++++++++
> >  tests/generic/952     |   70 +++++++++++++++++++++++++++++
> >  tests/generic/952.out |   13 +++++
> >  6 files changed, 405 insertions(+)
> >  create mode 100755 tests/generic/950
> >  create mode 100644 tests/generic/950.out
> >  create mode 100755 tests/generic/951
> >  create mode 100644 tests/generic/951.out
> >  create mode 100755 tests/generic/952
> >  create mode 100644 tests/generic/952.out
> >
> > diff --git a/tests/generic/950 b/tests/generic/950
> > new file mode 100755
> > index 00000000..a7398cb5
> > --- /dev/null
> > +++ b/tests/generic/950
> > @@ -0,0 +1,107 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > +#
> > +# FS QA Test 950
> > +#
> > +# Functional test for dropping suid and sgid bits as part of a reflink.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto clone quick
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/reflink
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_require_user
> > +_require_scratch_reflink
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_scratch_mount
> > +chmod a+rw $SCRATCH_MNT/
> > +
> > +setup_testfile() {
> > +       rm -f $SCRATCH_MNT/a $SCRATCH_MNT/b
> > +       _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
> > +       _pwrite_byte 0x57 0 1m $SCRATCH_MNT/b >> $seqres.full
> > +       chmod a+r $SCRATCH_MNT/b
> > +       sync
> > +}
> > +
> > +commit_and_check() {
> > +       local user="$1"
> > +
> > +       md5sum $SCRATCH_MNT/a | _filter_scratch
> > +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> > +
> > +       local cmd="$XFS_IO_PROG -c 'reflink $SCRATCH_MNT/b 0 0 1m' $SCRATCH_MNT/a"
> > +       if [ -n "$user" ]; then
> > +               su - "$user" -c "$cmd" >> $seqres.full
> > +       else
> > +               $SHELL -c "$cmd" >> $seqres.full
> > +       fi
> > +
> > +       _scratch_cycle_mount
> > +       md5sum $SCRATCH_MNT/a | _filter_scratch
> > +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> > +
> > +       # Blank line in output
> > +       echo
> > +}
> > +
> 
> Hi Darrick,
> 
> > +# Commit to a non-exec file by an unprivileged user clears suid but leaves
> > +# sgid.
> > +echo "Test 1 - qa_user, non-exec file"
> > +setup_testfile
> > +chmod a+rws $SCRATCH_MNT/a
> > +commit_and_check "$qa_user"
> 
> So this test fails on btrfs, and after taking a look at it, I'm not
> sure if this expected result is xfs specific or not.

It's.... complicated.  g+s without g+x is some holdover from System V
mandatory file locks, wherein:

"Note that the group-id bit is usually automatically cleared by the
kernel when a setgid file is written to. This is a security measure. The
kernel has been modified to recognize the special case of a mandatory
lock candidate and to refrain from clearing this bit. Similarly the
kernel has been modified not to run mandatory lock candidates with
setgid privileges."

https://www.kernel.org/doc/html/v5.14/filesystems/mandatory-locking.html#marking-a-file-for-mandatory-locking

Which, I think, is why XFS preserves the setgid bit.  Of course, with
mandatory locking now deprecated, it's perhaps time to get rid of that
behavior?

The funny part is, XFS itself doesn't make this decision;
should_remove_suid in the VFS does:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/inode.c?h=v5.17-rc4#n1967

So XFS has this behavior because generic_remap_file_range_prep calls
file_modified -> file_remove_privs -> dentry_needs_remove_privs ->
should_remove_suid...

> On btrfs we get sgid cleared:
> 
>      310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
>      6666 -rwSrwSrw- SCRATCH_MNT/a
>      3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
>     -2666 -rw-rwSrw- SCRATCH_MNT/a
>     +666 -rw-rw-rw- SCRATCH_MNT/a
> 
> This happens because at btrfs_setattr() we use setattr_copy() to
> change the inode's ->i_mode.
> I see that xfs does not use it, instead it manipulates ->i_mode
> directly with xfs_setattr_mode().
> 
> At setattr_copy() we get the sgid removed:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/attr.c?h=v5.17-rc4#n241

...OH, now I get it.  notify_change() sees that ATTR_KILL_SUID is set,
and sets ATTR_MODE.  If you use setattr_copy, will always clear the
setgid bit.  XFS doesn't (as you point out) which is why the behavior is
different.  xfs_setattr_nonsize looks like it open-codes a lot of what
setattr_copy does, but without the gid-killing quirk.

I'm not sure what to do here -- the VFS code is clearly conflicted about
this.  Given that the weird behavior only exists to support a dying
feature, we might as well just make everyone clear sgid.

Digging around in xfs_setattr_nonsize a bit more, I suspect the reason
why we handle ATTR_[UG]ID separately is because of the xfs quota
subsystem, but I don't see any reason why xfs couldn't adopt
setattr_copy for the rest of the ATTR_* bits.

Sorry about injecting a new fail test at you all. :/

> Testing this with buffered writes instead of reflink, to see how xfs,
> btrfs and ext4 behave:
> 
> #!/bin/bash
> 
> DEV=/dev/sdj
> MNT=/mnt/sdj
> XFS_IO=/home/fdmanana/xfsprogs/sbin/xfs_io
> 
> mkfs.btrfs -f $DEV >/dev/null
> #mkfs.ext4 -F $DEV >/dev/null
> #mkfs.xfs -f $DEV >/dev/null
> mount $DEV $MNT
> 
> $XFS_IO -f -c "pwrite -S 0xab 0 128K" $MNT/foo >/dev/null
> chmod a+rws $MNT/foo
> 
> echo "Inode mode before: $(stat -c '%a %A %n' $MNT/foo)"
> 
> cmd="$XFS_IO -c 'pwrite -S 0xcd 64K 4K' $MNT/foo"
> su - fsgqa -c "$cmd" >/dev/null
> 
> echo "Inode mode after:  $(stat -c '%a %A %n' $MNT/foo)"
> 
> umount $DEV
> 
> btrfs and ext4 give the same result, as both use the setattr_copy()
> from generic code, where sgid gets removed:
> 
> Inode mode before: 6666 -rwSrwSrw- /mnt/sdj/foo
> Inode mode after:  666 -rw-rw-rw- /mnt/sdj/foo
> 
> xfs gives the same behaviour as this test expects for reflinks, sgid
> is preserved:
> 
> Inode mode before: 6666 -rwSrwSrw- /mnt/sdj/foo
> Inode mode after:  2666 -rw-rwSrw- /mnt/sdj/foo
> 
> So I wonder if this is a behaviour that can be fs specific, if xfs is
> behaving incorrectly, or the generic code, setattr_copy(), is not
> correct.
> Any thoughts?

"Ow, my brain hurts." and "I wonder if Dave has better context about
this"...

--D

> 
> Thanks.
> 
> 
> 
> 
> 
> > +
> > +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> > +echo "Test 2 - qa_user, group-exec file"
> > +setup_testfile
> > +chmod g+x,a+rws $SCRATCH_MNT/a
> > +commit_and_check "$qa_user"
> > +
> > +# Commit to a user-exec file by an unprivileged user clears suid but not sgid.
> > +echo "Test 3 - qa_user, user-exec file"
> > +setup_testfile
> > +chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> > +commit_and_check "$qa_user"
> > +
> > +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> > +echo "Test 4 - qa_user, all-exec file"
> > +setup_testfile
> > +chmod a+rwxs $SCRATCH_MNT/a
> > +commit_and_check "$qa_user"
> > +
> > +# Commit to a non-exec file by root clears suid but leaves sgid.
> > +echo "Test 5 - root, non-exec file"
> > +setup_testfile
> > +chmod a+rws $SCRATCH_MNT/a
> > +commit_and_check
> > +
> > +# Commit to a group-exec file by root clears suid and sgid.
> > +echo "Test 6 - root, group-exec file"
> > +setup_testfile
> > +chmod g+x,a+rws $SCRATCH_MNT/a
> > +commit_and_check
> > +
> > +# Commit to a user-exec file by root clears suid but not sgid.
> > +echo "Test 7 - root, user-exec file"
> > +setup_testfile
> > +chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> > +commit_and_check
> > +
> > +# Commit to a all-exec file by root clears suid and sgid.
> > +echo "Test 8 - root, all-exec file"
> > +setup_testfile
> > +chmod a+rwxs $SCRATCH_MNT/a
> > +commit_and_check
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/950.out b/tests/generic/950.out
> > new file mode 100644
> > index 00000000..b42e4931
> > --- /dev/null
> > +++ b/tests/generic/950.out
> > @@ -0,0 +1,49 @@
> > +QA output created by 950
> > +Test 1 - qa_user, non-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6666 -rwSrwSrw- SCRATCH_MNT/a
> > +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > +2666 -rw-rwSrw- SCRATCH_MNT/a
> > +
> > +Test 2 - qa_user, group-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6676 -rwSrwsrw- SCRATCH_MNT/a
> > +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > +676 -rw-rwxrw- SCRATCH_MNT/a
> > +
> > +Test 3 - qa_user, user-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6766 -rwsrwSrw- SCRATCH_MNT/a
> > +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > +2766 -rwxrwSrw- SCRATCH_MNT/a
> > +
> > +Test 4 - qa_user, all-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6777 -rwsrwsrwx SCRATCH_MNT/a
> > +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > +777 -rwxrwxrwx SCRATCH_MNT/a
> > +
> > +Test 5 - root, non-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6666 -rwSrwSrw- SCRATCH_MNT/a
> > +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > +6666 -rwSrwSrw- SCRATCH_MNT/a
> > +
> > +Test 6 - root, group-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6676 -rwSrwsrw- SCRATCH_MNT/a
> > +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > +6676 -rwSrwsrw- SCRATCH_MNT/a
> > +
> > +Test 7 - root, user-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6766 -rwsrwSrw- SCRATCH_MNT/a
> > +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > +6766 -rwsrwSrw- SCRATCH_MNT/a
> > +
> > +Test 8 - root, all-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6777 -rwsrwsrwx SCRATCH_MNT/a
> > +3784de23efab7a2074c9ec66901e39e5  SCRATCH_MNT/a
> > +6777 -rwsrwsrwx SCRATCH_MNT/a
> > +
> > diff --git a/tests/generic/951 b/tests/generic/951
> > new file mode 100755
> > index 00000000..8484f225
> > --- /dev/null
> > +++ b/tests/generic/951
> > @@ -0,0 +1,117 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > +#
> > +# FS QA Test 951
> > +#
> > +# Functional test for dropping suid and sgid bits as part of a deduplication.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto clone quick
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/reflink
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_require_user
> > +_require_scratch_reflink
> > +_require_xfs_io_command dedupe
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_scratch_mount
> > +chmod a+rw $SCRATCH_MNT/
> > +
> > +setup_testfile() {
> > +       rm -f $SCRATCH_MNT/a $SCRATCH_MNT/b
> > +       _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
> > +       _pwrite_byte 0x58 0 1m $SCRATCH_MNT/b >> $seqres.full
> > +       chmod a+r $SCRATCH_MNT/b
> > +       sync
> > +}
> > +
> > +commit_and_check() {
> > +       local user="$1"
> > +
> > +       md5sum $SCRATCH_MNT/a | _filter_scratch
> > +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> > +
> > +       local before_freesp=$(_get_available_space $SCRATCH_MNT)
> > +
> > +       local cmd="$XFS_IO_PROG -c 'dedupe $SCRATCH_MNT/b 0 0 1m' $SCRATCH_MNT/a"
> > +       if [ -n "$user" ]; then
> > +               su - "$user" -c "$cmd" >> $seqres.full
> > +       else
> > +               $SHELL -c "$cmd" >> $seqres.full
> > +       fi
> > +
> > +       _scratch_cycle_mount
> > +       md5sum $SCRATCH_MNT/a | _filter_scratch
> > +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> > +
> > +       local after_freesp=$(_get_available_space $SCRATCH_MNT)
> > +
> > +       echo "before: $before_freesp; after: $after_freesp" >> $seqres.full
> > +       if [ $after_freesp -le $before_freesp ]; then
> > +               echo "expected more free space after dedupe"
> > +       fi
> > +
> > +       # Blank line in output
> > +       echo
> > +}
> > +
> > +# Commit to a non-exec file by an unprivileged user clears suid but leaves
> > +# sgid.
> > +echo "Test 1 - qa_user, non-exec file"
> > +setup_testfile
> > +chmod a+rws $SCRATCH_MNT/a
> > +commit_and_check "$qa_user"
> > +
> > +# Commit to a group-exec file by an unprivileged user clears suid and sgid.
> > +echo "Test 2 - qa_user, group-exec file"
> > +setup_testfile
> > +chmod g+x,a+rws $SCRATCH_MNT/a
> > +commit_and_check "$qa_user"
> > +
> > +# Commit to a user-exec file by an unprivileged user clears suid but not sgid.
> > +echo "Test 3 - qa_user, user-exec file"
> > +setup_testfile
> > +chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> > +commit_and_check "$qa_user"
> > +
> > +# Commit to a all-exec file by an unprivileged user clears suid and sgid.
> > +echo "Test 4 - qa_user, all-exec file"
> > +setup_testfile
> > +chmod a+rwxs $SCRATCH_MNT/a
> > +commit_and_check "$qa_user"
> > +
> > +# Commit to a non-exec file by root clears suid but leaves sgid.
> > +echo "Test 5 - root, non-exec file"
> > +setup_testfile
> > +chmod a+rws $SCRATCH_MNT/a
> > +commit_and_check
> > +
> > +# Commit to a group-exec file by root clears suid and sgid.
> > +echo "Test 6 - root, group-exec file"
> > +setup_testfile
> > +chmod g+x,a+rws $SCRATCH_MNT/a
> > +commit_and_check
> > +
> > +# Commit to a user-exec file by root clears suid but not sgid.
> > +echo "Test 7 - root, user-exec file"
> > +setup_testfile
> > +chmod u+x,a+rws,g-x $SCRATCH_MNT/a
> > +commit_and_check
> > +
> > +# Commit to a all-exec file by root clears suid and sgid.
> > +echo "Test 8 - root, all-exec file"
> > +setup_testfile
> > +chmod a+rwxs $SCRATCH_MNT/a
> > +commit_and_check
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/951.out b/tests/generic/951.out
> > new file mode 100644
> > index 00000000..f7099ea2
> > --- /dev/null
> > +++ b/tests/generic/951.out
> > @@ -0,0 +1,49 @@
> > +QA output created by 951
> > +Test 1 - qa_user, non-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6666 -rwSrwSrw- SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6666 -rwSrwSrw- SCRATCH_MNT/a
> > +
> > +Test 2 - qa_user, group-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6676 -rwSrwsrw- SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6676 -rwSrwsrw- SCRATCH_MNT/a
> > +
> > +Test 3 - qa_user, user-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6766 -rwsrwSrw- SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6766 -rwsrwSrw- SCRATCH_MNT/a
> > +
> > +Test 4 - qa_user, all-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6777 -rwsrwsrwx SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6777 -rwsrwsrwx SCRATCH_MNT/a
> > +
> > +Test 5 - root, non-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6666 -rwSrwSrw- SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6666 -rwSrwSrw- SCRATCH_MNT/a
> > +
> > +Test 6 - root, group-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6676 -rwSrwsrw- SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6676 -rwSrwsrw- SCRATCH_MNT/a
> > +
> > +Test 7 - root, user-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6766 -rwsrwSrw- SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6766 -rwsrwSrw- SCRATCH_MNT/a
> > +
> > +Test 8 - root, all-exec file
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6777 -rwsrwsrwx SCRATCH_MNT/a
> > +310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
> > +6777 -rwsrwsrwx SCRATCH_MNT/a
> > +
> > diff --git a/tests/generic/952 b/tests/generic/952
> > new file mode 100755
> > index 00000000..86443dcc
> > --- /dev/null
> > +++ b/tests/generic/952
> > @@ -0,0 +1,70 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > +#
> > +# FS QA Test 952
> > +#
> > +# Functional test for dropping suid and sgid capabilities as part of a reflink.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto clone quick
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/reflink
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_require_user
> > +_require_command "$GETCAP_PROG" getcap
> > +_require_command "$SETCAP_PROG" setcap
> > +_require_scratch_reflink
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_scratch_mount
> > +chmod a+rw $SCRATCH_MNT/
> > +
> > +setup_testfile() {
> > +       rm -f $SCRATCH_MNT/a $SCRATCH_MNT/b
> > +       _pwrite_byte 0x58 0 1m $SCRATCH_MNT/a >> $seqres.full
> > +       _pwrite_byte 0x57 0 1m $SCRATCH_MNT/b >> $seqres.full
> > +       chmod a+rwx $SCRATCH_MNT/a $SCRATCH_MNT/b
> > +       $SETCAP_PROG cap_setgid,cap_setuid+ep $SCRATCH_MNT/a
> > +       sync
> > +}
> > +
> > +commit_and_check() {
> > +       local user="$1"
> > +
> > +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> > +       _getcap -v $SCRATCH_MNT/a | _filter_scratch
> > +
> > +       local cmd="$XFS_IO_PROG -c 'reflink $SCRATCH_MNT/b 0 0 1m' $SCRATCH_MNT/a"
> > +       if [ -n "$user" ]; then
> > +               su - "$user" -c "$cmd" >> $seqres.full
> > +       else
> > +               $SHELL -c "$cmd" >> $seqres.full
> > +       fi
> > +
> > +       stat -c '%a %A %n' $SCRATCH_MNT/a | _filter_scratch
> > +       _getcap -v $SCRATCH_MNT/a | _filter_scratch
> > +
> > +       # Blank line in output
> > +       echo
> > +}
> > +
> > +# Commit by an unprivileged user clears capability bits.
> > +echo "Test 1 - qa_user"
> > +setup_testfile
> > +commit_and_check "$qa_user"
> > +
> > +# Commit by root leaves capability bits.
> > +echo "Test 2 - root"
> > +setup_testfile
> > +commit_and_check
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/952.out b/tests/generic/952.out
> > new file mode 100644
> > index 00000000..eac9e76a
> > --- /dev/null
> > +++ b/tests/generic/952.out
> > @@ -0,0 +1,13 @@
> > +QA output created by 952
> > +Test 1 - qa_user
> > +777 -rwxrwxrwx SCRATCH_MNT/a
> > +SCRATCH_MNT/a cap_setgid,cap_setuid=ep
> > +777 -rwxrwxrwx SCRATCH_MNT/a
> > +SCRATCH_MNT/a
> > +
> > +Test 2 - root
> > +777 -rwxrwxrwx SCRATCH_MNT/a
> > +SCRATCH_MNT/a cap_setgid,cap_setuid=ep
> > +777 -rwxrwxrwx SCRATCH_MNT/a
> > +SCRATCH_MNT/a
> > +

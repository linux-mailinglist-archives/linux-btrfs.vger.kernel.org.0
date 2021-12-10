Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1616146F82B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 01:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhLJA5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 19:57:40 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:55738 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230506AbhLJA5k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Dec 2021 19:57:40 -0500
X-Greylist: delayed 1286 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2021 19:57:39 EST
Received: from dread.disaster.area (pa49-181-243-119.pa.nsw.optusnet.com.au [49.181.243.119])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id A1EAFE0D90E;
        Fri, 10 Dec 2021 11:32:37 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mvTj3-001C8X-QR; Fri, 10 Dec 2021 11:25:25 +1100
Date:   Fri, 10 Dec 2021 11:25:25 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/335: explicitly fsync file foo when running on
 btrfs
Message-ID: <20211210002525.GB279368@dread.disaster.area>
References: <4e00357fe3aaa843bd8fd02218b97104e5fd74bf.1639060960.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e00357fe3aaa843bd8fd02218b97104e5fd74bf.1639060960.git.fdmanana@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61b2a026
        a=BEa52nrBdFykVEm6RU8P4g==:117 a=BEa52nrBdFykVEm6RU8P4g==:17
        a=kj9zAlcOel0A:10 a=IOMw9HtfNCkA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=nKcsr1Xi_qaZ1-0FyGEA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 09, 2021 at 02:44:06PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test is relying on the fact that an fsync on directory "a" will
> result in persisting the changes of its subdirectory "b", namely the
> rename of "/a/b/foo" to "/c/foo". For this particular filesystem layout,
> that will happen on btrfs, because all the directory entries end up in
> the same metadata leaf. However that is not a behaviour we can always
> guarantee on btrfs. For example, if we add more files to directory
> "a" before and after creating subdirectory "b", like this:
> 
>   mkdir $SCRATCH_MNT/a
>   for ((i = 0; i < 1000; i++)); do
>       echo -n > $SCRATCH_MNT/a/file_$i
>   done
>   mkdir $SCRATCH_MNT/a/b
>   for ((i = 1000; i < 2000; i++)); do
>       echo -n > $SCRATCH_MNT/a/file_$i
>   done
>   mkdir $SCRATCH_MNT/c
>   touch $SCRATCH_MNT/a/b/foo
> 
>   sync
> 
>   # The rest of the test remains unchanged...
>   (...)
> 
> Then after fsyncing only directory "a", the rename of file "foo" from
> "/a/b/foo" to "/c/foo" is not persisted.
> 
> Guaranteeing that on btrfs would be expensive on large directories, as
> it would require scanning for every subdirectory. It's also not required
> by posix for the fsync on a directory to persist changes inside its
> subdirectories. So add an explicit fsync on file "foo" when the filesystem
> being tested is btrfs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/335 | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tests/generic/335 b/tests/generic/335
> index e04f7a5f..196ada64 100755
> --- a/tests/generic/335
> +++ b/tests/generic/335
> @@ -51,6 +51,15 @@ mv $SCRATCH_MNT/a/b/foo $SCRATCH_MNT/c/
>  touch $SCRATCH_MNT/a/bar
>  $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a
>  
> +# btrfs can not guarantee that when we fsync a directory all its subdirectories
> +# created on past transactions are fsynced as well. It may do it sometimes, but
> +# it's not guaranteed, giving such guarantees would be too expensive for large
> +# directories and posix does not require that recursive behaviour. So if we want
> +# the rename of "foo" to be persisted, explicitly fsync "foo".
> +if [ $FSTYP == "btrfs" ]; then
> +	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/c/foo
> +fi

Doesn't this imply a regression in the behaviour of btrfs? After
all, this test was written explicitly to exercise a bug in btrfs log
recovery:

commit 72da52702a4b5bea1170aed791893487d0748566
Author: Filipe Manana <fdmanana@suse.com>
Date:   Fri Feb 19 12:15:17 2016 +1100

    generic: test directory fsync after rename operation

    Test that if we move one file between directories, fsync the parent
    directory of the old directory, power fail and remount the filesystem,
    the file is not lost and it's located at the destination directory.

    This is motivated by a bug found in btrfs, which is fixed by the patch
    (for the linux kernel) titled:

      "Btrfs: fix file loss on log replay after renaming a file and fsync"

    Tested against ext3, ext4, xfs, f2fs and reiserfs.

    Signed-off-by: Filipe Manana <fdmanana@suse.com>
    Reviewed-by: Dave Chinner <dchinner@redhat.com>
    Signed-off-by: Dave Chinner <david@fromorbit.com>

What's changed that now makes this an invalid test for btrfs log
recovery? Has btrfs loosened it's metadata ordering guarantees in
the past few years?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

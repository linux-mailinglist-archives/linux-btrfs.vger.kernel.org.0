Return-Path: <linux-btrfs+bounces-11918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91892A48713
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 18:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FE016D669
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009E1E51E6;
	Thu, 27 Feb 2025 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEQa0iHB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E731DDC22;
	Thu, 27 Feb 2025 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678743; cv=none; b=L/IROJtnd4/N5d0I3CGI9F2FNYPCcUd//Kn7ZFrKkmtYsXo3mzMoLIGbZWh8Ef4DE86X1K7r+G9xi953h6xsPyyDkShADEKaSkH683QWU0nVxn6WYCUwLHbogAe7gulIi8IZyrFhVRGzqGx4QNG9le2SLuWAPsVD49demsbbRbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678743; c=relaxed/simple;
	bh=nASaXZsXG/j69V03S4cG4uhZkL+ORNx69MslNkfPx4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykh5g3CNKf2Qfk47YOAr70DLe/gzI6nf8v+3UoYivEEpywgNJEWJUvEdXEabnh3C2Evs62WbxZVai1SoxiUr7/rPwiyCxF8WXgabdhaoMYZ8oCdNsIekRoSC0FA5S+GFyDEfdNCJ/sddhX0pKls8FwB10sTVtDVGEWjuVzm84/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEQa0iHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E238C4CEDD;
	Thu, 27 Feb 2025 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678742;
	bh=nASaXZsXG/j69V03S4cG4uhZkL+ORNx69MslNkfPx4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEQa0iHBvV4+qN41kzCDCkIl2deLVZHKjdVa4D7oA8ICBLmY5QKQMpikBMFX0Z0sD
	 q5g7ki9WUffC58ifEClqMaJXwfhi3NVXpS+i7FLPb4uvwSGX6DwyikVvoStKhuLx6w
	 tfrww1kt5VVdCVYNk2NdZ44w7l0SJm1NQvQ02LEBNRLbjVzJHJ67vtizuhDU4MrLUg
	 6LnmvK4UrLb7mUpJL3Adp3sMqiShSuVqA77WeDpeq3vP4O62JJUR3Knb+bqzkWEiuE
	 4Xqw2K0khVoOQY/BTSxqJHSloVfbyvf7QTpRNZcggwkxTg9QHfUh+VKk10cNZ5L019
	 /LH/fmsthTVNQ==
Date: Thu, 27 Feb 2025 09:52:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250227175221.GA1124788@frogsfrogsfrogs>
References: <67bb1448.500a0220.af3ac.9928SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAL3q7H7ODnoeo3ac1pahD9NdujiGA=zoG79arAgrJVDUu9j7hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7ODnoeo3ac1pahD9NdujiGA=zoG79arAgrJVDUu9j7hg@mail.gmail.com>

On Thu, Feb 27, 2025 at 01:32:42PM +0000, Filipe Manana wrote:
> On Sun, Feb 23, 2025 at 12:27 PM Zorro Lang <zlang@kernel.org> wrote:
> >
> > Hi all,
> >
> > The for-next branch of the xfstests repository at:
> >
> >         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >
> > has just been updated and tagged as v2025.02.23 release.
> >
> > Release Notes:
> > 1) There's not new test cases in this release, this's a release for bug fixes
> >    particularly.
> > 2) Reiserfs part is removed from fstests.
> > 3) ltp/growfiles is removed too, I think no one needs it.
> >
> > I can't list all updates at here, more details please refer to below.
> > Thanks for all these contributions!
> >
> > Thanks,
> > Zorro
> >
> > The new head of the for-next branch is commit:
> >
> > 5b56a2d88819 fstests: remove reiserfs support
> >
> > New commits:
> >
> > Christoph Hellwig (1):
> >       [04d0cf3f8909] generic/370: don't exclude XFS
> >
> > Darrick J. Wong (35):
> >       [cc379f50f3bd] generic/476: fix fsstress process management
> >       [ab459c67c5e0] metadump: make non-local function variables more obvious
> >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> >       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
> >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
> >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
> >       [777732b27e62] common/dump: don't replace pids arbitrarily
> >       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
> >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
> >       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
> >       [77548e6066fd] common/rc: create a wrapper for the su command
> >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
> >       [c71349150d34] common/rc: hoist pkill to a helper function
> >       [91d2880aa029] tools: add a Makefile
> >       [88d60f434bd9] common: fix pkill by running test program in a separate session
> >       [247ab01fa227] check: run tests in a private pid/mount namespace
> 
> By the way, this commits breaks several btrfs test cases in the
> read_repair group:
> 
> $ ./check -g read_repair
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/140 1s ... [failed, exit status 1]- output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad)
>     --- tests/btrfs/140.out 2024-06-04 12:18:50.080308741 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad
> 2025-02-27 13:27:56.050933812 +0000
>     @@ -1,3 +1,5 @@
>      QA output created by 140
>      wrote 131072/131072 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     +repair failed, csums don't match
>     +(see /home/fdmanana/git/hub/xfstests/results//btrfs/140.full for details)
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/140.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad'  to see
> the entire diff)
> btrfs/141 1s ... [failed, exit status 1]- output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad)
>     --- tests/btrfs/141.out 2024-06-04 12:18:50.084308982 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad

...which I never saw because I don't have SCRATCH_DEV_POOL set up. :(

I traced it to this code:

	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
		exec $XFS_IO_PROG \
			-c "pread -b $size $offset $size" $file) ]]; do
		:
	done

If memory serves, btrfs' raid rotoring is based on the global pid
number, right?  If so, then this is broken with the new run_privatens
isolation (i.e. the commit you referenced) because the pids that the
test program sees are private to that namespace.

IOWS, the subprocesses created in the loop test might appear to have
pids 3 -> 4 -> 5, but those could very well be 100, 200, 300 in the
global namespace, in which case all reads go to the same mirror
(assuming nr_mirrors==2 as it does in btrfs/140).

A really shitty hack around that is this:

	for ((i = 0; i < (nr_mirrors * 4); i++)); do
		$XFS_IO_PROG -c "pread -b $size $offset $size" $file
	done >> $seqres.full

but now we're just hoping that reading 8x actually manages to hit both
mirrors at some point in this test.  But that doesn't work reliably in
btrfs/141 even if I turn it up from 4 to 11.

Is there *any* other way to trigger read from a specific mirror?

--D

> 2025-02-27 13:27:57.233352695 +0000
>     @@ -1,3 +1,5 @@
>      QA output created by 141
>      wrote 131072/131072 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     +repair failed, csums don't match
>     +(see /home/fdmanana/git/hub/xfstests/results//btrfs/141.full for details)
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/141.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad'  to see
> the entire diff)
> btrfs/142 1s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad)
>     --- tests/btrfs/142.out 2020-06-10 19:29:03.818519162 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad
> 2025-02-27 13:27:59.133249259 +0000
>     @@ -1,37 +1,37 @@
>      QA output created by 142
>      wrote 131072/131072 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/142.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad'  to see
> the entire diff)
> btrfs/143 1s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad)
>     --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad
> 2025-02-27 13:28:00.989680223 +0000
>     @@ -1,37 +1,37 @@
>      QA output created by 143
>      wrote 131072/131072 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/143.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad'  to see
> the entire diff)
> btrfs/150 1s ...  1s
> btrfs/157 2s ...  1s
> btrfs/215 1s ...  1s
> btrfs/265 2s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
>     --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
> 2025-02-27 13:28:05.589305927 +0000
>     @@ -5,71 +5,71 @@
>      step 2......corrupt file extent
>      step 3......repair the bad copy
>      step 4......check if the repair worked
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
> the entire diff)
> btrfs/266 3s ...  2s
> btrfs/267 2s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad)
>     --- tests/btrfs/267.out 2023-03-02 21:47:53.876609426 +0000
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad
> 2025-02-27 13:28:09.161394788 +0000
>     @@ -73,37 +73,37 @@
>      XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>      read 512/512 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/267.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad'  to see
> the entire diff)
> btrfs/268 3s ...  2s
> btrfs/269 2s ...  1s
> btrfs/270 1s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad)
>     --- tests/btrfs/270.out 2023-03-02 21:47:53.876609426 +0000
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad
> 2025-02-27 13:28:14.090153054 +0000
>     @@ -5,3 +5,4099 @@
>      step 2......corrupt file extent
>      step 3......repair the bad copy
>      step 4......check if the repair worked
>     +   1 170 x    273 M-;
>     +   2 136 ^    273 M-;
>     +   3 354 M-l  273 M-;
>     +   4 320 M-P  273 M-;
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/270.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad'  to see
> the entire diff)
> Ran: btrfs/140 btrfs/141 btrfs/142 btrfs/143 btrfs/150 btrfs/157
> btrfs/215 btrfs/265 btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/270
> Failures: btrfs/140 btrfs/141 btrfs/142 btrfs/143 btrfs/265 btrfs/267 btrfs/270
> Failed 7 of 13 tests
> 
> The failures seems to be timing sensitive, as running a test
> individually doesn't always fails, for example:
> 
> $ root 13:30:43 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/265 1s ...  2s
> Ran: btrfs/265
> Passed all 1 tests
> 
> root 13:30:46 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/265 2s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
>     --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
> 2025-02-27 13:30:49.386584060 +0000
>     @@ -5,71 +5,71 @@
>      step 2......corrupt file extent
>      step 3......repair the bad copy
>      step 4......check if the repair worked
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
> the entire diff)
> Ran: btrfs/265
> Failures: btrfs/265
> Failed 1 of 1 tests
> 
> root 13:30:49 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/265 2s ...  1s
> Ran: btrfs/265
> Passed all 1 tests
> 
> root 13:31:02 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/265 1s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
>     --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
>     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
> 2025-02-27 13:31:05.522911416 +0000
>     @@ -5,38 +5,38 @@
>      step 2......corrupt file extent
>      step 3......repair the bad copy
>      step 4......check if the repair worked
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     ...
>     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
> the entire diff)
> Ran: btrfs/265
> Failures: btrfs/265
> Failed 1 of 1 tests
> 
> root 13:31:05 /home/fdmanana/git/hub/xfstests >
> 
> Bisection using 100 iterations reliably points to that commit.
> 
> Any ideas Darrick?
> 
> Thanks.
> 
> 
> 
> >       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
> >       [af0f1090e240] common/rc: don't copy fsstress to $TEST_DIR
> >       [f43da58ef936] unmount: resume logging of stdout and stderr for filtering
> >       [5dc27fd20f80] mkfs: don't hardcode log size
> >       [dba402b7e3ae] common/rc: return mount_ret in _try_scratch_mount
> >       [9505d04b8073] preamble: fix missing _kill_fsstress
> >       [4d9aeeb79f9c] generic/650: revert SOAK DURATION changes
> >       [1bb15a27573e] generic/032: fix pinned mount failure
> >       [b816737426bf] fuzzy: stop __stress_scrub_fsx_loop if fsx fails
> >       [040e74c89192] fuzzy: don't use readarray for xfsfind output
> >       [0dfe1fac98d2] fuzzy: always stop the scrub fsstress loop on error
> >       [336d73c96a96] fuzzy: port fsx and fsstress loop to use --duration
> >       [96d29207c126] fix _require_scratch_duperemove ordering
> >       [a8268531ca8b] fsstress: fix a memory leak
> >       [e8e29e028faa] fsx: fix leaked log file pointer
> >       [4a9e82863917] misc: don't put nr_cpus into the fsstress -n argument
> >       [c475ff6ff6d7] common/config: add $here to FSSTRESS_PROG
> >       [1c67e8b191fe] config: add FSX_PROG variable
> >       [a553e7eba1cf] build: initialize stack variables to zero by default
> >
> > David Sterba (2):
> >       [9049250b4042] fstests: remove ltp/growfiles
> >       [5b56a2d88819] fstests: remove reiserfs support
> >
> > Filipe Manana (2):
> >       [7122c0315a08] btrfs/254: don't leave mount on test fs in case of failure/interruption
> >       [535b72a63a28] btrfs/254: fix test failure in case scratch devices are larger than 50G
> >
> > Jeff Layton (1):
> >       [bd6e01c81e21] generic/126: run it inside its own subdirectory
> >
> >
> > Code Diffstat:
> >
> >  .gitignore            |    1 -
> >  Makefile              |    2 +-
> >  check                 |   91 +-
> >  common/config         |   12 +-
> >  common/dump           |    1 -
> >  common/fuzzy          |  104 +-
> >  common/metadump       |   42 +-
> >  common/populate       |   13 +-
> >  common/preamble       |    2 +-
> >  common/quota          |    6 +-
> >  common/rc             |  146 ++-
> >  common/reflink        |    2 +-
> >  configure.ac          |    1 +
> >  include/builddefs.in  |    3 +-
> >  lib/tlibio.c          |    2 +-
> >  ltp/Makefile          |    2 +-
> >  ltp/fsstress.c        |    1 +
> >  ltp/fsx.c             |    8 +-
> >  ltp/growfiles.c       | 2607 -------------------------------------------------
> >  m4/package_libcdev.m4 |   14 +
> >  src/nsexec.c          |   18 +-
> >  src/xfsfind.c         |   14 +-
> >  tests/btrfs/254       |    8 +-
> >  tests/generic/019     |    2 +-
> >  tests/generic/032     |    9 +
> >  tests/generic/050     |    2 +-
> >  tests/generic/075     |    2 +-
> >  tests/generic/085     |    2 +-
> >  tests/generic/093     |    2 +-
> >  tests/generic/112     |    2 +-
> >  tests/generic/125     |    2 +-
> >  tests/generic/126     |   17 +-
> >  tests/generic/127     |   16 +-
> >  tests/generic/128     |    2 +-
> >  tests/generic/193     |   36 +-
> >  tests/generic/230     |   14 +-
> >  tests/generic/231     |    4 +-
> >  tests/generic/233     |    2 +-
> >  tests/generic/270     |   12 +-
> >  tests/generic/310     |    6 +-
> >  tests/generic/314     |    2 +-
> >  tests/generic/327     |    2 +-
> >  tests/generic/328     |    4 +-
> >  tests/generic/355     |    2 +-
> >  tests/generic/361     |    4 +-
> >  tests/generic/370     |   10 +-
> >  tests/generic/453     |    6 +-
> >  tests/generic/455     |    2 +-
> >  tests/generic/456     |    2 +-
> >  tests/generic/457     |    2 +-
> >  tests/generic/469     |    2 +-
> >  tests/generic/476     |    4 +-
> >  tests/generic/499     |    2 +-
> >  tests/generic/504     |   15 +-
> >  tests/generic/511     |    2 +-
> >  tests/generic/514     |    2 +-
> >  tests/generic/530     |    6 +-
> >  tests/generic/531     |    6 +-
> >  tests/generic/561     |    2 +-
> >  tests/generic/573     |    2 +-
> >  tests/generic/590     |    2 +-
> >  tests/generic/600     |    2 +-
> >  tests/generic/601     |    2 +-
> >  tests/generic/603     |   10 +-
> >  tests/generic/642     |    2 +-
> >  tests/generic/650     |    6 +-
> >  tests/generic/673     |    2 +-
> >  tests/generic/674     |    2 +-
> >  tests/generic/675     |    2 +-
> >  tests/generic/680     |    2 +-
> >  tests/generic/681     |    2 +-
> >  tests/generic/682     |    2 +-
> >  tests/generic/683     |    2 +-
> >  tests/generic/684     |    2 +-
> >  tests/generic/685     |    2 +-
> >  tests/generic/686     |    2 +-
> >  tests/generic/687     |    2 +-
> >  tests/generic/688     |    2 +-
> >  tests/generic/691     |    8 +-
> >  tests/generic/721     |   10 +-
> >  tests/generic/726     |    2 +-
> >  tests/generic/727     |    2 +-
> >  tests/generic/740     |    2 +-
> >  tests/generic/746     |    2 +-
> >  tests/generic/750     |    2 +-
> >  tests/generic/759     |    7 +-
> >  tests/generic/760     |    7 +-
> >  tests/xfs/149         |    2 +-
> >  tests/xfs/501         |    2 +-
> >  tests/xfs/502         |    2 +-
> >  tests/xfs/530         |    2 +-
> >  tests/xfs/720         |    2 +-
> >  tests/xfs/795         |    2 +-
> >  tests/xfs/803         |    2 +-
> >  tools/Makefile        |   21 +
> >  tools/run_privatens   |   28 +
> >  tools/run_setsid      |   22 +
> >  97 files changed, 596 insertions(+), 2890 deletions(-)
> > --
> > Zorro Lang
> > zlang@kernel.org


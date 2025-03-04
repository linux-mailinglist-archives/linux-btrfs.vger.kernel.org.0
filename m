Return-Path: <linux-btrfs+bounces-12003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E280A4ECDE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 20:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C38870AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF39F204875;
	Tue,  4 Mar 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPsBJsB2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E22E3379;
	Tue,  4 Mar 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113432; cv=none; b=XddfA2HgmYDi0/RNwEBxzSEtBunzv8pGKoUC4W8NBRbH4pxWNKGUovDU9HbkL7T26fJ4ASVWswX/vvYiv1DZgfFFmg1Nplp2O1q+HT9gdRYGAd+AEYIXD2QvyhbrgNlZAMlWuMtwZu7YtE2TCfwTVhc4RwNOh/jdZmBrxOfy91c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113432; c=relaxed/simple;
	bh=+0fLbiwpsa6C3pQ+E8rtIIb1QvXGRONf17vXAyXjKJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj1WjRSlq4jU6/cD8TQXlQT6VWHAbcNVUXVxwmvh7jGqkrP5QqkGRq9hO4DcFl6JsEbJZfDzOV9caYjAqfmsKsyWqDcPw3P8sGwDIsjI6pGerYk5PnD27ifIMCzjxmma0wuaWRhHfNew3VGLBLal6jeDQtRTX+C5VdJyPHCCjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPsBJsB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC4CC4CEE5;
	Tue,  4 Mar 2025 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741113431;
	bh=+0fLbiwpsa6C3pQ+E8rtIIb1QvXGRONf17vXAyXjKJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPsBJsB2HCVQ8D8wuuQM3E7IK4usr4y0XTpDiGSiV82CpLSp4eV+qflu7X8WK4Pof
	 ZwKT/GB3M0H2P0DazyQq9ePhjCow6peZ2QgBGtCA5u4U0DyZB7pqdKBHZJUw6DJNNf
	 Jy3rFqLlqsI5P76faVViePTaKsEHQOyVFDOn71huYN24XhERXqufbTLmfjuwp9qYuP
	 YMCAVHtxy2wyPFL8SON0x0sYoJUXn3C5WmMJF+ONdjAzsQq5/S1E4F7fujSYC2H3xN
	 lMy67ovcCjm0t7naJRnK/wCTH9hRWikRbUvpKvr4+Bs5kaFnQBdxmf/fI2XgKtP1ow
	 mJ00ufD1azmiQ==
Date: Tue, 4 Mar 2025 10:37:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Filipe Manana <fdmanana@kernel.org>, Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
Message-ID: <20250304183710.GD2803740@frogsfrogsfrogs>
References: <67bb1448.500a0220.af3ac.9928SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAL3q7H7ODnoeo3ac1pahD9NdujiGA=zoG79arAgrJVDUu9j7hg@mail.gmail.com>
 <20250301172250.g3whd6rsr5pantdc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250301172250.g3whd6rsr5pantdc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sun, Mar 02, 2025 at 01:22:50AM +0800, Zorro Lang wrote:
> On Thu, Feb 27, 2025 at 01:32:42PM +0000, Filipe Manana wrote:
> > On Sun, Feb 23, 2025 at 12:27 PM Zorro Lang <zlang@kernel.org> wrote:
> > >
> > > Hi all,
> > >
> > > The for-next branch of the xfstests repository at:
> > >
> > >         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> > > has just been updated and tagged as v2025.02.23 release.
> > >
> > > Release Notes:
> > > 1) There's not new test cases in this release, this's a release for bug fixes
> > >    particularly.
> > > 2) Reiserfs part is removed from fstests.
> > > 3) ltp/growfiles is removed too, I think no one needs it.
> > >
> > > I can't list all updates at here, more details please refer to below.
> > > Thanks for all these contributions!
> > >
> > > Thanks,
> > > Zorro
> > >
> > > The new head of the for-next branch is commit:
> > >
> > > 5b56a2d88819 fstests: remove reiserfs support
> > >
> > > New commits:
> > >
> > > Christoph Hellwig (1):
> > >       [04d0cf3f8909] generic/370: don't exclude XFS
> > >
> > > Darrick J. Wong (35):
> > >       [cc379f50f3bd] generic/476: fix fsstress process management
> > >       [ab459c67c5e0] metadump: make non-local function variables more obvious
> > >       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
> > >       [e68a92376165] generic/019: don't fail if fio crashes while shutting down
> > >       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
> > >       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_stack
> > >       [777732b27e62] common/dump: don't replace pids arbitrarily
> > >       [81f28acda2f2] common/populate: correct the parent pointer name creation formulae
> > >       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inclusion
> > >       [241c1c787e5b] generic/759,760: skip test if we can't set up a hugepage for IO
> > >       [77548e6066fd] common/rc: create a wrapper for the su command
> > >       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
> > >       [c71349150d34] common/rc: hoist pkill to a helper function
> > >       [91d2880aa029] tools: add a Makefile
> > >       [88d60f434bd9] common: fix pkill by running test program in a separate session
> > >       [247ab01fa227] check: run tests in a private pid/mount namespace
> > 
> > By the way, this commits breaks several btrfs test cases in the
> > read_repair group:
> > 
> > $ ./check -g read_repair
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> > SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> > 
> > btrfs/140 1s ... [failed, exit status 1]- output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad)
> >     --- tests/btrfs/140.out 2024-06-04 12:18:50.080308741 +0100
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad
> > 2025-02-27 13:27:56.050933812 +0000
> >     @@ -1,3 +1,5 @@
> >      QA output created by 140
> >      wrote 131072/131072 bytes
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >     +repair failed, csums don't match
> >     +(see /home/fdmanana/git/hub/xfstests/results//btrfs/140.full for details)
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/140.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad'  to see
> > the entire diff)
> > btrfs/141 1s ... [failed, exit status 1]- output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad)
> >     --- tests/btrfs/141.out 2024-06-04 12:18:50.084308982 +0100
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad
> > 2025-02-27 13:27:57.233352695 +0000
> >     @@ -1,3 +1,5 @@
> >      QA output created by 141
> >      wrote 131072/131072 bytes
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >     +repair failed, csums don't match
> >     +(see /home/fdmanana/git/hub/xfstests/results//btrfs/141.full for details)
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/141.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad'  to see
> > the entire diff)
> 
> Sorry I didn't hit this failure on my last release test:
>   ...
>   btrfs/140 1s ...  1s
>   btrfs/141 1s ...  1s
>   ...
> 
> But by running them more times, I reproduce it manually now. And I noticed
> that it won't be failed if disable HAVE_PRIVATENS. So your and David's bugs
> are all from the `./tools/run_privatens "./$seq"` part.
> 
> I think below failures are same. You can disable HAVE_PRIVATENS and test
> again. If everything goes well, or still something wrong, please tell me.
> 
> Hi Darrick, I think we're a bit hurry to promote the PRIVATENS way. I don't
> want to give you too much pressure to face the issue from "run_privatens".
> So how about just don't let it to be the "first-choice" to run ./$seq for now,
> as it's not stable :-D
> 
> (1)     if [ -n "${HAVE_PRIVATENS}" ]; then
> 		./tools/run_privatens "./$seq"
> 		...
> (2)     elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> 		...
>                 systemd-run --quiet --unit "${unit}" --scope \
>                         ./tools/run_setsid "./$seq" &
> 		...
> (3)     else
> 		./tools/run_setsid "./$seq" &
> 		...
>         fi
> 
> We have (2) and (3) for years (although they're changed a bit, but still works
> well). Let's keep old ways at first, give the new way (1) some time to test and
> improve. When other filesystems think it's good to use (1), then turn to it at
> that time. What do you think?

(Reiterating something we're discussing in irc now)

What if btrfs/140 (and everything else using the _btrfs*read_on_mirror
functions) called a "_require_non_privatens" function:

_require_non_privatens() {
	test "$FSTESTS_ISOL" == "privatens" && \
		_notrun "test requires global pid/mount namespace"
}

And then ./check can detect such tests via
"grep -q _require_non_privatens ./$seq" and pick run_setsid instead?

Note: I don't actually know how to detect that ./check itself is being
run in a private pid/mount namespace, but I think these tests are broken
there anyway.

--D

> Thanks,
> Zorro
> 
> > btrfs/142 1s ... - output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad)
> >     --- tests/btrfs/142.out 2020-06-10 19:29:03.818519162 +0100
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad
> > 2025-02-27 13:27:59.133249259 +0000
> >     @@ -1,37 +1,37 @@
> >      QA output created by 142
> >      wrote 131072/131072 bytes
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/142.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad'  to see
> > the entire diff)
> > btrfs/143 1s ... - output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad)
> >     --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad
> > 2025-02-27 13:28:00.989680223 +0000
> >     @@ -1,37 +1,37 @@
> >      QA output created by 143
> >      wrote 131072/131072 bytes
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/143.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad'  to see
> > the entire diff)
> > btrfs/150 1s ...  1s
> > btrfs/157 2s ...  1s
> > btrfs/215 1s ...  1s
> > btrfs/265 2s ... - output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
> >     --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
> > 2025-02-27 13:28:05.589305927 +0000
> >     @@ -5,71 +5,71 @@
> >      step 2......corrupt file extent
> >      step 3......repair the bad copy
> >      step 4......check if the repair worked
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
> > the entire diff)
> > btrfs/266 3s ...  2s
> > btrfs/267 2s ... - output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad)
> >     --- tests/btrfs/267.out 2023-03-02 21:47:53.876609426 +0000
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad
> > 2025-02-27 13:28:09.161394788 +0000
> >     @@ -73,37 +73,37 @@
> >      XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >      read 512/512 bytes
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/267.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad'  to see
> > the entire diff)
> > btrfs/268 3s ...  2s
> > btrfs/269 2s ...  1s
> > btrfs/270 1s ... - output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad)
> >     --- tests/btrfs/270.out 2023-03-02 21:47:53.876609426 +0000
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad
> > 2025-02-27 13:28:14.090153054 +0000
> >     @@ -5,3 +5,4099 @@
> >      step 2......corrupt file extent
> >      step 3......repair the bad copy
> >      step 4......check if the repair worked
> >     +   1 170 x    273 M-;
> >     +   2 136 ^    273 M-;
> >     +   3 354 M-l  273 M-;
> >     +   4 320 M-P  273 M-;
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/270.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad'  to see
> > the entire diff)
> > Ran: btrfs/140 btrfs/141 btrfs/142 btrfs/143 btrfs/150 btrfs/157
> > btrfs/215 btrfs/265 btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/270
> > Failures: btrfs/140 btrfs/141 btrfs/142 btrfs/143 btrfs/265 btrfs/267 btrfs/270
> > Failed 7 of 13 tests
> > 
> > The failures seems to be timing sensitive, as running a test
> > individually doesn't always fails, for example:
> > 
> > $ root 13:30:43 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> > SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> > 
> > btrfs/265 1s ...  2s
> > Ran: btrfs/265
> > Passed all 1 tests
> > 
> > root 13:30:46 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> > SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> > 
> > btrfs/265 2s ... - output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
> >     --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
> > 2025-02-27 13:30:49.386584060 +0000
> >     @@ -5,71 +5,71 @@
> >      step 2......corrupt file extent
> >      step 3......repair the bad copy
> >      step 4......check if the repair worked
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
> > the entire diff)
> > Ran: btrfs/265
> > Failures: btrfs/265
> > Failed 1 of 1 tests
> > 
> > root 13:30:49 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> > SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> > 
> > btrfs/265 2s ...  1s
> > Ran: btrfs/265
> > Passed all 1 tests
> > 
> > root 13:31:02 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
> > SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> > 
> > btrfs/265 1s ... - output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
> >     --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
> >     +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
> > 2025-02-27 13:31:05.522911416 +0000
> >     @@ -5,38 +5,38 @@
> >      step 2......corrupt file extent
> >      step 3......repair the bad copy
> >      step 4......check if the repair worked
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > ................
> >     ...
> >     (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
> > the entire diff)
> > Ran: btrfs/265
> > Failures: btrfs/265
> > Failed 1 of 1 tests
> > 
> > root 13:31:05 /home/fdmanana/git/hub/xfstests >
> > 
> > Bisection using 100 iterations reliably points to that commit.
> > 
> > Any ideas Darrick?
> > 
> > Thanks.
> > 
> > 
> > 
> > >       [949bdf8eae31] check: deprecate using process sessions to isolate test instances
> > >       [af0f1090e240] common/rc: don't copy fsstress to $TEST_DIR
> > >       [f43da58ef936] unmount: resume logging of stdout and stderr for filtering
> > >       [5dc27fd20f80] mkfs: don't hardcode log size
> > >       [dba402b7e3ae] common/rc: return mount_ret in _try_scratch_mount
> > >       [9505d04b8073] preamble: fix missing _kill_fsstress
> > >       [4d9aeeb79f9c] generic/650: revert SOAK DURATION changes
> > >       [1bb15a27573e] generic/032: fix pinned mount failure
> > >       [b816737426bf] fuzzy: stop __stress_scrub_fsx_loop if fsx fails
> > >       [040e74c89192] fuzzy: don't use readarray for xfsfind output
> > >       [0dfe1fac98d2] fuzzy: always stop the scrub fsstress loop on error
> > >       [336d73c96a96] fuzzy: port fsx and fsstress loop to use --duration
> > >       [96d29207c126] fix _require_scratch_duperemove ordering
> > >       [a8268531ca8b] fsstress: fix a memory leak
> > >       [e8e29e028faa] fsx: fix leaked log file pointer
> > >       [4a9e82863917] misc: don't put nr_cpus into the fsstress -n argument
> > >       [c475ff6ff6d7] common/config: add $here to FSSTRESS_PROG
> > >       [1c67e8b191fe] config: add FSX_PROG variable
> > >       [a553e7eba1cf] build: initialize stack variables to zero by default
> > >
> > > David Sterba (2):
> > >       [9049250b4042] fstests: remove ltp/growfiles
> > >       [5b56a2d88819] fstests: remove reiserfs support
> > >
> > > Filipe Manana (2):
> > >       [7122c0315a08] btrfs/254: don't leave mount on test fs in case of failure/interruption
> > >       [535b72a63a28] btrfs/254: fix test failure in case scratch devices are larger than 50G
> > >
> > > Jeff Layton (1):
> > >       [bd6e01c81e21] generic/126: run it inside its own subdirectory
> > >
> > >
> > > Code Diffstat:
> > >
> > >  .gitignore            |    1 -
> > >  Makefile              |    2 +-
> > >  check                 |   91 +-
> > >  common/config         |   12 +-
> > >  common/dump           |    1 -
> > >  common/fuzzy          |  104 +-
> > >  common/metadump       |   42 +-
> > >  common/populate       |   13 +-
> > >  common/preamble       |    2 +-
> > >  common/quota          |    6 +-
> > >  common/rc             |  146 ++-
> > >  common/reflink        |    2 +-
> > >  configure.ac          |    1 +
> > >  include/builddefs.in  |    3 +-
> > >  lib/tlibio.c          |    2 +-
> > >  ltp/Makefile          |    2 +-
> > >  ltp/fsstress.c        |    1 +
> > >  ltp/fsx.c             |    8 +-
> > >  ltp/growfiles.c       | 2607 -------------------------------------------------
> > >  m4/package_libcdev.m4 |   14 +
> > >  src/nsexec.c          |   18 +-
> > >  src/xfsfind.c         |   14 +-
> > >  tests/btrfs/254       |    8 +-
> > >  tests/generic/019     |    2 +-
> > >  tests/generic/032     |    9 +
> > >  tests/generic/050     |    2 +-
> > >  tests/generic/075     |    2 +-
> > >  tests/generic/085     |    2 +-
> > >  tests/generic/093     |    2 +-
> > >  tests/generic/112     |    2 +-
> > >  tests/generic/125     |    2 +-
> > >  tests/generic/126     |   17 +-
> > >  tests/generic/127     |   16 +-
> > >  tests/generic/128     |    2 +-
> > >  tests/generic/193     |   36 +-
> > >  tests/generic/230     |   14 +-
> > >  tests/generic/231     |    4 +-
> > >  tests/generic/233     |    2 +-
> > >  tests/generic/270     |   12 +-
> > >  tests/generic/310     |    6 +-
> > >  tests/generic/314     |    2 +-
> > >  tests/generic/327     |    2 +-
> > >  tests/generic/328     |    4 +-
> > >  tests/generic/355     |    2 +-
> > >  tests/generic/361     |    4 +-
> > >  tests/generic/370     |   10 +-
> > >  tests/generic/453     |    6 +-
> > >  tests/generic/455     |    2 +-
> > >  tests/generic/456     |    2 +-
> > >  tests/generic/457     |    2 +-
> > >  tests/generic/469     |    2 +-
> > >  tests/generic/476     |    4 +-
> > >  tests/generic/499     |    2 +-
> > >  tests/generic/504     |   15 +-
> > >  tests/generic/511     |    2 +-
> > >  tests/generic/514     |    2 +-
> > >  tests/generic/530     |    6 +-
> > >  tests/generic/531     |    6 +-
> > >  tests/generic/561     |    2 +-
> > >  tests/generic/573     |    2 +-
> > >  tests/generic/590     |    2 +-
> > >  tests/generic/600     |    2 +-
> > >  tests/generic/601     |    2 +-
> > >  tests/generic/603     |   10 +-
> > >  tests/generic/642     |    2 +-
> > >  tests/generic/650     |    6 +-
> > >  tests/generic/673     |    2 +-
> > >  tests/generic/674     |    2 +-
> > >  tests/generic/675     |    2 +-
> > >  tests/generic/680     |    2 +-
> > >  tests/generic/681     |    2 +-
> > >  tests/generic/682     |    2 +-
> > >  tests/generic/683     |    2 +-
> > >  tests/generic/684     |    2 +-
> > >  tests/generic/685     |    2 +-
> > >  tests/generic/686     |    2 +-
> > >  tests/generic/687     |    2 +-
> > >  tests/generic/688     |    2 +-
> > >  tests/generic/691     |    8 +-
> > >  tests/generic/721     |   10 +-
> > >  tests/generic/726     |    2 +-
> > >  tests/generic/727     |    2 +-
> > >  tests/generic/740     |    2 +-
> > >  tests/generic/746     |    2 +-
> > >  tests/generic/750     |    2 +-
> > >  tests/generic/759     |    7 +-
> > >  tests/generic/760     |    7 +-
> > >  tests/xfs/149         |    2 +-
> > >  tests/xfs/501         |    2 +-
> > >  tests/xfs/502         |    2 +-
> > >  tests/xfs/530         |    2 +-
> > >  tests/xfs/720         |    2 +-
> > >  tests/xfs/795         |    2 +-
> > >  tests/xfs/803         |    2 +-
> > >  tools/Makefile        |   21 +
> > >  tools/run_privatens   |   28 +
> > >  tools/run_setsid      |   22 +
> > >  97 files changed, 596 insertions(+), 2890 deletions(-)
> > > --
> > > Zorro Lang
> > > zlang@kernel.org
> > 
> 
> 


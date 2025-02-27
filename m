Return-Path: <linux-btrfs+bounces-11908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F69A47F57
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C18A175C85
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828E2309AF;
	Thu, 27 Feb 2025 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbkPdpEM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F322D7A0;
	Thu, 27 Feb 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663202; cv=none; b=e570kL1j+MXN/c1T3xHf6VUGmcyYbg4BC7YPchth1WPPPMLBwC80ikwxQ+jzvTCiefoupc9nKBzNOPNZkp63GKYLzz61x93ESCsorrEa/NGuwprl6bKrdn3zPkOyVHCaEhJBg0znYvm7KFx7J944I/3dzlmAVoU7lD0vvNKRQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663202; c=relaxed/simple;
	bh=g338U78XWD8uZgI7OREQscdXvhfhMAW5zJwEz5dYWh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkOLmO2OfcanbQD3RdI3aLcrpmEfA2r39fxXmdBhplp8cUB/4tHZMNPRoYQmYkKV5wBNZ4OTdQCg462MsMggRfxb/9aijoQFqEjgSQGhiv1bfuCzlZ2GglfVjzisj2p8/j1TLFI552A8ga0RwRdL+lvSocPFYCoiJEetfxIlu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbkPdpEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A37CC4CEDD;
	Thu, 27 Feb 2025 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740663202;
	bh=g338U78XWD8uZgI7OREQscdXvhfhMAW5zJwEz5dYWh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dbkPdpEMMZ7tKKAfSzW/aavL3JojZJZ9BTltYbop2XhTrOjOZ8GnnQOUEcV6OahuT
	 xgGNM17W8VUnETsrhFYOrXmE29OgFZjf1q09OjbCtqm27Doud8LyoLaNEctrQQMfEe
	 AxmCkVypQzF7AHwkOi//JN5QDvY2wUu04LsvjkkyRAe4H9iovZksh5tOJSTvorlj0A
	 IozqTK0W3z+h8a1QyZYpa92hwtxSB8GnQxyTLE4moi88Q3pq9bfgSOCPHDqUb+V3iD
	 6ObJYp2/iSaOGFF31JkdjrBU3RW2HmkcNwRBrIinrR6LwSDHOKO0Q+wluVudH5xRdQ
	 9ObouydtMgqww==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso1329193a12.3;
        Thu, 27 Feb 2025 05:33:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZQJTlXzoN3QtqHxh9CNMizBOlzY5lVzzs563i4LcLLZ+b8eEVJTU1J4GUrrfsiASNR8uy8gxolFCklA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+FzyU6arr+h/n547QSMiyL5R2K7CUmykwx1HcVBqze+JrezI3
	qxqgwmq/918s2ne27Rp2aFbCqnTocRoZWTuURdHBKJEY4sdfZ6ve+IYxi+jpaXLrti10XY0hYhB
	vP7nP/kyu+ZduTxfDg3qi37cRtAc=
X-Google-Smtp-Source: AGHT+IGxLyXStBVi1HfLqCuAnDwT8ycq6NicJCyV63KdcFewrb5wR5NMKLcK36z7bzLtmrzCAotMVw3YeqTqr5MOZmM=
X-Received: by 2002:a17:906:30c4:b0:aba:519b:f7c5 with SMTP id
 a640c23a62f3a-abed0c5d9eemr1283937166b.4.1740663200471; Thu, 27 Feb 2025
 05:33:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67bb1448.500a0220.af3ac.9928SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <67bb1448.500a0220.af3ac.9928SMTPIN_ADDED_BROKEN@mx.google.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Feb 2025 13:32:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ODnoeo3ac1pahD9NdujiGA=zoG79arAgrJVDUu9j7hg@mail.gmail.com>
X-Gm-Features: AQ5f1Jp9-hjZy1XF31YHNK1PnNNkA6SleLeAQrDopMpA9TCR0-0QyDmPauyWGHA
Message-ID: <CAL3q7H7ODnoeo3ac1pahD9NdujiGA=zoG79arAgrJVDUu9j7hg@mail.gmail.com>
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2025.02.23
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 12:27=E2=80=AFPM Zorro Lang <zlang@kernel.org> wrot=
e:
>
> Hi all,
>
> The for-next branch of the xfstests repository at:
>
>         git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
> has just been updated and tagged as v2025.02.23 release.
>
> Release Notes:
> 1) There's not new test cases in this release, this's a release for bug f=
ixes
>    particularly.
> 2) Reiserfs part is removed from fstests.
> 3) ltp/growfiles is removed too, I think no one needs it.
>
> I can't list all updates at here, more details please refer to below.
> Thanks for all these contributions!
>
> Thanks,
> Zorro
>
> The new head of the for-next branch is commit:
>
> 5b56a2d88819 fstests: remove reiserfs support
>
> New commits:
>
> Christoph Hellwig (1):
>       [04d0cf3f8909] generic/370: don't exclude XFS
>
> Darrick J. Wong (35):
>       [cc379f50f3bd] generic/476: fix fsstress process management
>       [ab459c67c5e0] metadump: make non-local function variables more obv=
ious
>       [f428edcec2a2] metadump: fix cleanup for v1 metadump testing
>       [e68a92376165] generic/019: don't fail if fio crashes while shuttin=
g down
>       [48a3731b50ba] fuzzy: do not set _FSSTRESS_PID when exercising fsx
>       [543795bf67f2] common/rc: revert recursive unmount in _clear_mount_=
stack
>       [777732b27e62] common/dump: don't replace pids arbitrarily
>       [81f28acda2f2] common/populate: correct the parent pointer name cre=
ation formulae
>       [9b177d92dc65] generic/759,760: fix MADV_COLLAPSE detection and inc=
lusion
>       [241c1c787e5b] generic/759,760: skip test if we can't set up a huge=
page for IO
>       [77548e6066fd] common/rc: create a wrapper for the su command
>       [ac2d48f81094] fuzzy: kill subprocesses with SIGPIPE, not SIGINT
>       [c71349150d34] common/rc: hoist pkill to a helper function
>       [91d2880aa029] tools: add a Makefile
>       [88d60f434bd9] common: fix pkill by running test program in a separ=
ate session
>       [247ab01fa227] check: run tests in a private pid/mount namespace

By the way, this commits breaks several btrfs test cases in the
read_repair group:

$ ./check -g read_repair
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/140 1s ... [failed, exit status 1]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad)
    --- tests/btrfs/140.out 2024-06-04 12:18:50.080308741 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad
2025-02-27 13:27:56.050933812 +0000
    @@ -1,3 +1,5 @@
     QA output created by 140
     wrote 131072/131072 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    +repair failed, csums don't match
    +(see /home/fdmanana/git/hub/xfstests/results//btrfs/140.full for detai=
ls)
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/140.out
/home/fdmanana/git/hub/xfstests/results//btrfs/140.out.bad'  to see
the entire diff)
btrfs/141 1s ... [failed, exit status 1]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad)
    --- tests/btrfs/141.out 2024-06-04 12:18:50.084308982 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad
2025-02-27 13:27:57.233352695 +0000
    @@ -1,3 +1,5 @@
     QA output created by 141
     wrote 131072/131072 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    +repair failed, csums don't match
    +(see /home/fdmanana/git/hub/xfstests/results//btrfs/141.full for detai=
ls)
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/141.out
/home/fdmanana/git/hub/xfstests/results//btrfs/141.out.bad'  to see
the entire diff)
btrfs/142 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad)
    --- tests/btrfs/142.out 2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad
2025-02-27 13:27:59.133249259 +0000
    @@ -1,37 +1,37 @@
     QA output created by 142
     wrote 131072/131072 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/142.out
/home/fdmanana/git/hub/xfstests/results//btrfs/142.out.bad'  to see
the entire diff)
btrfs/143 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad)
    --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad
2025-02-27 13:28:00.989680223 +0000
    @@ -1,37 +1,37 @@
     QA output created by 143
     wrote 131072/131072 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/143.out
/home/fdmanana/git/hub/xfstests/results//btrfs/143.out.bad'  to see
the entire diff)
btrfs/150 1s ...  1s
btrfs/157 2s ...  1s
btrfs/215 1s ...  1s
btrfs/265 2s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
    --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
2025-02-27 13:28:05.589305927 +0000
    @@ -5,71 +5,71 @@
     step 2......corrupt file extent
     step 3......repair the bad copy
     step 4......check if the repair worked
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
/home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
the entire diff)
btrfs/266 3s ...  2s
btrfs/267 2s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad)
    --- tests/btrfs/267.out 2023-03-02 21:47:53.876609426 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad
2025-02-27 13:28:09.161394788 +0000
    @@ -73,37 +73,37 @@
     XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
     read 512/512 bytes
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/267.out
/home/fdmanana/git/hub/xfstests/results//btrfs/267.out.bad'  to see
the entire diff)
btrfs/268 3s ...  2s
btrfs/269 2s ...  1s
btrfs/270 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad)
    --- tests/btrfs/270.out 2023-03-02 21:47:53.876609426 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad
2025-02-27 13:28:14.090153054 +0000
    @@ -5,3 +5,4099 @@
     step 2......corrupt file extent
     step 3......repair the bad copy
     step 4......check if the repair worked
    +   1 170 x    273 M-;
    +   2 136 ^    273 M-;
    +   3 354 M-l  273 M-;
    +   4 320 M-P  273 M-;
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/270.out
/home/fdmanana/git/hub/xfstests/results//btrfs/270.out.bad'  to see
the entire diff)
Ran: btrfs/140 btrfs/141 btrfs/142 btrfs/143 btrfs/150 btrfs/157
btrfs/215 btrfs/265 btrfs/266 btrfs/267 btrfs/268 btrfs/269 btrfs/270
Failures: btrfs/140 btrfs/141 btrfs/142 btrfs/143 btrfs/265 btrfs/267 btrfs=
/270
Failed 7 of 13 tests

The failures seems to be timing sensitive, as running a test
individually doesn't always fails, for example:

$ root 13:30:43 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/265 1s ...  2s
Ran: btrfs/265
Passed all 1 tests

root 13:30:46 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/265 2s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
    --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
2025-02-27 13:30:49.386584060 +0000
    @@ -5,71 +5,71 @@
     step 2......corrupt file extent
     step 3......repair the bad copy
     step 4......check if the repair worked
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
/home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
the entire diff)
Ran: btrfs/265
Failures: btrfs/265
Failed 1 of 1 tests

root 13:30:49 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/265 2s ...  1s
Ran: btrfs/265
Passed all 1 tests

root 13:31:02 /home/fdmanana/git/hub/xfstests > ./check btrfs/265
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1
SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/265 1s ... - output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad)
    --- tests/btrfs/265.out 2023-03-02 21:47:53.876609426 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad
2025-02-27 13:31:05.522911416 +0000
    @@ -5,38 +5,38 @@
     step 2......corrupt file extent
     step 3......repair the bad copy
     step 4......check if the repair worked
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
................
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/265.out
/home/fdmanana/git/hub/xfstests/results//btrfs/265.out.bad'  to see
the entire diff)
Ran: btrfs/265
Failures: btrfs/265
Failed 1 of 1 tests

root 13:31:05 /home/fdmanana/git/hub/xfstests >

Bisection using 100 iterations reliably points to that commit.

Any ideas Darrick?

Thanks.



>       [949bdf8eae31] check: deprecate using process sessions to isolate t=
est instances
>       [af0f1090e240] common/rc: don't copy fsstress to $TEST_DIR
>       [f43da58ef936] unmount: resume logging of stdout and stderr for fil=
tering
>       [5dc27fd20f80] mkfs: don't hardcode log size
>       [dba402b7e3ae] common/rc: return mount_ret in _try_scratch_mount
>       [9505d04b8073] preamble: fix missing _kill_fsstress
>       [4d9aeeb79f9c] generic/650: revert SOAK DURATION changes
>       [1bb15a27573e] generic/032: fix pinned mount failure
>       [b816737426bf] fuzzy: stop __stress_scrub_fsx_loop if fsx fails
>       [040e74c89192] fuzzy: don't use readarray for xfsfind output
>       [0dfe1fac98d2] fuzzy: always stop the scrub fsstress loop on error
>       [336d73c96a96] fuzzy: port fsx and fsstress loop to use --duration
>       [96d29207c126] fix _require_scratch_duperemove ordering
>       [a8268531ca8b] fsstress: fix a memory leak
>       [e8e29e028faa] fsx: fix leaked log file pointer
>       [4a9e82863917] misc: don't put nr_cpus into the fsstress -n argumen=
t
>       [c475ff6ff6d7] common/config: add $here to FSSTRESS_PROG
>       [1c67e8b191fe] config: add FSX_PROG variable
>       [a553e7eba1cf] build: initialize stack variables to zero by default
>
> David Sterba (2):
>       [9049250b4042] fstests: remove ltp/growfiles
>       [5b56a2d88819] fstests: remove reiserfs support
>
> Filipe Manana (2):
>       [7122c0315a08] btrfs/254: don't leave mount on test fs in case of f=
ailure/interruption
>       [535b72a63a28] btrfs/254: fix test failure in case scratch devices =
are larger than 50G
>
> Jeff Layton (1):
>       [bd6e01c81e21] generic/126: run it inside its own subdirectory
>
>
> Code Diffstat:
>
>  .gitignore            |    1 -
>  Makefile              |    2 +-
>  check                 |   91 +-
>  common/config         |   12 +-
>  common/dump           |    1 -
>  common/fuzzy          |  104 +-
>  common/metadump       |   42 +-
>  common/populate       |   13 +-
>  common/preamble       |    2 +-
>  common/quota          |    6 +-
>  common/rc             |  146 ++-
>  common/reflink        |    2 +-
>  configure.ac          |    1 +
>  include/builddefs.in  |    3 +-
>  lib/tlibio.c          |    2 +-
>  ltp/Makefile          |    2 +-
>  ltp/fsstress.c        |    1 +
>  ltp/fsx.c             |    8 +-
>  ltp/growfiles.c       | 2607 -------------------------------------------=
------
>  m4/package_libcdev.m4 |   14 +
>  src/nsexec.c          |   18 +-
>  src/xfsfind.c         |   14 +-
>  tests/btrfs/254       |    8 +-
>  tests/generic/019     |    2 +-
>  tests/generic/032     |    9 +
>  tests/generic/050     |    2 +-
>  tests/generic/075     |    2 +-
>  tests/generic/085     |    2 +-
>  tests/generic/093     |    2 +-
>  tests/generic/112     |    2 +-
>  tests/generic/125     |    2 +-
>  tests/generic/126     |   17 +-
>  tests/generic/127     |   16 +-
>  tests/generic/128     |    2 +-
>  tests/generic/193     |   36 +-
>  tests/generic/230     |   14 +-
>  tests/generic/231     |    4 +-
>  tests/generic/233     |    2 +-
>  tests/generic/270     |   12 +-
>  tests/generic/310     |    6 +-
>  tests/generic/314     |    2 +-
>  tests/generic/327     |    2 +-
>  tests/generic/328     |    4 +-
>  tests/generic/355     |    2 +-
>  tests/generic/361     |    4 +-
>  tests/generic/370     |   10 +-
>  tests/generic/453     |    6 +-
>  tests/generic/455     |    2 +-
>  tests/generic/456     |    2 +-
>  tests/generic/457     |    2 +-
>  tests/generic/469     |    2 +-
>  tests/generic/476     |    4 +-
>  tests/generic/499     |    2 +-
>  tests/generic/504     |   15 +-
>  tests/generic/511     |    2 +-
>  tests/generic/514     |    2 +-
>  tests/generic/530     |    6 +-
>  tests/generic/531     |    6 +-
>  tests/generic/561     |    2 +-
>  tests/generic/573     |    2 +-
>  tests/generic/590     |    2 +-
>  tests/generic/600     |    2 +-
>  tests/generic/601     |    2 +-
>  tests/generic/603     |   10 +-
>  tests/generic/642     |    2 +-
>  tests/generic/650     |    6 +-
>  tests/generic/673     |    2 +-
>  tests/generic/674     |    2 +-
>  tests/generic/675     |    2 +-
>  tests/generic/680     |    2 +-
>  tests/generic/681     |    2 +-
>  tests/generic/682     |    2 +-
>  tests/generic/683     |    2 +-
>  tests/generic/684     |    2 +-
>  tests/generic/685     |    2 +-
>  tests/generic/686     |    2 +-
>  tests/generic/687     |    2 +-
>  tests/generic/688     |    2 +-
>  tests/generic/691     |    8 +-
>  tests/generic/721     |   10 +-
>  tests/generic/726     |    2 +-
>  tests/generic/727     |    2 +-
>  tests/generic/740     |    2 +-
>  tests/generic/746     |    2 +-
>  tests/generic/750     |    2 +-
>  tests/generic/759     |    7 +-
>  tests/generic/760     |    7 +-
>  tests/xfs/149         |    2 +-
>  tests/xfs/501         |    2 +-
>  tests/xfs/502         |    2 +-
>  tests/xfs/530         |    2 +-
>  tests/xfs/720         |    2 +-
>  tests/xfs/795         |    2 +-
>  tests/xfs/803         |    2 +-
>  tools/Makefile        |   21 +
>  tools/run_privatens   |   28 +
>  tools/run_setsid      |   22 +
>  97 files changed, 596 insertions(+), 2890 deletions(-)
> --
> Zorro Lang
> zlang@kernel.org


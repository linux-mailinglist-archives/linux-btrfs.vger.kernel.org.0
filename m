Return-Path: <linux-btrfs+bounces-18339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9EC0A52A
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 10:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E218A17EB
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 09:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2B2882A6;
	Sun, 26 Oct 2025 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx08Zy+s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B222212572
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761469494; cv=none; b=OCOQDAP/hN9jtvCX02OYfYYgP1H7+UePhQbjhzncfxsNmpVh1RlfR5l3n6Lhv0ROHU7gZgib6NUH+zIkLDRIrHidreoHfMclXTzog7Ndd8nXgvH0ByWfI/mN3NGpZAHQvT9wCGz5aizDUe7Xl5nU+goWS1SmyJzexM+HVQf6+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761469494; c=relaxed/simple;
	bh=QkIpeed90JvRYD+LlXhb38rcDeUYh6JyO/y80SENDbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciWobg6/l91//IssHXVougj+zpFPA2bEVDR3+DgYQFRByhnOiFP5vFdjtCvRIibjLgViOB8+4pZ2JAc+nBmaxi8EwyFT7oNJBMhjtMbJpRhHzIof3Mfc8lTBGFehqce6xPc1zATGU74sUqNApPx+xoT4T0Q1VppjE/VET9sBG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx08Zy+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD059C116B1
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761469493;
	bh=QkIpeed90JvRYD+LlXhb38rcDeUYh6JyO/y80SENDbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jx08Zy+srhwWrsVRy4kMP3wZwFApw4x9qH6OcYGssUych/go1Bc4KDj7saFLjPcS0
	 PhFZQuKZ45hzITx9sWjcQO4+8+z5HgiP0lTv3QKZLbeFfSlkugJZedyDibPC2el8wi
	 KAi2WLv3bVHrDjYKoqJzJBKH0Y+lazdKnxHIthQ5YUbbeFUAxvcm07m0YR64e5/k4v
	 EoHxW5XpO3hY7B9sCzGX75oDpSYcAiw1yzTSbDrF8pR1QLY9steamhNvrh/BrvHxCt
	 jHsKxPPp2ZyuGczSWlpKj+JSOHB91QxHciJXz7bqUfz2GdzmMf8eFUkacnout71XQs
	 vAPqIyImU/3gg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d83bf1077so290374366b.3
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 02:04:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFl1dfPxV+BqSMV4uLV0sJO1vpkCUkMTsdgzQpz3ChG+1b2wvlITFG3e3u1T5RFtTCQPAL0u98MHHO0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7G3y4PVZykQMkujP/kQAXCwIV4oUN5vBwBErCA8l796KZKj6
	2OM+XrNfWuUf0DTc12NFbV5ynHia9oKOuG5YXM21fWvFNuHWjqBhZhsKZxUzqa/m3USI0pmTWzA
	e+ghdBT413jsZLbzZ7HHdu0KMOB7Oh+g=
X-Google-Smtp-Source: AGHT+IGyEHSDzuVGDFODZvjJvjOd8qAfNqDU3rNiaxcu5N0duCid5VIUNaadnBu/k4DYtY8GVk8WHPe1hHl7tVTMbTY=
X-Received: by 2002:a17:907:728d:b0:b49:b3ca:52b4 with SMTP id
 a640c23a62f3a-b6471f3bdfemr4160600466b.23.1761469492223; Sun, 26 Oct 2025
 02:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com>
 <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com> <d039a3c8-c4f7-487c-a848-2a26ea26f77d@gmail.com>
In-Reply-To: <d039a3c8-c4f7-487c-a848-2a26ea26f77d@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 26 Oct 2025 09:04:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ewZROWz0384L_pLvqWrjNK8mX=-kQb26ZDmpAbBUQ4A@mail.gmail.com>
X-Gm-Features: AWmQ_bk0FrP1t6tmpr-sfxZeFRrPyaKvBAwfIsWmpf3rbbKI-FzXZTkveawBXw0
Message-ID: <CAL3q7H5ewZROWz0384L_pLvqWrjNK8mX=-kQb26ZDmpAbBUQ4A@mail.gmail.com>
Subject: Re: Directory is not persisted after writing to the file within
 directory if system crashes
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 10:49=E2=80=AFAM Vyacheslav Kovalevsky
<slava.kovalevskiy.2014@gmail.com> wrote:
>
> On 24/10/2025 19:17, Filipe Manana wrote:
> > I converted that to a test case for fstests and couldn't reproduce,
> > "dir", "file1" and "dir/file2" exist after the power failure.
> >
> > The conversion for fstests:
> >
> > #! /bin/bash
> > # SPDX-License-Identifier: GPL-2.0
> > # Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> > #
> > # FS QA Test 780
> > #
> > # what am I here for?
> > #
> > . ./common/preamble
> > _begin_fstest auto quick log
> >
> > _cleanup()
> > {
> > _cleanup_flakey
> > cd /
> > rm -r -f $tmp.*
> > }
> >
> > . ./common/filter
> > . ./common/dmflakey
> >
> > _require_scratch
> > _require_dm_target flakey
> >
> > rm -f $seqres.full
> > On 24/10/2025 19:17, Filipe Manana wrote:
> > _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > _require_metadata_journaling $SCRATCH_DEV
> > _init_flakey
> > _mount_flakey
> >
> > touch $SCRATCH_MNT/file1
> >
> > _scratch_sync
> >
> > mkdir $SCRATCH_MNT/dir
> > echo -n "hello world" > $SCRATCH_MNT/file1
> > ln $SCRATCH_MNT/file1 $SCRATCH_MNT/dir/file2
> >
> > $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
> >
> > # Simulate a power failure and then mount again the filesystem to repla=
y the
> > # journal/log.
> > _flakey_drop_and_remount
> >
> > ls -R $SCRATCH_MNT/ | _filter_scratch
> >
> > _unmount_flakey
> >
> > # success, all done
> > _exit 0
>
> I think the line with `echo` may not be the correct translation:
>  > echo -n "hello world" > $SCRATCH_MNT/file1

An echo is just a write...

>
> In the original test, the file was opened with `O_SYNC` flag, if you
> remove it, the directory will be there when the system crashes. I also
> forgot to close the file after the `creat` call in the original test,
> may be important as well.

An O_SYNC, which is what I missed before, is essentially just an
implicit fsync after every write on a file.
Adding an fsync after the echo:

$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/file1

Triggers the problem of "dir" not being persisted.

>
> The test itself is quite weird (why would `dir` be gone after seemingly
> unrelated operation?), any detail can matter.

"dir" should be persisted as well as "dir/file2", according to the
SOMC (Strictly Ordered Metadata Consistency) that Dave Chinner
discussed many times in the past in fstests and btrfs mailing lists.

You should also reach the xfs mailing list and mention that
"dir/file2" is not persisted.

>
> Please run the original test with a real system crash. I will also
> double check everything on my side.

I've said before in another thread: we don't need to trigger qemu
crashes in order to test fsync.
Just use the dm flakey target with fstests - no need to do reboots,
much more practical and way less time consuming.
In 12 years of fixing fsync stuff on btrfs, I haven't yet seen any
case where dm flakey didn't do the job of reproducing issues.

>


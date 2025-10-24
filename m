Return-Path: <linux-btrfs+bounces-18293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9855C07413
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277651C049E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83427510B;
	Fri, 24 Oct 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMiUY52p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3833375A4
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322675; cv=none; b=hJ9r3qJkH53dH8D0O1ByJGndNlPEMtbIlVl6lnBaQk6wdPQMnTsfKGWDa8O1cNjNkbPEsiQtISMhBqMPM5EL3O6lvluy1W05bU1NOXW5AZ2UN+6rT/DJiYkVAmds8FhpFWIRVRtqrGxI8JGLE9qbCd7nSzm8GAD1aNdtPHsGMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322675; c=relaxed/simple;
	bh=hmzTcE1IA4fVEgDm0CipvNce/HMctP5mLgaqdB0PL88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXfBk/3JFGorT/AXD1ZItNEqxFbcVhGG6ddHqZZwUeR3IWdYte8KmSHLC669cZin0N+oeKZ6iFAgThxK42pnpsPUl02gyLGrwsdUpdWmCAJFYVm6ap8C/mLUNfELF6U4kfX6NTcad78m5i+2Er/bd+zgUPsW6bLB96Jm5ICWgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMiUY52p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDFBC116D0
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761322674;
	bh=hmzTcE1IA4fVEgDm0CipvNce/HMctP5mLgaqdB0PL88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JMiUY52ppfwRbdkFrAfDO2qFjQ0RzocJiw9Xa/wZQOQTZyvXhogsUhDeNPvTlV60P
	 D6izRD247whxMz1aZuvHwaqr+pWge8qjMIuO3G+iAEmBsFV9AM0bb7a21MzSBRkdEM
	 RXiczpInbhBDJUP7xOGErT1vtYnD1Sn6fWZET3YgJEOoQSwcDLcEa6ERAYXMWjVNBm
	 XKGL+lO31ODbgOpu35de92k7BIDcch70+1lkaYSYPaJY3GqYISWRec+Ly8FwmMjRIs
	 oFSopB2brhwQLs07FKwgQNirBZULd8SPP3+EZtV7Lp8y0IR90VWSOLY2NnSZUKB91Y
	 9RUKvZkKoBJxw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso110972266b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 09:17:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2B9zfYXXLM7JQrXp/S14ivJPIql8L2rXZmuHNNiaRJcHq1/rWYUyd4rvZ9mXAGvqxQ7vTqNnB5ZiNAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXWrv4a/yOxvaC+5bN/fIwWPp37RiHWRZiZ0oy20zG4wAKRlP
	ZBD+Vm7q4dG9E5D4GhRLZWfa/cnXOkRnQfb86q2KS4WKIMb/GgZDZKQqtJ3SyV05SWpziJDpfg/
	IgvHIsLSiXEqLiaeg4J+euF9JTdJN1U8=
X-Google-Smtp-Source: AGHT+IHtGtdBAyqo6hvgp+5zOxw426G1RR3UtlU8/Ca2eMeBcA4tGeFXKYnpf7Kaq97j2gu52L1+dhXCMCeBw2yIJPc=
X-Received: by 2002:a17:907:6ea9:b0:b6d:606f:2aa9 with SMTP id
 a640c23a62f3a-b6d606f3a5emr519118766b.65.1761322673142; Fri, 24 Oct 2025
 09:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com>
In-Reply-To: <03c5d7ec-5b3d-49d1-95bc-8970a7f82d87@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 17:17:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com>
X-Gm-Features: AS18NWCU00h722LQDTBmrGYiuo-ctgjdMx3DwmnZZwAsTeoabf-PwA6L4C99fbY
Message-ID: <CAL3q7H5ggWXdptoGH9Bmk-hc2CMBLz-YmC1A8U-hx9q=ZZ0BHw@mail.gmail.com>
Subject: Re: Directory is not persisted after writing to the file within
 directory if system crashes
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 4:21=E2=80=AFPM Vyacheslav Kovalevsky
<slava.kovalevskiy.2014@gmail.com> wrote:
>
> Under some circumstances, directory entry is not persisted after writing
> to the file inside the directory that was opened with `O_SYNC` flag if
> system crashes.
>
>
> Detailed description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hello, we have found another issue with btrfs crash behavior.
>
> In short, empty file is created and synced. Then, a new directory is
> created, old file is opened with `O_SYNC` flag and some data is written.
> After this, a new hard link is created inside the directory and the root
> is `fsync`ed (directory should persist). However, after a crash, the
> directory entry is missing even though data written to the old file was
> persisted.
>
>
> System info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Linux version 6.18.0-rc2, also tested on 6.14.11.
>
>
> How to reproduce
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ```
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> int main() {
> int status;
> int file_fd;
> int root_fd;
>
> status =3D creat("file1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
> printf("CREAT: %d\n", status);
>
> // persist `file1`
> sync();
>
> status =3D mkdir("dir", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
> printf("MKDIR: %d\n", status);
>
> status =3D open("file1", O_WRONLY | O_SYNC);
> printf("OPEN: %d\n", status);
> file_fd =3D status;
>
> status =3D write(file_fd, "Test data!", 10);
> printf("WRITE: %d\n", status);
>
> status =3D link("file1", "dir/file2");
> printf("LINK: %d\n", status);
>
> status =3D open(".", O_RDONLY | O_DIRECTORY);
> printf("OPEN: %d\n", status);
> root_fd =3D status;
>
> // persist `dir`
> status =3D fsync(root_fd);
> printf("FSYNC: %d\n", status);
> }
> ```
>
> Steps:
>
> 1. Create and mount new btrfs file system in default configuration.
> 2. Change directory to root of the file system and run the compiled test.
> 3. Cause hard system crash (e.g. QEMU `system_reset` command).
> 4. Remount file system after crash.
> 5. Observe that `dir` directory is missing.

I converted that to a test case for fstests and couldn't reproduce,
"dir", "file1" and "dir/file2" exist after the power failure.

The conversion for fstests:

#! /bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
#
# FS QA Test 780
#
# what am I here for?
#
. ./common/preamble
_begin_fstest auto quick log

_cleanup()
{
_cleanup_flakey
cd /
rm -r -f $tmp.*
}

. ./common/filter
. ./common/dmflakey

_require_scratch
_require_dm_target flakey

rm -f $seqres.full

_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
_require_metadata_journaling $SCRATCH_DEV
_init_flakey
_mount_flakey

touch $SCRATCH_MNT/file1

_scratch_sync

mkdir $SCRATCH_MNT/dir
echo -n "hello world" > $SCRATCH_MNT/file1
ln $SCRATCH_MNT/file1 $SCRATCH_MNT/dir/file2

$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/

# Simulate a power failure and then mount again the filesystem to replay th=
e
# journal/log.
_flakey_drop_and_remount

ls -R $SCRATCH_MNT/ | _filter_scratch

_unmount_flakey

# success, all done
_exit 0




>
> Notes:
>
> - ext4 does persist `dir` and `dir/file2` even though it was not synced.
> - xfs does persist `dir` but does not persist `dir/file2`.
>
>
> P.S. Want to apologize for formatting in previous report, first time
> using Thunderbird and plain text.
>
>
>
>


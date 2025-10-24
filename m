Return-Path: <linux-btrfs+bounces-18285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D382C06270
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD28B3BC766
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E063093AA;
	Fri, 24 Oct 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8zxROpB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471A306B12
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307189; cv=none; b=Vydm+UnyeLlLE4qpMSrLTTCrT+1uKdM1pSrIzYkyXA101gQsSyTz4U9c5gHOYbHMeCjeVuhT0av5UnqC1y+CaD/v1ZdMV85mS0S5HfZjRsWbWbh/2ilXTnQKgL35t2k/ZGfQL+7aOgaUUrSp1ahIUBQKOYTExJXB2sQj7iHgH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307189; c=relaxed/simple;
	bh=fXCyP50M5WiZ6EwUrVMzqHxCuyqwmZ1C10ZAQVjZ/B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flRj/ybn8cZTTczG+cCXePGQq83tZ2cq6p03dJMKbhjybzVtm8L3FIziXKfeb48Agtog+coxwdw9+wmyC/y3rylUQQSfNCwAY4DgK/dYtQZqmykSE7JCug0UrHT0WyhZ+KUp6bcEUHKh/uoGttvjNNvClxeYwRxBbZ5ymVeZDx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8zxROpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06194C113D0
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761307189;
	bh=fXCyP50M5WiZ6EwUrVMzqHxCuyqwmZ1C10ZAQVjZ/B8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d8zxROpBR+fhEEQ+Fq+rfCn0YHi8Ub8cRxKLLFkKye47Kz5B0BEhk+Ec1oiPHxKxe
	 HkNZQik4D8oqajw6RKexUQxBPiYjlKp3W2bhiHc8P8e6RMjdygfEbz98+1Sud7kRyk
	 7j6KsFw2D5d1fIF0pJFPVyWwNguzS1TqZfrY2b3oPkITsriwXEbOO8WcYXJIMemA1O
	 KdnwLJwrpZJ2aaZkRY5PVf4NJSE7rSScGq8jWLX3nsOM30sBXA33qtZ51bSCdkk6C/
	 I6AWPRfQyGaRVMJWsjsLPizVzaHsjq2g1Jwo+CLIKYifuDr/68sC3QyTjBFrSOnE4w
	 aGC4nWNHjzSiA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4539dddd99so394362966b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 04:59:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWH86At8H3YNMcZvw7opQBghJg1F6Inapj+XrK2R0WZYl7X3PEcDuRRo5pS4dlkPZi4YZOHjgTozzCcvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXH21vsJbfmha43FvfdxArTzlLPLaFV8nY480G7pd7QvjjqRJE
	6jOKLTISIOzPTDwrYIoEqc15egVUc1gntAjGkE1T5M5L3GX7gPVFcz8l71vAc4J3xhxaGL04R3p
	wfoya+Gw6GoDMFazpBS1zELQmE+QcYzk=
X-Google-Smtp-Source: AGHT+IEPyY9JfxI5oeCDzDCf38E+2SoheGQehIyD9efprZ4YplKQ4oF8QOmWcrVCYiVDhhGqQGuIQUWYnEIaJvMKWKs=
X-Received: by 2002:a17:907:1c81:b0:b6c:8e24:21f with SMTP id
 a640c23a62f3a-b6d51c325c6mr833097866b.55.1761307187519; Fri, 24 Oct 2025
 04:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac949c74-90c2-4b9a-b7fd-1ffc5c3175c7@gmail.com>
In-Reply-To: <ac949c74-90c2-4b9a-b7fd-1ffc5c3175c7@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 Oct 2025 12:59:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7NzucX=fLPu_Jws=N4AkAFfxXN-wLX5YotO74Pd3WuKA@mail.gmail.com>
X-Gm-Features: AS18NWAjeKFJ8u1BLhwt4Uqc5Vl4RpWt-rJE503drTlUt7NrO9srtbMpdi9_iBQ
Message-ID: <CAL3q7H7NzucX=fLPu_Jws=N4AkAFfxXN-wLX5YotO74Pd3WuKA@mail.gmail.com>
Subject: Re: Symlink entry is not persisted after rename if system crashes
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:38=E2=80=AFPM Vyacheslav Kovalevsky
<slava.kovalevskiy.2014@gmail.com> wrote:
>
> Under some circumstances, new directory entry of a symbolic link is not
> persisted after rename if the file system crashes.
>
>
>
> Detailed description
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Hello, we are doing research on testing file system crash consistency.
> During
>
> testing we found this issue with btrfs file system. In short, a symbolic
> link
>
> is created and renamed. Directory entries are synced using `fsync` after
> every
>
> step. However, after a crash, the symbolic link new directory entry is no=
t
>
> persisted (symbolic link has the old name). Read the test below for more
>
> details.

Btw, the message is somewhat oddly formatted with phrases being
interrupted in the middle with blank lines.

>
>
>
> System info
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Linux version 6.18.0-rc2 (root@ubuntu) (gcc (Ubuntu 15.2.0-4ubuntu4)
> 15.2.0,
>
> GNU ld (GNU Binutils for Ubuntu) 2.45) #2 SMP PREEMPT_DYNAMIC Thu Oct 23

Irrelevant information :)

>
> 12:32:29 UTC 2025
>
>
> Also tested on Linux 6.14.11.
>
>
> Operating System: Ubuntu 25.10
>
> CPU architecture: x86_64
>
>
> btrfs-progs version: v6.16
>
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
> CRYPTO=3Dbuiltin
>
>
> Tested on QEMU emulator version 10.1.1.

Irrelevant too.

>
>
>
> How to reproduce
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ```
>
> #include <errno.h>
>
> #include <fcntl.h>
>
> #include <stdio.h>
>
> #include <string.h>
>
> #include <sys/stat.h>
>
> #include <sys/types.h>
>
> #include <unistd.h>
>
>
> int main() {
>
> int status;
>
> int root_fd;
>
> int dir_fd1;
>
> int dir_fd2;
>
>
> status =3D mkdir("dir", S_IRWXO);
>
> printf("MKDIR: %d\n", status);
>
>
> status =3D open(".", O_RDONLY | O_DIRECTORY);
>
> printf("OPEN: %d\n", status);
>
> root_fd =3D status;
>
>
> // persist `dir`
>
> status =3D fsync(root_fd);
>
> printf("FSYNC: %d\n", status);
>
>
> status =3D symlink("foobar", "dir/slink-old");
>
> printf("SYMLINK: %d\n", status);
>
>
> status =3D open("dir", O_RDONLY | O_DIRECTORY);
>
> printf("OPEN: %d\n", status);
>
> dir_fd1 =3D status;
>
>
> // persist `slink-old`
>
> status =3D fsync(dir_fd1);
>
> printf("FSYNC: %d\n", status);
>
>
> status =3D rename("dir/slink-old", "dir/slink-new");
>
> printf("RENAME: %d\n", status);
>
>
> status =3D open("dir", O_RDONLY | O_DIRECTORY);
>
> printf("OPEN: %d\n", status);
>
> dir_fd2 =3D status;
>
>
> // persist `slink-new`
>
> status =3D fsync(dir_fd2);
>
> printf("FSYNC: %d\n", status);
>
> }
>
> ```
>
>
> Short test summary:
>
>
> 1. Directory `dir` is created.
>
> 2. Directory `.` is fsynced (`dir` entry should persist).
>
> 3. New symbolic link `slink-old` is created in `dir`.
>
> 4. Directory `dir` is fsynced using descriptor 1 (`slink-old` entry shoul=
d
>
> persist).
>
> 5. Link is renamed from `slink-old` to `slink-new`.
>
> 6. Directory `dir` is fsynced using decriptor 2 (`slink-new` entry should
>
> persist).
>
>
> Steps:
>
>
> 1. Create and mount new btrfs file system in default configuration.
>
> 2. Change directory to root of the file system and run the compiled test.
>
> 3. Cause hard system crash (e.g. QEMU `system_reset` command).

Btw, you can test things in a much easier way by using the dm flakey target=
.
No need to reboot qemu, etc. That's how we do it with fstests, and we
can even use simple shell scripting and the xfs_io utility most of the
time, no need to write C programs.

Fix sent here:

https://lore.kernel.org/linux-btrfs/cf3df42390ff83be421dcdc375d072716a67d56=
1.1761306236.git.fdmanana@suse.com/

Thanks.

>
> 4. Remount file system after crash.
>
> 5. Observe that `dir` directory contains entry named `slink-old` instead =
of
>
> `slink-new`.
>
>
> Notes:
>
>
> - In other file systems (ext4, xfs, nilfs2) the `dir` will contain new
>
> (`slink-new`) entry, not the old one.
>
> - The problem only affects symlinks, but not regular files.
>
> - The problem only arises if `dir` fsyncs are made using different
>
> descriptors.
>
>


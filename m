Return-Path: <linux-btrfs+bounces-19490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B67CA113A
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 19:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9AC432A786A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 17:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25D33B6CC;
	Wed,  3 Dec 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfNGKi34"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EB343D7B
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783791; cv=none; b=BPeGteFWCXDBBT16eAUIARkPHycz2u2lWcaezA9nqp5ptA7FHMGP3xGt08wseRXW68/JxFXz/GOvqeY5hQBGUvx7VfJxRIcRMgi5dWA/avqkkS/70WlxeGfrEgVGOOU4zkT5Dx6c3KZxqGCybaVEAiW59w2V+05xxd+mtiXdRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783791; c=relaxed/simple;
	bh=xqK3UsWzwiP+Id7mGerrYXyXpPb9Quy5TrWRzw9rVOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNitWOtIMarVj86xcV57zl1hNLABTzFFkKVchfzjdVqFee+elpfdy6NuhUGsJ2TNYfG9tn8U48IuxfjtykufASam0eAwifiX2yJRcEeQt4ivDp/zHLlm4HGetwYbvHqUP2xlPB2oBKm3I311dPAiF0NAvhfRgHGn8LMFuKSFXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfNGKi34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65035C116C6
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764783790;
	bh=xqK3UsWzwiP+Id7mGerrYXyXpPb9Quy5TrWRzw9rVOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NfNGKi34/DlKWO60pUTc4OwQb77k5OOa5ZDhglyilT4coaAADpvzUYqPti4lU+SB8
	 zHg6hBmYXm0FRS936sUcrBC3+M8XbEkpD2h8L+8DTVgZoHMYQpnB/T/LDSjxRTmiWF
	 4YbqfBg2CKyyIxIAMwVtTBF1tyNB4J7XPtIQI9OuouQXLtNPtG182VkwzNgd4tnrhS
	 cXnkybRGEPSsTW6nldYsnGazSeOKK8IVb38ztFTg+DcrDqFQ1+zHTYOz/Ua2pYOtoV
	 D+rfmuplu2JZzJdTvklq4ageccWhVkY9dtXjkyCUF/OvbIdLV92VGQNmwx2JpRgghY
	 O79otxX7tmNDw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so5299148a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Dec 2025 09:43:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOge6M9DueuQpkad03DnvTzJVmwJsRPQzoMJeieAdBWP3eKrDpkIBlZjzhhYJtdPeq70cPnwUEoZI70A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbyPqmUi4AKAfNMmC9UKntEiE5qynO3fyDq8dr706znauDZ9I
	DksX/W1iPHuReyGtfbQ4rYlQAvkNDkTePbltwxXcsYGMRjC9Ua+BNi16+gVFoVdabJCN/948jlM
	hb6jl8R+ZmmLndroBguw6ELLp4pETU/A=
X-Google-Smtp-Source: AGHT+IGwjjNAAGhQ46s6akOruKGa6yH4GMjXOoCzsIHwzLED5vtf+SuYyY84f+ZBuVZ67UoSB/bth643xVfvUMP/E0Q=
X-Received: by 2002:a17:907:3f24:b0:b70:68d7:ac0c with SMTP id
 a640c23a62f3a-b79ec6b9586mr2343866b.42.1764783788628; Wed, 03 Dec 2025
 09:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84c4e713-85d6-42b9-8dcf-0722ed26cb05@gmail.com>
In-Reply-To: <84c4e713-85d6-42b9-8dcf-0722ed26cb05@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Dec 2025 17:42:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4e8JPggKYasQA9Cm2UA=iCNuuchEjB0GzYKxPvf4f-FA@mail.gmail.com>
X-Gm-Features: AWmQ_bl01_qDFrQoMHIgzNtzpvKhtnW9SlQyo-BF0jqXLY83Wk7ksM0HT8TKtdg
Message-ID: <CAL3q7H4e8JPggKYasQA9Cm2UA=iCNuuchEjB0GzYKxPvf4f-FA@mail.gmail.com>
Subject: Re: Directory is not persisted after creating 100s of files inside,
 writing to another file and renaming it if system crashes.
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:26=E2=80=AFAM Vyacheslav Kovalevsky
<slava.kovalevskiy.2014@gmail.com> wrote:
>
> Directory entry is not persisted after creating 100s (hundreds) of files =
inside, writing to another file (with `O_SYNC` flag) and renaming it if sys=
tem crashes.

There's no need to create hundreds of files, 1 is enough. There's also
no need to open the file with O_SYNC or write data to it, more details
below.

>
>
> Detailed description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hello, we have found another issue with btrfs crash behavior.
>
> In short:
>
> 1. Create and sync an empty file in root directory.
> 2. Make new directory in root directory.
> 3. Open the file with `O_SYNC` flag and write some data (of specific size=
).

There's no need to O_SYNC, write data of any specific size or even write da=
ta.
Just change the file in some way (writing something to it of any size,
or changing uid, gid, or add a xattr, etc) and then fsync it.

> 4. Fill directory with specific number of empty files.

One file is enough.

Fixed by:   https://lore.kernel.org/linux-btrfs/a1b70971f8b73d44695ab6af56b=
69e0ae1010179.1764783284.git.fdmanana@suse.com/

Thanks.

> 5. Rename the previously written file.
> 6. Sync root directory.
>
> After system crash directory will be missing, although it was synced in t=
he last step.
>
>
> System info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Linux version 6.18, also tested on 6.14.11.
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
> #define BUFFER_LEN 1024 // should be at least ~ 528
> #define FILE_N 256      // should be at least ~ 128
>
> int main() {
>    int status;
>    int file_fd;
>    int root_fd;
>
>    int buffer[BUFFER_LEN + 1] =3D {};
>    for (int i =3D 0; i < BUFFER_LEN; ++i) {
>      buffer[i] =3D i;
>    }
>
>    status =3D creat("file1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>    printf("CREAT: %d\n", status);
>    close(status);
>
>    // persist `file1`
>    sync();
>
>    status =3D mkdir("dir", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>    printf("MKDIR: %d\n", status);
>
>    // `O_SYNC` is important
>    status =3D open("file1", O_WRONLY | O_SYNC);
>    printf("OPEN: %d\n", status);
>    file_fd =3D status;
>
>    status =3D write(file_fd, buffer, BUFFER_LEN);
>    printf("WRITE: %d\n", status);
>
>    char path[100];
>    // fill directory with a lot of empty files
>    for (int i =3D 0; i < FILE_N; ++i) {
>      sprintf(path, "dir/%d", i);
>      status =3D creat(path, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>      close(status);
>    }
>
>    status =3D rename("file1", "file2");
>    printf("RENAME: %d\n", status);
>
>    status =3D open(".", O_RDONLY | O_DIRECTORY);
>    printf("OPEN: %d\n", status);
>    root_fd =3D status;
>
>    // persist `dir`
>    status =3D fsync(root_fd);
>    printf("FSYNC: %d\n", status);
> }
> // after the crash `dir` is missing
> ```
>
> Steps:
>
> 1. Create and mount new btrfs file system in default configuration.
> 2. Change directory to root of the file system and run the compiled test.
> 3. Cause hard system crash (e.g. QEMU `system_reset` command).
> 4. Remount file system after crash.
> 5. Observe that `dir` directory is missing.
>
>


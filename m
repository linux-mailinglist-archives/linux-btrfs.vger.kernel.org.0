Return-Path: <linux-btrfs+bounces-22200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFnlBtEyp2k9fwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22200-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 20:13:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC51F5C0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 20:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A7CD314FC8A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE0F47DF89;
	Tue,  3 Mar 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb9TzDpj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7F3D75AB
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564933; cv=none; b=LfXvW61+urCwGsNYuVA/6j0XxfsITKRktmRR6u6C/3e0wQMf9iLbARe10jFq6cBvl3g4qQw3LSjTP90n1D1ztlEU6T6FeyOGav//c6s+r/xoHt0NcwHTfx/Amv3GwkFUuMsHcwl/uor57q1R1Kb8Bia4NUGmkVHp1qeyQklMcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564933; c=relaxed/simple;
	bh=TsPrR/eLRSJ65FEx8TgYx/fClW6QQ/DHA731G5LntL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfhk7Fgxe1NbWOF2UJGetdDoQsBU5qUXAB0Vx4KHAGTek1G0u/Z9Hzk7naIaSQJD85P3EictbSw1d4xFOT2EBcOZaBxe5uAKM2Vs0Vn87xSfg75JSGTcDCPB8/fyr28u0aHU8WYhoFjMkCH65kx4EA1pIXAC4j2a8dYQ9QzhBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb9TzDpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F40C2BCB0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772564932;
	bh=TsPrR/eLRSJ65FEx8TgYx/fClW6QQ/DHA731G5LntL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lb9TzDpj6DldEzOCZ8/Weip8qYPkhg1F/Zl8p6FxqsM1Dtrhio1RHWbXaqoim/jSe
	 lpM8ZlThu107gZqEylKol6Tf2R6XDpAFjaYz2sKc0QO3LLwGvhHMl6csmHZ1ZDMh99
	 kTsqM7ZJs1awZCh3dAgFteI94kkx7cP+n7PnDw9mb5p7Hfobxt+6sgOviKCO8Ca4/T
	 xc3C55Dh67M6V20ljIWaIB4ce1KFemxU/vqxKwhvTze+vJqVuQcXT0VpdvUZQXd+Fs
	 6JYlg1MmjW6qyGpYCcoYJ8NXtNZERdUjgwCuYicGvS8vSa4y3vfMBOg2D1K+VfxuD4
	 7Eqnx7hw2TifQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9359c0ec47so648888866b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Mar 2026 11:08:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrslF89jQjHoxgmwDTsMcmG6eTcVVGg2YOwKGaaLmwebzATmWrZRWLOWchLrGF85GN8pyUOBWr24PbyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycZ0cIuRk7MobGfQfK9C5JcBXtLnB2g+BOK8Q++MWwito41q97
	qDKklrmzp1OuhhsBmQ9tWRNsTraFpWs8ZDwhcGnPN8Vv4eEZjKsfQSWJdukYq+296WaU5toe+Lc
	UzeqHuPUDVM1a//QX3/YvIAfjs/fSNdo=
X-Received: by 2002:a17:907:7207:b0:b90:bc06:2acb with SMTP id
 a640c23a62f3a-b937636186bmr1159893066b.7.1772564931295; Tue, 03 Mar 2026
 11:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d514275-d2dc-4c0b-a7bd-3adf9415711b@gmail.com>
In-Reply-To: <2d514275-d2dc-4c0b-a7bd-3adf9415711b@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Mar 2026 19:08:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7frAhNt+KVk7KwKS_1SWnka--xWQTaOJX+KLJuHqnOEA@mail.gmail.com>
X-Gm-Features: AaiRm52c4p6aXJNbettMghYxYiZlsAx9JPgt3gUaiGRC3IatlBbovTzprhko0Is
Message-ID: <CAL3q7H7frAhNt+KVk7KwKS_1SWnka--xWQTaOJX+KLJuHqnOEA@mail.gmail.com>
Subject: Re: File permissions are not persisted after creating hard link if
 system crashes
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AEDC51F5C0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22200-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 4:47=E2=80=AFPM Vyacheslav Kovalevsky
<slava.kovalevskiy.2014@gmail.com> wrote:
>
> Detailed description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hello, there seems to be an issue with btrfs crash behavior:
>
> 1. Create and sync a new file.
> 2. Open the file and change permissions.
> 3. Sync the file.
> 4. Create new hard link to file.
> 5. Sync the root directory.
>
> After crash the file will have old (original) permissions, though the
> changes were synced.

For this test to pass you'll need the patch I sent for another report
you made before:

https://lore.kernel.org/linux-btrfs/af8c15fa-4e41-4bb2-885c-0bc4e97532a6@gm=
ail.com/

The patch is: https://lore.kernel.org/linux-btrfs/1c66bd7efe749cd3b421fc3df=
f5ef646dda8c7aa.1771350720.git.fdmanana@suse.com/

It's not in any released kernel yet (not even in Linus' master
branch), only in the for-next github branch:
https://github.com/btrfs/linux/commits/for-next/

Whenever you have new things to report, try to see if every patch I
pointed you to in previous reports is applied in the kernel you are
testing.

Thanks.

>
>
> System info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Linux version 7.0-rc2, also tested on 6.19.2
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
>    int status;
>    int file_fd0;
>    int file_fd1;
>    int root_fd;
>
>    status =3D creat("file1", S_IRWXU | S_IRGRP | S_IXGRP | S_IXOTH);
>    printf("CREAT: %d\n", status);
>    file_fd0 =3D status;
>
>    status =3D close(file_fd0);
>    printf("CLOSE: %d\n", status);
>
>    sync();
>
>    status =3D open("file1", O_RDONLY);
>    printf("OPEN: %d\n", status);
>    file_fd1 =3D status;
>
>    status =3D fchmod(file_fd1, S_IRWXU | S_IRWXG | S_IRWXO);
>    printf("FCHMOD: %d\n", status);
>
>    status =3D fsync(file_fd1);
>    printf("FSYNC: %d\n", status);
>
>    status =3D link("file1", "file2");
>    printf("LINK: %d\n", status);
>
>    status =3D open(".", O_RDONLY);
>    printf("OPEN: %d\n", status);
>    root_fd =3D status;
>
>    status =3D fsync(root_fd);
>    printf("FSYNC: %d\n", status);
> }
> // after crash file `file1` / `file2` has old permissions (0751 instead
> of 0777)
> ```
>
> Steps:
>
> 1. Create and mount new btrfs file system in default configuration.
> 2. Change directory to root of the file system and run the compiled test.
> 3. Cause hard system crash (e.g. QEMU `system_reset` command).
> 4. Remount file system after crash.
> 5. Observe that file permissions were not persisted.
>
>


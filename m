Return-Path: <linux-btrfs+bounces-15446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35543B01519
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B943A4D05
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69611F8908;
	Fri, 11 Jul 2025 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qqtH2DW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F11F8690
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219907; cv=none; b=S85vTHylDSjabTHGABnR2LRxiSuBBKSZhXYqtSLn0ymj+wVAdHoPiM/VVtRPQwMXQwcIe8OwXLzfip/zWoQeJtCJSS+37JUjQLTCm8ht6DRCN7CFKzLoHNC6vTXLMUUTLOHvwyXx0Td7kREk68gYKHsZt3NBHaf0lhjVjv2iNyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219907; c=relaxed/simple;
	bh=6YXSkR7x41tUzWJTiYuqbyQTbRPpk6TxwCucKDJ4j94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLVJSRa5u2I1xmN5K3BxIlM/Ginn6/HnvEmf9R2d45sMm/2Pkg/jnoQzEDTKlmQBC988uApHEOw6lmiJia4duHCdJOdq94BnyrT7HCwHf3mLLK09stJsl/K7MlPpmIOgP6VXwV1IxVvl723k+77v+GyeJ8vp3abOGp0VlxZ8unE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qqtH2DW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso1753375a91.2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752219905; x=1752824705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR0//uo+QHOMXG7k4LZ8s28q+1ZtuSoHzyRGpR1E+vA=;
        b=1qqtH2DW1rg+3qcyV/Cuvmbi73DsRhOJ6EBvqnry5OZBb3Hp7M6YTTHmDwdY1yKxT9
         4+jcR1Ip0EfeD+xbrjFUBwR67uKptYcl4lQ5QP/RTKyWkNjalBUivd/pOibSLKfbi3si
         kQVUFSpniyqDhUZmEQVr0nRquIdxJ2ZGL+be02JFbDXXQkcYm4bFJ1SzsH8+HZOHpYPb
         6E9KJQzYejj09cdOu03gxGW7+fUa/lmlnNiv7f8mFMV6iPBn/rve/3LVDRMdHKXvIiIO
         /tIBbNHgyBOqFoXmSr4a3vaVSNC90UYoMCEuy9YCJUKF6Y/1kfJJWH5U8ZsktkUmZr7U
         vQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752219905; x=1752824705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KR0//uo+QHOMXG7k4LZ8s28q+1ZtuSoHzyRGpR1E+vA=;
        b=n1XlJ7Io3c5yBZhB2AOfR+6l0NrjuA0MAhYCTIa8sEW6GQsJgQ4ENKCytvtPqIqjTZ
         zMYel8KI5T+g/WPQknIV1aAsFS0/cyafFn5kzxENNQD2blM50XkUylPoHFrObgzSAmtB
         u6j2XYl1OtOROtOHC6sIZLMInSfVMvLBIhqr9XMiNDFzRNZo9a1dZHgjYwWZn/koTeK6
         2SBMxr1cr92H0rh/7E2YXOOEReRozHfi4HkD0EJE/1I2cT/W0pwbNoJ5jNTyQ2aI56Sm
         moc5efDip6GMqadfWRv5241eitj8SUQkQf9Us1uUdMgyM1klz2WcZUFYqJpJsPV6vkN1
         TcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXol2Zr+CUmnHedVMY7gPIBn/XdKbXcSLQoUP3vLHAnAeYkZJSOIgZu92QTruIhyZcYoUIXoKOWtj1GlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyklicO66iC8aVvoKBMzfrVzd3bxt490/f1gc6MYmgX5aRhRE14
	6GjqwVOjD2V5pFxKwxttkZcGs/P2PdE32Wh12r1RmbS6hcApkaJ3M3ArcaVlD+fqzz6ZWpdP1Ie
	HAUMWhHvT3U/baE9qwR8VuwfcWrSGr4bNl0xxDfBS
X-Gm-Gg: ASbGnctHYmODFWLbwdvZRdCsACwFsSrjuN/As56tqvB3BKlWKkHvWejVCbptRfTP1pT
	A0+Vlmhlb5SHBkJRAIIeONi+xb9M9zMnvVCYB8197mR/gJao3eu2PgYZFDcOMbVRMvG8ecf4PU1
	EmstlignBZodNfcxr9UDOVX9wy27Q5MFdpS91pnGqcVaSpgLMmOo4KJTDN8RdXdU9kIIhleWlK4
	WOm5+jwyS+orfzOIPpi07ISGMizxlcNuyoZ6Q==
X-Google-Smtp-Source: AGHT+IFfufbHiwTokFo9H8Ko+8ik8lnHGpAzzynncKYY39zU1wFtJxNOc2bDnxAx/hHH089ymjTSpkdbMyD5mHaXKEM=
X-Received: by 2002:a17:90b:5868:b0:312:29e:9ed5 with SMTP id
 98e67ed59e1d1-31c4cd9c12cmr3380834a91.23.1752219904418; Fri, 11 Jul 2025
 00:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <88961a5.13de8.197f869374b.Coremail.baishuoran@hrbeu.edu.cn>
In-Reply-To: <88961a5.13de8.197f869374b.Coremail.baishuoran@hrbeu.edu.cn>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 11 Jul 2025 09:44:52 +0200
X-Gm-Features: Ac12FXwiAUvtlC_5Gf-_4rwi2asNx2efaLAiI_4DnmWKw6XsIN1cXSyNaxvhDh8
Message-ID: <CANp29Y565yMhy2aGo4d1sX0XL8VrmSuNgFTsL47ARxsUhkb5zw@mail.gmail.com>
Subject: Re: WARNING in btrfs_remove_chunk
To: =?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>
Cc: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>, 
	syzkaller@googlegroups.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kun Hu,

Please note that the bug has already been reported to the mailing
lists by syzbot ~ 2 years ago:

https://syzkaller.appspot.com/bug?extid=3De8582cc16881ec70a430
https://lore.kernel.org/all/00000000000089839605eeabb948@google.com/T/

On Fri, Jul 11, 2025 at 9:35=E2=80=AFAM =E7=99=BD=E7=83=81=E5=86=89 <baishu=
oran@hrbeu.edu.cn> wrote:
>
> Dear Maintainers,
>
> When using our customized Syzkaller to fuzz the latest Linux kernel, the =
following crash (120th)was triggered.
>
>
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream
> Output:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/WARNING%2=
0in%20btrfs_remove_chunk/120report.txt
> Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/co=
nfig.txt
> C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.14/WAR=
NING%20in%20btrfs_remove_chunk/120repro.c
> Syzlang reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0702_6.=
14/WARNING%20in%20btrfs_remove_chunk/120repro.txt
>
> Our reproducer uses mounts a constructed filesystem image.
>
>
> The error occurred in line 3426 of volumes. c, in the error handling path=
 of the btrfs_remove_chunk function. This may be because in the process of =
calling btrfs_remove_chunk to remove chunks during the balance operation, t=
he first call to remove_chunk_item fails, returns - ENOSPC, and then enters=
 the ENOSPC error recovery logic to try to allocate a new system chunk. And=
 the system chunk space is exhausted, and the creation of a new system chun=
k fails.
>
>
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.ed=
u.cn>, Shuoran Bai <baishuoran@hrbeu.edu.cn>
>
>
>
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 2 PID: 14048 at fs/btrfs/volumes.c:3426 btrfs_remove_chunk+=
0x1667/0x1a20
> Modules linked in:
> CPU: 2 UID: 0 PID: 14048 Comm: syz.1.10 Not tainted 6.14.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubunt=
u1.1 04/01/2014
> RIP: 0010:btrfs_remove_chunk+0x1667/0x1a20
> Code: 83 f9 19 77 0f b8 01 00 00 00 48 d3 e0 a9 01 00 04 02 75 49 e8 ca 7=
1 e4 fd 90 48 c7 c7 20 5a ba 8b 44 89 e6 e8 ca 6b a4 fd 90 <0f> 0b 90 90 bb=
 01 00 00 00 e8 ab 71 e4 fd 48 8b 7c 24 08 41 89 d8
> RSP: 0018:ffffc90002da7830 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000080000
> RDX: ffffc90003169000 RSI: ffff8880234e2480 RDI: 0000000000000002
> RBP: ffff88804477cd00 R08: fffffbfff1c0b901 R09: ffffed1005725182
> R10: ffffed1005725181 R11: ffff88802b928c0b R12: ffffffffffffffe4
> R13: 00000000ffffffe4 R14: ffff88807830abec R15: ffff888078c48878
> FS:  00007f09099aa700(0000) GS:ffff88802b900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2d610ff8 CR3: 0000000053082000 CR4: 0000000000750ef0
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  btrfs_relocate_chunk+0x2bb/0x440
>  btrfs_balance+0x201a/0x3f80
>  btrfs_ioctl_balance+0x43f/0x6f0
>  btrfs_ioctl+0x2c57/0x6230
>  __x64_sys_ioctl+0x19e/0x210
>  do_syscall_64+0xcf/0x250
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0908bacadd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f09099a9ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f0908da5fa0 RCX: 00007f0908bacadd
> RDX: 0000000020000480 RSI: 00000000c4009420 RDI: 0000000000000004
> RBP: 00007f0908c2ab8f R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f0908da5fac R14: 00007f0908da6038 R15: 00007f09099a9d40
>  </TASK>
>
>
>
>
>
>
> thanks,
> Kun Hu
>

--=20
Aleksandr


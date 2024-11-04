Return-Path: <linux-btrfs+bounces-9310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F669BAC79
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 07:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCC71C2042B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 06:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545518C91D;
	Mon,  4 Nov 2024 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAcSxn4s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BDE552;
	Mon,  4 Nov 2024 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701305; cv=none; b=JTMuEnt7zgodtHP35/r6iKXReas6pOh3ff2YB5zt240951iuUgyCFFvQgoyPtBEx8t834wBZjPP9sMaUaS/bwZlFOuPzOZniwjs93qQ5lfHZGMYqsaaSX/8HNW9Bm2oTA3ncVfAs4tElnHVQ9OjZ5Kaw0GCznLqEO3YccTmQTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701305; c=relaxed/simple;
	bh=XEw+EaA1wvQ78GBZ/rCvyQ8G3Ye51QaxE3ljjsbFUCE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o59IcbBYVcwfulZvZCxWStGH7voBZpZSQvLwrDCng/nWHdAnRbDo+0JEYSGu9DVRu6Qa7jgUyBGaeuEDM6fahjjnj8Lyn/IPO/ihLcLrcIXN/11gtyxYU0RTPdE2U76SHdA3BOH8mBYAULWgeoD4Z9bzQ5zVJz7qNY/MHr9FYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAcSxn4s; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e4e481692so3687644b3a.1;
        Sun, 03 Nov 2024 22:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730701303; x=1731306103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEw+EaA1wvQ78GBZ/rCvyQ8G3Ye51QaxE3ljjsbFUCE=;
        b=WAcSxn4sxoRFLQx83zcwt2qRFViz7wYpzx/6bJ6m97yacNmo4NhJ+krjNQYtCJrtCd
         6gcbytqowRpeI/p3sPNuSUcOz6LCbcGWFUuHMF733v6urPtNPMGHX502H70fHi8Ncg0g
         4HLFIOVuwPWDps3/pfdo9U4OEQgrYzx0zls9D2A81o1FUUmMgLT/ejMmYn3c25zT2S04
         qrCMMFOB3xr9R6t1SSo/gm1OjgpKk3kWaVMjEWl4OWZr1nG1F7iFdLyhT/IbdifJ5kQz
         ypbPNTMXvIPcU34Xr2hCQdCHbfHxtEQfjQLnBv2XoPlGiVxsHhgVLwEFXfa5rbbj9lFQ
         ecOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730701303; x=1731306103;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XEw+EaA1wvQ78GBZ/rCvyQ8G3Ye51QaxE3ljjsbFUCE=;
        b=F0CSC/HCQI+fhMv2yuH0Jk3o+y4/1MgSlff3UEZ8FWR3mCVAURL4mwGw3CXKJzJcc8
         gkQHWx/cuuyWmr60ghqISnjqkSke8/gURwa4NbVuoLo3+DlXf+6HfwDQiENpj3zWKGyM
         0kXvYOr7rudyHBj3mazCZCF+tAHHJb1tbhGZZ3Syy/Fwq2EbtBtRA/T4fcBiK09HVq45
         g3qoRGmo+f3GVbPieqwz/+LFpZsAK8bcvtGT4UIVV4R3rS6eNK9RtqGPyRt4kkPHbPM9
         6DiUmh+FYELh//CTdQgv7XJRhhggeKoP+McDXiV4mfACrXXkQ3HPNV6DsvQjBQkPaEvr
         3KyA==
X-Forwarded-Encrypted: i=1; AJvYcCX5RMnZ7Ku5GeQFGYtCpACK939eFgsYaMrOQA8q8M+wkuzuum7170CPXjUdTg4+d/EvU6KqurwzJbS+Vg==@vger.kernel.org, AJvYcCXnmzl4z9j8xQE3K1KNhQdNBHd9YB1k7k7uJoggQPSYu3kHKi4A/pN84DmwP8/LP5fvL2UR3TKqXb2lbUpc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kiK4hsdKaYiEg4gULV0c0Zy4/RxbDqRyq0mtQsptCVQ47p5Z
	Tq6HbHlkgMmfxHeH5gVVgE0pbRsTmzKTbgD/FaNa+Ngs99HHCyze
X-Google-Smtp-Source: AGHT+IG5SRxooOG7307bNGRUX6CouAaj+/FLK8oLbbBA4JteqTJTsQ+1nfH9VkQkJN9zLQ966ZYikg==
X-Received: by 2002:a05:6a21:170f:b0:1d9:1071:9175 with SMTP id adf61e73a8af0-1dba54f3fadmr14599261637.32.1730701303229;
        Sun, 03 Nov 2024 22:21:43 -0800 (PST)
Received: from [10.172.23.36] ([38.207.141.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfb04asm9071449a91.50.2024.11.03.22.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 22:21:42 -0800 (PST)
Message-ID: <3c01986b19c041931fe7bb542b1b00069b2e458a.camel@gmail.com>
Subject: Re: [syzbot] [btrfs?] VFS: Busy inodes after unmount
 (use-after-free)
From: Julian Sun <sunjunchao2870@gmail.com>
To: syzbot <syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com>, 
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Date: Mon, 04 Nov 2024 14:21:39 +0800
In-Reply-To: <000000000000229e6205f3144e05@google.com>
References: <000000000000229e6205f3144e05@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-01-25 at 02:43 -0800, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 edb2f0dc90f2 Merge branch 'for-next/core' =
into for-
> kernelci
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-
> kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1484d22e48000=
0
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3Da1c301efa2b11613
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D0af00f6a2cba2058b5db
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 13.0.1=
-
> ++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU
> Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D15e20341480000
> C reproducer:=C2=A0=C2=A0 https://syzkaller.appspot.com/x/repro.c?x=3D154=
fa4f1480000
>=20
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/ca1677dc6969/disk-edb2f0dc.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/22527595a2dd/vmlinux-edb2f0d=
c.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/45308e5f6962/Image-edb2f0dc.=
gz.xz
> mounted in repro:
> https://storage.googleapis.com/syzbot-assets/6105a892b6d5/mount_0.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com
>=20
> VFS: Busy inodes after unmount of loop0. Self-destruct in 5 seconds.=C2=
=A0
> Have a nice day...
> VFS: Busy inodes after unmount of loop0. Self-destruct in 5 seconds.=C2=
=A0
> Have a nice day...
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ=C2=A0for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status=C2=A0for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz test

--=20
Julian Sun <sunjunchao2870@gmail.com>


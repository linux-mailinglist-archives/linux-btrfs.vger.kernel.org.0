Return-Path: <linux-btrfs+bounces-11000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A10A1601D
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 04:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ABE7A2BF3
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 03:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F5A41C6E;
	Sun, 19 Jan 2025 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZCmxEW5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231F23C9
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737258469; cv=none; b=H12ia9TJ09x1WJA3e5SsdRIpetxh1EmNwLajLYqzHXXUvrJXXuuq2mOGUZK2NbspjdVh2MabmgAUSvugCWvK9kS/w8ZomsYd8LtfciN98eJGKC3YjVN7F3zNdU32Yo+zvmQf1KHozHHgtFqy1GMLGgc+I7eW0QFb0esfqMaVuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737258469; c=relaxed/simple;
	bh=ixAlwhruQzs1Iiz4/Ck0NmdweAnXgiTI44Z88hjsT+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvU4HMVytqHNwrOqoB2I/wpp2ZxT4q+h6+u0jPG3LFWs6byI+37UJkWH2RHKw3ggDFoi0+PiHl6y5AChYt+WRQeFRlU7bco+uBbsqSCA3OiCG9Vt6QqICauAIQKe6t6sedWgzx9zS6Foif20qSwCLVsHb0G1etR9DQaj8KiVzHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZCmxEW5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5773c5901aso7074714276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jan 2025 19:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737258462; x=1737863262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvS/mAFIX6i0dChwHzUmKumvDeMaA9KUAvspD0xJU74=;
        b=nZCmxEW5GbX/lbnEXrr/92e8zkapxP5DScqpxbPCEnpeXXOfnIQ0yhmx9EzpYb23xx
         RsdhzFY/XjALiibWiZCJ6Kf/o3zPPzFXJs5RX3Xb5EDwCgQYvuICjPemtI/JvYV+O6ga
         5suL6HcvfsH2LeVRaUwZWRWU7zRj/8u85JE6J0BnlxQDmsXvGh2CV6fA2rck/3PYmhls
         wRlweNMAxYSYeTmH+yTVjN5f0T35E0qo2kSjk6g6gAlxVJa9DiE/JfTmLfW/Pa3FH8bD
         AVF5+5rgvirZPahkDy0zjGtp0bpfWMfyXI4L/Rnw0E1l6BfTYu+U2DAhMeziG2lwnZm0
         CnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737258462; x=1737863262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvS/mAFIX6i0dChwHzUmKumvDeMaA9KUAvspD0xJU74=;
        b=pMwK+XfBJ3lHTlkcQyEyOaDhRbj+MWhxet2WwepELVC46AR5L3qWTYgLWeRcSJEBgI
         /KqcdVwDx+p3CIFfx0DA3HDpIM3d7DqvaNEJq0Lt2j3gS1I1Jz8MxhNAxd8p6BMPBHl1
         NxFbqaWuwNCru5iyuZO8o/gcoK5c5/N0PDBLr2GX/zu5/ZYJGC6QFxASxnBPdRRtuCbC
         A87ad9ziNcF83pnMhBd0UMWbSTSGzdiDYDcoewYNc0UEnI3IfeDJ4F/aAX9SjCLUY4D2
         noPjaxkwkurY50XyeRy8JuYruWjRcQFs6iSN6nPXtjC336cE5jjz8SB4CYPnm8oEJd8W
         ttwQ==
X-Gm-Message-State: AOJu0YzxzsC3uzKtq5TvMkEzu2D5CZSD2WVUcYAZ7W+BjA0cFChya3fc
	w/aiLquFMJE9gQuUqcZLaR9RPDdNe69H3H7k4yLXXnBVaMKo/sZ3SF5mUFGn6+UZh2CJOstkOUR
	ArXi7zMnWXkNtIZL7JsIC+aLZlo5uLmhsy5Q=
X-Gm-Gg: ASbGncvBEniNJOik/xJ5tN8aa1sgOzb7f3U4TKgCGuf4t6TE40GmBhbq2UV8jUYdAw6
	xf+B9EaYT45xLfu9qlxdNSYFhaQhCtddZ1iLd6uDfa1xpJXugO08=
X-Google-Smtp-Source: AGHT+IGCcR2aCLHv/XoAUNSKbjJ027LkI42afxEXM4Ku1gJZKFyMSyNF+JcU7SnVFaULaF/QIwzV/tLTf5y1GywOre0=
X-Received: by 2002:a05:690c:dc3:b0:6f0:5fc:7d with SMTP id
 00721157ae682-6f6c9af4a11mr120465077b3.11.1737258461653; Sat, 18 Jan 2025
 19:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com>
In-Reply-To: <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com>
From: Dave T <davestechshop@gmail.com>
Date: Sat, 18 Jan 2025 22:47:30 -0500
X-Gm-Features: AbW1kvYHIS8p7feCXAMy3lyoo_aC6lGDQYB7IRUG-TwwT3Bnv2INWSdSnZtAkPU
Message-ID: <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is the full dmesg. Does this go back far enough?
I will run the "btrfs check --readonly" soon.

# dmesg
[Jan18 15:08] BTRFS info (device dm-0): relocating block group
2242498265088 flags metadata
[  +9.352125] BTRFS info (device dm-0): found 50763 extents, stage:
move data extents
[  +4.994162] BTRFS info (device dm-0): relocating block group
2241424523264 flags data
[  +0.242087] BTRFS info (device dm-0): found 2 extents, stage: move
data extents
[  +0.100458] BTRFS info (device dm-0): found 2 extents, stage: update
data pointers
[  +0.085191] BTRFS info (device dm-0): relocating block group
2240350781440 flags data
[  +0.147464] BTRFS info (device dm-0): found 1673 extents, stage:
move data extents
[  +3.316772] BTRFS info (device dm-0): found 1673 extents, stage:
update data pointers
[  +2.262001] BTRFS info (device dm-0): balance: ended with status: 0
[  +0.078749] BTRFS info (device dm-0): balance: start
-dusage=3D93,limit=3D2..10 -musage=3D93,limit=3D2..10 -susage=3D93,limit=3D=
2..10
[  +0.000495] BTRFS info (device dm-0): relocating block group
2248940716032 flags data
[  +0.141007] BTRFS info (device dm-0): found 1665 extents, stage:
move data extents
[  +3.486510] BTRFS info (device dm-0): found 1665 extents, stage:
update data pointers
[  +2.320799] BTRFS info (device dm-0): found 1 extents, stage: update
data pointers
[  +0.098829] BTRFS info (device dm-0): relocating block group
2247866974208 flags data
[  +0.235432] BTRFS info (device dm-0): found 2 extents, stage: move
data extents
[  +0.098843] BTRFS info (device dm-0): found 2 extents, stage: update
data pointers
[  +0.081197] BTRFS info (device dm-0): relocating block group
2246793232384 flags metadata
[  +3.671490] BTRFS info (device dm-0): found 21283 extents, stage:
move data extents
[  +2.187440] BTRFS info (device dm-0): relocating block group
2245719490560 flags metadata
[Jan18 15:09] BTRFS info (device dm-0): found 50987 extents, stage:
move data extents
[  +5.112818] BTRFS info (device dm-0): relocating block group
2244645748736 flags data
[  +0.629956] BTRFS info (device dm-0): found 453 extents, stage: move
data extents
[  +1.650014] BTRFS info (device dm-0): found 447 extents, stage:
update data pointers
[  +1.075952] BTRFS info (device dm-0): relocating block group
1598219616256 flags metadata
[ +20.750676] BTRFS info (device dm-0): found 60777 extents, stage:
move data extents
[ +10.498047] BTRFS info (device dm-0): balance: ended with status: 0
[  +0.092364] BTRFS info (device dm-0): balance: start
-dusage=3D95,limit=3D2..10 -musage=3D95,limit=3D2..10 -susage=3D95,limit=3D=
2..10
[  +0.000618] BTRFS info (device dm-0): relocating block group
2255383166976 flags metadata
[  +1.067884] BTRFS info (device dm-0): found 19476 extents, stage:
move data extents
[  +0.138367] BTRFS info (device dm-0): relocating block group
2254309425152 flags data
[  +0.576472] BTRFS info (device dm-0): found 449 extents, stage: move
data extents
[  +1.594043] BTRFS info (device dm-0): found 449 extents, stage:
update data pointers
[  +1.067538] BTRFS info (device dm-0): relocating block group
2253235683328 flags metadata
[Jan18 15:10] BTRFS info (device dm-0): found 51316 extents, stage:
move data extents
[  +7.168217] BTRFS info (device dm-0): relocating block group
2252161941504 flags metadata
[ +17.067206] BTRFS info (device dm-0): found 60534 extents, stage:
move data extents
[  +8.275508] BTRFS info (device dm-0): relocating block group
2251088199680 flags data
[  +0.248107] BTRFS info (device dm-0): found 2 extents, stage: move
data extents
[  +0.111768] BTRFS info (device dm-0): found 2 extents, stage: update
data pointers
[  +0.098011] BTRFS info (device dm-0): relocating block group
2250014457856 flags data
[  +0.155036] BTRFS info (device dm-0): found 1687 extents, stage:
move data extents
[  +3.469861] BTRFS info (device dm-0): found 1687 extents, stage:
update data pointers
[  +2.307146] BTRFS info (device dm-0): balance: ended with status: 0
[  +0.078999] BTRFS info (device dm-0): balance: start
-dusage=3D97,limit=3D2..10 -musage=3D97,limit=3D2..10 -susage=3D97,limit=3D=
2..10
[  +0.000494] BTRFS info (device dm-0): relocating block group
2260751876096 flags data
[  +0.133913] BTRFS info (device dm-0): found 1664 extents, stage:
move data extents
[  +3.464269] BTRFS info (device dm-0): found 1664 extents, stage:
update data pointers
[  +2.263999] BTRFS info (device dm-0): relocating block group
2259678134272 flags data
[  +0.278314] BTRFS info (device dm-0): found 2 extents, stage: move
data extents
[  +0.099309] BTRFS info (device dm-0): found 2 extents, stage: update
data pointers
[  +0.085843] BTRFS info (device dm-0): relocating block group
2258604392448 flags metadata
[  +3.655394] BTRFS info (device dm-0): found 21588 extents, stage:
move data extents
[  +2.171743] BTRFS info (device dm-0): relocating block group
2257530650624 flags metadata
[Jan18 15:11] BTRFS info (device dm-0): found 51229 extents, stage:
move data extents
[  +7.253823] BTRFS info (device dm-0): relocating block group
2256456908800 flags metadata
[ +14.595148] BTRFS info (device dm-0): found 59934 extents, stage:
move data extents
[  +7.832925] BTRFS info (device dm-0): relocating block group
2255383166976 flags data
[  +0.560993] BTRFS info (device dm-0): found 454 extents, stage: move
data extents
[  +1.482543] BTRFS info (device dm-0): found 454 extents, stage:
update data pointers
[  +1.089166] BTRFS info (device dm-0): balance: ended with status: 0
[  +0.068531] BTRFS info (device dm-0): balance: start
-dusage=3D99,limit=3D2..10 -musage=3D99,limit=3D2..10 -susage=3D99,limit=3D=
2..10
[  +0.000584] BTRFS info (device dm-0): relocating block group
2267194327040 flags data
[  +0.579027] BTRFS info (device dm-0): found 446 extents, stage: move
data extents
[  +1.486219] BTRFS info (device dm-0): found 446 extents, stage:
update data pointers
[  +1.136268] BTRFS info (device dm-0): relocating block group
2266120585216 flags metadata
[  +2.555838] BTRFS info (device dm-0): found 19964 extents, stage:
move data extents
[  +1.098575] BTRFS info (device dm-0): relocating block group
2265046843392 flags metadata
[ +12.317746] BTRFS info (device dm-0): found 59402 extents, stage:
move data extents
[Jan18 15:12] BTRFS info (device dm-0): relocating block group
2263973101568 flags metadata
[ +17.909995] BTRFS info (device dm-0): found 59803 extents, stage:
move data extents
[  +8.577437] BTRFS info (device dm-0): relocating block group
2262899359744 flags data
[  +0.241203] BTRFS info (device dm-0): found 2 extents, stage: move
data extents
[  +0.098803] BTRFS info (device dm-0): found 2 extents, stage: update
data pointers
[  +0.084717] BTRFS info (device dm-0): relocating block group
2261825617920 flags data
[  +0.188783] BTRFS info (device dm-0): found 1688 extents, stage:
move data extents
[  +3.394257] BTRFS info (device dm-0): found 1688 extents, stage:
update data pointers
[  +2.341116] BTRFS info (device dm-0): relocating block group
2074960986112 flags data
[  +1.273917] BTRFS info (device dm-0): found 26 extents, stage: move
data extents
[  +1.446045] BTRFS info (device dm-0): found 26 extents, stage:
update data pointers
[  +0.888043] BTRFS info (device dm-0): relocating block group
1581039747072 flags metadata
[ +17.116977] BTRFS info (device dm-0): found 64736 extents, stage:
move data extents
[Jan18 15:13] BTRFS info (device dm-0): relocating block group
70888980480 flags metadata
[ +12.415041] BTRFS info (device dm-0): found 64760 extents, stage:
move data extents
[  +4.022198] BTRFS info (device dm-0): balance: ended with status: 0
[Jan18 15:15] BTRFS info (device dm-0): balance: start -d -m -s
[  +0.000914] BTRFS info (device dm-0): relocating block group
2276858003456 flags metadata
[  +1.104723] BTRFS info (device dm-0): found 18763 extents, stage:
move data extents
[  +0.153617] BTRFS info (device dm-0): relocating block group
2275784261632 flags metadata
[  +6.885107] BTRFS info (device dm-0): found 59356 extents, stage:
move data extents
[  +2.043180] BTRFS info (device dm-0): relocating block group
2274710519808 flags data
[  +0.429634] BTRFS info (device dm-0): found 3 extents, stage: move
data extents
[  +0.108149] BTRFS info (device dm-0): found 3 extents, stage: update
data pointers
[  +0.084415] BTRFS info (device dm-0): relocating block group
2273636777984 flags data
[  +0.163039] BTRFS info (device dm-0): found 1712 extents, stage:
move data extents
[  +4.172062] BTRFS info (device dm-0): found 1712 extents, stage:
update data pointers
[  +2.331337] BTRFS info (device dm-0): relocating block group
2272563036160 flags data
[  +1.113937] BTRFS info (device dm-0): found 25 extents, stage: move
data extents
[  +1.260968] BTRFS info (device dm-0): found 25 extents, stage:
update data pointers
[  +0.886727] BTRFS info (device dm-0): relocating block group
2271489294336 flags metadata
[Jan18 15:16] BTRFS info (device dm-0): found 56181 extents, stage:
move data extents
[  +7.036143] BTRFS info (device dm-0): relocating block group
2270415552512 flags metadata
[ +17.301626] BTRFS info (device dm-0): found 64846 extents, stage:
move data extents
[  +7.372384] BTRFS info (device dm-0): relocating block group
2269341810688 flags metadata
[ +17.312848] BTRFS info (device dm-0): found 65158 extents, stage:
move data extents
[  +7.895505] BTRFS info (device dm-0): relocating block group
2268268068864 flags data
[  +0.617978] BTRFS info (device dm-0): found 460 extents, stage: move
data extents
[  +1.539034] BTRFS info (device dm-0): found 459 extents, stage:
update data pointers
[Jan18 15:17] BTRFS info (device dm-0): relocating block group
2129721819136 flags system
[  +0.065094] BTRFS info (device dm-0): found 7 extents, stage: move
data extents
[  +0.065618] BTRFS info (device dm-0): relocating block group
2073887244288 flags data
[  +2.502559] BTRFS info (device dm-0): found 46657 extents, stage:
move data extents
[ +22.196772] BTRFS info (device dm-0): found 46657 extents, stage:
update data pointers
[ +13.165116] BTRFS info (device dm-0): relocating block group
2072813502464 flags data
[  +1.640444] BTRFS info (device dm-0): found 1600 extents, stage:
move data extents
[  +1.384299] BTRFS info (device dm-0): found 1600 extents, stage:
update data pointers
[  +0.928896] BTRFS info (device dm-0): relocating block group
2071739760640 flags data
[  +2.825211] BTRFS info (device dm-0): found 54693 extents, stage:
move data extents
[Jan18 15:18] BTRFS info (device dm-0): found 54693 extents, stage:
update data pointers
[ +12.152862] BTRFS info (device dm-0): relocating block group
2070666018816 flags data
[  +1.547667] BTRFS info (device dm-0): found 62 extents, stage: move
data extents
[  +1.400327] BTRFS info (device dm-0): found 62 extents, stage:
update data pointers
[  +1.033425] BTRFS info (device dm-0): relocating block group
2069592276992 flags data
[  +3.524258] BTRFS info (device dm-0): found 78889 extents, stage:
move data extents
[ +24.168486] BTRFS info (device dm-0): found 78889 extents, stage:
update data pointers
[Jan18 15:19] BTRFS info (device dm-0): relocating block group
2068518535168 flags data
[  +1.624021] BTRFS info (device dm-0): found 33 extents, stage: move
data extents
[  +0.775026] BTRFS info (device dm-0): found 33 extents, stage:
update data pointers
[  +0.582753] BTRFS info (device dm-0): relocating block group
2067444793344 flags data
[  +1.311879] BTRFS info (device dm-0): found 35 extents, stage: move
data extents
[  +0.217143] BTRFS info (device dm-0): found 35 extents, stage:
update data pointers
[  +0.146575] BTRFS info (device dm-0): relocating block group
2066371051520 flags data
[  +1.431034] BTRFS info (device dm-0): found 39 extents, stage: move
data extents
[  +0.155935] BTRFS info (device dm-0): found 39 extents, stage:
update data pointers
[  +0.095757] BTRFS info (device dm-0): relocating block group
2065297309696 flags data
[  +1.404673] BTRFS info (device dm-0): found 35 extents, stage: move
data extents
[  +0.160785] BTRFS info (device dm-0): found 35 extents, stage:
update data pointers
[  +0.100834] BTRFS info (device dm-0): relocating block group
2064223567872 flags data
[  +1.402516] BTRFS info (device dm-0): found 40 extents, stage: move
data extents
[  +0.232314] BTRFS info (device dm-0): found 40 extents, stage:
update data pointers
[  +0.165339] BTRFS info (device dm-0): relocating block group
2063149826048 flags data
[  +1.869808] BTRFS info (device dm-0): found 1939 extents, stage:
move data extents
[  +4.503052] BTRFS info (device dm-0): found 1937 extents, stage:
update data pointers
[  +2.906477] BTRFS info (device dm-0): relocating block group
2061002342400 flags data
[  +1.443952] BTRFS info (device dm-0): found 30 extents, stage: move
data extents
[  +0.286753] BTRFS info (device dm-0): found 30 extents, stage:
update data pointers
[  +0.194599] BTRFS info (device dm-0): relocating block group
2059928600576 flags data
[  +3.572562] BTRFS info (device dm-0): found 74571 extents, stage:
move data extents
[ +23.451162] BTRFS info (device dm-0): found 74570 extents, stage:
update data pointers
[Jan18 15:20] BTRFS info (device dm-0): relocating block group
2058854858752 flags data
[  +1.700115] BTRFS info (device dm-0): found 1665 extents, stage:
move data extents
[  +0.901153] BTRFS info (device dm-0): found 1665 extents, stage:
update data pointers
[  +0.607655] BTRFS info (device dm-0): relocating block group
2057781116928 flags data
[  +1.449949] BTRFS info (device dm-0): found 2794 extents, stage:
move data extents
[  +3.413562] BTRFS info (device dm-0): found 2794 extents, stage:
update data pointers
[  +2.257800] BTRFS info (device dm-0): relocating block group
2056707375104 flags data
[  +1.442171] BTRFS info (device dm-0): found 2679 extents, stage:
move data extents
[  +3.334947] BTRFS info (device dm-0): found 2679 extents, stage:
update data pointers
[  +2.246454] BTRFS info (device dm-0): relocating block group
2055633633280 flags data
[  +1.328482] BTRFS info (device dm-0): found 37 extents, stage: move
data extents
[  +0.292447] BTRFS info (device dm-0): found 37 extents, stage:
update data pointers
[  +0.188969] BTRFS info (device dm-0): relocating block group
2054559891456 flags data
[  +1.437067] BTRFS info (device dm-0): found 2589 extents, stage:
move data extents
[  +3.732309] BTRFS info (device dm-0): found 2589 extents, stage:
update data pointers
[  +2.275773] BTRFS info (device dm-0): relocating block group
2053486149632 flags data
[  +1.430712] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.194770] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.154586] BTRFS info (device dm-0): relocating block group
2052412407808 flags data
[  +1.457710] BTRFS info (device dm-0): found 2845 extents, stage:
move data extents
[  +3.623591] BTRFS info (device dm-0): found 2845 extents, stage:
update data pointers
[  +2.355431] BTRFS info (device dm-0): relocating block group
2051338665984 flags data
[  +1.461509] BTRFS info (device dm-0): found 2539 extents, stage:
move data extents
[  +3.903627] BTRFS info (device dm-0): found 2539 extents, stage:
update data pointers
[  +2.555836] BTRFS info (device dm-0): relocating block group
2050264924160 flags data
[  +1.405837] BTRFS info (device dm-0): found 1559 extents, stage:
move data extents
[  +3.067955] BTRFS info (device dm-0): found 1559 extents, stage:
update data pointers
[  +1.944078] BTRFS info (device dm-0): relocating block group
2049191182336 flags data
[  +1.427102] BTRFS info (device dm-0): found 2497 extents, stage:
move data extents
[  +3.311458] BTRFS info (device dm-0): found 2497 extents, stage:
update data pointers
[Jan18 15:21] BTRFS info (device dm-0): relocating block group
2048117440512 flags data
[  +1.421492] BTRFS info (device dm-0): found 1982 extents, stage:
move data extents
[  +3.101886] BTRFS info (device dm-0): found 1982 extents, stage:
update data pointers
[  +1.987725] BTRFS info (device dm-0): relocating block group
2047043698688 flags data
[  +1.431890] BTRFS info (device dm-0): found 2185 extents, stage:
move data extents
[  +3.818668] BTRFS info (device dm-0): found 2185 extents, stage:
update data pointers
[  +2.534626] BTRFS info (device dm-0): relocating block group
2045969956864 flags data
[  +1.440974] BTRFS info (device dm-0): found 2175 extents, stage:
move data extents
[  +3.755167] BTRFS info (device dm-0): found 2175 extents, stage:
update data pointers
[  +2.319663] BTRFS info (device dm-0): relocating block group
2044896215040 flags data
[  +1.361890] BTRFS info (device dm-0): found 1218 extents, stage:
move data extents
[  +2.373438] BTRFS info (device dm-0): found 1218 extents, stage:
update data pointers
[  +1.589709] BTRFS info (device dm-0): relocating block group
2043822473216 flags data
[  +1.343619] BTRFS info (device dm-0): found 48 extents, stage: move
data extents
[  +0.533085] BTRFS info (device dm-0): found 48 extents, stage:
update data pointers
[  +0.361912] BTRFS info (device dm-0): relocating block group
2042748731392 flags data
[  +1.411912] BTRFS info (device dm-0): found 1316 extents, stage:
move data extents
[  +2.677896] BTRFS info (device dm-0): found 1316 extents, stage:
update data pointers
[  +1.850915] BTRFS info (device dm-0): relocating block group
2041674989568 flags data
[  +1.502597] BTRFS info (device dm-0): found 21 extents, stage: move
data extents
[  +0.216511] BTRFS info (device dm-0): found 21 extents, stage:
update data pointers
[  +0.141037] BTRFS info (device dm-0): relocating block group
2040601247744 flags data
[  +1.340446] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.176872] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.141444] BTRFS info (device dm-0): relocating block group
2039527505920 flags data
[  +1.411345] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.196265] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.129217] BTRFS info (device dm-0): relocating block group
2038453764096 flags data
[  +1.374269] BTRFS info (device dm-0): found 15 extents, stage: move
data extents
[  +0.176726] BTRFS info (device dm-0): found 15 extents, stage:
update data pointers
[  +0.123225] BTRFS info (device dm-0): relocating block group
2037380022272 flags data
[  +1.739648] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.165755] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.129966] BTRFS info (device dm-0): relocating block group
2036306280448 flags data
[  +1.932472] BTRFS info (device dm-0): found 1850 extents, stage:
move data extents
[  +0.446125] BTRFS info (device dm-0): found 1850 extents, stage:
update data pointers
[  +0.305022] BTRFS info (device dm-0): relocating block group
2035232538624 flags data
[  +1.947639] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.244236] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.144091] BTRFS info (device dm-0): relocating block group
2034158796800 flags data
[  +1.820615] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.188222] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.155765] BTRFS info (device dm-0): relocating block group
2033085054976 flags data
[  +1.910690] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.203780] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.150358] BTRFS info (device dm-0): relocating block group
2032011313152 flags data
[  +1.879318] BTRFS info (device dm-0): found 2076 extents, stage:
move data extents
[  +1.121954] BTRFS info (device dm-0): found 2076 extents, stage:
update data pointers
[  +0.672579] BTRFS info (device dm-0): relocating block group
2030937571328 flags data
[Jan18 15:22] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.227367] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.154796] BTRFS info (device dm-0): relocating block group
2029863829504 flags data
[  +1.813351] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.178013] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.137201] BTRFS info (device dm-0): relocating block group
2028790087680 flags data
[  +1.816888] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.183610] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.130141] BTRFS info (device dm-0): relocating block group
2027716345856 flags data
[  +1.807639] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.179637] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.142093] BTRFS info (device dm-0): relocating block group
2026642604032 flags data
[  +1.947407] BTRFS info (device dm-0): found 2042 extents, stage:
move data extents
[  +0.483061] BTRFS info (device dm-0): found 2042 extents, stage:
update data pointers
[  +0.343098] BTRFS info (device dm-0): relocating block group
2025568862208 flags data
[  +1.826149] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.215095] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.144160] BTRFS info (device dm-0): relocating block group
2024495120384 flags data
[  +1.873527] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.207700] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.194623] BTRFS info (device dm-0): relocating block group
2023421378560 flags data
[  +1.862416] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.429947] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.339484] BTRFS info (device dm-0): relocating block group
2022347636736 flags data
[  +1.960028] BTRFS info (device dm-0): found 2490 extents, stage:
move data extents
[  +3.931489] BTRFS info (device dm-0): found 2490 extents, stage:
update data pointers
[  +2.434991] BTRFS info (device dm-0): relocating block group
2021273894912 flags data
[  +1.449373] BTRFS info (device dm-0): found 45 extents, stage: move
data extents
[  +0.472401] BTRFS info (device dm-0): found 45 extents, stage:
update data pointers
[  +0.323401] BTRFS info (device dm-0): relocating block group
2020200153088 flags data
[  +1.494241] BTRFS info (device dm-0): found 2903 extents, stage:
move data extents
[  +4.683839] BTRFS info (device dm-0): found 2903 extents, stage:
update data pointers
[  +3.115922] BTRFS info (device dm-0): relocating block group
2019126411264 flags data
[  +1.510117] BTRFS info (device dm-0): found 2622 extents, stage:
move data extents
[  +5.131213] BTRFS info (device dm-0): found 2622 extents, stage:
update data pointers
[  +3.070458] BTRFS info (device dm-0): relocating block group
2018052669440 flags data
[  +1.434423] BTRFS info (device dm-0): found 2307 extents, stage:
move data extents
[  +4.735976] BTRFS info (device dm-0): found 2307 extents, stage:
update data pointers
[  +3.123015] BTRFS info (device dm-0): relocating block group
2016978927616 flags data
[  +1.458941] BTRFS info (device dm-0): found 1923 extents, stage:
move data extents
[Jan18 15:23] BTRFS info (device dm-0): found 1923 extents, stage:
update data pointers
[  +2.558938] BTRFS info (device dm-0): relocating block group
2015905185792 flags data
[  +1.351306] BTRFS info (device dm-0): found 69 extents, stage: move
data extents
[  +0.669909] BTRFS info (device dm-0): found 69 extents, stage:
update data pointers
[  +0.496272] BTRFS info (device dm-0): relocating block group
2014831443968 flags data
[  +1.414796] BTRFS info (device dm-0): found 2078 extents, stage:
move data extents
[  +3.698222] BTRFS info (device dm-0): found 2078 extents, stage:
update data pointers
[  +2.559926] BTRFS info (device dm-0): relocating block group
2013757702144 flags data
[  +1.398547] BTRFS info (device dm-0): found 68 extents, stage: move
data extents
[  +0.682824] BTRFS info (device dm-0): found 68 extents, stage:
update data pointers
[  +0.452557] BTRFS info (device dm-0): relocating block group
2012683960320 flags data
[  +1.383863] BTRFS info (device dm-0): found 1707 extents, stage:
move data extents
[  +3.215996] BTRFS info (device dm-0): found 1707 extents, stage:
update data pointers
[  +2.076637] BTRFS info (device dm-0): relocating block group
2011610218496 flags data
[  +1.341684] BTRFS info (device dm-0): found 37 extents, stage: move
data extents
[  +0.479734] BTRFS info (device dm-0): found 37 extents, stage:
update data pointers
[  +0.323390] BTRFS info (device dm-0): relocating block group
2010536476672 flags data
[  +1.419589] BTRFS info (device dm-0): found 24 extents, stage: move
data extents
[  +0.320294] BTRFS info (device dm-0): found 24 extents, stage:
update data pointers
[  +0.242661] BTRFS info (device dm-0): relocating block group
2009462734848 flags data
[  +1.436751] BTRFS info (device dm-0): found 1703 extents, stage:
move data extents
[  +2.578643] BTRFS info (device dm-0): found 1703 extents, stage:
update data pointers
[  +1.739102] BTRFS info (device dm-0): relocating block group
2008388993024 flags data
[  +1.448745] BTRFS info (device dm-0): found 41 extents, stage: move
data extents
[  +0.223190] BTRFS info (device dm-0): found 41 extents, stage:
update data pointers
[  +0.156651] BTRFS info (device dm-0): relocating block group
2007315251200 flags data
[  +1.335698] BTRFS info (device dm-0): found 33 extents, stage: move
data extents
[  +0.224016] BTRFS info (device dm-0): found 33 extents, stage:
update data pointers
[  +0.140561] BTRFS info (device dm-0): relocating block group
2006241509376 flags data
[  +1.760992] BTRFS info (device dm-0): found 29 extents, stage: move
data extents
[  +0.172769] BTRFS info (device dm-0): found 29 extents, stage:
update data pointers
[  +0.116607] BTRFS info (device dm-0): relocating block group
2005167767552 flags data
[  +1.858305] BTRFS info (device dm-0): found 25 extents, stage: move
data extents
[  +0.198643] BTRFS info (device dm-0): found 25 extents, stage:
update data pointers
[  +0.145673] BTRFS info (device dm-0): relocating block group
2004094025728 flags data
[  +1.841935] BTRFS info (device dm-0): found 27 extents, stage: move
data extents
[  +0.206199] BTRFS info (device dm-0): found 27 extents, stage:
update data pointers
[  +0.182341] BTRFS info (device dm-0): relocating block group
2003020283904 flags data
[  +1.859692] BTRFS info (device dm-0): found 30 extents, stage: move
data extents
[  +0.201690] BTRFS info (device dm-0): found 30 extents, stage:
update data pointers
[  +0.173685] BTRFS info (device dm-0): relocating block group
2001946542080 flags data
[  +1.789506] BTRFS info (device dm-0): found 29 extents, stage: move
data extents
[  +0.137047] BTRFS info (device dm-0): found 29 extents, stage:
update data pointers
[  +0.122381] BTRFS info (device dm-0): relocating block group
2000872800256 flags data
[  +1.859556] BTRFS info (device dm-0): found 26 extents, stage: move
data extents
[  +0.194175] BTRFS info (device dm-0): found 26 extents, stage:
update data pointers
[  +0.152973] BTRFS info (device dm-0): relocating block group
1999799058432 flags data
[  +1.786213] BTRFS info (device dm-0): found 32 extents, stage: move
data extents
[  +0.215460] BTRFS info (device dm-0): found 32 extents, stage:
update data pointers
[  +0.157935] BTRFS info (device dm-0): relocating block group
1998725316608 flags data
[  +1.815475] BTRFS info (device dm-0): found 27 extents, stage: move
data extents
[  +0.165652] BTRFS info (device dm-0): found 27 extents, stage:
update data pointers
[  +0.114749] BTRFS info (device dm-0): relocating block group
1997651574784 flags data
[  +1.800758] BTRFS info (device dm-0): found 25 extents, stage: move
data extents
[  +0.146149] BTRFS info (device dm-0): found 25 extents, stage:
update data pointers
[  +0.135331] BTRFS info (device dm-0): relocating block group
1996577832960 flags data
[  +1.878426] BTRFS info (device dm-0): found 29 extents, stage: move
data extents
[  +0.176956] BTRFS info (device dm-0): found 29 extents, stage:
update data pointers
[  +0.131111] BTRFS info (device dm-0): relocating block group
1995504091136 flags data
[Jan18 15:24] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.147126] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.122175] BTRFS info (device dm-0): relocating block group
1994430349312 flags data
[  +2.276458] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.172090] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.124422] BTRFS info (device dm-0): relocating block group
1993356607488 flags data
[  +1.871407] BTRFS info (device dm-0): found 30 extents, stage: move
data extents
[  +0.358960] BTRFS info (device dm-0): found 30 extents, stage:
update data pointers
[  +0.236442] BTRFS info (device dm-0): relocating block group
1992282865664 flags data
[  +1.879302] BTRFS info (device dm-0): found 1180 extents, stage:
move data extents
[  +2.315539] BTRFS info (device dm-0): found 1180 extents, stage:
update data pointers
[  +1.552886] BTRFS info (device dm-0): relocating block group
1991209123840 flags data
[  +1.355206] BTRFS info (device dm-0): found 38 extents, stage: move
data extents
[  +0.133618] BTRFS info (device dm-0): found 38 extents, stage:
update data pointers
[  +0.093376] BTRFS info (device dm-0): relocating block group
1990135382016 flags data
[  +1.699054] BTRFS info (device dm-0): found 26 extents, stage: move
data extents
[  +0.212417] BTRFS info (device dm-0): found 26 extents, stage:
update data pointers
[  +0.137081] BTRFS info (device dm-0): relocating block group
1989061640192 flags data
[  +1.821898] BTRFS info (device dm-0): found 50 extents, stage: move
data extents
[  +0.167805] BTRFS info (device dm-0): found 50 extents, stage:
update data pointers
[  +0.136514] BTRFS info (device dm-0): relocating block group
1987987898368 flags data
[  +1.867349] BTRFS info (device dm-0): found 1387 extents, stage:
move data extents
[  +2.884352] BTRFS info (device dm-0): found 1387 extents, stage:
update data pointers
[  +1.908285] BTRFS info (device dm-0): relocating block group
1986914156544 flags data
[  +1.357877] BTRFS info (device dm-0): found 48 extents, stage: move
data extents
[  +0.512938] BTRFS info (device dm-0): found 48 extents, stage:
update data pointers
[  +0.369819] BTRFS info (device dm-0): relocating block group
1985840414720 flags data
[  +1.646867] BTRFS info (device dm-0): found 52 extents, stage: move
data extents
[  +0.553390] BTRFS info (device dm-0): found 52 extents, stage:
update data pointers
[  +0.385800] BTRFS info (device dm-0): relocating block group
1984766672896 flags data
[  +1.852500] BTRFS info (device dm-0): found 19 extents, stage: move
data extents
[  +0.276453] BTRFS info (device dm-0): found 19 extents, stage:
update data pointers
[  +0.196784] BTRFS info (device dm-0): relocating block group
1983692931072 flags data
[  +1.870232] BTRFS info (device dm-0): found 1320 extents, stage:
move data extents
[  +2.601874] BTRFS info (device dm-0): found 1320 extents, stage:
update data pointers
[  +1.723474] BTRFS info (device dm-0): relocating block group
1982619189248 flags data
[  +1.358995] BTRFS info (device dm-0): found 66 extents, stage: move
data extents
[  +0.747443] BTRFS info (device dm-0): found 66 extents, stage:
update data pointers
[  +0.456505] BTRFS info (device dm-0): relocating block group
1981545447424 flags data
[  +1.642589] BTRFS info (device dm-0): found 1566 extents, stage:
move data extents
[  +2.837221] BTRFS info (device dm-0): found 1566 extents, stage:
update data pointers
[  +1.859004] BTRFS info (device dm-0): relocating block group
1980471705600 flags data
[  +1.512417] BTRFS info (device dm-0): found 1438 extents, stage:
move data extents
[  +2.373210] BTRFS info (device dm-0): found 1437 extents, stage:
update data pointers
[  +1.554840] BTRFS info (device dm-0): relocating block group
1979397963776 flags data
[  +1.471543] BTRFS info (device dm-0): found 1783 extents, stage:
move data extents
[  +2.646888] BTRFS info (device dm-0): found 1783 extents, stage:
update data pointers
[  +1.909934] BTRFS info (device dm-0): relocating block group
1978324221952 flags data
[  +1.472311] BTRFS info (device dm-0): found 1660 extents, stage:
move data extents
[Jan18 15:25] BTRFS info (device dm-0): found 1660 extents, stage:
update data pointers
[  +2.037424] BTRFS info (device dm-0): relocating block group
1977250480128 flags data
[  +1.344470] BTRFS info (device dm-0): found 70 extents, stage: move
data extents
[  +0.711845] BTRFS info (device dm-0): found 70 extents, stage:
update data pointers
[  +0.487030] BTRFS info (device dm-0): relocating block group
1976176738304 flags data
[  +1.382702] BTRFS info (device dm-0): found 1108 extents, stage:
move data extents
[  +2.629639] BTRFS info (device dm-0): found 1108 extents, stage:
update data pointers
[  +1.833785] BTRFS info (device dm-0): relocating block group
1975102996480 flags data
[  +1.406119] BTRFS info (device dm-0): found 1290 extents, stage:
move data extents
[  +3.294856] BTRFS info (device dm-0): found 1290 extents, stage:
update data pointers
[  +2.067828] BTRFS info (device dm-0): relocating block group
1974029254656 flags data
[  +1.381485] BTRFS info (device dm-0): found 1356 extents, stage:
move data extents
[  +3.056990] BTRFS info (device dm-0): found 1356 extents, stage:
update data pointers
[  +2.129743] BTRFS info (device dm-0): relocating block group
1972955512832 flags data
[  +1.527029] BTRFS info (device dm-0): found 2079 extents, stage:
move data extents
[  +3.756393] BTRFS info (device dm-0): found 2079 extents, stage:
update data pointers
[  +2.379849] BTRFS info (device dm-0): relocating block group
1971881771008 flags data
[  +1.377401] BTRFS info (device dm-0): found 1642 extents, stage:
move data extents
[  +2.748887] BTRFS info (device dm-0): found 1642 extents, stage:
update data pointers
[  +1.841603] BTRFS info (device dm-0): relocating block group
1970808029184 flags data
[  +1.339358] BTRFS info (device dm-0): found 28 extents, stage: move
data extents
[  +0.154853] BTRFS info (device dm-0): found 28 extents, stage:
update data pointers
[  +0.116762] BTRFS info (device dm-0): relocating block group
1969734287360 flags data
[  +1.320835] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.131753] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.093645] BTRFS info (device dm-0): relocating block group
1968660545536 flags data
[  +1.361227] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.137134] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.094289] BTRFS info (device dm-0): relocating block group
1967586803712 flags data
[  +1.528489] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.179555] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.184439] BTRFS info (device dm-0): relocating block group
1966513061888 flags data
[  +1.882470] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.186256] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.130652] BTRFS info (device dm-0): relocating block group
1965439320064 flags data
[  +1.890562] BTRFS info (device dm-0): found 1862 extents, stage:
move data extents
[  +1.292871] BTRFS info (device dm-0): found 1862 extents, stage:
update data pointers
[  +0.851760] BTRFS info (device dm-0): relocating block group
1964365578240 flags data
[  +1.801076] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.162885] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.116773] BTRFS info (device dm-0): relocating block group
1963291836416 flags data
[  +1.866835] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.168357] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.098133] BTRFS info (device dm-0): relocating block group
1962218094592 flags data
[  +1.881356] BTRFS info (device dm-0): found 2038 extents, stage:
move data extents
[  +0.485284] BTRFS info (device dm-0): found 2038 extents, stage:
update data pointers
[Jan18 15:26] BTRFS info (device dm-0): relocating block group
1961144352768 flags data
[  +1.736437] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.165076] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.108257] BTRFS info (device dm-0): relocating block group
1960070610944 flags data
[  +1.824415] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.171047] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.119551] BTRFS info (device dm-0): relocating block group
1958996869120 flags data
[  +1.864361] BTRFS info (device dm-0): found 2036 extents, stage:
move data extents
[  +0.435575] BTRFS info (device dm-0): found 2036 extents, stage:
update data pointers
[  +0.293417] BTRFS info (device dm-0): relocating block group
1957923127296 flags data
[  +1.883880] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.156490] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.106017] BTRFS info (device dm-0): relocating block group
1956849385472 flags data
[  +1.896695] BTRFS info (device dm-0): found 2023 extents, stage:
move data extents
[  +0.302837] BTRFS info (device dm-0): found 2023 extents, stage:
update data pointers
[  +0.227481] BTRFS info (device dm-0): relocating block group
1955775643648 flags data
[  +1.883749] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.133430] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.094742] BTRFS info (device dm-0): relocating block group
1954701901824 flags data
[  +1.887999] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.172438] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.117737] BTRFS info (device dm-0): relocating block group
1953628160000 flags data
[  +1.968091] BTRFS info (device dm-0): found 2040 extents, stage:
move data extents
[  +0.317863] BTRFS info (device dm-0): found 2040 extents, stage:
update data pointers
[  +0.250895] BTRFS info (device dm-0): relocating block group
1952554418176 flags data
[  +1.815590] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.141856] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.107801] BTRFS info (device dm-0): relocating block group
1951480676352 flags data
[  +1.836833] BTRFS info (device dm-0): found 2051 extents, stage:
move data extents
[  +0.310453] BTRFS info (device dm-0): found 2051 extents, stage:
update data pointers
[  +0.221586] BTRFS info (device dm-0): relocating block group
1950406934528 flags data
[  +1.886376] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.144677] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.140680] BTRFS info (device dm-0): relocating block group
1949333192704 flags data
[  +1.865179] BTRFS info (device dm-0): found 2034 extents, stage:
move data extents
[  +0.420899] BTRFS info (device dm-0): found 2034 extents, stage:
update data pointers
[  +0.342505] BTRFS info (device dm-0): relocating block group
1948259450880 flags data
[  +1.919596] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.134493] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.102766] BTRFS info (device dm-0): relocating block group
1947185709056 flags data
[  +1.915003] BTRFS info (device dm-0): found 2049 extents, stage:
move data extents
[  +0.318321] BTRFS info (device dm-0): found 2049 extents, stage:
update data pointers
[  +0.242183] BTRFS info (device dm-0): relocating block group
1946111967232 flags data
[  +1.892172] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.187340] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.146940] BTRFS info (device dm-0): relocating block group
1945038225408 flags data
[  +1.932929] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.161503] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.126906] BTRFS info (device dm-0): relocating block group
1943964483584 flags data
[  +1.854843] BTRFS info (device dm-0): found 2028 extents, stage:
move data extents
[  +0.289529] BTRFS info (device dm-0): found 2028 extents, stage:
update data pointers
[  +0.223101] BTRFS info (device dm-0): relocating block group
1942890741760 flags data
[  +1.878019] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.210213] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.142372] BTRFS info (device dm-0): relocating block group
1941816999936 flags data
[  +1.866994] BTRFS info (device dm-0): found 1920 extents, stage:
move data extents
[  +0.201444] BTRFS info (device dm-0): found 1920 extents, stage:
update data pointers
[  +0.162174] BTRFS info (device dm-0): relocating block group
1940743258112 flags data
[  +1.846976] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.232499] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.159624] BTRFS info (device dm-0): relocating block group
1939669516288 flags data
[  +1.884719] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.249291] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.158716] BTRFS info (device dm-0): relocating block group
1938595774464 flags data
[  +1.932780] BTRFS info (device dm-0): found 19 extents, stage: move
data extents
[  +0.385142] BTRFS info (device dm-0): found 19 extents, stage:
update data pointers
[  +0.243711] BTRFS info (device dm-0): relocating block group
1937522032640 flags data
[  +1.928080] BTRFS info (device dm-0): found 2044 extents, stage:
move data extents
[  +0.555480] BTRFS info (device dm-0): found 2044 extents, stage:
update data pointers
[  +0.425048] BTRFS info (device dm-0): relocating block group
1936448290816 flags data
[  +1.754082] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.212851] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.159746] BTRFS info (device dm-0): relocating block group
1935374548992 flags data
[  +1.909127] BTRFS info (device dm-0): found 1402 extents, stage:
move data extents
[  +1.943949] BTRFS info (device dm-0): found 1402 extents, stage:
update data pointers
[Jan18 15:27] BTRFS info (device dm-0): relocating block group
1934300807168 flags data
[  +1.342323] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.148959] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.110953] BTRFS info (device dm-0): relocating block group
1933227065344 flags data
[  +1.742664] BTRFS info (device dm-0): found 2029 extents, stage:
move data extents
[  +0.303943] BTRFS info (device dm-0): found 2029 extents, stage:
update data pointers
[  +0.248671] BTRFS info (device dm-0): relocating block group
1932153323520 flags data
[  +2.362148] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.199941] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.139143] BTRFS info (device dm-0): relocating block group
1931079581696 flags data
[  +1.888756] BTRFS info (device dm-0): found 2048 extents, stage:
move data extents
[  +0.590381] BTRFS info (device dm-0): found 2048 extents, stage:
update data pointers
[  +0.434433] BTRFS info (device dm-0): relocating block group
1930005839872 flags data
[  +1.852056] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.210354] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.143130] BTRFS info (device dm-0): relocating block group
1928932098048 flags data
[  +1.853697] BTRFS info (device dm-0): found 47 extents, stage: move
data extents
[  +0.530062] BTRFS info (device dm-0): found 47 extents, stage:
update data pointers
[  +0.379759] BTRFS info (device dm-0): relocating block group
1927858356224 flags data
[  +1.952909] BTRFS info (device dm-0): found 1960 extents, stage:
move data extents
[  +1.197421] BTRFS info (device dm-0): found 1960 extents, stage:
update data pointers
[  +0.799418] BTRFS info (device dm-0): relocating block group
1926784614400 flags data
[  +1.884481] BTRFS info (device dm-0): found 887 extents, stage: move
data extents
[  +2.468054] BTRFS info (device dm-0): found 887 extents, stage:
update data pointers
[  +1.639720] BTRFS info (device dm-0): relocating block group
1925710872576 flags data
[  +1.403017] BTRFS info (device dm-0): found 954 extents, stage: move
data extents
[  +2.511222] BTRFS info (device dm-0): found 954 extents, stage:
update data pointers
[  +1.727455] BTRFS info (device dm-0): relocating block group
1924637130752 flags data
[  +1.385607] BTRFS info (device dm-0): found 66 extents, stage: move
data extents
[  +0.343338] BTRFS info (device dm-0): found 66 extents, stage:
update data pointers
[  +0.226581] BTRFS info (device dm-0): relocating block group
1923563388928 flags data
[  +1.572663] BTRFS info (device dm-0): found 26 extents, stage: move
data extents
[  +0.323201] BTRFS info (device dm-0): found 26 extents, stage:
update data pointers
[  +0.267944] BTRFS info (device dm-0): relocating block group
1922489647104 flags data
[  +2.316298] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.202696] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.123715] BTRFS info (device dm-0): relocating block group
1921415905280 flags data
[  +1.846940] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.224589] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.157458] BTRFS info (device dm-0): relocating block group
1920342163456 flags data
[  +1.914408] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.237751] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.149428] BTRFS info (device dm-0): relocating block group
1919268421632 flags data
[  +1.899475] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.222790] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.143483] BTRFS info (device dm-0): relocating block group
1918194679808 flags data
[  +1.836259] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.136444] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.120046] BTRFS info (device dm-0): relocating block group
1917120937984 flags data
[  +1.784191] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.160878] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.104321] BTRFS info (device dm-0): relocating block group
1916047196160 flags data
[  +1.906612] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.216747] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.122355] BTRFS info (device dm-0): relocating block group
1914973454336 flags data
[  +1.840406] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.161601] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.158781] BTRFS info (device dm-0): relocating block group
1913899712512 flags data
[  +2.321431] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.195054] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.174410] BTRFS info (device dm-0): relocating block group
1912825970688 flags data
[  +1.840024] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.106174] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.096021] BTRFS info (device dm-0): relocating block group
1911752228864 flags data
[  +1.805214] BTRFS info (device dm-0): found 15 extents, stage: move
data extents
[  +0.117782] BTRFS info (device dm-0): found 15 extents, stage:
update data pointers
[  +0.117659] BTRFS info (device dm-0): relocating block group
1910678487040 flags data
[Jan18 15:28] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.117249] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.079588] BTRFS info (device dm-0): relocating block group
1909604745216 flags data
[  +1.768119] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.090763] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.085949] BTRFS info (device dm-0): relocating block group
1908531003392 flags data
[  +1.867075] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.252617] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.180265] BTRFS info (device dm-0): relocating block group
1907457261568 flags data
[  +1.779799] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.146492] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.083847] BTRFS info (device dm-0): relocating block group
1906383519744 flags data
[  +1.782194] BTRFS info (device dm-0): found 15 extents, stage: move
data extents
[  +0.172272] BTRFS info (device dm-0): found 15 extents, stage:
update data pointers
[  +0.131195] BTRFS info (device dm-0): relocating block group
1905309777920 flags data
[  +1.934596] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.239781] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.202269] BTRFS info (device dm-0): relocating block group
1904236036096 flags data
[  +1.848155] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.150609] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.139744] BTRFS info (device dm-0): relocating block group
1903162294272 flags data
[  +2.226924] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.290543] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.220096] BTRFS info (device dm-0): relocating block group
1902088552448 flags data
[  +1.802360] BTRFS info (device dm-0): found 897 extents, stage: move
data extents
[  +2.393786] BTRFS info (device dm-0): found 897 extents, stage:
update data pointers
[  +1.581112] BTRFS info (device dm-0): relocating block group
1901014810624 flags data
[  +1.488032] BTRFS info (device dm-0): found 17 extents, stage: move
data extents
[  +0.235161] BTRFS info (device dm-0): found 17 extents, stage:
update data pointers
[  +0.166514] BTRFS info (device dm-0): relocating block group
1899941068800 flags data
[  +1.782103] BTRFS info (device dm-0): found 64 extents, stage: move
data extents
[  +0.230307] BTRFS info (device dm-0): found 64 extents, stage:
update data pointers
[  +0.164212] BTRFS info (device dm-0): relocating block group
1898867326976 flags data
[  +1.813852] BTRFS info (device dm-0): found 1307 extents, stage:
move data extents
[  +2.569474] BTRFS info (device dm-0): found 1307 extents, stage:
update data pointers
[  +1.660422] BTRFS info (device dm-0): relocating block group
1897793585152 flags data
[  +1.380350] BTRFS info (device dm-0): found 35 extents, stage: move
data extents
[  +0.747984] BTRFS info (device dm-0): found 35 extents, stage:
update data pointers
[  +0.585892] BTRFS info (device dm-0): relocating block group
1896719843328 flags data
[  +1.903581] BTRFS info (device dm-0): found 997 extents, stage: move
data extents
[  +2.536151] BTRFS info (device dm-0): found 997 extents, stage:
update data pointers
[  +1.620525] BTRFS info (device dm-0): relocating block group
1895646101504 flags data
[  +1.405159] BTRFS info (device dm-0): found 36 extents, stage: move
data extents
[  +0.639695] BTRFS info (device dm-0): found 36 extents, stage:
update data pointers
[  +0.457943] BTRFS info (device dm-0): relocating block group
1894572359680 flags data
[  +2.354707] BTRFS info (device dm-0): found 883 extents, stage: move
data extents
[  +2.420688] BTRFS info (device dm-0): found 883 extents, stage:
update data pointers
[  +1.740848] BTRFS info (device dm-0): relocating block group
1893498617856 flags data
[  +1.447661] BTRFS info (device dm-0): found 1454 extents, stage:
move data extents
[  +2.660899] BTRFS info (device dm-0): found 1454 extents, stage:
update data pointers
[  +1.897413] BTRFS info (device dm-0): relocating block group
1892424876032 flags data
[  +1.459970] BTRFS info (device dm-0): found 1385 extents, stage:
move data extents
[Jan18 15:29] BTRFS info (device dm-0): found 1385 extents, stage:
update data pointers
[  +1.640389] BTRFS info (device dm-0): relocating block group
1891351134208 flags data
[  +1.336500] BTRFS info (device dm-0): found 49 extents, stage: move
data extents
[  +0.702492] BTRFS info (device dm-0): found 49 extents, stage:
update data pointers
[  +0.500944] BTRFS info (device dm-0): relocating block group
1890277392384 flags data
[  +1.638178] BTRFS info (device dm-0): found 47 extents, stage: move
data extents
[  +0.602560] BTRFS info (device dm-0): found 47 extents, stage:
update data pointers
[  +0.456685] BTRFS info (device dm-0): relocating block group
1889203650560 flags data
[  +1.744582] BTRFS info (device dm-0): found 27 extents, stage: move
data extents
[  +0.545210] BTRFS info (device dm-0): found 27 extents, stage:
update data pointers
[  +0.396886] BTRFS info (device dm-0): relocating block group
1888129908736 flags data
[  +1.903404] BTRFS info (device dm-0): found 22 extents, stage: move
data extents
[  +0.209516] BTRFS info (device dm-0): found 22 extents, stage:
update data pointers
[  +0.141258] BTRFS info (device dm-0): relocating block group
1887056166912 flags data
[  +1.845161] BTRFS info (device dm-0): found 51 extents, stage: move
data extents
[  +0.310089] BTRFS info (device dm-0): found 51 extents, stage:
update data pointers
[  +0.237863] BTRFS info (device dm-0): relocating block group
1885982425088 flags data
[  +1.855566] BTRFS info (device dm-0): found 59 extents, stage: move
data extents
[  +0.241743] BTRFS info (device dm-0): found 59 extents, stage:
update data pointers
[  +0.170057] BTRFS info (device dm-0): relocating block group
1884908683264 flags data
[  +1.887037] BTRFS info (device dm-0): found 27 extents, stage: move
data extents
[  +0.289353] BTRFS info (device dm-0): found 27 extents, stage:
update data pointers
[  +0.184901] BTRFS info (device dm-0): relocating block group
1883834941440 flags data
[  +1.850885] BTRFS info (device dm-0): found 23 extents, stage: move
data extents
[  +0.318758] BTRFS info (device dm-0): found 23 extents, stage:
update data pointers
[  +0.230512] BTRFS info (device dm-0): relocating block group
1882761199616 flags data
[  +1.939909] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.267817] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.220236] BTRFS info (device dm-0): relocating block group
1881687457792 flags data
[  +1.799009] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.311194] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.232076] BTRFS info (device dm-0): relocating block group
1880613715968 flags data
[  +2.314273] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.291773] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.278567] BTRFS info (device dm-0): relocating block group
1879539974144 flags data
[  +1.872490] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.263699] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.193143] BTRFS info (device dm-0): relocating block group
1878466232320 flags data
[  +1.870942] BTRFS info (device dm-0): found 19 extents, stage: move
data extents
[  +0.255293] BTRFS info (device dm-0): found 19 extents, stage:
update data pointers
[  +0.186072] BTRFS info (device dm-0): relocating block group
1877392490496 flags data
[  +1.747170] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.317583] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.206440] BTRFS info (device dm-0): relocating block group
1876318748672 flags data
[  +1.746095] BTRFS info (device dm-0): found 22 extents, stage: move
data extents
[  +0.281584] BTRFS info (device dm-0): found 22 extents, stage:
update data pointers
[  +0.196788] BTRFS info (device dm-0): relocating block group
1875245006848 flags data
[  +1.790148] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.170944] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.129355] BTRFS info (device dm-0): relocating block group
1874171265024 flags data
[  +1.882688] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.257740] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.179164] BTRFS info (device dm-0): relocating block group
1873097523200 flags data
[  +1.831584] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.165671] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.132274] BTRFS info (device dm-0): relocating block group
1872023781376 flags data
[  +1.921699] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.148574] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.122255] BTRFS info (device dm-0): relocating block group
1870950039552 flags data
[  +1.862075] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.287888] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.163864] BTRFS info (device dm-0): relocating block group
1869876297728 flags data
[  +1.937606] BTRFS info (device dm-0): found 15 extents, stage: move
data extents
[  +0.325174] BTRFS info (device dm-0): found 15 extents, stage:
update data pointers
[  +0.202371] BTRFS info (device dm-0): relocating block group
1868802555904 flags data
[  +1.798692] BTRFS info (device dm-0): found 24 extents, stage: move
data extents
[  +0.433876] BTRFS info (device dm-0): found 24 extents, stage:
update data pointers
[  +0.318753] BTRFS info (device dm-0): relocating block group
1867728814080 flags data
[  +1.836125] BTRFS info (device dm-0): found 23 extents, stage: move
data extents
[  +0.396579] BTRFS info (device dm-0): found 23 extents, stage:
update data pointers
[  +0.270037] BTRFS info (device dm-0): relocating block group
1866655072256 flags data
[  +1.793621] BTRFS info (device dm-0): found 19 extents, stage: move
data extents
[  +0.181265] BTRFS info (device dm-0): found 19 extents, stage:
update data pointers
[  +0.130173] BTRFS info (device dm-0): relocating block group
1865581330432 flags data
[Jan18 15:30] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.198122] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.124607] BTRFS info (device dm-0): relocating block group
1864507588608 flags data
[  +2.230042] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.134616] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.122990] BTRFS info (device dm-0): relocating block group
1863433846784 flags data
[  +1.886734] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.221389] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.131962] BTRFS info (device dm-0): relocating block group
1862360104960 flags data
[  +1.940544] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.210752] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.129371] BTRFS info (device dm-0): relocating block group
1861286363136 flags data
[  +1.920760] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.089871] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.085510] BTRFS info (device dm-0): relocating block group
1860212621312 flags data
[  +1.803495] BTRFS info (device dm-0): found 17 extents, stage: move
data extents
[  +0.182062] BTRFS info (device dm-0): found 17 extents, stage:
update data pointers
[  +0.109635] BTRFS info (device dm-0): relocating block group
1859138879488 flags data
[  +1.884533] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.239849] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.161135] BTRFS info (device dm-0): relocating block group
1858065137664 flags data
[  +1.780992] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.192000] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.130109] BTRFS info (device dm-0): relocating block group
1856991395840 flags data
[  +1.805865] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.158671] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.138704] BTRFS info (device dm-0): relocating block group
1855917654016 flags data
[  +1.963063] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.399432] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.292183] BTRFS info (device dm-0): relocating block group
1854843912192 flags data
[  +1.782793] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.169588] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.122886] BTRFS info (device dm-0): relocating block group
1853770170368 flags data
[  +2.274450] BTRFS info (device dm-0): found 21 extents, stage: move
data extents
[  +0.195638] BTRFS info (device dm-0): found 21 extents, stage:
update data pointers
[  +0.131735] BTRFS info (device dm-0): relocating block group
1852696428544 flags data
[  +1.920556] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.270411] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.199844] BTRFS info (device dm-0): relocating block group
1851622686720 flags data
[  +1.970271] BTRFS info (device dm-0): found 17 extents, stage: move
data extents
[  +0.292499] BTRFS info (device dm-0): found 17 extents, stage:
update data pointers
[  +0.246485] BTRFS info (device dm-0): relocating block group
1850548944896 flags data
[  +1.871794] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.409908] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.311424] BTRFS info (device dm-0): relocating block group
1849475203072 flags data
[  +1.863845] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.154208] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.107943] BTRFS info (device dm-0): relocating block group
1848401461248 flags data
[  +1.879255] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.349066] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.227388] BTRFS info (device dm-0): relocating block group
1847327719424 flags data
[  +1.834747] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.213292] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.145553] BTRFS info (device dm-0): relocating block group
1846253977600 flags data
[  +1.803118] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.146268] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.106827] BTRFS info (device dm-0): relocating block group
1845180235776 flags data
[  +1.862181] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.133106] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.095811] BTRFS info (device dm-0): relocating block group
1844106493952 flags data
[  +1.754079] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.171550] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.123360] BTRFS info (device dm-0): relocating block group
1843032752128 flags data
[  +1.951133] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.171380] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.123972] BTRFS info (device dm-0): relocating block group
1841959010304 flags data
[  +1.877135] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.282191] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.185858] BTRFS info (device dm-0): relocating block group
1840885268480 flags data
[  +1.969287] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.201108] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.132812] BTRFS info (device dm-0): relocating block group
1839811526656 flags data
[  +1.915000] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.120233] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.097121] BTRFS info (device dm-0): relocating block group
1838737784832 flags data
[  +1.863966] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.134343] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.082146] BTRFS info (device dm-0): relocating block group
1837664043008 flags data
[Jan18 15:31] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.285729] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.214210] BTRFS info (device dm-0): relocating block group
1836590301184 flags data
[  +2.339026] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.140070] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.111376] BTRFS info (device dm-0): relocating block group
1835516559360 flags data
[  +1.814820] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.171900] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.175193] BTRFS info (device dm-0): relocating block group
1834442817536 flags data
[  +2.296078] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.111720] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.083575] BTRFS info (device dm-0): relocating block group
1833369075712 flags data
[  +1.917608] BTRFS info (device dm-0): found 9 extents, stage: move
data extents
[  +0.140694] BTRFS info (device dm-0): found 9 extents, stage: update
data pointers
[  +0.098782] BTRFS info (device dm-0): relocating block group
1832295333888 flags data
[  +1.883019] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.485472] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.345505] BTRFS info (device dm-0): relocating block group
1831221592064 flags data
[  +1.871773] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.199338] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.145115] BTRFS info (device dm-0): relocating block group
1830147850240 flags data
[  +1.859378] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.100011] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.084456] BTRFS info (device dm-0): relocating block group
1829074108416 flags data
[  +1.933656] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.138491] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.092675] BTRFS info (device dm-0): relocating block group
1828000366592 flags data
[  +1.828926] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.078954] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.072920] BTRFS info (device dm-0): relocating block group
1826926624768 flags data
[  +1.888995] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.497314] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.426377] BTRFS info (device dm-0): relocating block group
1825852882944 flags data
[  +1.927275] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.128912] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.078261] BTRFS info (device dm-0): relocating block group
1824779141120 flags data
[  +1.898284] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.125154] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.092461] BTRFS info (device dm-0): relocating block group
1823705399296 flags data
[  +2.317144] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.174705] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.119288] BTRFS info (device dm-0): relocating block group
1822631657472 flags data
[  +1.905608] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.276132] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.174775] BTRFS info (device dm-0): relocating block group
1821557915648 flags data
[  +1.826314] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.302948] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.205361] BTRFS info (device dm-0): relocating block group
1820484173824 flags data
[  +1.732618] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.244363] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.172857] BTRFS info (device dm-0): relocating block group
1819410432000 flags data
[  +1.829754] BTRFS info (device dm-0): found 9 extents, stage: move
data extents
[  +0.108347] BTRFS info (device dm-0): found 9 extents, stage: update
data pointers
[  +0.079036] BTRFS info (device dm-0): relocating block group
1818336690176 flags data
[  +1.781351] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.197770] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.160088] BTRFS info (device dm-0): relocating block group
1817262948352 flags data
[  +2.419586] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.239409] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.188505] BTRFS info (device dm-0): relocating block group
1816189206528 flags data
[  +1.835942] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.153959] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.102475] BTRFS info (device dm-0): relocating block group
1815115464704 flags data
[  +1.831717] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.116978] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.092410] BTRFS info (device dm-0): relocating block group
1814041722880 flags data
[  +1.796583] BTRFS info (device dm-0): found 17 extents, stage: move
data extents
[  +0.267918] BTRFS info (device dm-0): found 17 extents, stage:
update data pointers
[  +0.177186] BTRFS info (device dm-0): relocating block group
1812967981056 flags data
[  +1.807108] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.336896] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.224821] BTRFS info (device dm-0): relocating block group
1811894239232 flags data
[  +1.807698] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.308662] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.216204] BTRFS info (device dm-0): relocating block group
1810820497408 flags data
[  +1.936610] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.353134] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.251301] BTRFS info (device dm-0): relocating block group
1809746755584 flags data
[Jan18 15:32] BTRFS info (device dm-0): found 21 extents, stage: move
data extents
[  +0.543884] BTRFS info (device dm-0): found 21 extents, stage:
update data pointers
[  +0.422833] BTRFS info (device dm-0): relocating block group
1808673013760 flags data
[  +1.811009] BTRFS info (device dm-0): found 15 extents, stage: move
data extents
[  +0.361473] BTRFS info (device dm-0): found 15 extents, stage:
update data pointers
[  +0.279057] BTRFS info (device dm-0): relocating block group
1807599271936 flags data
[  +1.810041] BTRFS info (device dm-0): found 43 extents, stage: move
data extents
[  +1.115458] BTRFS info (device dm-0): found 43 extents, stage:
update data pointers
[  +0.556756] BTRFS info (device dm-0): relocating block group
1806525530112 flags data
[  +1.813335] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.313798] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.217929] BTRFS info (device dm-0): relocating block group
1805451788288 flags data
[  +1.877624] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.203914] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.142318] BTRFS info (device dm-0): relocating block group
1804378046464 flags data
[  +1.919095] BTRFS info (device dm-0): found 23 extents, stage: move
data extents
[  +0.523149] BTRFS info (device dm-0): found 23 extents, stage:
update data pointers
[  +0.414063] BTRFS info (device dm-0): relocating block group
1803304304640 flags data
[  +1.975284] BTRFS info (device dm-0): found 19 extents, stage: move
data extents
[  +1.341553] BTRFS info (device dm-0): found 19 extents, stage:
update data pointers
[  +1.001495] BTRFS info (device dm-0): relocating block group
1802230562816 flags data
[  +2.375586] BTRFS info (device dm-0): found 855 extents, stage: move
data extents
[  +2.133894] BTRFS info (device dm-0): found 855 extents, stage:
update data pointers
[  +1.491660] BTRFS info (device dm-0): relocating block group
1801156820992 flags data
[  +1.917908] BTRFS info (device dm-0): found 1094 extents, stage:
move data extents
[  +1.718834] BTRFS info (device dm-0): found 1094 extents, stage:
update data pointers
[  +1.147222] BTRFS info (device dm-0): relocating block group
1800083079168 flags data
[  +1.764109] BTRFS info (device dm-0): found 1248 extents, stage:
move data extents
[  +2.341981] BTRFS info (device dm-0): found 1248 extents, stage:
update data pointers
[  +1.578723] BTRFS info (device dm-0): relocating block group
1799009337344 flags data
[  +1.466985] BTRFS info (device dm-0): found 1186 extents, stage:
move data extents
[  +2.304285] BTRFS info (device dm-0): found 1186 extents, stage:
update data pointers
[  +1.558209] BTRFS info (device dm-0): relocating block group
1797935595520 flags data
[  +1.372763] BTRFS info (device dm-0): found 975 extents, stage: move
data extents
[  +2.451016] BTRFS info (device dm-0): found 975 extents, stage:
update data pointers
[  +1.606516] BTRFS info (device dm-0): relocating block group
1796861853696 flags data
[  +1.499352] BTRFS info (device dm-0): found 24 extents, stage: move
data extents
[  +0.475993] BTRFS info (device dm-0): found 24 extents, stage:
update data pointers
[  +0.371364] BTRFS info (device dm-0): relocating block group
1795788111872 flags data
[  +1.845694] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.723875] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.547518] BTRFS info (device dm-0): relocating block group
1794714370048 flags data
[  +1.869671] BTRFS info (device dm-0): found 906 extents, stage: move
data extents
[  +1.891215] BTRFS info (device dm-0): found 906 extents, stage:
update data pointers
[  +1.353180] BTRFS info (device dm-0): relocating block group
1793640628224 flags data
[  +1.778399] BTRFS info (device dm-0): found 784 extents, stage: move
data extents
[  +1.419679] BTRFS info (device dm-0): found 784 extents, stage:
update data pointers
[Jan18 15:33] BTRFS info (device dm-0): relocating block group
1792566886400 flags data
[  +1.759242] BTRFS info (device dm-0): found 22 extents, stage: move
data extents
[  +0.497966] BTRFS info (device dm-0): found 22 extents, stage:
update data pointers
[  +0.344907] BTRFS info (device dm-0): relocating block group
1791493144576 flags data
[  +2.314003] BTRFS info (device dm-0): found 830 extents, stage: move
data extents
[  +1.408640] BTRFS info (device dm-0): found 830 extents, stage:
update data pointers
[  +0.961377] BTRFS info (device dm-0): relocating block group
1790419402752 flags data
[  +1.801392] BTRFS info (device dm-0): found 42 extents, stage: move
data extents
[  +0.564685] BTRFS info (device dm-0): found 42 extents, stage:
update data pointers
[  +0.376232] BTRFS info (device dm-0): relocating block group
1789345660928 flags data
[  +1.797604] BTRFS info (device dm-0): found 29 extents, stage: move
data extents
[  +0.438418] BTRFS info (device dm-0): found 29 extents, stage:
update data pointers
[  +0.325281] BTRFS info (device dm-0): relocating block group
1788271919104 flags data
[  +1.811432] BTRFS info (device dm-0): found 779 extents, stage: move
data extents
[  +1.897506] BTRFS info (device dm-0): found 779 extents, stage:
update data pointers
[  +1.261706] BTRFS info (device dm-0): relocating block group
1787198177280 flags data
[  +1.360274] BTRFS info (device dm-0): found 26 extents, stage: move
data extents
[  +0.257925] BTRFS info (device dm-0): found 26 extents, stage:
update data pointers
[  +0.174671] BTRFS info (device dm-0): relocating block group
1786124435456 flags data
[  +1.741916] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.146005] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.111865] BTRFS info (device dm-0): relocating block group
1785050693632 flags data
[  +1.741906] BTRFS info (device dm-0): found 31 extents, stage: move
data extents
[  +0.384683] BTRFS info (device dm-0): found 31 extents, stage:
update data pointers
[  +0.261380] BTRFS info (device dm-0): relocating block group
1783976951808 flags data
[  +1.912694] BTRFS info (device dm-0): found 19 extents, stage: move
data extents
[  +0.396872] BTRFS info (device dm-0): found 19 extents, stage:
update data pointers
[  +0.268553] BTRFS info (device dm-0): relocating block group
1782903209984 flags data
[  +0.897771] perf: interrupt took too long (3138 > 3132), lowering
kernel.perf_event_max_sample_rate to 63600
[  +0.989661] BTRFS info (device dm-0): found 689 extents, stage: move
data extents
[  +1.195618] BTRFS info (device dm-0): found 689 extents, stage:
update data pointers
[  +0.826292] BTRFS info (device dm-0): relocating block group
1781829468160 flags data
[  +1.873815] BTRFS info (device dm-0): found 30 extents, stage: move
data extents
[  +0.379113] BTRFS info (device dm-0): found 30 extents, stage:
update data pointers
[  +0.268466] BTRFS info (device dm-0): relocating block group
1780755726336 flags data
[  +1.797967] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.274540] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.199422] BTRFS info (device dm-0): relocating block group
1779681984512 flags data
[  +1.854451] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.306483] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.252639] BTRFS info (device dm-0): relocating block group
1778608242688 flags data
[  +1.838613] BTRFS info (device dm-0): found 1018 extents, stage:
move data extents
[  +1.572379] BTRFS info (device dm-0): found 1018 extents, stage:
update data pointers
[  +1.052787] BTRFS info (device dm-0): relocating block group
1777534500864 flags data
[  +1.389221] BTRFS info (device dm-0): found 37 extents, stage: move
data extents
[  +0.555892] BTRFS info (device dm-0): found 37 extents, stage:
update data pointers
[  +0.391729] BTRFS info (device dm-0): relocating block group
1776460759040 flags data
[  +1.835117] BTRFS info (device dm-0): found 1116 extents, stage:
move data extents
[  +2.129584] BTRFS info (device dm-0): found 1116 extents, stage:
update data pointers
[  +1.597729] BTRFS info (device dm-0): relocating block group
1775387017216 flags data
[  +1.353225] BTRFS info (device dm-0): found 42 extents, stage: move
data extents
[  +0.462916] BTRFS info (device dm-0): found 42 extents, stage:
update data pointers
[  +0.345040] BTRFS info (device dm-0): relocating block group
1774313275392 flags data
[  +2.224150] BTRFS info (device dm-0): found 846 extents, stage: move
data extents
[  +2.014359] BTRFS info (device dm-0): found 846 extents, stage:
update data pointers
[  +1.320804] BTRFS info (device dm-0): relocating block group
1773239533568 flags data
[Jan18 15:34] BTRFS info (device dm-0): found 1175 extents, stage:
move data extents
[  +1.611452] BTRFS info (device dm-0): found 1175 extents, stage:
update data pointers
[  +1.072158] BTRFS info (device dm-0): relocating block group
1772165791744 flags data
[  +3.036914] BTRFS info (device dm-0): found 64785 extents, stage:
move data extents
[ +23.416847] BTRFS info (device dm-0): found 64785 extents, stage:
update data pointers
[ +12.289026] BTRFS info (device dm-0): relocating block group
1771092049920 flags data
[  +1.614726] BTRFS info (device dm-0): found 1382 extents, stage:
move data extents
[  +1.955299] BTRFS info (device dm-0): found 1382 extents, stage:
update data pointers
[  +1.278824] BTRFS info (device dm-0): relocating block group
1770018308096 flags data
[  +1.448794] BTRFS info (device dm-0): found 935 extents, stage: move
data extents
[  +2.028987] BTRFS info (device dm-0): found 935 extents, stage:
update data pointers
[  +1.333203] BTRFS info (device dm-0): relocating block group
1768944566272 flags data
[  +1.377773] BTRFS info (device dm-0): found 46 extents, stage: move
data extents
[  +0.812661] BTRFS info (device dm-0): found 46 extents, stage:
update data pointers
[  +0.620178] BTRFS info (device dm-0): relocating block group
1767870824448 flags data
[  +1.341231] BTRFS info (device dm-0): found 25 extents, stage: move
data extents
[  +0.363535] BTRFS info (device dm-0): found 25 extents, stage:
update data pointers
[  +0.253634] BTRFS info (device dm-0): relocating block group
1766797082624 flags data
[  +2.401630] BTRFS info (device dm-0): found 34679 extents, stage:
move data extents
[Jan18 15:35] BTRFS info (device dm-0): found 34679 extents, stage:
update data pointers
[  +5.380733] BTRFS info (device dm-0): relocating block group
1765723340800 flags data
[  +1.531713] BTRFS info (device dm-0): found 59 extents, stage: move
data extents
[  +0.515041] BTRFS info (device dm-0): found 59 extents, stage:
update data pointers
[  +0.315432] BTRFS info (device dm-0): relocating block group
1764649598976 flags data
[  +1.332150] BTRFS info (device dm-0): found 45 extents, stage: move
data extents
[  +0.691447] BTRFS info (device dm-0): found 45 extents, stage:
update data pointers
[  +0.536337] BTRFS info (device dm-0): relocating block group
1763575857152 flags data
[  +1.433081] BTRFS info (device dm-0): found 702 extents, stage: move
data extents
[  +1.424609] BTRFS info (device dm-0): found 702 extents, stage:
update data pointers
[  +0.967585] BTRFS info (device dm-0): relocating block group
1762502115328 flags data
[  +2.189979] BTRFS info (device dm-0): found 28198 extents, stage:
move data extents
[  +8.807881] BTRFS info (device dm-0): found 28198 extents, stage:
update data pointers
[  +5.356099] BTRFS info (device dm-0): relocating block group
1761428373504 flags data
[  +1.526870] BTRFS info (device dm-0): found 1336 extents, stage:
move data extents
[  +1.944510] BTRFS info (device dm-0): found 1336 extents, stage:
update data pointers
[  +1.323061] BTRFS info (device dm-0): relocating block group
1760354631680 flags data
[  +1.411223] BTRFS info (device dm-0): found 1102 extents, stage:
move data extents
[  +1.755539] BTRFS info (device dm-0): found 1102 extents, stage:
update data pointers
[  +1.222713] BTRFS info (device dm-0): relocating block group
1759280889856 flags data
[  +1.395351] BTRFS info (device dm-0): found 1221 extents, stage:
move data extents
[  +1.708770] BTRFS info (device dm-0): found 1221 extents, stage:
update data pointers
[  +1.120983] BTRFS info (device dm-0): relocating block group
1758207148032 flags data
[  +2.129996] BTRFS info (device dm-0): found 29477 extents, stage:
move data extents
[Jan18 15:36] BTRFS info (device dm-0): found 29477 extents, stage:
update data pointers
[  +5.391773] BTRFS info (device dm-0): relocating block group
1757133406208 flags data
[  +1.521947] BTRFS info (device dm-0): found 37 extents, stage: move
data extents
[  +0.401179] BTRFS info (device dm-0): found 37 extents, stage:
update data pointers
[  +0.269363] BTRFS info (device dm-0): relocating block group
1756059664384 flags data
[  +1.360415] BTRFS info (device dm-0): found 1230 extents, stage:
move data extents
[  +1.453533] BTRFS info (device dm-0): found 1230 extents, stage:
update data pointers
[  +1.074541] BTRFS info (device dm-0): relocating block group
1754985922560 flags data
[  +1.418285] BTRFS info (device dm-0): found 760 extents, stage: move
data extents
[  +0.891472] BTRFS info (device dm-0): found 760 extents, stage:
update data pointers
[  +0.605636] BTRFS info (device dm-0): relocating block group
1753912180736 flags data
[  +1.370039] BTRFS info (device dm-0): found 551 extents, stage: move
data extents
[  +0.799415] BTRFS info (device dm-0): found 551 extents, stage:
update data pointers
[  +0.589182] BTRFS info (device dm-0): relocating block group
1752838438912 flags data
[  +1.425957] BTRFS info (device dm-0): found 704 extents, stage: move
data extents
[  +1.156866] BTRFS info (device dm-0): found 704 extents, stage:
update data pointers
[  +0.880107] BTRFS info (device dm-0): relocating block group
1751764697088 flags data
[  +1.795441] BTRFS info (device dm-0): found 1227 extents, stage:
move data extents
[  +1.619985] BTRFS info (device dm-0): found 1227 extents, stage:
update data pointers
[  +1.139882] BTRFS info (device dm-0): relocating block group
1750690955264 flags data
[  +1.583835] BTRFS info (device dm-0): found 27 extents, stage: move
data extents
[  +0.342619] BTRFS info (device dm-0): found 27 extents, stage:
update data pointers
[  +0.244353] BTRFS info (device dm-0): relocating block group
1749617213440 flags data
[  +1.819598] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +1.038783] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.822581] BTRFS info (device dm-0): relocating block group
1748543471616 flags data
[  +1.927728] BTRFS info (device dm-0): found 1230 extents, stage:
move data extents
[  +1.487686] BTRFS info (device dm-0): found 1230 extents, stage:
update data pointers
[  +1.035083] BTRFS info (device dm-0): relocating block group
1747469729792 flags data
[  +1.507985] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.231730] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.186809] BTRFS info (device dm-0): relocating block group
1746395987968 flags data
[  +1.799635] BTRFS info (device dm-0): found 48 extents, stage: move
data extents
[  +0.314016] BTRFS info (device dm-0): found 48 extents, stage:
update data pointers
[  +0.218637] BTRFS info (device dm-0): relocating block group
1745322246144 flags data
[  +2.936662] BTRFS info (device dm-0): found 42929 extents, stage:
move data extents
[ +13.030772] BTRFS info (device dm-0): found 42929 extents, stage:
update data pointers
[Jan18 15:37] BTRFS info (device dm-0): relocating block group
1744248504320 flags data
[  +1.515959] BTRFS info (device dm-0): found 728 extents, stage: move
data extents
[  +1.204363] BTRFS info (device dm-0): found 728 extents, stage:
update data pointers
[  +0.888499] BTRFS info (device dm-0): relocating block group
1743174762496 flags data
[  +1.323773] BTRFS info (device dm-0): found 36 extents, stage: move
data extents
[  +0.258220] BTRFS info (device dm-0): found 36 extents, stage:
update data pointers
[  +0.185390] BTRFS info (device dm-0): relocating block group
1742101020672 flags data
[  +1.378884] BTRFS info (device dm-0): found 29 extents, stage: move
data extents
[  +0.192066] BTRFS info (device dm-0): found 29 extents, stage:
update data pointers
[  +0.145597] BTRFS info (device dm-0): relocating block group
1741027278848 flags data
[  +1.415071] BTRFS info (device dm-0): found 15 extents, stage: move
data extents
[  +0.211695] BTRFS info (device dm-0): found 15 extents, stage:
update data pointers
[  +0.235096] BTRFS info (device dm-0): relocating block group
1739953537024 flags data
[  +1.386272] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.280566] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.227339] BTRFS info (device dm-0): relocating block group
1738879795200 flags data
[  +1.837290] BTRFS info (device dm-0): found 28 extents, stage: move
data extents
[  +0.278503] BTRFS info (device dm-0): found 28 extents, stage:
update data pointers
[  +0.196478] BTRFS info (device dm-0): relocating block group
1737806053376 flags data
[  +1.812032] BTRFS info (device dm-0): found 41 extents, stage: move
data extents
[  +0.315089] BTRFS info (device dm-0): found 41 extents, stage:
update data pointers
[  +0.236575] BTRFS info (device dm-0): relocating block group
1736732311552 flags data
[  +1.872742] BTRFS info (device dm-0): found 261 extents, stage: move
data extents
[  +0.721183] BTRFS info (device dm-0): found 261 extents, stage:
update data pointers
[  +0.535634] BTRFS info (device dm-0): relocating block group
1735658569728 flags data
[  +1.856382] BTRFS info (device dm-0): found 60 extents, stage: move
data extents
[  +0.176813] BTRFS info (device dm-0): found 60 extents, stage:
update data pointers
[  +0.148883] BTRFS info (device dm-0): relocating block group
1734584827904 flags data
[  +1.905047] BTRFS info (device dm-0): found 82 extents, stage: move
data extents
[  +0.167200] BTRFS info (device dm-0): found 82 extents, stage:
update data pointers
[  +0.120110] BTRFS info (device dm-0): relocating block group
1733511086080 flags data
[  +1.739304] BTRFS info (device dm-0): found 99 extents, stage: move
data extents
[  +0.154532] BTRFS info (device dm-0): found 99 extents, stage:
update data pointers
[  +0.105657] BTRFS info (device dm-0): relocating block group
1732437344256 flags data
[  +1.789583] BTRFS info (device dm-0): found 96 extents, stage: move
data extents
[  +0.206162] BTRFS info (device dm-0): found 96 extents, stage:
update data pointers
[  +0.144819] BTRFS info (device dm-0): relocating block group
1731363602432 flags data
[  +1.865640] BTRFS info (device dm-0): found 163 extents, stage: move
data extents
[  +0.334403] BTRFS info (device dm-0): found 163 extents, stage:
update data pointers
[  +0.198242] BTRFS info (device dm-0): relocating block group
1730289860608 flags data
[  +1.820457] BTRFS info (device dm-0): found 91 extents, stage: move
data extents
[  +0.224481] BTRFS info (device dm-0): found 91 extents, stage:
update data pointers
[  +0.131074] BTRFS info (device dm-0): relocating block group
1729216118784 flags data
[  +1.756657] BTRFS info (device dm-0): found 93 extents, stage: move
data extents
[  +0.185247] BTRFS info (device dm-0): found 93 extents, stage:
update data pointers
[  +0.143976] BTRFS info (device dm-0): relocating block group
1728142376960 flags data
[  +1.798142] BTRFS info (device dm-0): found 91 extents, stage: move
data extents
[  +0.213334] BTRFS info (device dm-0): found 91 extents, stage:
update data pointers
[  +0.124316] BTRFS info (device dm-0): relocating block group
1727068635136 flags data
[  +1.747703] BTRFS info (device dm-0): found 90 extents, stage: move
data extents
[  +0.157803] BTRFS info (device dm-0): found 90 extents, stage:
update data pointers
[  +0.129692] BTRFS info (device dm-0): relocating block group
1725994893312 flags data
[  +1.848725] BTRFS info (device dm-0): found 54 extents, stage: move
data extents
[  +0.164671] BTRFS info (device dm-0): found 54 extents, stage:
update data pointers
[  +0.150116] BTRFS info (device dm-0): relocating block group
1724921151488 flags data
[  +1.846372] BTRFS info (device dm-0): found 172 extents, stage: move
data extents
[  +0.303865] BTRFS info (device dm-0): found 172 extents, stage:
update data pointers
[  +0.186243] BTRFS info (device dm-0): relocating block group
1723847409664 flags data
[  +1.771598] BTRFS info (device dm-0): found 51 extents, stage: move
data extents
[  +0.168787] BTRFS info (device dm-0): found 51 extents, stage:
update data pointers
[  +0.129464] BTRFS info (device dm-0): relocating block group
1722773667840 flags data
[  +1.816257] BTRFS info (device dm-0): found 62 extents, stage: move
data extents
[  +0.172642] BTRFS info (device dm-0): found 62 extents, stage:
update data pointers
[  +0.151443] BTRFS info (device dm-0): relocating block group
1721699926016 flags data
[  +1.906123] BTRFS info (device dm-0): found 100 extents, stage: move
data extents
[  +0.202493] BTRFS info (device dm-0): found 100 extents, stage:
update data pointers
[  +0.138571] BTRFS info (device dm-0): relocating block group
1720626184192 flags data
[  +1.844822] BTRFS info (device dm-0): found 168 extents, stage: move
data extents
[  +0.182580] BTRFS info (device dm-0): found 168 extents, stage:
update data pointers
[  +0.140475] BTRFS info (device dm-0): relocating block group
1719552442368 flags data
[  +1.884502] BTRFS info (device dm-0): found 175 extents, stage: move
data extents
[  +0.322209] BTRFS info (device dm-0): found 175 extents, stage:
update data pointers
[  +0.290644] BTRFS info (device dm-0): relocating block group
1718478700544 flags data
[Jan18 15:38] BTRFS info (device dm-0): found 84 extents, stage: move
data extents
[  +0.245612] BTRFS info (device dm-0): found 84 extents, stage:
update data pointers
[  +0.160941] BTRFS info (device dm-0): relocating block group
1717404958720 flags data
[  +1.901109] BTRFS info (device dm-0): found 75 extents, stage: move
data extents
[  +0.219144] BTRFS info (device dm-0): found 75 extents, stage:
update data pointers
[  +0.163908] BTRFS info (device dm-0): relocating block group
1716331216896 flags data
[  +1.932018] BTRFS info (device dm-0): found 57 extents, stage: move
data extents
[  +0.187188] BTRFS info (device dm-0): found 57 extents, stage:
update data pointers
[  +0.142422] BTRFS info (device dm-0): relocating block group
1715257475072 flags data
[  +1.866722] BTRFS info (device dm-0): found 59 extents, stage: move
data extents
[  +0.190847] BTRFS info (device dm-0): found 59 extents, stage:
update data pointers
[  +0.129264] BTRFS info (device dm-0): relocating block group
1714183733248 flags data
[  +2.218005] BTRFS info (device dm-0): found 61 extents, stage: move
data extents
[  +0.194671] BTRFS info (device dm-0): found 61 extents, stage:
update data pointers
[  +0.123223] BTRFS info (device dm-0): relocating block group
1713109991424 flags data
[  +1.885663] BTRFS info (device dm-0): found 62 extents, stage: move
data extents
[  +0.165960] BTRFS info (device dm-0): found 62 extents, stage:
update data pointers
[  +0.129910] BTRFS info (device dm-0): relocating block group
1712036249600 flags data
[  +1.865937] BTRFS info (device dm-0): found 59 extents, stage: move
data extents
[  +0.173198] BTRFS info (device dm-0): found 59 extents, stage:
update data pointers
[  +0.139583] BTRFS info (device dm-0): relocating block group
1710962507776 flags data
[  +1.766376] BTRFS info (device dm-0): found 59 extents, stage: move
data extents
[  +0.179085] BTRFS info (device dm-0): found 59 extents, stage:
update data pointers
[  +0.160538] BTRFS info (device dm-0): relocating block group
1709888765952 flags data
[  +1.842057] BTRFS info (device dm-0): found 64 extents, stage: move
data extents
[  +0.179781] BTRFS info (device dm-0): found 64 extents, stage:
update data pointers
[  +0.123149] BTRFS info (device dm-0): relocating block group
1708815024128 flags data
[  +1.827349] BTRFS info (device dm-0): found 61 extents, stage: move
data extents
[  +0.178081] BTRFS info (device dm-0): found 61 extents, stage:
update data pointers
[  +0.132655] BTRFS info (device dm-0): relocating block group
1707741282304 flags data
[  +1.773292] BTRFS info (device dm-0): found 62 extents, stage: move
data extents
[  +0.172274] BTRFS info (device dm-0): found 62 extents, stage:
update data pointers
[  +0.145388] BTRFS info (device dm-0): relocating block group
1706667540480 flags data
[  +1.894854] BTRFS info (device dm-0): found 62 extents, stage: move
data extents
[  +0.241122] BTRFS info (device dm-0): found 62 extents, stage:
update data pointers
[  +0.165314] BTRFS info (device dm-0): relocating block group
1705593798656 flags data
[  +1.759554] BTRFS info (device dm-0): found 62 extents, stage: move
data extents
[  +0.161678] BTRFS info (device dm-0): found 62 extents, stage:
update data pointers
[  +0.150910] BTRFS info (device dm-0): relocating block group
1704520056832 flags data
[  +1.850081] BTRFS info (device dm-0): found 276 extents, stage: move
data extents
[  +0.344245] BTRFS info (device dm-0): found 276 extents, stage:
update data pointers
[  +0.255345] BTRFS info (device dm-0): relocating block group
1703446315008 flags data
[  +1.872553] BTRFS info (device dm-0): found 61 extents, stage: move
data extents
[  +0.245493] BTRFS info (device dm-0): found 61 extents, stage:
update data pointers
[  +0.135038] BTRFS info (device dm-0): relocating block group
1702372573184 flags data
[  +1.897030] BTRFS info (device dm-0): found 57 extents, stage: move
data extents
[  +0.175363] BTRFS info (device dm-0): found 57 extents, stage:
update data pointers
[  +0.124267] BTRFS info (device dm-0): relocating block group
1701298831360 flags data
[  +1.937438] BTRFS info (device dm-0): found 54 extents, stage: move
data extents
[  +0.172222] BTRFS info (device dm-0): found 54 extents, stage:
update data pointers
[  +0.112754] BTRFS info (device dm-0): relocating block group
1700225089536 flags data
[  +1.771464] BTRFS info (device dm-0): found 68 extents, stage: move
data extents
[  +0.238627] BTRFS info (device dm-0): found 68 extents, stage:
update data pointers
[  +0.148707] BTRFS info (device dm-0): relocating block group
1699151347712 flags data
[  +1.787826] BTRFS info (device dm-0): found 56 extents, stage: move
data extents
[  +0.179180] BTRFS info (device dm-0): found 56 extents, stage:
update data pointers
[  +0.143330] BTRFS info (device dm-0): relocating block group
1698077605888 flags data
[  +1.873635] BTRFS info (device dm-0): found 1041 extents, stage:
move data extents
[  +0.633324] BTRFS info (device dm-0): found 1041 extents, stage:
update data pointers
[  +0.526335] BTRFS info (device dm-0): relocating block group
1697003864064 flags data
[  +2.200557] BTRFS info (device dm-0): found 55 extents, stage: move
data extents
[  +0.178979] BTRFS info (device dm-0): found 55 extents, stage:
update data pointers
[  +0.131052] BTRFS info (device dm-0): relocating block group
1695930122240 flags data
[  +1.880378] BTRFS info (device dm-0): found 51 extents, stage: move
data extents
[  +0.176166] BTRFS info (device dm-0): found 51 extents, stage:
update data pointers
[  +0.173964] BTRFS info (device dm-0): relocating block group
1694856380416 flags data
[  +1.870929] BTRFS info (device dm-0): found 58 extents, stage: move
data extents
[  +0.244462] BTRFS info (device dm-0): found 58 extents, stage:
update data pointers
[  +0.200836] BTRFS info (device dm-0): relocating block group
1693782638592 flags data
[  +2.364105] BTRFS info (device dm-0): found 878 extents, stage: move
data extents
[  +0.529115] BTRFS info (device dm-0): found 878 extents, stage:
update data pointers
[  +0.429806] BTRFS info (device dm-0): relocating block group
1692708896768 flags data
[  +1.857807] BTRFS info (device dm-0): found 67 extents, stage: move
data extents
[  +0.215291] BTRFS info (device dm-0): found 67 extents, stage:
update data pointers
[  +0.164219] BTRFS info (device dm-0): relocating block group
1691635154944 flags data
[  +1.942704] BTRFS info (device dm-0): found 71 extents, stage: move
data extents
[  +0.188681] BTRFS info (device dm-0): found 71 extents, stage:
update data pointers
[  +0.176379] BTRFS info (device dm-0): relocating block group
1690561413120 flags data
[Jan18 15:39] BTRFS info (device dm-0): found 72 extents, stage: move
data extents
[  +0.225491] BTRFS info (device dm-0): found 72 extents, stage:
update data pointers
[  +0.155275] BTRFS info (device dm-0): relocating block group
1689487671296 flags data
[  +1.741103] BTRFS info (device dm-0): found 66 extents, stage: move
data extents
[  +0.204114] BTRFS info (device dm-0): found 66 extents, stage:
update data pointers
[  +0.156141] BTRFS info (device dm-0): relocating block group
1688413929472 flags data
[  +1.883923] BTRFS info (device dm-0): found 66 extents, stage: move
data extents
[  +0.161384] BTRFS info (device dm-0): found 66 extents, stage:
update data pointers
[  +0.133261] BTRFS info (device dm-0): relocating block group
1687340187648 flags data
[  +1.916049] BTRFS info (device dm-0): found 71 extents, stage: move
data extents
[  +0.290249] BTRFS info (device dm-0): found 71 extents, stage:
update data pointers
[  +0.196862] BTRFS info (device dm-0): relocating block group
1686266445824 flags data
[  +1.877467] BTRFS info (device dm-0): found 71 extents, stage: move
data extents
[  +0.188479] BTRFS info (device dm-0): found 71 extents, stage:
update data pointers
[  +0.138538] BTRFS info (device dm-0): relocating block group
1685192704000 flags data
[  +1.791204] BTRFS info (device dm-0): found 75 extents, stage: move
data extents
[  +0.184103] BTRFS info (device dm-0): found 75 extents, stage:
update data pointers
[  +0.144735] BTRFS info (device dm-0): relocating block group
1684118962176 flags data
[  +1.818887] BTRFS info (device dm-0): found 1446 extents, stage:
move data extents
[  +0.429416] BTRFS info (device dm-0): found 1446 extents, stage:
update data pointers
[  +0.319785] BTRFS info (device dm-0): relocating block group
1683045220352 flags data
[  +1.717893] BTRFS info (device dm-0): found 63 extents, stage: move
data extents
[  +0.152382] BTRFS info (device dm-0): found 63 extents, stage:
update data pointers
[  +0.136715] BTRFS info (device dm-0): relocating block group
1681971478528 flags data
[  +1.898336] BTRFS info (device dm-0): found 30 extents, stage: move
data extents
[  +0.188966] BTRFS info (device dm-0): found 30 extents, stage:
update data pointers
[  +0.145742] BTRFS info (device dm-0): relocating block group
1680897736704 flags data
[  +1.872614] BTRFS info (device dm-0): found 19 extents, stage: move
data extents
[  +0.197824] BTRFS info (device dm-0): found 19 extents, stage:
update data pointers
[  +0.120634] BTRFS info (device dm-0): relocating block group
1679823994880 flags data
[  +1.844476] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.161406] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.118709] BTRFS info (device dm-0): relocating block group
1678750253056 flags data
[  +1.962539] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.166927] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.121142] BTRFS info (device dm-0): relocating block group
1677676511232 flags data
[  +1.935658] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.197973] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.123778] BTRFS info (device dm-0): relocating block group
1676602769408 flags data
[  +1.905605] BTRFS info (device dm-0): found 1535 extents, stage:
move data extents
[  +0.515180] BTRFS info (device dm-0): found 1535 extents, stage:
update data pointers
[  +0.393992] BTRFS info (device dm-0): relocating block group
1675529027584 flags data
[  +1.869511] BTRFS info (device dm-0): found 20 extents, stage: move
data extents
[  +0.206056] BTRFS info (device dm-0): found 20 extents, stage:
update data pointers
[  +0.171974] BTRFS info (device dm-0): relocating block group
1674455285760 flags data
[  +1.985718] BTRFS info (device dm-0): found 1660 extents, stage:
move data extents
[  +0.260979] BTRFS info (device dm-0): found 1660 extents, stage:
update data pointers
[  +0.253089] BTRFS info (device dm-0): relocating block group
1673381543936 flags data
[  +1.815295] BTRFS info (device dm-0): found 9 extents, stage: move
data extents
[  +0.214912] BTRFS info (device dm-0): found 9 extents, stage: update
data pointers
[  +0.134666] BTRFS info (device dm-0): relocating block group
1672307802112 flags data
[  +1.967975] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.211979] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.137153] BTRFS info (device dm-0): relocating block group
1671234060288 flags data
[  +1.905067] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.209894] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.118050] BTRFS info (device dm-0): relocating block group
1670160318464 flags data
[  +1.865781] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.165737] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.114321] BTRFS info (device dm-0): relocating block group
1669086576640 flags data
[  +1.908920] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.216860] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.134156] BTRFS info (device dm-0): relocating block group
1668012834816 flags data
[  +1.772801] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.153822] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.132907] BTRFS info (device dm-0): relocating block group
1666939092992 flags data
[  +1.921075] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.175987] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.150064] BTRFS info (device dm-0): relocating block group
1665865351168 flags data
[  +2.261041] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.201763] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.158740] BTRFS info (device dm-0): relocating block group
1664791609344 flags data
[  +2.291396] BTRFS info (device dm-0): found 1422 extents, stage:
move data extents
[  +0.261593] BTRFS info (device dm-0): found 1422 extents, stage:
update data pointers
[  +0.182721] BTRFS info (device dm-0): relocating block group
1663717867520 flags data
[  +1.796331] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.166458] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.144567] BTRFS info (device dm-0): relocating block group
1662644125696 flags data
[Jan18 15:40] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.170432] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.133995] BTRFS info (device dm-0): relocating block group
1661570383872 flags data
[  +1.912855] BTRFS info (device dm-0): found 1792 extents, stage:
move data extents
[  +0.326616] BTRFS info (device dm-0): found 1792 extents, stage:
update data pointers
[  +0.204768] BTRFS info (device dm-0): relocating block group
1660496642048 flags data
[  +2.386293] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.197997] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.129644] BTRFS info (device dm-0): relocating block group
1659422900224 flags data
[  +1.995469] BTRFS info (device dm-0): found 1362 extents, stage:
move data extents
[  +0.301172] BTRFS info (device dm-0): found 1362 extents, stage:
update data pointers
[  +0.258044] BTRFS info (device dm-0): relocating block group
1658349158400 flags data
[  +1.879550] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.157490] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.164182] BTRFS info (device dm-0): relocating block group
1657275416576 flags data
[  +1.964488] BTRFS info (device dm-0): found 17 extents, stage: move
data extents
[  +0.250582] BTRFS info (device dm-0): found 17 extents, stage:
update data pointers
[  +0.195796] BTRFS info (device dm-0): relocating block group
1656201674752 flags data
[  +1.811922] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.172236] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.130860] BTRFS info (device dm-0): relocating block group
1655127932928 flags data
[  +1.893068] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.197495] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.132796] BTRFS info (device dm-0): relocating block group
1654054191104 flags data
[  +1.834799] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.168844] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.132309] BTRFS info (device dm-0): relocating block group
1652980449280 flags data
[  +1.880879] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.178243] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.129336] BTRFS info (device dm-0): relocating block group
1651906707456 flags data
[  +1.904469] BTRFS info (device dm-0): found 623 extents, stage: move
data extents
[  +0.301644] BTRFS info (device dm-0): found 623 extents, stage:
update data pointers
[  +0.193515] BTRFS info (device dm-0): relocating block group
1650832965632 flags data
[  +1.854034] BTRFS info (device dm-0): found 1688 extents, stage:
move data extents
[  +0.317312] BTRFS info (device dm-0): found 1688 extents, stage:
update data pointers
[  +0.270449] BTRFS info (device dm-0): relocating block group
1649759223808 flags data
[  +1.973518] BTRFS info (device dm-0): found 1636 extents, stage:
move data extents
[  +0.409077] BTRFS info (device dm-0): found 1636 extents, stage:
update data pointers
[  +0.320089] BTRFS info (device dm-0): relocating block group
1648685481984 flags data
[  +1.874692] BTRFS info (device dm-0): found 25 extents, stage: move
data extents
[  +0.196471] BTRFS info (device dm-0): found 25 extents, stage:
update data pointers
[  +0.141267] BTRFS info (device dm-0): relocating block group
1647611740160 flags data
[  +1.904289] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.242032] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.171701] BTRFS info (device dm-0): relocating block group
1646537998336 flags data
[  +1.980465] BTRFS info (device dm-0): found 9 extents, stage: move
data extents
[  +0.195983] BTRFS info (device dm-0): found 9 extents, stage: update
data pointers
[  +0.129195] BTRFS info (device dm-0): relocating block group
1645464256512 flags data
[  +2.032015] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.199831] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.131207] BTRFS info (device dm-0): relocating block group
1644390514688 flags data
[  +1.796996] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.151423] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.112601] BTRFS info (device dm-0): relocating block group
1643316772864 flags data
[  +1.871352] BTRFS info (device dm-0): found 9 extents, stage: move
data extents
[  +0.191067] BTRFS info (device dm-0): found 9 extents, stage: update
data pointers
[  +0.113767] BTRFS info (device dm-0): relocating block group
1642243031040 flags data
[  +1.810208] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.139687] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.128003] BTRFS info (device dm-0): relocating block group
1641169289216 flags data
[  +1.831015] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.159633] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.118783] BTRFS info (device dm-0): relocating block group
1640095547392 flags data
[  +1.873606] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.245216] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.150641] BTRFS info (device dm-0): relocating block group
1639021805568 flags data
[  +1.800583] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.145354] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.100661] BTRFS info (device dm-0): relocating block group
1637948063744 flags data
[  +1.856758] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.134611] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.106316] BTRFS info (device dm-0): relocating block group
1636874321920 flags data
[  +1.855402] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.165764] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.101155] BTRFS info (device dm-0): relocating block group
1635800580096 flags data
[  +1.803072] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.188786] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.140617] BTRFS info (device dm-0): relocating block group
1634726838272 flags data
[  +1.933371] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.193772] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.146844] BTRFS info (device dm-0): relocating block group
1633653096448 flags data
[Jan18 15:41] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.178378] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.103848] BTRFS info (device dm-0): relocating block group
1632579354624 flags data
[  +1.912264] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.133523] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.111321] BTRFS info (device dm-0): relocating block group
1631505612800 flags data
[  +1.819323] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.143731] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.095014] BTRFS info (device dm-0): relocating block group
1630431870976 flags data
[  +1.952136] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.306485] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.169258] BTRFS info (device dm-0): relocating block group
1629358129152 flags data
[  +1.901437] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.194508] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.144616] BTRFS info (device dm-0): relocating block group
1628284387328 flags data
[  +2.402461] BTRFS info (device dm-0): found 1883 extents, stage:
move data extents
[  +0.419908] BTRFS info (device dm-0): found 1883 extents, stage:
update data pointers
[  +0.301955] BTRFS info (device dm-0): relocating block group
1627210645504 flags data
[  +1.732529] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.134921] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.111327] BTRFS info (device dm-0): relocating block group
1626136903680 flags data
[  +1.877563] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.128910] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.137152] BTRFS info (device dm-0): relocating block group
1625063161856 flags data
[  +1.827860] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.234928] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.157183] BTRFS info (device dm-0): relocating block group
1623989420032 flags data
[  +1.922616] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.162762] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.130033] BTRFS info (device dm-0): relocating block group
1622915678208 flags data
[  +1.919295] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.174292] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.150524] BTRFS info (device dm-0): relocating block group
1621841936384 flags data
[  +1.863584] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.262755] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.217283] BTRFS info (device dm-0): relocating block group
1620768194560 flags data
[  +2.348312] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.299007] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.190522] BTRFS info (device dm-0): relocating block group
1619694452736 flags data
[  +1.782406] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.233468] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.177405] BTRFS info (device dm-0): relocating block group
1618620710912 flags data
[  +1.893692] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.238344] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.162962] BTRFS info (device dm-0): relocating block group
1617546969088 flags data
[  +1.765575] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.172865] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.129820] BTRFS info (device dm-0): relocating block group
1616473227264 flags data
[  +1.901372] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.225566] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.153010] BTRFS info (device dm-0): relocating block group
1615399485440 flags data
[  +1.882379] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.350681] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.226379] BTRFS info (device dm-0): relocating block group
1614325743616 flags data
[  +1.852368] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.295428] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.232584] BTRFS info (device dm-0): relocating block group
1613252001792 flags data
[  +1.795275] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.195833] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.203187] BTRFS info (device dm-0): relocating block group
1612178259968 flags data
[  +1.809400] BTRFS info (device dm-0): found 10 extents, stage: move
data extents
[  +0.150127] BTRFS info (device dm-0): found 10 extents, stage:
update data pointers
[  +0.118860] BTRFS info (device dm-0): relocating block group
1611104518144 flags data
[  +1.906588] BTRFS info (device dm-0): found 11 extents, stage: move
data extents
[  +0.240311] BTRFS info (device dm-0): found 11 extents, stage:
update data pointers
[  +0.150966] BTRFS info (device dm-0): relocating block group
1610030776320 flags data
[  +1.762170] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.192513] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.154407] BTRFS info (device dm-0): relocating block group
1608957034496 flags data
[  +1.857186] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.260707] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.199493] BTRFS info (device dm-0): relocating block group
1607883292672 flags data
[  +2.591479] BTRFS info (device dm-0): found 24955 extents, stage:
move data extents
[Jan18 15:42] BTRFS info (device dm-0): found 24955 extents, stage:
update data pointers
[  +5.449343] BTRFS info (device dm-0): relocating block group
1606809550848 flags data
[  +1.525704] BTRFS info (device dm-0): found 14 extents, stage: move
data extents
[  +0.340943] BTRFS info (device dm-0): found 14 extents, stage:
update data pointers
[  +0.233302] BTRFS info (device dm-0): relocating block group
1605735809024 flags data
[  +1.380640] BTRFS info (device dm-0): found 8 extents, stage: move
data extents
[  +0.189133] BTRFS info (device dm-0): found 8 extents, stage: update
data pointers
[  +0.104769] BTRFS info (device dm-0): relocating block group
1604662067200 flags data
[  +1.333495] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.296764] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.215755] BTRFS info (device dm-0): relocating block group
1603588325376 flags data
[  +1.406112] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.219436] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.171222] BTRFS info (device dm-0): relocating block group
1602514583552 flags data
[  +1.466037] BTRFS info (device dm-0): found 9 extents, stage: move
data extents
[  +0.147672] BTRFS info (device dm-0): found 9 extents, stage: update
data pointers
[  +0.114967] BTRFS info (device dm-0): relocating block group
1601440841728 flags data
[  +1.709771] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.213070] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.174122] BTRFS info (device dm-0): relocating block group
1600367099904 flags data
[  +1.769315] BTRFS info (device dm-0): found 12 extents, stage: move
data extents
[  +0.238652] BTRFS info (device dm-0): found 12 extents, stage:
update data pointers
[  +0.163959] BTRFS info (device dm-0): relocating block group
1599293358080 flags data
[  +1.760721] BTRFS info (device dm-0): found 22 extents, stage: move
data extents
[  +0.289657] BTRFS info (device dm-0): found 22 extents, stage:
update data pointers
[  +0.231629] BTRFS info (device dm-0): relocating block group
1597145874432 flags data
[  +1.871272] BTRFS info (device dm-0): found 19 extents, stage: move
data extents
[  +0.379288] BTRFS info (device dm-0): found 19 extents, stage:
update data pointers
[  +0.298328] BTRFS info (device dm-0): relocating block group
1596072132608 flags data
[  +1.779985] BTRFS info (device dm-0): found 16 extents, stage: move
data extents
[  +0.249093] BTRFS info (device dm-0): found 16 extents, stage:
update data pointers
[  +0.220527] BTRFS info (device dm-0): relocating block group
1594998390784 flags data
[  +1.755254] BTRFS info (device dm-0): found 28 extents, stage: move
data extents
[  +0.255958] BTRFS info (device dm-0): found 28 extents, stage:
update data pointers
[  +0.220113] BTRFS info (device dm-0): relocating block group
1593924648960 flags data
[  +1.800747] BTRFS info (device dm-0): found 28 extents, stage: move
data extents
[  +0.327398] BTRFS info (device dm-0): found 28 extents, stage:
update data pointers
[  +0.242606] BTRFS info (device dm-0): relocating block group
1592850907136 flags data
[  +1.723629] BTRFS info (device dm-0): found 17 extents, stage: move
data extents
[  +0.224580] BTRFS info (device dm-0): found 17 extents, stage:
update data pointers
[  +0.178353] BTRFS info (device dm-0): relocating block group
1591777165312 flags data
[  +1.788822] BTRFS info (device dm-0): found 17 extents, stage: move
data extents
[  +0.250485] BTRFS info (device dm-0): found 17 extents, stage:
update data pointers
[  +0.197592] BTRFS info (device dm-0): relocating block group
1590703423488 flags data
[  +1.750810] BTRFS info (device dm-0): found 21 extents, stage: move
data extents
[  +0.231510] BTRFS info (device dm-0): found 21 extents, stage:
update data pointers
[  +0.200242] BTRFS info (device dm-0): relocating block group
1589629681664 flags data
[  +1.765997] BTRFS info (device dm-0): found 17 extents, stage: move
data extents
[  +0.274539] BTRFS info (device dm-0): found 17 extents, stage:
update data pointers
[  +0.196786] BTRFS info (device dm-0): relocating block group
1588555939840 flags data
[  +1.806441] BTRFS info (device dm-0): found 24 extents, stage: move
data extents
[  +0.317318] BTRFS info (device dm-0): found 24 extents, stage:
update data pointers
[  +0.198630] BTRFS info (device dm-0): relocating block group
1587482198016 flags data
[  +1.719075] BTRFS info (device dm-0): found 21 extents, stage: move
data extents
[  +0.241412] BTRFS info (device dm-0): found 21 extents, stage:
update data pointers
[  +0.163149] BTRFS info (device dm-0): relocating block group
1586408456192 flags data
[  +1.771510] BTRFS info (device dm-0): found 28 extents, stage: move
data extents
[  +0.316996] BTRFS info (device dm-0): found 28 extents, stage:
update data pointers
[  +0.220585] BTRFS info (device dm-0): relocating block group
1585334714368 flags data
[  +1.846705] BTRFS info (device dm-0): found 24 extents, stage: move
data extents
[  +0.354401] BTRFS info (device dm-0): found 24 extents, stage:
update data pointers
[  +0.204265] BTRFS info (device dm-0): relocating block group
1584260972544 flags data
[  +1.731777] BTRFS info (device dm-0): found 32 extents, stage: move
data extents
[  +0.213906] BTRFS info (device dm-0): found 32 extents, stage:
update data pointers
[  +0.172966] BTRFS info (device dm-0): relocating block group
1583187230720 flags data
[  +2.552611] BTRFS info (device dm-0): found 30749 extents, stage:
move data extents
[Jan18 15:43] BTRFS info (device dm-0): found 30749 extents, stage:
update data pointers
[  +4.242339] BTRFS info (device dm-0): relocating block group
1579966005248 flags data
[  +1.595657] BTRFS info (device dm-0): found 1399 extents, stage:
move data extents
[  +1.134944] BTRFS info (device dm-0): found 1399 extents, stage:
update data pointers
[  +0.766037] BTRFS info (device dm-0): relocating block group
1578892263424 flags data
[  +1.355692] BTRFS info (device dm-0): found 31 extents, stage: move
data extents
[  +0.202763] BTRFS info (device dm-0): found 31 extents, stage:
update data pointers
[  +0.162848] BTRFS info (device dm-0): relocating block group
1577818521600 flags data
[  +1.329057] BTRFS info (device dm-0): found 21 extents, stage: move
data extents
[  +0.148113] BTRFS info (device dm-0): found 21 extents, stage:
update data pointers
[  +0.125740] BTRFS info (device dm-0): relocating block group
1576744779776 flags data
[  +1.325564] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.118156] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.093427] BTRFS info (device dm-0): relocating block group
1575671037952 flags data
[  +1.416460] BTRFS info (device dm-0): found 13 extents, stage: move
data extents
[  +0.133543] BTRFS info (device dm-0): found 13 extents, stage:
update data pointers
[  +0.107911] BTRFS info (device dm-0): relocating block group
1574563741696 flags data
[  +1.765062] BTRFS info (device dm-0): found 862 extents, stage: move
data extents
[  +0.951968] BTRFS info (device dm-0): found 862 extents, stage:
update data pointers
[  +0.628234] BTRFS info (device dm-0): relocating block group
1573489999872 flags data
[  +1.721233] BTRFS info (device dm-0): found 18 extents, stage: move
data extents
[  +0.275571] BTRFS info (device dm-0): found 18 extents, stage:
update data pointers
[  +0.155941] BTRFS info (device dm-0): relocating block group
1572416258048 flags data
[  +2.470482] BTRFS info (device dm-0): found 21244 extents, stage:
move data extents
[  +8.365052] BTRFS info (device dm-0): found 21244 extents, stage:
update data pointers
[  +5.340568] BTRFS info (device dm-0): relocating block group
299998642176 flags data
[  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
move data extents
[  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
for logical 404419657728 length 16384
[  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
for logical 404419657728 length 16384
[Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -5
[Jan18 17:31] netfs: FS-Cache loaded
[  +0.051228] RPC: Registered named UNIX socket transport module.
[  +0.000002] RPC: Registered udp transport module.
[  +0.000001] RPC: Registered tcp transport module.
[  +0.000001] RPC: Registered tcp-with-tls transport module.
[  +0.000001] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  +0.060368] Key type dns_resolver registered
[  +0.141764] NFS: Registering the id_resolver key type
[  +0.000010] Key type id_resolver registered
[  +0.000001] Key type id_legacy registered
[Jan18 21:13] perf: interrupt took too long (3932 > 3922), lowering
kernel.perf_event_max_sample_rate to 50700

On Sat, Jan 18, 2025 at 9:47=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/1/19 11:53, Dave T =E5=86=99=E9=81=93:
> > I have BTRFS running on a laptop with a SK Hynix Gold P31 NVMe 2TB
> > drive. Since I started using this drive I have seen a few BTRFS
> > errors, but scrub has been able to fix them. But today I went one step
> > further and found this "critical" error. Here's how it happened.
> >
> > I was downloading a large (4GB) file when my filesystem went
> > read-only. I was not out of space. I rebooted. After rebooting,
> > everything seemed fine. I ran my usual BTRFS maintenance, which is a
> > filtered balance and scrub. No errors were found. (This is the 2nd or
> > 3rd time I have seen this exact scenario since I upgraded to the SK
> > Hynix SSD.)
> >
> > This time I decided to run full balance without filters. That task
> > failed the first time with the error:
> >
> > BTRFS info (device dm-0): balance: ended with status: -22
> >
> > The filtered balance ran successfully again, but the second full
> > balance also failed with:
> >
> > BTRFS critical (device dm-0): unable to find chunk map for logical
> > 404419657728 length 16384
> >
> > I will paste most of my console output with just a few parts trimmed
> > to make it less redundant. My bash function for the filtered balance
> > is included too.
>
> The most important part is the full dmesg, at least including the first
> error and its call trace.
>
> Single line dmesg seldomly helps.
>
> Also "btrfs check --readonly" on the unmounted fs.
>
> Thanks,
> Qu
>
> >
> > balance() {
> >          echo "starting btrfs balance for $path"
> >          path=3D$1
> >          runtime=3D0
> >          while [ $runtime -le $max_runtime ] && [ $dval -le $max_dusage=
 ]
> >          do
> >                  echo "starting btrfs balance with $dval, $mval ..."
> >                  start=3D$(date +%s)
> >                  time btrfs balance start -dusage=3D$dval -dlimit=3D2..=
10
> > -musage=3D$mval -mlimit=3D2..10 "$path"
> >                  end=3D$(date +%s)
> >                  runtime=3D$(( $end - $start ))
> >                  #echo "runtime =3D $runtime"
> >                  dval=3D$(( $dval + $step_size ))
> >                  mval=3D$(( $mval + $step_size ))
> >          done
> > }
> >
> > dval=3D15
> > mval=3D15
> > runtime=3D0
> > max_dusage=3D100 #btrfs balance filter parameter for maximum dusage so
> > balance does not run a very long time
> > max_runtime=3D360 #if any balance iteratin exceeds this time, that is
> > the last balance run on that path
> > step_size=3D5 #increment of dusage and musage filter parameters with
> > each loop iteration
> >
> > Filesystem            Size  Used Avail Use% Mounted on
> > /dev/mapper/rootluks  1.9T  733G  1.1T  40% /
> > Overall:
> >      Device size:                   1.80TiB
> >      Device allocated:            741.04GiB
> >      Device unallocated:            1.08TiB
> >      Device missing:                  0.00B
> >      Device slack:                    0.00B
> >      Used:                        731.96GiB
> >      Free (estimated):              1.08TiB      (min: 1.08TiB)
> >      Free (statfs, df):             1.08TiB
> >      Data ratio:                       1.00
> >      Metadata ratio:                   1.00
> >      Global reserve:              512.00MiB      (used: 0.00B)
> >      Multiple profiles:                  no
> >
> > Data,single: Size:736.01GiB, Used:728.07GiB (98.92%)
> >     /dev/mapper/rootluks  736.01GiB
> >
> > Metadata,single: Size:5.00GiB, Used:3.90GiB (77.98%)
> >     /dev/mapper/rootluks    5.00GiB
> >
> > System,single: Size:32.00MiB, Used:112.00KiB (0.34%)
> >     /dev/mapper/rootluks   32.00MiB
> >
> > Unallocated:
> >     /dev/mapper/rootluks    1.08TiB
> >
> > starting btrfs balance for /
> > starting btrfs balance with 15, 15 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 20, 20 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 25, 25 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 30, 30 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 35, 35 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 40, 40 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 45, 45 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 50, 50 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 55, 55 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 60, 60 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 65, 65 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 70, 70 ...
> > Done, had to relocate 2 out of 743 chunks
> >
> > starting btrfs balance with 75, 75 ...
> > Done, had to relocate 3 out of 743 chunks
> >
> > starting btrfs balance with 80, 80 ...
> > Done, had to relocate 4 out of 743 chunks
> >
> > starting btrfs balance with 85, 85 ...
> > Done, had to relocate 5 out of 743 chunks
> >
> > starting btrfs balance with 90, 90 ...
> > Done, had to relocate 3 out of 741 chunks
> >
> > starting btrfs scrub ...
> > Starting scrub on devid 1
> > scrub done for xxxxxxxxxxx
> > Scrub started:    Sat Jan 18 13:23:04 2025
> > Status:           finished
> > Duration:         0:05:15
> > Total to scrub:   732.04GiB
> > Rate:             2.32GiB/s
> > Error summary:    no errors found
> >
> > btrfs bal start /
> > WARNING:
> >
> >          Full balance without filters requested. This operation is very
> >          intense and takes potentially very long. It is recommended to
> >          use the balance filters to narrow down the scope of balance.
> >          Use 'btrfs balance start --full-balance' option to skip this
> >          warning. The operation will start in 10 seconds.
> >          Use Ctrl-C to stop it.
> > 10 9 8 7 6 5 4 3 2 1
> > Starting balance without any filters.
> > ERROR: error during balancing '/': Invalid argument
> > There may be more info in syslog - try dmesg | tail
> >
> > # dmesg | tail
> > [  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000010
> > [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000074c0=
e2887ced
> > [  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI: 00000000=
00000003
> > [  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09: 00000000=
00000000
> > [  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000=
00000000
> > [  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15: 00000000=
00000000
> > [  +0.000004]  </TASK>
> > [  +0.000001] ---[ end trace 0000000000000000 ]---
> > [ +15.464049] BTRFS info (device dm-0): balance: ended with status: -22
> > [Jan18 14:39] perf: interrupt took too long (2506 > 2500), lowering
> > kernel.perf_event_max_sample_rate to 79800
> >
> > starting filtered btrfs balance again...
> > [...]
> > starting btrfs balance with 90, 90 ...
> > Done, had to relocate 5 out of 739 chunks
> >
> > starting btrfs scrub ...
> > Starting scrub on devid 1
> > scrub done for xxxxxxxxx
> > Scrub started:    Sat Jan 18 14:54:41 2025
> > Status:           finished
> > Duration:         0:04:59
> > Total to scrub:   732.45GiB
> > Rate:             2.45GiB/s
> > Error summary:    no errors found
> > Finished btrfs maintenance.
> >
> >
> > btrfs bal start /
> > WARNING:
> >
> >          Full balance without filters requested. This operation is very
> >          intense and takes potentially very long. It is recommended to
> >          use the balance filters to narrow down the scope of balance.
> >          Use 'btrfs balance start --full-balance' option to skip this
> >          warning. The operation will start in 10 seconds.
> >          Use Ctrl-C to stop it.
> > 10 9 8 7 6 5 4 3 2 1
> > Starting balance without any filters.
> > ERROR: error during balancing '/': Input/output error
> > There may be more info in syslog - try dmesg | tail
> >
> > dmesg | tail -n 40
> > [  +1.771510] BTRFS info (device dm-0): found 28 extents, stage: move
> > data extents
> > [  +0.316996] BTRFS info (device dm-0): found 28 extents, stage:
> > update data pointers
> > [  +0.220585] BTRFS info (device dm-0): relocating block group
> > 1585334714368 flags data
> > [  +1.846705] BTRFS info (device dm-0): found 24 extents, stage: move
> > data extents
> > [  +0.354401] BTRFS info (device dm-0): found 24 extents, stage:
> > update data pointers
> > [  +0.204265] BTRFS info (device dm-0): relocating block group
> > 1584260972544 flags data
> > [  +1.731777] BTRFS info (device dm-0): found 32 extents, stage: move
> > data extents
> > [  +0.213906] BTRFS info (device dm-0): found 32 extents, stage:
> > update data pointers
> > [  +0.172966] BTRFS info (device dm-0): relocating block group
> > 1583187230720 flags data
> > [  +2.552611] BTRFS info (device dm-0): found 30749 extents, stage:
> > move data extents
> > [Jan18 15:43] BTRFS info (device dm-0): found 30749 extents, stage:
> > update data pointers
> > [  +4.242339] BTRFS info (device dm-0): relocating block group
> > 1579966005248 flags data
> > [  +1.595657] BTRFS info (device dm-0): found 1399 extents, stage:
> > move data extents
> > [  +1.134944] BTRFS info (device dm-0): found 1399 extents, stage:
> > update data pointers
> > [  +0.766037] BTRFS info (device dm-0): relocating block group
> > 1578892263424 flags data
> > [  +1.355692] BTRFS info (device dm-0): found 31 extents, stage: move
> > data extents
> > [  +0.202763] BTRFS info (device dm-0): found 31 extents, stage:
> > update data pointers
> > [  +0.162848] BTRFS info (device dm-0): relocating block group
> > 1577818521600 flags data
> > [  +1.329057] BTRFS info (device dm-0): found 21 extents, stage: move
> > data extents
> > [  +0.148113] BTRFS info (device dm-0): found 21 extents, stage:
> > update data pointers
> > [  +0.125740] BTRFS info (device dm-0): relocating block group
> > 1576744779776 flags data
> > [  +1.325564] BTRFS info (device dm-0): found 18 extents, stage: move
> > data extents
> > [  +0.118156] BTRFS info (device dm-0): found 18 extents, stage:
> > update data pointers
> > [  +0.093427] BTRFS info (device dm-0): relocating block group
> > 1575671037952 flags data
> > [  +1.416460] BTRFS info (device dm-0): found 13 extents, stage: move
> > data extents
> > [  +0.133543] BTRFS info (device dm-0): found 13 extents, stage:
> > update data pointers
> > [  +0.107911] BTRFS info (device dm-0): relocating block group
> > 1574563741696 flags data
> > [  +1.765062] BTRFS info (device dm-0): found 862 extents, stage: move
> > data extents
> > [  +0.951968] BTRFS info (device dm-0): found 862 extents, stage:
> > update data pointers
> > [  +0.628234] BTRFS info (device dm-0): relocating block group
> > 1573489999872 flags data
> > [  +1.721233] BTRFS info (device dm-0): found 18 extents, stage: move
> > data extents
> > [  +0.275571] BTRFS info (device dm-0): found 18 extents, stage:
> > update data pointers
> > [  +0.155941] BTRFS info (device dm-0): relocating block group
> > 1572416258048 flags data
> > [  +2.470482] BTRFS info (device dm-0): found 21244 extents, stage:
> > move data extents
> > [  +8.365052] BTRFS info (device dm-0): found 21244 extents, stage:
> > update data pointers
> > [  +5.340568] BTRFS info (device dm-0): relocating block group
> > 299998642176 flags data
> > [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
> > move data extents
> > [  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
> > for logical 404419657728 length 16384
> > [  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
> > for logical 404419657728 length 16384
> > [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -5
> >
>


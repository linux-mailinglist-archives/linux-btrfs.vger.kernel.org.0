Return-Path: <linux-btrfs+bounces-10142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D69E8859
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD3B163D63
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BB193079;
	Sun,  8 Dec 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz8D1UF5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDF28691
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733698228; cv=none; b=cRQqMMNBbvsnegOiyfrjCEl8Iw/n/6xUAsHFdqpj2CXGJOM72qo0L8Z70cOshmF6c5RflU5nlW0baeAHff1mGVgfBlf2g9UFtkJ0Z0ruObO1rPqp11JApBWfZmrrojEfHoQwPCIZPiWJ4aLR/wINkDEXXQJdJ79XmEbl0S8PgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733698228; c=relaxed/simple;
	bh=rQ/m0WvvOMdcru3DfA5L94ELDgFzpUPTQseZnb8Ojqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeM1lc4OtfshMSCj8aX4Aw4jcdimeisF/SORk7cK06k/x2UDASixv1Yixf3lMXoohzAEZbkZpcK3azoYcl3WbKxLe/tXRqPypSA/qD7RNGeeAmHUbMzofsjocQvo2DLXN/4ue79TkK0LC6zWoXu7lMmUDQRMC4AG7KCwipFns/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz8D1UF5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so15620301fa.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733698225; x=1734303025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzw3tKnZC+BrbfE5JuGtLzc3kN1Gm7dFEC/5RSNZhF0=;
        b=dz8D1UF5oEc97tjF+P4NPhuP7sO6N1ig4q1LN2XTdZNKTbo3qoI12ujXDOCdwq51xY
         jjyI2aso+I4cYTgq1C2tMmM5TZpvYm6rvDZQgIqjh6bp9qXKbCTJgbwQoopUJTDo6cu/
         OlnCRad2QC++4GDZOEtotVVQOK5n8iDGgENBovC5tpLkPTzkzN8/kt2nwWFC28mw2Vpz
         EAPouFtaN4Yu/OqLTEil6+zg8h+1zooxEA75roMcT19o+1JsCJU97uFH49dBGQW5lZBV
         /P+d5vMMR0Ul6Gkg4gt2GgQzCrH8qGps4z2tHFOcA725YNu+5yJ747CbViC5/PPQO2Tz
         9A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733698225; x=1734303025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzw3tKnZC+BrbfE5JuGtLzc3kN1Gm7dFEC/5RSNZhF0=;
        b=xG+mrVL/vWCpq4dGrcs7hVrG/6o4XHC64Cn7dNUaA7Llhyl4ZS2H8uTVqxTaGhQEQR
         T46lOAH8cBqbcfQLbVDJIP7qvv0XdlLjsRIlMshqTx88S6CoZ4uu3elA7su5XpE4fcTj
         wRxv7wJ2Ng3aNM0e6dPY+tBw70gdRptsJM0JZvBaz5dUEUQJdPvXyvArsxfRHquIisnJ
         hreesjZODaIBAqE8a1cfAj1v+FZWpdd09QrDqLsv/wSLkiTYNlosJpibRkbjlpUd94+a
         A9Hzel7EVhSzfzb5dwud07x5Pj3M9WaCpmzeItQuIBZIJ9ZKkUcasDvLKgwNzYpVGlNa
         bNoA==
X-Gm-Message-State: AOJu0Yy7SMo6v45dLbtVNrokupH9+3MiXtjbZouFLDwL6e+qQ+tCkDUL
	MBfUcc0Sgkd9iliZwJcthwD7k2ssMv5MKhSBGtucSD2zLnMs5j4SSvN3FOmh0PyYP6I4/5fzmK8
	h9s6oMx+vBQwVQ2aMJSOwUix/PN0=
X-Gm-Gg: ASbGncsZaTWvuT4tI220nvssyshCGqWjTwtliCjkSbq231ERJhKdDJbpomQk1OdVwj9
	3DrmE2H2/lz+YoCJ2PFIBbCn3wor1R9vb
X-Google-Smtp-Source: AGHT+IEQSa+Eo6uDJVYwyskqaOsLqNc5n1vaVrFNtv55lGb40cfehX64BP9MNo9/oYbUCBBNktsH6yzWFKJ0CbZ0z8U=
X-Received: by 2002:a05:651c:545:b0:2fa:d7ea:a219 with SMTP id
 38308e7fff4ca-3002fc6c168mr30409911fa.37.1733698224763; Sun, 08 Dec 2024
 14:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
 <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com> <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
 <561aab35-007d-48d5-bf61-8cfc159cba28@gmx.com> <CADhu7iCYRjcQ2kHWqvaZYTnwVUY-qFaBSaDyZA_OL2MEpr6EYg@mail.gmail.com>
 <61140354-83ce-43cb-8bb6-fc7b5ecaa1f1@gmx.com>
In-Reply-To: <61140354-83ce-43cb-8bb6-fc7b5ecaa1f1@gmx.com>
From: j4nn <j4nn.xda@gmail.com>
Date: Sun, 8 Dec 2024 23:50:12 +0100
Message-ID: <CADhu7iBR-i9bOHRDN-adtWkoF8R9v=kvFhAySV_Fbfk_v8iFXg@mail.gmail.com>
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Dec 2024 at 23:32, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> =E5=9C=A8 2024/12/9 08:49, j4nn =E5=86=99=E9=81=93:
> > On Sun, 8 Dec 2024 at 22:36, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >> =E5=9C=A8 2024/12/9 07:55, j4nn =E5=86=99=E9=81=93:
> >>> On Sun, 8 Dec 2024 at 21:26, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>>> =E5=9C=A8 2024/12/9 02:32, j4nn =E5=86=99=E9=81=93:
> > [56068.823725] BTRFS info (device dm-0): bdev /dev/mapper/wdrb-bdata
> > errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
> > [56068.823733] BTRFS info (device dm-0): bdev /dev/mapper/wdrc-cdata
> > errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
> >
> > Just wondering what the "errs: wr 8" and "errs: wr 7" mean here?
>
> It means in the past, there are 8 write failures for the device
> wdrb-bdata, and 7 write failures for device wdrc-cdata.
>
> The error is from the lower layer, thus btrfs has no idea what happened.
> You may need to check the log to find out why.

Thank you for the explanation.
I guess that must have been from the time when replacing cpu - my
motherboard has flaky sata connectors and it's really a pain to
"position" sata cables in a way that does not cause sata errors in
kernel logs.


> > gentoo ~ # mount -o rw,remount /mnt/data
> >
> > [56709.279574] BTRFS info (device dm-0 state M): creating free space tr=
ee
> > [56893.200005] INFO: task btrfs-transacti:2510362 blocked for more
> > than 122 seconds.
> > [56893.200011]       Tainted: G        W  O       6.12.3-gentoo-x86_64 =
#1
>
> I'm a little concerned about this.
>
> Mind to share the full dmesg?
>

[56068.187456] BTRFS info (device dm-0): first mount of filesystem
1dfac20a-3f84-4149-aba0-f160ab633373
[56068.187473] BTRFS info (device dm-0): using crc32c (crc32c-intel)
checksum algorithm
[56068.187477] BTRFS info (device dm-0): using free-space-tree
[56068.823725] BTRFS info (device dm-0): bdev /dev/mapper/wdrb-bdata
errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[56068.823733] BTRFS info (device dm-0): bdev /dev/mapper/wdrc-cdata
errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
[56709.279574] BTRFS info (device dm-0 state M): creating free space tree
[56893.200005] INFO: task btrfs-transacti:2510362 blocked for more
than 122 seconds.
[56893.200011]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[56893.200014] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[56893.200016] task:btrfs-transacti state:D stack:0     pid:2510362
tgid:2510362 ppid:2      flags:0x00004000
[56893.200021] Call Trace:
[56893.200023]  <TASK>
[56893.200028]  __schedule+0x3f0/0xbd0
[56893.200037]  schedule+0x27/0xf0
[56893.200043]  btrfs_commit_transaction+0xc27/0xe80 [btrfs]
[56893.200086]  ? start_transaction+0xc0/0x820 [btrfs]
[56893.200120]  ? __pfx_autoremove_wake_function+0x10/0x10
[56893.200126]  transaction_kthread+0x159/0x1c0 [btrfs]
[56893.200160]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[56893.200198]  kthread+0xd2/0x100
[56893.200204]  ? __pfx_kthread+0x10/0x10
[56893.200209]  ret_from_fork+0x34/0x50
[56893.200214]  ? __pfx_kthread+0x10/0x10
[56893.200217]  ret_from_fork_asm+0x1a/0x30
[56893.200224]  </TASK>
[57061.541085] BTRFS info (device dm-0 state M): setting compat-ro
feature flag for FREE_SPACE_TREE (0x1)
[57061.541091] BTRFS info (device dm-0 state M): setting compat-ro
feature flag for FREE_SPACE_TREE_VALID (0x2)
[57062.642266] BTRFS info (device dm-0 state M): cleaning free space cache =
v1

> My current guess is, the v1 cache clearing is taking too much time for
> the initial mount.

I assumed the same, so I used the suggested echo to avoid repeating
that backtrace.
The initial mount after removal of v1 has been read only, the
backtrace happened when remounting rw, which started to create the
free space tree.

> We should handle it properly or it may cause false alerts for future
> migration.

Hope that helps...
Thank you.


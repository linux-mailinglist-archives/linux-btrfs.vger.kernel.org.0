Return-Path: <linux-btrfs+bounces-13480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F52A9FFC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 04:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4304D3B6AAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F0629AB11;
	Tue, 29 Apr 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Yt5Axv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3C24EAB3
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893532; cv=none; b=aIa5Sh7Ym6yeZds7/eg91NlKM9Dzvp2x17y+zwFdwob6Dye2jsw4jtIJLQABNbaA0b9g3Mapep0rAga6HVj1HCx32hDKftg5ksy9ji9395DgQDjN2tuZsb/FV5uzz/w/mPOIPJSQLD3gkvwcjd1N08QHE8MQwazaSf4cXXheYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893532; c=relaxed/simple;
	bh=P6ej6IXHfTXnRY8DcVWq4iTP7JcAKv754tsZ9JpPzws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=a0iqMr3mKWa4lHfPlaxPxHzIIQ28hIZTM001KUF0Um7ZjVQm/0aElOyBvn5GNJsC0c3iHuMHdHnX2ez552xnt9cKlkOIt6t/3xVh8d4N8pq5ebTt9zhZQEbZzIjJED6mVFuqkKSlNuOY64N28v8LE3ckYIS6GDOcJJcns8MsLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/Yt5Axv; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523dc190f95so2398142e0c.1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 19:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745893529; x=1746498329; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gqIuQy/4hdtlrH4bWfCgwln1Vu/7R6s5H0OnaglimcU=;
        b=i/Yt5AxvKDM9+UcoagL53sRle0NFMQd0M5rYUwLy3+EeT7F9sWmyRVsY7NAEmbHmKQ
         +bgDY0WVddO5ILT/WNOgEa3VBpHZl/Hc/SheO5tGTMcRcGH0wy5KIZ2mM11dRiAmYfUh
         CTuuCp3+9ODE1thMc4zafsR/rj9tBmOJUUi5vd3qqvbswIyan3FtTZrtcxFQg31RUyv3
         ZSBVVPEtezKysOHHnXOiwT7mMLxrHnuejPJET1V4wnH7C1on6zM9Ufwv9jx9LRS01u2W
         wC8WQZBdWgno0SGbr/KsE1fuIbozSXuYiZcvti4OK9FkNdZJWfk5KRG0tHKQkXDLtK3O
         mQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745893529; x=1746498329;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqIuQy/4hdtlrH4bWfCgwln1Vu/7R6s5H0OnaglimcU=;
        b=HLRIjFWBC4R0mqR15k5lZZlWiO+bazArOTvFXV5iwgvwoSWKAI0nobY1H2h/Zxx+SV
         Y2EwDkjzi9FbfApsl5oyRH80p4upMgJTNeFEmIzqdVqGQnAVbFJJsas8k4dK8+Zky4gi
         QCfvTmPbTGSwji2aMVp1OHqtpzFHqH295EOI1smibbsBRzzBzpZ/wsPzYcdv3uNiOus4
         62XK0zKpwcsHBYVTGygwbpRH0Mf6nUQeMso6eAWFKXo+UQFm3BnSDYDSkDe9/A1lue5A
         vdfT0+ckRn0doEN2y+XNyc8B1KwmjVzXHjW89Kwos3Expp+H+0vNXKIJVVC8KTqDZv0V
         cCNA==
X-Gm-Message-State: AOJu0Yx0yjV1zg6CGxyDr4ftf+PuFHUtb7YDHUhxvFLnvGAKSSMembri
	ZZWoYUGu/zHgzhJsSxEjjdKDdrl+u/6Gth8mKZL1ZN8Pc3Gf9WDFR8BS+MlpRm4Lfhkxcdwc9Pl
	WXOvpfIXxowqXc5qqcSoIWvKpDarogQ==
X-Gm-Gg: ASbGnctrDa1IWkddePzyshPpc3XW8el0rBiF4XhhuJkRLrmO+uP/8LGLTRfyzNgovOk
	djXA3vNV7ISOWJ0vrSO/NU29kEEqDOolND4CJCBzkF9dh5dOwV6oDnV6oAFMvptrZqaltwKv3Dr
	bcS538UV/45FMzUJ7vmE7vA2K4qfuOyxKRGvEUyoAF6QtAqR/LIhwZ1AXq
X-Google-Smtp-Source: AGHT+IHPIoFfOVN8CNIFJfL43EJRWTRL5E8dnzydjG1wGv0+P4dBaZxdMbxuGzRN1qAgybqJwIbFmI427r7G0dnNOAM=
X-Received: by 2002:a05:6122:3287:b0:520:4996:7d2a with SMTP id
 71dfb90a1353d-52ac0b224c3mr610705e0c.10.1745893529155; Mon, 28 Apr 2025
 19:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1745893230-14268-mlmmj-729fb3af@vger.kernel.org>
In-Reply-To: <1745893230-14268-mlmmj-729fb3af@vger.kernel.org>
From: Przemek Klosowski <przemek.klosowski@gmail.com>
Date: Mon, 28 Apr 2025 22:25:12 -0400
X-Gm-Features: ATxdqUGy84QPPEoEgHBJjUInhAR04SNPF-cj4cLnNWOZz7W3rftr9BIaV_LrLEM
Message-ID: <CAC=1GgGRobZ7sMN6iBExMuYCRzNyei_mngkyRd=kvOX9rj90Lg@mail.gmail.com>
Subject: Fwd: HTML message rejected: btrfs checksum error
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a RAID1 btrfs root/home on Fedora 42 that developed what
appears to be a single data checksum error. RAM tests fine, but it's a
DELL system that had memory problems early on (years ago), that were
fixed by Dell BIOS memory tests  (which changed the mem controller
settings).

The errors seem to have started right after a scrub (see btrfs
messages from journal below)

btrfs check --readonly --force --check-data-csum -p /dev/nvme0n1p2

shows a cascade of errors (which seem to be increasing in number)
..
[4/7] checking fs roots                        (0:00:04 elapsed, 60923
items checked)
mirror 1 bytenr 299511672832 csum 0x125beb3c expected csum
0xc8374bb569 items checked)
mirror 1 bytenr 299511676928 csum 0x4c6adf72 expected csum 0xd82f54b8
mirror 2 bytenr 299511672832 csum 0x125beb3c expected csum 0xc8374bb5
mirror 2 bytenr 299511676928 csum 0x4c6adf72 expected csum 0xd82f54b8
mirror 1 bytenr 306513821696 csum 0x8941f998 expected csum
0xa5fe1bfd94 items checked)
mirror 1 bytenr 306513825792 csum 0x8941f998 expected csum 0x77c755d4
.. and many more

I can recover the file with only 1 4kB block zeroed out.

Is there a way to read the bad sector? I thought that
mount -o ro,degraded,rescue=ignoredatacsums/dev/sda5 /mnt
would read data ignoring the bad checksum? as it is, it replicates the
I/O error that is raised when reading the original file.

Do you think that deleting the file with the bad checksum will solve
this? or should I move to rebuilding and restoring from backups?


Apr 26 22:41:04 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
started on devid 1
Apr 26 22:41:04 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
started on devid 2
Apr 26 22:41:36 fedora kernel: BTRFS error (device nvme0n1p2): unable
to fixup (regular) error at logical 452965761024 on dev /dev/nvme0n1p2
physical 74303995904
Apr 26 22:41:36 fedora kernel: BTRFS warning (device nvme0n1p2):
checksum error at logical 452965761024 on dev /dev/nvme0n1p2, physical
74303995904, root 257, inode 35328, offset 26034176, length 4096,
links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
Apr 26 22:42:52 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
finished on devid 1 with status: 0
Apr 26 22:45:46 fedora kernel: BTRFS error (device nvme0n1p2): unable
to fixup (regular) error at logical 452965761024 on dev /dev/sda5
physical 147297468416
Apr 26 22:45:46 fedora kernel: BTRFS warning (device nvme0n1p2):
checksum error at logical 452965761024 on dev /dev/sda5, physical
147297468416, root 257, inode 35328, offset 26034176, length 4096,
links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
Apr 26 22:48:45 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
finished on devid 2 with status: 0
Apr 26 22:53:23 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
started on devid 2
Apr 26 22:53:23 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
started on devid 1
Apr 26 22:53:52 fedora kernel: BTRFS error (device nvme0n1p2): unable
to fixup (regular) error at logical 452965761024 on dev /dev/nvme0n1p2
physical 74303995904
Apr 26 22:53:52 fedora kernel: BTRFS warning (device nvme0n1p2):
checksum error at logical 452965761024 on dev /dev/nvme0n1p2, physical
74303995904, root 257, inode 35328, offset 26034176, length 4096,
links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
Apr 26 22:55:07 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
finished on devid 1 with status: 0
Apr 26 22:58:04 fedora kernel: BTRFS error (device nvme0n1p2): unable
to fixup (regular) error at logical 452965761024 on dev /dev/sda5
physical 147297468416
Apr 26 22:58:04 fedora kernel: BTRFS warning (device nvme0n1p2):
checksum error at logical 452965761024 on dev /dev/sda5, physical
147297468416, root 257, inode 35328, offset 26034176, length 4096,
links 1 (path: usr/lib/sysimage/rpm/rpmdb.sqlite-wal)
Apr 26 23:01:01 fedora kernel: BTRFS info (device nvme0n1p2): scrub:
finished on devid 2 with status: 0
Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
Apr 27 07:35:32 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:32 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
Apr 27 07:35:33 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:33 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
Apr 27 07:35:55 fedora kernel: btrfs_print_data_csum_error: 2
callbacks suppressed
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:55 fedora kernel: btrfs_dev_stat_inc_and_print: 2
callbacks suppressed
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x127b77ee expected csum
0xcf4a5572 mirror 2
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/sda5 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
Apr 27 07:35:55 fedora kernel: BTRFS warning (device nvme0n1p2): csum
failed root 257 ino 35328 off 26079232 csum 0x862b6025 expected csum
0xcf4a5572 mirror 1
Apr 27 07:35:55 fedora kernel: BTRFS error (device nvme0n1p2): bdev
/dev/nvme0n1p2 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0


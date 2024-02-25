Return-Path: <linux-btrfs+bounces-2752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A85862C93
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 20:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE69E281633
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87318E27;
	Sun, 25 Feb 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0tuJFbK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4618637
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708889523; cv=none; b=W2djmPlTUbx2c2OD/PifDIedCkleKu8KrPdHE7iryPLU+889hiK28qttjswb1y+2ht6cq6Wpn57bJUzE0Ui6Co3r4P4zQjYK1v5sTKcrCXcAKMIIJtOzDmagvIY3Du+31oFSNuuMxhKYLGOHiMMrDg8tRisWT3iuOLL+g7Ca/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708889523; c=relaxed/simple;
	bh=WNP/sRVXH1/o9GxwGDYQb3koT3EpL9R8HArBzeGLOhM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Fyww1PrcQ0E121PA9tivAwp0dCQ5APHVTSuHmBHosnijVBCx/zoj2/r5C40CCm7fbOvD7lpnBWIgk9o9Lp6//Rd+BBNhrWQ+1fKfmBhCYRJNLJAsJ9Qc1B4hPqQNrpMjsMcrz39DYxw0f++TvXL7nVP78jxWX2MRA1DS2bAmEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0tuJFbK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2493310a12.1
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 11:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708889520; x=1709494320; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YpqtJc7cC3mrAWEw4Fe/obS9PwZl/LRax7v0CxFgtwI=;
        b=Y0tuJFbKWORkApLIFrzq1Qwnk4ndcU5FBEilExsq5kNjdEgyIAaMjwoiYji5v4ulgX
         ui5F1yzrUFWxD3XoQpkvrhfytBdki3i0AzfC+83qWFDaSG5mHunGbOjw8lV80dtXsbFl
         G2fIhDi8Gk4wDd/yF1nh8XvRnNGf/AdRWU2KV2uyydSde8mJHwV3ubn7JyRZIbYrNS6Y
         5gk19+Cok8GtTQfEiB5yr1HSLIheyl/9SrN1uOVvlPtCOXhQJVvzYqFkGxEw/0s8e4oN
         v+ttyQQBNOOnqBlbwVzNnQ0WHKB5sRwxqbIMfK0qa+Npxyzo4UMlt+5fYDMIDUjoEmZZ
         fV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708889520; x=1709494320;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpqtJc7cC3mrAWEw4Fe/obS9PwZl/LRax7v0CxFgtwI=;
        b=BcqJnLZtOdgS1QxOp30PFTP+5wzv9VEsUKKIeC/pZW7lf3dbav0QpWQePVq3jj0ZBy
         fRhKTXcpDem1WWbUrl9PY1Urzg9Odx7r6NWpj2iX+z3ARi4Nk88wbMnJ37xsf8y3kWUH
         kCKCdwuTqzzxZMQgg9tDEEWT8PVYlTJBMNqbIxhlaTe7cGa8Jfg0oRMhIHSGFoxSWHTy
         b/IzHZuShu5wTJa/+Ts17jSDSFUTNE+M/80W34fjcvIhkMxyto3SwvkBJ+A9m4enmm8e
         F7Rz+ReOqpl4mBewIOsgCUdN1orX1I2n4DebMgOUgRyhecstp+yrexQEDAkkq+Q49rdF
         Nnsw==
X-Gm-Message-State: AOJu0YyY+y14hSkHsHDJ46rfaQeS2CB4cMWKRHO20woY7jJlQOFx4z9a
	QliAo4pALu5C5ZsXof9D0G9R6+qQEfEwBv4KKMkeOJD76i+Gda7BqzJNB/3MJ0spP+cB+od7/+l
	4Tco9PerErq7LFtLG76ra9IMhxNaAKibAzPs=
X-Google-Smtp-Source: AGHT+IFn9FUQxD5fWtXTRa4InUv5kMwQKft8S+j7xP3Na+MDY3TZNxN/6Gduq7Vqkx6vWr2RW0KTStlcUEDv2c0bnl4=
X-Received: by 2002:a05:6a20:9f07:b0:1a0:a082:b2b8 with SMTP id
 mk7-20020a056a209f0700b001a0a082b2b8mr4820494pzb.33.1708889519867; Sun, 25
 Feb 2024 11:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?H=C3=A9rikz_Nawarro?= <herikz.nawarro@gmail.com>
Date: Sun, 25 Feb 2024 16:31:48 -0300
Message-ID: <CAD6NJSwf164xtRzdUYVh3P76YhEPamx3_njsicBbLEUUKcXTVw@mail.gmail.com>
Subject: btrfs checksum/header error while scrubing
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a btrfs array of Seagate EXOS drives with some errors in a
specific disk that started with:

/var/log/syslog.1:2024-02-21T23:33:26.759790-03:00 [redacted] kernel:
[449003.540050] sd 9:0:3:0: [sdn] tag#8849 FAILED Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_OK cmd_age=3D0s
/var/log/syslog.1-2024-02-21T23:33:26.759790-03:00 [redacted] kernel:
[449003.540052] sd 9:0:3:0: [sdn] tag#8849 Sense Key : Not Ready
[current]
/var/log/syslog.1-2024-02-21T23:33:26.759791-03:00 [redacted] kernel:
[449003.540053] sd 9:0:3:0: [sdn] tag#8849 Add. Sense: Logical unit
not ready, cause not reportable
/var/log/syslog.1-2024-02-21T23:33:26.759791-03:00 [redacted] kernel:
[449003.540054] sd 9:0:3:0: [sdn] tag#8849 CDB: Write(16) 8a 00 00 00
00 00 f2 93 37 c0 00 00 00 20 00 00
/var/log/syslog.1-2024-02-21T23:33:26.759792-03:00 [redacted] kernel:
[449003.540055] I/O error, dev sdn, sector 4069734336 op 0x1:(WRITE)
flags 0x1800 phys_seg 1 prio class 2
/var/log/syslog.1-2024-02-21T23:33:26.759792-03:00 [redacted] kernel:
[449003.540057] BTRFS error (device dm-6): bdev /dev/mapper/dados7
errs: wr 1550, rd 717, flush 0, corrupt 0, gen 0

These errors may look like a bad disk or cable, but both are new,
there are no smartctl errors and I still can mount the fs. Then I
discovered that exos drives have a power management feature
that may have seen the source of those. This feature was disabled
after I started scrubbing another disk (dados3) in the array and got
around ~100 "parent transid verify" errors on dados7:

2024-02-22T06:48:02.159759-03:00 [redacted] kernel: [475078.840590]
BTRFS error (device dm-6): parent transid verify failed on logical
155541273280512 mirror 1 wanted 119878 found 119830
2024-02-22T06:48:02.175700-03:00 [redacted] kernel: [475078.855540]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541273280512 (dev /dev/mapper/dados7 sector 4067183552)
2024-02-22T06:48:02.175707-03:00 [redacted] kernel: [475078.855881]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541273284608 (dev /dev/mapper/dados7 sector 4067183560)
2024-02-22T06:48:02.175708-03:00 [redacted] kernel: [475078.856199]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541273288704 (dev /dev/mapper/dados7 sector 4067183568)
2024-02-22T06:48:02.175709-03:00 [redacted] kernel: [475078.856503]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541273292800 (dev /dev/mapper/dados7 sector 4067183576)
2024-02-22T06:48:02.199758-03:00 [redacted] kernel: [475078.879503]
BTRFS error (device dm-6): parent transid verify failed on logical
155541811625984 mirror 1 wanted 119878 found 119830
2024-02-22T06:48:02.211728-03:00 [redacted] kernel: [475078.891915]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541811625984 (dev /dev/mapper/dados7 sector 4068235008)
2024-02-22T06:48:02.211738-03:00 [redacted] kernel: [475078.892234]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541811630080 (dev /dev/mapper/dados7 sector 4068235016)
2024-02-22T06:48:02.211739-03:00 [redacted] kernel: [475078.892534]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541811634176 (dev /dev/mapper/dados7 sector 4068235024)
2024-02-22T06:48:02.211740-03:00 [redacted] kernel: [475078.892726]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541811638272 (dev /dev/mapper/dados7 sector 4068235032)
2024-02-22T06:49:58.303802-03:00 [redacted] kernel: [475194.982119]
BTRFS warning (device dm-6): checksum verify failed on logical
155541844590592 mirror 1 wanted 0x79c87082 found 0x574aaf76 level 0
2024-02-22T06:49:58.315710-03:00 [redacted] kernel: [475194.994802]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541844590592 (dev /dev/mapper/dados7 sector 4068299392)
2024-02-22T06:49:58.315719-03:00 [redacted] kernel: [475194.995272]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541844594688 (dev /dev/mapper/dados7 sector 4068299400)
2024-02-22T06:49:58.315721-03:00 [redacted] kernel: [475194.995636]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541844598784 (dev /dev/mapper/dados7 sector 4068299408)
2024-02-22T06:49:58.315722-03:00 [redacted] kernel: [475194.995985]
BTRFS info (device dm-6): read error corrected: ino 0 off
155541844602880 (dev /dev/mapper/dados7 sector 4068299416)

After that, the scrub on dados7 had these errors:

[s=C3=A1b fev 24 14:19:11 2024] BTRFS warning (device dm-7): tree block
154605127745536 mirror 1 has bad generation, has 119710 want 119878
[s=C3=A1b fev 24 14:19:11 2024] BTRFS warning (device dm-7): tree block
154605134839808 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:11 2024] BTRFS warning (device dm-7): tree block
154605134708736 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7): tree block
154605155155968 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7): tree block
154605163479040 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7): tree block
154605183041536 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7): tree block
154605200900096 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7): tree block
154605206241280 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7): tree block
154605163479040 mirror 0 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605163479040 on dev
/dev/mapper/dados7, physical 2081517305856: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605163479040 on dev
/dev/mapper/dados7, physical 2081517305856: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7): tree block
154605206552576 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605127745536 on dev
/dev/mapper/dados7, physical 2081481572352: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605127745536 on dev
/dev/mapper/dados7, physical 2081481572352: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 2
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605127761920 on dev
/dev/mapper/dados7, physical 2081481588736: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605127761920 on dev
/dev/mapper/dados7, physical 2081481588736: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 3
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605200900096 on dev
/dev/mapper/dados7, physical 2081554726912: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605200900096 on dev
/dev/mapper/dados7, physical 2081554726912: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 4
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605134708736 on dev
/dev/mapper/dados7, physical 2081488535552: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605134708736 on dev
/dev/mapper/dados7, physical 2081488535552: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 5
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605134839808 on dev
/dev/mapper/dados7, physical 2081488666624: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605134839808 on dev
/dev/mapper/dados7, physical 2081488666624: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 6
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605134741504 on dev
/dev/mapper/dados7, physical 2081488568320: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605134741504 on dev
/dev/mapper/dados7, physical 2081488568320: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605155155968 on dev
/dev/mapper/dados7, physical 2081508982784: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605155155968 on dev
/dev/mapper/dados7, physical 2081508982784: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 8
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605209108480 on dev
/dev/mapper/dados7, physical 2081562935296: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605209108480 on dev
/dev/mapper/dados7, physical 2081562935296: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 9
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605212172288 on dev
/dev/mapper/dados7, physical 2081565999104: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS warning (device dm-7):
checksum/header error at logical 154605212172288 on dev
/dev/mapper/dados7, physical 2081565999104: metadata leaf (level 0) in
tree 7
[s=C3=A1b fev 24 14:19:12 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 10
[s=C3=A1b fev 24 14:19:16 2024] scrub_checksum_tree_block: 1069 callbacks s=
uppressed
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541301116928 mirror 1 has bad generation, has 107229 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541302525952 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541304115200 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541304639488 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541294891008 mirror 0 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541294972928 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541295022080 mirror 0 has bad generation, has 117491 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541305786368 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541295448064 mirror 0 has bad generation, has 117491 want 119878
[s=C3=A1b fev 24 14:19:16 2024] BTRFS warning (device dm-7): tree block
155541308669952 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:17 2024] scrub_handle_errored_block: 547 callbacks s=
uppressed
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541377597440 on dev
/dev/mapper/dados7, physical 2082502295552: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541377597440 on dev
/dev/mapper/dados7, physical 2082502295552: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] btrfs_dev_stat_inc_and_print: 547 callbacks
suppressed
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 559
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541378269184 on dev
/dev/mapper/dados7, physical 2082502967296: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541378269184 on dev
/dev/mapper/dados7, physical 2082502967296: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 560
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541376532480 on dev
/dev/mapper/dados7, physical 2082501230592: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541376532480 on dev
/dev/mapper/dados7, physical 2082501230592: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 561
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541371060224 on dev
/dev/mapper/dados7, physical 2082495758336: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541371060224 on dev
/dev/mapper/dados7, physical 2082495758336: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 562
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541371076608 on dev
/dev/mapper/dados7, physical 2082495774720: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541371076608 on dev
/dev/mapper/dados7, physical 2082495774720: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 563
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541382430720 on dev
/dev/mapper/dados7, physical 2082507128832: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541382430720 on dev
/dev/mapper/dados7, physical 2082507128832: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 564
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541388263424 on dev
/dev/mapper/dados7, physical 2082512961536: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541388263424 on dev
/dev/mapper/dados7, physical 2082512961536: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 565
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541381464064 on dev
/dev/mapper/dados7, physical 2082506162176: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541381464064 on dev
/dev/mapper/dados7, physical 2082506162176: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 566
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541388820480 on dev
/dev/mapper/dados7, physical 2082513518592: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541388820480 on dev
/dev/mapper/dados7, physical 2082513518592: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 567
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541381529600 on dev
/dev/mapper/dados7, physical 2082506227712: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS warning (device dm-7):
checksum/header error at logical 155541381529600 on dev
/dev/mapper/dados7, physical 2082506227712: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:17 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 568
[s=C3=A1b fev 24 14:19:21 2024] scrub_checksum_tree_block: 740 callbacks su=
ppressed
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282080608256 mirror 0 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282080722944 mirror 0 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282080837632 mirror 0 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282080739328 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282080657408 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282080559104 mirror 0 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282081509376 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282081361920 mirror 0 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282081624064 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:21 2024] BTRFS warning (device dm-7): tree block
156282081738752 mirror 1 has bad generation, has 119830 want 119878
[s=C3=A1b fev 24 14:19:22 2024] scrub_handle_errored_block: 463 callbacks s=
uppressed
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282189004800 on dev
/dev/mapper/dados7, physical 2083505586176: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282189004800 on dev
/dev/mapper/dados7, physical 2083505586176: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] btrfs_dev_stat_inc_and_print: 463 callbacks
suppressed
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1032
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282189201408 on dev
/dev/mapper/dados7, physical 2083505782784: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282189201408 on dev
/dev/mapper/dados7, physical 2083505782784: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1033
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282211467264 on dev
/dev/mapper/dados7, physical 2083528048640: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282211467264 on dev
/dev/mapper/dados7, physical 2083528048640: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1034
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282211549184 on dev
/dev/mapper/dados7, physical 2083528130560: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282211549184 on dev
/dev/mapper/dados7, physical 2083528130560: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1035
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282220511232 on dev
/dev/mapper/dados7, physical 2083537092608: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282220511232 on dev
/dev/mapper/dados7, physical 2083537092608: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1036
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282220986368 on dev
/dev/mapper/dados7, physical 2083537567744: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282220986368 on dev
/dev/mapper/dados7, physical 2083537567744: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1037
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282223198208 on dev
/dev/mapper/dados7, physical 2083539779584: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282223198208 on dev
/dev/mapper/dados7, physical 2083539779584: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1038
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282202603520 on dev
/dev/mapper/dados7, physical 2083519184896: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282202603520 on dev
/dev/mapper/dados7, physical 2083519184896: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1039
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282199965696 on dev
/dev/mapper/dados7, physical 2083516547072: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282199965696 on dev
/dev/mapper/dados7, physical 2083516547072: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1040
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282224312320 on dev
/dev/mapper/dados7, physical 2083540893696: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS warning (device dm-7):
checksum/header error at logical 156282224312320 on dev
/dev/mapper/dados7, physical 2083540893696: metadata leaf (level 0) in
tree 2
[s=C3=A1b fev 24 14:19:22 2024] BTRFS error (device dm-7): bdev
/dev/mapper/dados7 errs: wr 0, rd 0, flush 0, corrupt 0, gen 1041

scrub result:

UUID:             67df499b-d151-4c56-bdc8-6a25c7a5360d
Scrub started:    Sat Feb 24 12:13:43 2024
Status:           finished
Duration:         22:13:10
Total to scrub:   136.02TiB
Rate:             210.73MiB/s
Error summary:    verify=3D1204
 Corrected:      0
 Uncorrectable:  0
 Unverified:     0

system information:

root@[redacted] / uname -a
Linux [redacted] 6.1.0-17-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.69-1
(2023-12-30) x86_64 GNU/Linux

root@[redacted] / btrfs --version
btrfs-progs v6.2

root@[redacted] / btrfs fi show /mnt/dados_btrfs
Label: 'dados_btrfs' uuid: 67df499b-d151-4c56-bdc8-6a25c7a5360d
Total devices 9 FS bytes used 135.59TiB
devid 1 size 16.37TiB used 16.37TiB path /dev/mapper/dados0
devid 2 size 16.37TiB used 16.37TiB path /dev/mapper/dados1
devid 3 size 16.37TiB used 16.35TiB path /dev/mapper/dados3
devid 4 size 16.37TiB used 16.32TiB path /dev/mapper/dados2
devid 5 size 16.37TiB used 16.32TiB path /dev/mapper/dados4
devid 6 size 16.37TiB used 16.33TiB path /dev/mapper/dados5
devid 7 size 16.37TiB used 16.33TiB path /dev/mapper/dados6
devid 8 size 16.37TiB used 16.33TiB path /dev/mapper/dados7
devid 9 size 9.09TiB used 9.06TiB path /dev/mapper/dados8

root@[redacted] / btrfs fi df /mnt/dados_btrfs
Data, single: total=3D139.20TiB, used=3D135.45TiB
System, RAID1C4: total=3D64.00MiB, used=3D15.72MiB
Metadata, RAID1C4: total=3D148.09GiB, used=3D146.15GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
--------------

Those errors on dados7 are recoverable? What should I do next?

Cheers,


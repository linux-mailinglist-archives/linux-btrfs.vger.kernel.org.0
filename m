Return-Path: <linux-btrfs+bounces-5308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01F8D118A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 03:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C411C21709
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 01:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114399479;
	Tue, 28 May 2024 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0T4vl2g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE52907
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860653; cv=none; b=GoS03J9KsAhBTYqrn/KtOnEmfffoL3WdgCTlCFEmAqx/FHpCNOCZXRxKu68oXgrSE1fOd4c7+hnNnbsvTt4kfNhqqjELMl5DGgFm/xMPPL+EdddWW9p2DUuSx7A4iRYjwikVTmCrgL6WcWS9TeEndIXVyB9ZnSJEJnKcZyCiffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860653; c=relaxed/simple;
	bh=eZ3W8RIxUJ9Zjw1kg7xXyYBW8dEkyePwyWZzF9fdbp4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=co9kyLmoGHX9S5gPdT6h8qXJb2fMOg3TD5XJx6yT1gjhcJlZfsm2NUVzDx3iD/YNwbLeTTU14X5HdANjDOLdKqa9NWXc7cj5ER0SYGa2gqhA+0u1bxQj1wLng0q23nEQfJo1vHQLbW+xUOkV1AZhxwU8K09K52ZI+6iGrzg7Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0T4vl2g; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5295a576702so402233e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2024 18:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716860649; x=1717465449; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9GR5XizDz9cTZGah0tFPV1TAict9c40o8yG0kUkfLc=;
        b=g0T4vl2gRWT07lJDKCmVU7Vi6IrREeHo24pdi2mP/hiDs85wXfoiTqhwRD9FtSPK1M
         hkf9nNldbzWBZDMuRvSnWiYV/Jio9UKEuxEKBtjmarBwBrHMjE4Gjon5mpHIjEw7D5Y0
         cxvhsf79TApU/sR9hjt7BCjtC4E4dtULwL/3e59vdKDoC+RovdFlaWBYHoWM+YD8CSxe
         ZhGM3Q57/IXL1Gz4SpyLrT5XOpUJPJQBpmZYkG7oeaf2lDpyA//HMLb1Drt+/E9g5lF5
         1LreoK/A0B6w4x8CADwjJHss1Iye0A08olKXO3+w18fEXpOJ8JYNXx9GkvAeIfBd94ON
         qDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716860649; x=1717465449;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q9GR5XizDz9cTZGah0tFPV1TAict9c40o8yG0kUkfLc=;
        b=jS/9so6O+wWlrZOvnBxbF5TMMXTwQVqColufWVeSIuEfUSzbpsLrg4qNf3owaLUqqF
         IDbe7IF+7F7b2ElBJPoxTORJsbrlbfrgil8TBghNskujrSbUnSS+EvM13Cn73QSKfO0s
         YT8PXOcEMbGaWcm206AD6MLnNXERNLen4rj45OkEJhOwzOq0KvLtwDJEW+fVlP9yvmFW
         SkJX86Rhpti+bdMWpxcqHVkC5zxy2kRE0SxvGyFbzOQMPglao19AM8BObZhb/jLhcOwc
         qmLQ3sDX/B2sCR1OiWiAkUP3m9ldzLEbyKoyAbUE5srJnfjrdCivhlbPt+BI2M0H2xbq
         /peg==
X-Gm-Message-State: AOJu0YztsXci71eVkFz5pGRX5t3bcywh4UO736l6+wkwqQ/UvliQWKyA
	NHVa9W4xJUTGLawTM5jnDvZpCVYgedRv5Dth8vIUppwDFmBD2cM3IRJYr0iN
X-Google-Smtp-Source: AGHT+IFELpaXraapA0Ut6FXMYynaXyh+LCdNHGJG5ru9WrUNs/qUzpW57X25hTvgweMIKt76eTosPQ==
X-Received: by 2002:ac2:4e10:0:b0:51b:e0f0:e4f8 with SMTP id 2adb3069b0e04-52964bb0ea4mr8700631e87.31.1716860648838;
        Mon, 27 May 2024 18:44:08 -0700 (PDT)
Received: from ?IPV6:2a02:a311:5d:7a00:d57a:f406:f986:3c3b? ([2a02:a311:5d:7a00:d57a:f406:f986:3c3b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8a742sm547231966b.153.2024.05.27.18.44.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 18:44:08 -0700 (PDT)
Message-ID: <e6dc5d0b-1f43-4aad-9189-3ba6e9031a5b@gmail.com>
Date: Tue, 28 May 2024 03:42:39 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: linux-btrfs@vger.kernel.org
From: wojtasjd <wojtasjd@gmail.com>
Subject: btrfs check --repair - hangs in infinite loop
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have damaged btrfs file system (root partition for GNU/Linux LMDE 4 
with 4.19.x kernel which boots and mounts "/" read only, some files with 
0 size, damaged timestamps and cannot be deleted because of I/O error).

"btrfs check ..." (provided with LMDE 4) crashes with SegFault so I've 
booted to LMDE 6 live session and did some checks:

root@mint:~# uname -a
Linux mint 6.1.0-12-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.52-1 
(2023-09-07) x86_64 GNU/Linux

root@mint:~# btrfs --version
btrfs-progs v6.2

root@mint:~# mount /dev/sdb2 /mnt

root@mint:~# btrfs fi show
Label: none  uuid: 3a40ba85-56c2-4d26-a126-70839983f4a2
     Total devices 1 FS bytes used 9.05GiB
     devid    1 size 15.02GiB used 12.57GiB path /dev/sdb2

root@mint:~# btrfs fi df /mnt
Data, single: total=10.01GiB, used=8.62GiB
System, DUP: total=32.00MiB, used=16.00KiB
Metadata, DUP: total=1.25GiB, used=434.23MiB
GlobalReserve, single: total=512.00MiB, used=0.00B

root@mint:~# dmesg | tail -n 7
[  404.266242] BTRFS info (device sdb2): using crc32c (crc32c-intel) 
checksum algorithm
[  404.266264] BTRFS info (device sdb2): disk space caching is enabled
[  404.558136] BTRFS critical (device sdb2): corrupt leaf: root=5 
block=29589504 slot=30 ino=1378764, invalid mode: has 00 expect valid 
S_IF* bit(s)
[  404.558157] BTRFS error (device sdb2): read time tree block 
corruption detected on logical 29589504 mirror 1
[  404.565225] BTRFS critical (device sdb2): corrupt leaf: root=5 
block=29589504 slot=30 ino=1378764, invalid mode: has 00 expect valid 
S_IF* bit(s)
[  404.565244] BTRFS error (device sdb2): read time tree block 
corruption detected on logical 29589504 mirror 2
[  404.565328] BTRFS error (device sdb2): could not do orphan cleanup -5
root@mint:~#

root@mint:~# btrfs inspect-internal logical-resolve 29589504 /mnt
ERROR: logical ino ioctl: No such file or directory

root@mint:~# umount /mnt
root@mint:~# btrfs check --repair /dev/sdb2
enabling repair mode
WARNING:

     Do not use --repair unless you are advised to do so by a developer
     or an experienced user, and then only after having accepted that no
     fsck can successfully repair all types of filesystem corruption. Eg.
     some software or hardware bugs can fatally damage a volume.
     The operation will start in 10 seconds.
     Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/sdb2
UUID: 3a40ba85-56c2-4d26-a126-70839983f4a2
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
corrupt leaf: root=5 block=29589504 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29589504 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29589504 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29589504 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=32129024 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29540352 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=32129024 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29540352 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=32129024 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29540352 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=32129024 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29540352 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=32129024 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29540352 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=32129024 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=29540352 slot=31, unexpected item end, have 
4294979450 expect 12154
corrupt leaf: root=5 block=32129024 slot=31, unexpected item end, have 
4294979450 expect 12154
^C
root@mint:~#

btrfs in repair mode hangs in infinite loop and spits out info about 
corrupt leaf and two blocks like you can see above.

I have image of disk.

Can I repair this somehow?



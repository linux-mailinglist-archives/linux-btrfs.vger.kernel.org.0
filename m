Return-Path: <linux-btrfs+bounces-16876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2235B7C894
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5C84810D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FDF264A60;
	Wed, 17 Sep 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXcdOU5S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604523D7E6
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089206; cv=none; b=U4LY6la1j8+8v0KrhBqaSY1J1PXcwJb0m2jiC+VA0ntTpvvdr+lZtYZHfzU54f0qnPI0K1cwK2jPfLNaAzVcwCbUVZFeXbF9B44QcAOB0I80nTbOAB651lsR2ep9D4QwQdEAhKTI6C9DQV8Q3lKtE/uGPlw/mi+0v2ZfjjeL+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089206; c=relaxed/simple;
	bh=sqAQyfoQZbjAGnS42iOELCc8P51YscWEcBcImMY6jxo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AU9DIqD5lxWNK8OXBiMe3m+VJ+sMdunNAyxeF+z+NVKjMRl8iJ3m976KSKEmbCneBlc/hzyaogCDqzUzieiq+82luuYXCDbt40bWGf19zzrs33foOpZLOBVVHR+AAk4XRE/Wa6KmqvdgDUFnconnkGRgtKcYm3SlTmnxxbh/Fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXcdOU5S; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-56afe77bc1eso6623158e87.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 23:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089202; x=1758694002; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFNPzUDQb9IKrpx9MmXqob8kfOKtvOHCzkhLJCQBg9c=;
        b=SXcdOU5SIOD6r5OZGOtzrlpkweDmOhGw1RTMecDvC0wI4TaZ45/GiR6oohjAnbIKQ4
         3f1DaAj3tXvhxd5t22MBOIHWxWFu9/32ILbi+JMH2jIvCZxbaUNYA21lOvXrHLs8L4Ye
         mXirYdC2Y63rafliibPHFh203uG2F05zEc/wYPdghR6QmVDKV3ytby6ftY8/COn48dLh
         UztzmyNoGvn5O2wnk0xD1xkUz85Mm55U0I6mV8lotr0Hvtd19QpIWPDqqwH3s6D8/Gs1
         njYY4BHT4o2dP78VuzwpBRSnVH/wVClWRG1nXPn4t007Ds87gzkQ2mF+1SZCNVAW3B8E
         /ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089202; x=1758694002;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFNPzUDQb9IKrpx9MmXqob8kfOKtvOHCzkhLJCQBg9c=;
        b=YN4Pg9f1Wt/1QES/ibtvrvLk+Y0lOHX5kilxknZQdigsVh4co2bW9d/suYC/MaFNag
         hRI3i+axkmWknHkLPFppfOO3lkvDtn8Yl/3XDb1lrQKvYT16/cmBaOTAX4SlWAau3C5V
         KoWyJBbWDQG6ALQ8jC5HuvR36h1u09PAmAZjq8UV0E6CQwUWm1HdPLu0aDHkbWGDpUTH
         j93SUheRseXOfsDgCBtkMmDhdwIqLUh22b4CdpOfvO65ylJtdPMAyONwXEn3PxrxGOa0
         W+y1i/nGlVBpGCSx6W2wzQDCAJzSzrDi09xASfywpZfnJsa8aBm6mwc/axxMiwJHgoWc
         go7Q==
X-Gm-Message-State: AOJu0YxbGnh8yTo0myyMuRIxqVBMwNyXyRYP3M9+Mps6XuPiLTmF/x4n
	+IF1qi5PS+NtfcJz24+nAdlg+TmFD1DMb/LggfPOzQZSuNrVCAq52Hr8Fs9OxCl9DzS/n0out/k
	Q5Ra8SqOxUBhjBfsqPoO0yubilaYbQfnTl401
X-Gm-Gg: ASbGncuevFaBDkvajjBDN5lir62Y5L8KD8EI9rY1HBJm03A7cal5PWcYbdBlvPyKxEC
	W2kzfxvsfsc2I31wQnA4zQ/jHhPoTSvDdcpAF64x1wKM8lz6bZ0tJlUjXGQ7jYyOLmJUpmPtW1i
	1QOIZ2kiYgqX/4BF5OPWZAHv9cQQrb3l/lobYsjXDEW7Ip9WWTXaiFPu2FvjVYHjGyViaCHu5Su
	E9VhcA=
X-Google-Smtp-Source: AGHT+IH5WSuIqQ8yMUDrdY3CGkZW17yCqGYmOTzYjZzQUz0UH446U761YudrMUlwvvl8UbiYegnM1kHZkBLWN55R7+k=
X-Received: by 2002:ac2:4f08:0:b0:55f:7328:f6ae with SMTP id
 2adb3069b0e04-5779b3e92camr333658e87.51.1758089201764; Tue, 16 Sep 2025
 23:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: optix2002 <optix2002@gmail.com>
Date: Wed, 17 Sep 2025 01:06:30 -0500
X-Gm-Features: AS18NWCq8BxMsvt38DOP8HYWuGvwvI-u8RCg14os7f_vt1ImkXYLsXCJXgAUxZI
Message-ID: <CADdO3Oxj5ghF2AS=j2HOrJOVQaiBo0XM3Aq6aGr9e_jZzU64yA@mail.gmail.com>
Subject: Cannot truncate existing file during disk replace
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a filesystem mounted degraded in the middle of replacing a
missing disk and I cannot truncate some existing files. Truncate is
unfortunately needed by sqlite3 to open a database which now fails to
open.

Overall:
    Device size:                  45.48TiB
    Device allocated:             22.13TiB
    Device unallocated:           23.35TiB
    Device missing:                3.64TiB
    Device slack:                  2.00GiB
    Used:                         22.01TiB
    Free (estimated):             19.20TiB      (min: 5.94TiB)
    Free (statfs, df):            11.32TiB
    Data ratio:                       1.22
    Metadata ratio:                   4.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,RAID6: Size:18.02TiB, Used:17.92TiB (99.44%)
   /dev/dm-2       2.00TiB
   missing         2.00TiB
   /dev/dm-23      2.00TiB
   /dev/dm-25      2.00TiB
   /dev/dm-0       2.00TiB
   /dev/dm-1       2.00TiB
   /dev/dm-18      2.00TiB
   /dev/dm-19      2.00TiB
   /dev/dm-20      2.00TiB
   /dev/dm-21      2.00TiB
   /dev/dm-22      2.00TiB

Metadata,RAID1C4: Size:29.00GiB, Used:27.75GiB (95.71%)
   /dev/dm-2       8.00GiB
   missing         7.00GiB
   /dev/dm-23      7.00GiB
   /dev/dm-25      7.00GiB
   /dev/dm-20     29.00GiB
   /dev/dm-21     29.00GiB
   /dev/dm-22     29.00GiB

System,RAID1C4: Size:32.00MiB, Used:928.00KiB (2.83%)
   /dev/dm-23     32.00MiB
   /dev/dm-20     32.00MiB
   /dev/dm-21     32.00MiB
   /dev/dm-22     32.00MiB

Unallocated:
   /dev/dm-13      3.64TiB
   /dev/dm-2       1.63TiB
   missing         1.63TiB
   /dev/dm-23      1.63TiB
   /dev/dm-25      1.63TiB
   /dev/dm-0     744.27GiB
   /dev/dm-1     744.27GiB
   /dev/dm-18    744.27GiB
   /dev/dm-19    744.27GiB
   /dev/dm-20      3.43TiB
   /dev/dm-21      3.43TiB
   /dev/dm-22      3.43TiB


Running on:

Linux 6.16.3+deb14-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.16.3-1
(2025-08-24) x86_64 GNU/Linux


With flags:

rw,noatime,degraded,nossd,discard=async,space_cache=v2,autodefrag,subvolid=5,subvol=/


I can write and truncate new files on the filesystem without issue:

/mnt/tmp % dd if=/dev/urandom of=foo bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.00623029 s, 168 MB/s
/mnt/tmp % truncate -s 3 foo
/mnt/tmp % ls -al
total 20
drwxrwxrwx 1 root      root        32 Sep 16 22:34 .
drwxr-xr-x 1 root      root        36 Sep 16 17:43 ..
-rw-rw-r-- 1 x         x            3 Sep 16 22:35 foo


However trying to truncate existing ones fail:

/mnt/server % truncate -s 3 db/state.db-shm
truncate: failed to truncate 'db/state.db-shm' at 3 bytes: Input/output error


There's no issue reading the file:

% sudo dd if=/mnt/server/db/state.db-shm of=/dev/null
64+0 records in
64+0 records out
32768 bytes (33 kB, 32 KiB) copied, 0.000119071 s, 275 MB/s


And there are no logs in dmesg or any errors btrfs device stats:

[/dev/mapper/e0d05].write_io_errs    0
[/dev/mapper/e0d05].read_io_errs     0
[/dev/mapper/e0d05].flush_io_errs    0
[/dev/mapper/e0d05].corruption_errs  0
[/dev/mapper/e0d05].generation_errs  0
[/dev/mapper/e1d12].write_io_errs    0
[/dev/mapper/e1d12].read_io_errs     0
[/dev/mapper/e1d12].flush_io_errs    0
[/dev/mapper/e1d12].corruption_errs  0
[/dev/mapper/e1d12].generation_errs  0
[devid:2].write_io_errs    0
[devid:2].read_io_errs     0
[devid:2].flush_io_errs    0
[devid:2].corruption_errs  0
[devid:2].generation_errs  0
[/dev/mapper/e1d14].write_io_errs    0
[/dev/mapper/e1d14].read_io_errs     0
[/dev/mapper/e1d14].flush_io_errs    0
[/dev/mapper/e1d14].corruption_errs  0
[/dev/mapper/e1d14].generation_errs  0
[/dev/mapper/e1d13].write_io_errs    0
[/dev/mapper/e1d13].read_io_errs     0
[/dev/mapper/e1d13].flush_io_errs    0
[/dev/mapper/e1d13].corruption_errs  0
[/dev/mapper/e1d13].generation_errs  0
[/dev/mapper/e1d04].write_io_errs    0
[/dev/mapper/e1d04].read_io_errs     0
[/dev/mapper/e1d04].flush_io_errs    0
[/dev/mapper/e1d04].corruption_errs  0
[/dev/mapper/e1d04].generation_errs  0
[/dev/mapper/e1d05].write_io_errs    0
[/dev/mapper/e1d05].read_io_errs     0
[/dev/mapper/e1d05].flush_io_errs    0
[/dev/mapper/e1d05].corruption_errs  0
[/dev/mapper/e1d05].generation_errs  0
[/dev/mapper/e1d06].write_io_errs    0
[/dev/mapper/e1d06].read_io_errs     0
[/dev/mapper/e1d06].flush_io_errs    0
[/dev/mapper/e1d06].corruption_errs  0
[/dev/mapper/e1d06].generation_errs  0
[/dev/mapper/e1d07].write_io_errs    0
[/dev/mapper/e1d07].read_io_errs     0
[/dev/mapper/e1d07].flush_io_errs    0
[/dev/mapper/e1d07].corruption_errs  0
[/dev/mapper/e1d07].generation_errs  0
[/dev/mapper/e1d08].write_io_errs    0
[/dev/mapper/e1d08].read_io_errs     0
[/dev/mapper/e1d08].flush_io_errs    0
[/dev/mapper/e1d08].corruption_errs  0
[/dev/mapper/e1d08].generation_errs  0
[/dev/mapper/e1d09].write_io_errs    0
[/dev/mapper/e1d09].read_io_errs     0
[/dev/mapper/e1d09].flush_io_errs    0
[/dev/mapper/e1d09].corruption_errs  0
[/dev/mapper/e1d09].generation_errs  0
[/dev/mapper/e1d10].write_io_errs    0
[/dev/mapper/e1d10].read_io_errs     0
[/dev/mapper/e1d10].flush_io_errs    0
[/dev/mapper/e1d10].corruption_errs  0
[/dev/mapper/e1d10].generation_errs  0


Will this resolve itself after the replace completes? Why does this occur?

Let me know if any additional information is needed.

Thanks,
Kyo


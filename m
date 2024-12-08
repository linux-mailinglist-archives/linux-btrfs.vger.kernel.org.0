Return-Path: <linux-btrfs+bounces-10126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC319E8620
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 17:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F6C281724
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FCF156228;
	Sun,  8 Dec 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RouW5uPB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B313B2B6
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673787; cv=none; b=bExLFnhKSjAbBfC0QS0lfYuNZpihS54Y5zcpLJsGDnGPfvDJ4zuyWDQdnh4EjTq+kp7zvgbpaDaPeYaVK8+Curw+SQP+KKViyjSjNqio0nZp2GEL1F4yU4CHeddes8kVJzV5yCC4y4GTBu91sijTL1edtNPCdkhhy1RJTuO47N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673787; c=relaxed/simple;
	bh=cgs7nuv8lWQpmn/VIhHzxQvaGGlNguDe/Im/buo0OHo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SeaHMLv6KpWUg/sw+QJFApN2BL/D9EAv6dHbKsWmVnSxe3hA0Dl6EQwTs2x5xoNpLJizLfo64lJgnIJcqCUxiH/Hn65eS7ZO24NKy0Hz+BFK3sCEn5rWA+nRq0Vbv8WPNEa3OsWqwKN/QK+Qrm7Xo2gEUTp3Pku2N3WFbSj7DsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RouW5uPB; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-3004028c714so12505821fa.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 08:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733673784; x=1734278584; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g2bju1TFzkb78paxzmhvnib4fF4bCeClML62fbpGDGA=;
        b=RouW5uPBSjmR14rJnhv4YSNxbWEeFVSy2VlhPczAhjrl32weAit+ZJEBSIvyL3Wg4G
         +E6ss0R3SdEDAAhwjiHv2FJwHuRb8/xyz5nJN7cA59LSEMSzgoPe+GOwI9V0a/DwDGFy
         Cnq2/WoMKn32bc7jVNKvsGBWPkzyaVi9/u+TobZWG/geGlPxIJAQHK6D4+sX+V+Xqln6
         a25k2l2Lv0Tj1CS1vmyDbONYYROF6zHXP62e2B4bLAvlSEVm0UPP0bQM9h+8aDkz8o7D
         3p/lCBxQoVT7BXPaJrFZP1+Ki+FkoPWNq2HIdPWRvKz5dW6N16ihBmHeer8GYBDbrW3s
         uS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673784; x=1734278584;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2bju1TFzkb78paxzmhvnib4fF4bCeClML62fbpGDGA=;
        b=eCbn7Nqpd2gMsj7QVKm+fZwYc9IYGNXl1dGspJtcJLOFczdTDHd4jb/hphZbmZQ/HH
         cG5hMALEeVZC8honxnwj0eiK4hNU7EnAbJzwDCVRPvqkCCUkNIZdVikO0WeNKKKxK+oQ
         3EejdEX/AEuxcLIZucjkUzeiUAYzehuJzspk1ae1NsCmhzZQKgBwe6rD+87LzTF6a13A
         pK289D2K28qHlf0xFCP9EO7z+EPFajOiIgMyUBiHg8o4nWa3rur5SFiPb1+KbLmTWUzo
         x4S82qXcXC2sAbTAPiZE5D60dEh8QmVJztZMunsKoe4TEQSoA5ZWi39cIIR3REyHG+ed
         p8cw==
X-Gm-Message-State: AOJu0YxtCvFHZG13+v7nfuRc+NrAFySiQ5IoNElqmhfaEfmKMbXpyJqb
	4yA7GrHLcFZSRn/yE1HjNBjlf54h3PeQFFHoLog5G9KdbXnmC26hA6hGsaEAc34G62wr1dNy86j
	xMV5xEwTzAtoiZUX9IINc81ohopDzLodPc5deJ2sz
X-Gm-Gg: ASbGnctMayEMczd1wiH/5Wb1X5u2LL3M6o/3b4ZHJMJ2gCB4c1T5+B/aIGle0UAvgKz
	sbSyEvnEZsLJswqsL24I2j+51v8YSEAoR
X-Google-Smtp-Source: AGHT+IGl7fW9Xou5kJnzfHi3JuaZGmL66I/U0U0da7jGcCJd79xKhg+slsbHNwqdeU027B3ppBd7WrfPxgQNjRfEPPc=
X-Received: by 2002:a2e:a10e:0:b0:300:1448:c526 with SMTP id
 38308e7fff4ca-3002fc97665mr31843431fa.37.1733673783736; Sun, 08 Dec 2024
 08:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: j4nn <j4nn.xda@gmail.com>
Date: Sun, 8 Dec 2024 17:02:51 +0100
Message-ID: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
Subject: clear space cache v1 fails with Unable to find block group for 0
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to switch 8TB raid1 btrfs from space cache v1 to v2, but
the clear space cache v1 fails as following:

gentoo ~ # btrfs filesystem df /mnt/data
Data, RAID1: total=7.36TiB, used=7.00TiB
System, RAID1: total=64.00MiB, used=1.11MiB
Metadata, RAID1: total=63.00GiB, used=57.37GiB
Metadata, DUP: total=5.00GiB, used=1.18GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
WARNING:    Metadata: raid1, dup
gentoo ~ # umount /mnt/data

gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bdata
Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
ERROR: failed to clear free space cache
extent buffer leak: start 9587384418304 len 16384

real    7m8.174s
user    0m6.883s
sys     0m9.322s


Here some info:

gentoo ~ # uname -a
Linux gentoo 6.12.3-gentoo-x86_64 #1 SMP PREEMPT_DYNAMIC Sun Dec  8
00:12:56 CET 2024 x86_64 AMD Ryzen 9 5950X 16-Core Processor
AuthenticAMD GNU/Linux
gentoo ~ # btrfs --version
btrfs-progs v6.12
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=builtin
gentoo ~ # btrfs filesystem show /mnt/data
Label: 'rdata'  uuid: 1dfac20a-3f84-4149-aba0-f160ab633373
       Total devices 2 FS bytes used 7.06TiB
       devid    1 size 8.00TiB used 7.26TiB path /dev/mapper/wdrb-bdata
       devid    2 size 8.00TiB used 7.25TiB path /dev/mapper/wdrc-cdata
gentoo ~ # dmesg | tail -n 6
[31008.980706] BTRFS info (device dm-0): first mount of filesystem
1dfac20a-3f84-4149-aba0-f160ab633373
[31008.980726] BTRFS info (device dm-0): using crc32c (crc32c-intel)
checksum algorithm
[31008.980731] BTRFS info (device dm-0): disk space caching is enabled
[31008.980734] BTRFS warning (device dm-0): space cache v1 is being
deprecated and will be removed in a future release, please use -o
space_cache=v2
[31009.994687] BTRFS info (device dm-0): bdev /dev/mapper/wdrb-bdata
errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[31009.994696] BTRFS info (device dm-0): bdev /dev/mapper/wdrc-cdata
errs: wr 7, rd 0, flush 0, corrupt 0, gen 0

Completed scrub (which corrected 4 errors), btrfs check completed
without errors:

gentoo ~ # btrfs scrub status /mnt/data
UUID:             1dfac20a-3f84-4149-aba0-f160ab633373
Scrub started:    Fri Dec  6 13:12:36 2024
Status:           finished
Duration:         16:11:22
Total to scrub:   14.92TiB
Rate:             268.35MiB/s
Error summary:    verify=4
 Corrected:      4
 Uncorrectable:  0
 Unverified:     0
gentoo ~ # umount /mnt/data

gentoo ~ # time btrfs check -p /dev/mapper/wdrb-bdata
Opening filesystem to check...
Checking filesystem on /dev/mapper/wdrb-bdata
UUID: 1dfac20a-3f84-4149-aba0-f160ab633373
[1/7] checking root items                      (0:06:57 elapsed,
34253945 items checked)
[2/7] checking extents                         (0:23:08 elapsed,
3999596 items checked)
[3/7] checking free space cache                (0:04:25 elapsed, 7868
items checked)
[4/7] checking fs roots                        (1:03:46 elapsed,
3215533 items checked)
[5/7] checking csums (without verifying data)  (0:11:58 elapsed,
15418322 items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 52
items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 8199989936128 bytes used, no error found
total csum bytes: 7940889876
total tree bytes: 65528446976
total fs tree bytes: 52856799232
total extent tree bytes: 3578331136
btree space waste bytes: 10797983857
file data blocks allocated: 21632555483136
referenced 9547690319872

real    111m10.370s
user    10m28.442s
sys     6m44.888s

Tried some balance as found example posted, not really sure if that should help:

gentoo ~ # btrfs balance start -dusage=10 /mnt/data
Done, had to relocate 32 out of 7467 chunks

gentoo ~ # btrfs filesystem df /mnt/data
Data, RAID1: total=7.19TiB, used=7.00TiB
System, RAID1: total=64.00MiB, used=1.08MiB
Metadata, RAID1: total=63.00GiB, used=57.36GiB
Metadata, DUP: total=5.00GiB, used=1.18GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'
WARNING:    Metadata: raid1, dup

But it did not help:

gentoo ~ # time btrfs rescue clear-space-cache v1 /dev/mapper/wdrb-bdata
Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
ERROR: failed to clear free space cache
extent buffer leak: start 7995086045184 len 16384

real    6m58.515s
user    0m6.270s
sys     0m9.586s

Any idea how to fix this?
Thanks.


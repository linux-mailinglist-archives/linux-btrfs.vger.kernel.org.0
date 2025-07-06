Return-Path: <linux-btrfs+bounces-15269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70BCAFA359
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jul 2025 08:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098F317FE7D
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Jul 2025 06:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220131C6FFD;
	Sun,  6 Jul 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV4tlC4v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80241096F
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Jul 2025 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751785152; cv=none; b=psWVJa+64efxgPnfKdCDMmz1L6EWw2yJWuio/1+jYj03Ted6Zsduq8BkQZ1DWKDReebCkziP9jlRLHIzI6s7ce/VtK2zzXRlwKqVGZQGcevXpjw8aJ+R7fLHzqdRm3DWKE0Roj6sDPXlSw4NR1FhYwNb5diyj3Ii81A4zroLTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751785152; c=relaxed/simple;
	bh=2Mlcc0AUVNnciuqbWCDnzxzIyvqBRLqGdHKta/yWr50=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hBQgfgRR5QlBtdWw43izoS/hjWf8fOqj5c78dqyw0+oZfddXRXYpnO8xlrD7wvZeAVs7IsEryrN2mcz3PWl8iWC0+PYQbhuLKe1mrZVgrM7beF8+f/cj+zZgm5jYq28ulb0rWLXXgj21i+TSMcmvKulAhM9G0Exe5wejTfX5HxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV4tlC4v; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-555163cd09aso2060404e87.3
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Jul 2025 23:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751785149; x=1752389949; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y1Ho6vQHMZ4zfLsZVaCxCAdgzd1SwLTbfidUwj0Fjjg=;
        b=MV4tlC4vGdJmEQIMEqkHK9o0UalwBdUI5enbXj80Dqu+QlVM3nPaJSvwZ2Jvm7x0qt
         UH8fMatQ9TW+6IzHqcRTV3xEQc+aG3TayPXEB+gdEX9n9BlKy3IjHLktcTpH6g/t5bh2
         LNofOjSezR4egx++xDStr/up+3pfSQ/FbeFZTjEWhGaUGwXDnBbYQt5lUH8O0WtTlMzf
         wKUBpD74eOJEwNEOOL1QaBTaNkhZwd90B9PVBSP+rXVLdnYSksTcO1ALTUnN2+0cEnjL
         DYCl3iogBh8J36uDix7bw/YxNS2QjFdb4cgaEKB9eq9TQ938aAgX3zRxzyVcQHBNKw+D
         byjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751785149; x=1752389949;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1Ho6vQHMZ4zfLsZVaCxCAdgzd1SwLTbfidUwj0Fjjg=;
        b=AAzJijfHsLnEoCcDxEaDp7qLhJbkXayhv003XY5SYjRkoXmmHzWdMuWL0GUo+Fv1KB
         uI0SKgkRZAib7F2J2bK6JY5yr+Rvu/7CfLgdwBPESJGk/y0nlqeE7T3u5hNnyHxI/THc
         bmOmE33AGdHDJA+WOmX54SMcUb4zuspapimsS+GOJuTF8kLNKLUHT18BF7M+qpnfOCuL
         pPaD1ETfpLEeUJ6BxQ+O1v02tWAClpVPj2pJqeuii90c8P5Zw9ZxVOlGvCf5AFTSUh7Z
         8Q127YiiTPkKUCx32zEe7ZAdGvHHTNTO5ZPRm8sn6KJ6Mh07Pe3rqasxRMtH0b01Fjj+
         QWtA==
X-Gm-Message-State: AOJu0Yz+M/8y4CE/5GvpmH3z1RvJWet3tUCQH6u/m0wUdw0b2sAwnDAR
	TkrTEvs4vWssjxQrGxjySKXJgfh9bBiJkUQg5K17QmE/pfvHWbvcG4xcXOPPCduAV1zoaGH+ZxP
	OpLn6eINJuQXpXm1DpMC0Q4MfECJ59p5tQyNY
X-Gm-Gg: ASbGncsnQfuueZ6+SAa665qgUWWJtRytchrMas+pwZQN3FhWJmVB/0PlEFMXw1cPwQm
	SWKaiBbctPi25cN/nGZ/OjFRqD1Z90oeb5NL7dp6P3Yt2DtTB9fMUMhBr1qYqJ3wJ1IlvCBeUj3
	JGao5A1usbWVZjSwtd7lsa2ayQAx2QaO7ARopik0fR7Uev
X-Google-Smtp-Source: AGHT+IGRqVodNBvd6LTno67w3KVyHbrWmVWMyeIDISd4E8lEhWZRP/LC9UT9zGYVgtA5Qhm5x5RBkSjWi/h1GaEaLs8=
X-Received: by 2002:a2e:be90:0:b0:32e:deb2:f75 with SMTP id
 38308e7fff4ca-32f19acdec1mr10851391fa.23.1751785148416; Sat, 05 Jul 2025
 23:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: PranshuTheGamer <12345qwertyman12345@gmail.com>
Date: Sun, 6 Jul 2025 09:58:56 +0300
X-Gm-Features: Ac12FXwdkrhFGlKGE5olWsNHny7q9PWSlfVjEhGmsqTnOZfhJ_bieaco8b10Ct8
Message-ID: <CAPYq2E0yh0cfM9AXNqjHpz9dLnzRa3xZ76vJEKqsM9-jaJpktQ@mail.gmail.com>
Subject: [help needed] parent verity error on HDD & btrfs restore segfault
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I am rewriting this email from
https://lore.kernel.org/linux-btrfs/CAPYq2E3zdzx4vvSrGT3goRvikt4grUfgZuE5kB1hcoK=RRpseg@mail.gmail.com/T/#t
because It seems to not have attracted any attention as I sent a total
of 3 emails. I will update the other email thread to redirect them
here.

I have a backup of my files on a hard drive with btrfs. Recently while
running something off the hard drive, it switched off by itself, and
then when i tried remounting it, it gave me this:

I would like to note that since the last successful mount, there
haven't been any important writes to the disk.

> uname -a
Linux pranshu-arch-1 6.15.4-arch2-1 #1 SMP PREEMPT_DYNAMIC Fri, 27 Jun
2025 16:35:07 +0000 x86_64 GNU/Linux

> btrfs version
btrfs-progs v6.15
-EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED CRYPTO=libgcrypt

> sudo mount /dev/sdc1 /run/media/shivangi/LV-01
mount: /run/media/shivangi/LV-01: can't read superblock on /dev/sdc1.
       dmesg(1) may have more information after failed mount system call.

> sudo dmesg
[ 2049.529633] BTRFS: device /dev/sdc1 (8:33) using temp-fsid
0f830c0c-e975-4c8d-974a-d8cc94bf49e7
[ 2049.529643] BTRFS: device label LV-01 devid 1 transid 8301
/dev/sdc1 (8:33) scanned by mount (5669)
[ 2049.687040] BTRFS info (device sdc1): first mount of filesystem
d9441c01-827c-47da-890c-491213f25ddb
[ 2049.687057] BTRFS info (device sdc1): using crc32c (crc32c-x86)
checksum algorithm
[ 2049.687061] BTRFS info (device sdc1): using free-space-tree
[ 2049.976371] BTRFS info (device sdc1): bdev /dev/sdc1 errs: wr 0, rd
0, flush 0, corrupt 5, gen 0
[ 2052.052541] BTRFS error (device sdc1): parent transid verify failed
on logical 120422400 mirror 1 wanted 8301 found 5836
[ 2052.083206] BTRFS error (device sdc1): parent transid verify failed
on logical 120422400 mirror 2 wanted 8301 found 5836
[ 2052.083258] BTRFS error (device sdc1): failed to read block groups: -5
[ 2052.085958] BTRFS error (device sdc1): open_ctree failed: -5

> sudo btrfs check --readonly /dev/sdc1
Opening filesystem to check...
parent transid verify failed on 120422400 wanted 8301 found 5836
parent transid verify failed on 120422400 wanted 8301 found 5836
parent transid verify failed on 120422400 wanted 8301 found 5836
Ignoring transid failure
parent transid verify failed on 120619008 wanted 8301 found 5836
parent transid verify failed on 120619008 wanted 8301 found 5836
parent transid verify failed on 120619008 wanted 8301 found 5836
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=40599552 item=4 parent
level=2 child bytenr=120619008 child level=0
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system

> sudo btrfs rescue chunk-recover /dev/sdc1
Scanning: 789579710464 in dev0scan chunk headers error

> sudo btrfs-find-root /dev/disk/by-label/LV-01
parent transid verify failed on 120422400 wanted 8301 found 5836
parent transid verify failed on 120422400 wanted 8301 found 5836
ERROR: failed to read block groups: Input/output error
Superblock thinks the generation is 8301
Superblock thinks the level is 1
Found tree root at 119324672 gen 8301 level 1
Well block 35749888(gen: 8300 level: 1) seems good, but
generation/level doesn't match, want gen: 8301 level: 1

> sudo btrfs restore -D -s -S -x -m -i  --path-regex "^.*$" \
/dev/disk/by-label/LV-01 .
This is a dry-run, no files are going to be restored
ERROR: failed to change owner of './Backups/Other/school/G12
School/eng/hugo-portfolio/themes/risotto/exampleSite/content/_index.md':
No such file or directory
ERROR: failed to change owner of
'./Snapshots/Backups/Other-1748279502.547062230_2025-05-26_20:11:42/school/G12
School/eng/hugo-portfolio/themes/risotto/exampleSite/content/_index.md':
No such file or directory
[1]    11852 segmentation fault  sudo btrfs restore -D -s -S -x -m -i
--path-regex "^.*$"  .

Please help me with this drive, either recovering the files or fixing the drive.


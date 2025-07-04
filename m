Return-Path: <linux-btrfs+bounces-15250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410A8AF8782
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 08:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4901897B0A
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 06:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2DE214812;
	Fri,  4 Jul 2025 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBYV3mzf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD4214204
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Jul 2025 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751608791; cv=none; b=jOoj2GiEOMEsdy3SxqgHpnoLPwSZ4t4LuQvUzewcMTLlKYMOxLg6Iu66BnRQw/jilHjRmIBC/U7LprD+dADTJVr+2fkuSS3JSlcSkFj5/PlKvbZTGemlmxVQO0FOFDxv/zWr0/qoReAbgWByKg84v+UFPEWhiK3C8e4z2THu5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751608791; c=relaxed/simple;
	bh=03UmhaOpafVigCpmSOU9EzEy25qI7CocWlUydG3TOgg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Fl0YsK7tHwVNpn6OdNjw2XvDNDiSAbjzZmoMRTUsx34+ZNB2/KgVA4WcaLjlG4AvS/b+AFEO/wh352yCwTG6CXaaYnU+aTOvI0JHG9fkWgAtPzl3ltKxyEqHY4LUBA93PUG2YW5WppuSG33HEsyPtI8P+HwJbPxExxckP8VolDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBYV3mzf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso6143141fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Jul 2025 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751608787; x=1752213587; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2fMVJBscPdWkI0c5eMJkr9eomdI/lYPoa93+vGDooq4=;
        b=NBYV3mzfpXdbjZIl44kewdXUFOaQxnCjfbeX1wWPYhYEMOVau8vu/B1US48T1NbiKZ
         IKD47F4IPLSdWciIfuHryzGgggeZBpthnix2S8pz438gzkCOfJOBjNzA441X5R2sMOzi
         RqovPXE68N2boB8DFDcQnEixN8aQ3mYH5jPKd0K2Z8IMSCmXvm2ymEBxMMIElu2kyew6
         0i1D8fKz1oddEICA++F8pM/w7Ji4wXJx+2z+ntuN3mdGVqYzPNJ4KXby4SdZ3fpRQyF9
         GCtkI8dtoP+I/2o8Y+4ZXaOh5AqQzhcRdUVT1E2BuCei7w15OMT1XLK5BUbsDtiF1jxJ
         UMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751608787; x=1752213587;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2fMVJBscPdWkI0c5eMJkr9eomdI/lYPoa93+vGDooq4=;
        b=cOcapdvQgU0r0CI22fEFYJoy7ByWubw2v3s+3GOxtR8jOYgy9v1yDPOWQNkJ5zTGdW
         2Xeo1nT5WS4k6soQ+HWomoEXl3brE/zIR7Ror+l1rQ9cqr2xpkyCJAy/xCH6YiLDqL0m
         VgV7WmePtDh8xiANrjajQISIgUo+1VHpBU/SttSXrMwKQGlTCIiKDWkDIZFawrCSyTSb
         Jfp/j5e5xGEQXLF/ce8GdzgmfxLPHV3y0GmG+0V25xMQ2K2oJw8AetOmF8Pqcb9SJLF6
         IBp4bAWgxin3x2dB4d5ngX6YS9+BA2eqplACHuk17AL7M+4oeo59gUHNcglHQxnBe9rV
         HR5A==
X-Gm-Message-State: AOJu0Yxb3bT0HSODgfPQYGMb9XIhgEbfpsuiXodL+M1D7r32K1D9aAIv
	uUqWvLb0fcuIW2MrrqOVZGOoyeGgR5+g2rIDTa1xGDLl7I7yhL2mIW5taeo/JmhOlfeFOnHAFuK
	OWZ9VowbxpTJiuHfgTK6iuU25ACTnkGg1tQrg
X-Gm-Gg: ASbGncuZUY0FPxNmXQqWF3q+r4BBBq0mjw1PTKJ6lOfSKtIvLUQMSNfxvhBCX6W/pPL
	JJO2m3+oV7woM1C55nvintnp2b0DCV0PiWFX+CPbSp/FBKZBF+WOUX+I5hcXQYDVIt6p/sphD9Q
	IdEGn50ubmUgaA2uAyrXjtdGyHnOQeW2w2grEuOOH53WTx
X-Google-Smtp-Source: AGHT+IFzTTcZEW9oW7rBG5FpMBue57yJ3TzmPKa7W34MNk5HCplYXvjdOX6I0F5iM24llpsQQVnLmRx2GOdP4WbgKcQ=
X-Received: by 2002:a05:651c:41c1:b0:32b:7111:95a3 with SMTP id
 38308e7fff4ca-32e62030444mr2714431fa.38.1751608786826; Thu, 03 Jul 2025
 22:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: PranshuTheGamer <12345qwertyman12345@gmail.com>
Date: Fri, 4 Jul 2025 08:59:35 +0300
X-Gm-Features: Ac12FXw60IUwCOwkTdS2GHnuKPGhxYj6kpJdSdMx8JnYXYqxFRFp_RSNqyXAJS0
Message-ID: <CAPYq2E23F7VdgtwCydEVa9wdomEVbQUsQPgfyLVh5ac=KLBEdw@mail.gmail.com>
Subject: [help needed] parent verity error on HDD
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have a backup of my files on a hard drive with btrfs. Recently while
running something off the hard drive, it switched off by itself, and
then when i tried remounting it, it gave me this:

I would like to note that since the last successful mount, there
hasn't been any important writes to the disk.

> sudo mount /dev/sdc1 /run/media/shivangi/LV-01
[sudo] password for shivangi:
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

kernel info:
6.15.4-arch2-1

Please help me fix the drive.


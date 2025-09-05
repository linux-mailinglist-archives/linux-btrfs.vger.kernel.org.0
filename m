Return-Path: <linux-btrfs+bounces-16628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A0B44B80
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 04:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44D77B636F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 02:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F47218E97;
	Fri,  5 Sep 2025 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0rV1JV/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933614E2F2
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038216; cv=none; b=joaZJMJwvVIG+hIbl5I7wOsSWj+geFzj8st8nYX1KbCnpm4ZF1wEtXHZtcWd06TOM6Iv0ZhJNKzbUHy56eP+zWvxQiDADxoVx6pklm/JdUnN8mISJTsMsQPfrkotxtw9E4LZXJ9gohjzabN4tcJAVvYsSQeE0dcWxnWbu/Z2kgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038216; c=relaxed/simple;
	bh=UlJZIFrFSWAoeRFjHgLlJDfVXTC1t/W5iinzur3PeGc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AQb1FCJFgW9u+MKD0zJNfvwm0gsg7TIeHPALccT7jvJ3svkyeebEc/RXNLwqzUrgi6IAbPx0kCQC1YiIOjxuPxikczYU1VzOK4PCxJ43a7u/LDAREUGTIGOOyQbWbG5tWaR8wITjZNhh68Tk+xm7e6+ar/LAmRiwvrO11GL/asE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0rV1JV/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-56088927dcbso2061429e87.3
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Sep 2025 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757038212; x=1757643012; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hE1hnJMteezzxFNOs5QnHe0I3BxtMFARMf0VmC25T6M=;
        b=d0rV1JV/EnqqvPgmvBdwAVBTcYMha5vdzeP2QfwhSNy/M7NZbaLzD8svoSvA06wNjI
         nba0EzwrsnfaYHWE7Ma7FpbCv7HHOCoAcQ1x/fGvZdATIc87947Gqkec6eviUuJZNqqQ
         v4ASHviH82/6jq1NE444xFRjFjOevkzh8/LK22+H/jBfLCf/MoAyJcisToinlboTI7hA
         C37RXjfHeXS2SJheYngMOIsiWRg6tgaxvKARH1qiwjqlIqf4cCX/Card+4b7S06DHgQd
         aYUkk9mu0Gw49BvBEIlBmZeSHvoslX9KRgERSqN/0jloK666JEHvSeQWBB+WQRyeSL8s
         qsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757038212; x=1757643012;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hE1hnJMteezzxFNOs5QnHe0I3BxtMFARMf0VmC25T6M=;
        b=Yb28PXUFrpc/QUKVDNxvZfc/QR9UXjY02VjBXMIcKcE3dj+1HadSbJx0lQKllizChR
         LU7vvgqT2w2x/Ver+fGn9cttNoLtkLp85o7r8DKiJ7GVnkn9EayZ5TXTwUQOAOBsM3ST
         pKOrsbMrIer6qbYe0Re9JwXWIJflxZJ5+Gzdu3EdfuvUp3nujCwHSzlygV5yt2JTVM/C
         ashMH4sFihdMRfiRl7xJX8nhQooG32z85nzJwQ5l7qKKZfHNvDCssq8niVAmNZfD4Zal
         2e2atY1LW+nX2NQpEyuNEOQP1Uv7mcLBJnZ8f96af5n0hCwb3FoxbJvd1mvVZ6ncQhxp
         8qPA==
X-Gm-Message-State: AOJu0Yx6jS50mfRCjoHnr+9Ks3T7bG7WIE8VSFV6PmjCDhWLGR7sa6AT
	ESjnOi3kWW/CXumFCX7LAeerzy73CfBNdZUEbFSiDEqq0ZYRsxr+vFPLtwz3FWGTKo30q1qJTP0
	/RFCQHLTRAjIG1ZtTUJeO9FrLWETfNoXzPDJDmj4=
X-Gm-Gg: ASbGnct/NbeiwQh3MniBiXoYlIbGaiSp6F8yCvpK0E/2cV8IDbIuW8S5MDsMt5paqNc
	Qra/ez7SBvDvzQ/5p97DdXgfZgqJ/04VSa/aWtsbxw24LKAMlWZ9tQxNCiNiKq7kAwPmY2Cm7J7
	IQig25EXZ0oybCgJzvYDlkPk18VyWRC+fdvxTFdjqLFLkN5rdQDu97peqS/CV2J08yVnnbZ641u
	nPOp54=
X-Google-Smtp-Source: AGHT+IHMDLG7tgHOeDMxkELvBuLRX2ZSzNZ9hyz8YVpNxhH1pq8omZQFfmIvRp94y8xXj2OOHIOqwauO7iLq2htsndE=
X-Received: by 2002:a05:6512:acf:b0:561:4630:8c17 with SMTP id
 2adb3069b0e04-5614630976fmr225126e87.49.1757038212076; Thu, 04 Sep 2025
 19:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Charlie Kernstock <cakernstock@gmail.com>
Date: Thu, 4 Sep 2025 19:10:01 -0700
X-Gm-Features: Ac12FXxeEBYP89zksDbDL1GwSlCY713jmgP059cHJmAxVIbnRLLtMLMppNWk1-s
Message-ID: <CALRiM0xL5A70zuTgBFwCW94RQB7JV5ssaigwg7jxh6=tfEZyhg@mail.gmail.com>
Subject: Need guidance on btrfs: uncorrectable errors from scrub
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When trying to run "rpm-ostree reset" or similar, dmesg shows this:

[  101.630706] BTRFS warning (device nvme0n1p8): checksum verify
failed on logical 582454427648 mirror 1 wanted 0xf0af24c9 found
0xb3fe78f4 level 0
[  101.630887] BTRFS warning (device nvme0n1p8): checksum verify
failed on logical 582454427648 mirror 2 wanted 0xf0af24c9 found
0xb3fe78f4 level 0

Running a scrub, I see this in dmesg:

[24059.681116] BTRFS info (device nvme0n1p8): scrub: started on devid 1
[24179.809250] BTRFS warning (device nvme0n1p8): tree block
582454427648 mirror 1 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
[24179.810105] BTRFS warning (device nvme0n1p8): tree block
582454427648 mirror 1 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
[24179.810541] BTRFS warning (device nvme0n1p8): tree block
582454427648 mirror 1 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
[24179.810739] BTRFS warning (device nvme0n1p8): tree block
582454427648 mirror 1 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
[24179.810744] BTRFS error (device nvme0n1p8): unable to fixup
(regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
527701966848
[24179.810749] BTRFS warning (device nvme0n1p8): header error at
logical 582454411264 on dev /dev/nvme0n1p8, physical 527701966848:
metadata leaf (level 0) in tree 258
[24179.810752] BTRFS error (device nvme0n1p8): unable to fixup
(regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
527701966848
[24179.810755] BTRFS warning (device nvme0n1p8): header error at
logical 582454411264 on dev /dev/nvme0n1p8, physical 527701966848:
metadata leaf (level 0) in tree 258
[24179.810757] BTRFS error (device nvme0n1p8): unable to fixup
(regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
527701966848
[24179.810759] BTRFS warning (device nvme0n1p8): header error at
logical 582454411264 on dev /dev/nvme0n1p8, physical 527701966848:
metadata leaf (level 0) in tree 258
[24179.810761] BTRFS error (device nvme0n1p8): unable to fixup
(regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
527701966848
[24179.810763] BTRFS warning (device nvme0n1p8): header error at
logical 582454411264 on dev /dev/nvme0n1p8, physical 527701966848:
metadata leaf (level 0) in tree 258
[24180.058637] BTRFS warning (device nvme0n1p8): tree block
582454427648 mirror 2 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
[24180.059654] BTRFS warning (device nvme0n1p8): tree block
582454427648 mirror 2 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
[24180.059924] BTRFS warning (device nvme0n1p8): tree block
582454427648 mirror 2 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
[24180.060079] BTRFS warning (device nvme0n1p8): tree block
582454427648 mirror 2 has bad csum, has 0xf0af24c9 want 0xb3fe78f4
[24180.060081] BTRFS error (device nvme0n1p8): unable to fixup
(regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
528775708672
[24180.060085] BTRFS warning (device nvme0n1p8): header error at
logical 582454411264 on dev /dev/nvme0n1p8, physical 528775708672:
metadata leaf (level 0) in tree 258
[24180.060088] BTRFS error (device nvme0n1p8): unable to fixup
(regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
528775708672
[24180.060091] BTRFS warning (device nvme0n1p8): header error at
logical 582454411264 on dev /dev/nvme0n1p8, physical 528775708672:
metadata leaf (level 0) in tree 258
[24180.060093] BTRFS error (device nvme0n1p8): unable to fixup
(regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
528775708672
[24180.060095] BTRFS warning (device nvme0n1p8): header error at
logical 582454411264 on dev /dev/nvme0n1p8, physical 528775708672:
metadata leaf (level 0) in tree 258
[24180.060097] BTRFS error (device nvme0n1p8): unable to fixup
(regular) error at logical 582454411264 on dev /dev/nvme0n1p8 physical
528775708672
[24180.060100] BTRFS warning (device nvme0n1p8): header error at
logical 582454411264 on dev /dev/nvme0n1p8, physical 528775708672:
metadata leaf (level 0) in tree 258
[24272.506842] BTRFS info (device nvme0n1p8): scrub: finished on devid
1 with status: 0

I've tried to see what file(s) this might correspond to, but I'm
unable to figure that out using the inspect tool?

user@ashbringer:~$ sudo btrfs inspect-internal logical-resolve -o
582454411264 /sysroot
ERROR: logical ino ioctl: No such file or directory

Other details: "btrfs fi usage" shows only 80% used. This NVMe drive
is about 1 year old. If I had to guess, I may have gotten into this
state with an unsafe shutdown or from a previous week-long period
where I improperly overclocked my system memory. Looking for guidance
on where to proceed from here. Here is smartctl info if that helps:

user@ashbringer:~$ sudo smartctl -a /dev/nvme0n1p8
smartctl 7.5 2025-04-30 r5714
[x86_64-linux-6.15.6-113.bazzite.fc42.x86_64] (local build)
Copyright (C) 2002-25, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Number:                       WD_BLACK SN850X 2000GB
Serial Number:                      24131M803742
Firmware Version:                   620361WD
PCI Vendor/Subsystem ID:            0x15b7
IEEE OUI Identifier:                0x001b44
Total NVM Capacity:                 2,000,398,934,016 [2.00 TB]
Unallocated NVM Capacity:           0
Controller ID:                      8224
NVMe Version:                       1.4
Number of Namespaces:               1
Namespace 1 Size/Capacity:          2,000,398,934,016 [2.00 TB]
Namespace 1 Formatted LBA Size:     512
Namespace 1 IEEE EUI-64:            001b44 8b477e0c95
Local Time is:                      Thu Sep  4 19:02:03 2025 PDT
Firmware Updates (0x14):            2 Slots, no Reset required
Optional Admin Commands (0x0017):   Security Format Frmw_DL Self_Test
Optional NVM Commands (0x00df):     Comp Wr_Unc DS_Mngmt Wr_Zero
Sav/Sel_Feat Timestmp Verify
Log Page Attributes (0x1e):         Cmd_Eff_Lg Ext_Get_Lg Telmtry_Lg Pers_Ev_Lg
Maximum Data Transfer Size:         128 Pages
Warning  Comp. Temp. Threshold:     90 Celsius
Critical Comp. Temp. Threshold:     94 Celsius
Namespace 1 Features (0x02):        NA_Fields

Supported Power States
St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
 0 +     9.00W    9.00W       -    0  0  0  0        0       0
 1 +     6.00W    6.00W       -    0  0  0  0        0       0
 2 +     4.50W    4.50W       -    0  0  0  0        0       0
 3 -   0.0250W       -        -    3  3  3  3     5000   10000
 4 -   0.0050W       -        -    4  4  4  4     3900   45700

Supported LBA Sizes (NSID 0x1)
Id Fmt  Data  Metadt  Rel_Perf
 0 +     512       0         2
 1 -    4096       0         1

=== START OF SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

SMART/Health Information (NVMe Log 0x02, NSID 0xffffffff)
Critical Warning:                   0x00
Temperature:                        44 Celsius
Available Spare:                    100%
Available Spare Threshold:          10%
Percentage Used:                    0%
Data Units Read:                    26,678,672 [13.6 TB]
Data Units Written:                 30,077,184 [15.3 TB]
Host Read Commands:                 228,465,682
Host Write Commands:                583,022,967
Controller Busy Time:               382
Power Cycles:                       301
Power On Hours:                     6,895
Unsafe Shutdowns:                   28
Media and Data Integrity Errors:    0
Error Information Log Entries:      0
Warning  Comp. Temperature Time:    0
Critical Comp. Temperature Time:    8

Error Information (NVMe Log 0x01, 16 of 256 entries)
No Errors Logged

Self-test Log (NVMe Log 0x06, NSID 0xffffffff)
Self-test status: No self-test in progress
No Self-tests Logged

Thanks,
- Charlie Kernstock


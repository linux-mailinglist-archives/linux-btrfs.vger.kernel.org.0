Return-Path: <linux-btrfs+bounces-5612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AE2902679
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976F0289984
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A261F142E97;
	Mon, 10 Jun 2024 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3tf6bev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F2142E7F
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036339; cv=none; b=M8P7W0d4NwMebagTHGtwDme5vZ8LmY7iqqM9lH/KzBGZ63uV3YlXDzgoHBsgAsm0hKBdTkLzCVIgRWb+tl92zrdx50poIGM+aGjs5qmPZ/syeQyJm+NVgmfdoTlimYyvpVRXxWCl8vcQXcFWxYy0UpVnzGygrLStC7xtIS5yu/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036339; c=relaxed/simple;
	bh=72j0j9nDOUu6+J6Dqt7PUQoinhdNr7PWzYGfZPODnf4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=FjZL6JCh6nmxaKnm2kINNSLCZ4wh89//SHb0r2Hg8lNosa1E8b2hQqkllYdobhuSdPGWPPxKWR1vW/7Cy4tbldHgJk0JQYbLVcUfDQWZ9Grr+++kwJvOeu3HW4X7CNheRdSBn4swcPQNnRXNvuiLake3RUm8glfoNMbtdGjq/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3tf6bev; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so1936584a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718036336; x=1718641136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRoNLq8SpncBvYsmw9gJOBUvYP9xaX9eMIiGDEO2vB0=;
        b=F3tf6bev38j8G0X8rKHpsyrabe0gJhFs/QzWDtpwmXbYCSxDKI+RXS1WsyEPMuHlX+
         2nD1E+z1CArTC28FoI8f5MIP8ZvG5iNpVTJDEigIQJzBep2NT60GdSsH1Rcfjz2pKllL
         zDtLphR2t3u1lSvVwO3uC4f+gkl60KMqC1KNqA1jYr7PjTT7/WMeSBUvmeB3FjYJJPJN
         eCBsCFat81HQaQWwpbGS5D5ixZAJNUv0Upu+ZCfosVs7aPqFXCsq24BOvOfjisjt7b/5
         ioeR+wtS0W3v3xs78i7UAQmO7+Xd9e6aawtk+HFFwU1yGMIbq2eSITHjH1ZErUMh9o9z
         y5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718036336; x=1718641136;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRoNLq8SpncBvYsmw9gJOBUvYP9xaX9eMIiGDEO2vB0=;
        b=f1+QxMplfwK6a9JbQlaRaTOthUKdQY2CKjvhcuQQpkOWztvyLsu5cd0hBx40aGP/3Z
         8hepYnCo12uWEdRA0bhe8m51Zv4zQ1ucejbqpW55jM0vsVFsyPSQM4ANI6PY/DZWed7d
         2E3qw2wuY+FA0TMUmoHEbD5n+8TZSePpRk1Cqy9lmVh5plFtIPnKastDLaER2qm3yslO
         IXy6wJ3hanZweI4tMG9Zl5G31yKmgdQhxpVDFHdPZgxGp53AvywQBGOMvI3ittpNVJyV
         1kEkTggPZeOuE5kfUan0ECzrYsErTNo/IL5bViPaEtibGMAFUKrPth7qFwff719b1XJ8
         KgjQ==
X-Gm-Message-State: AOJu0YwKC9ie4SWNejYVl84R3mUe6cf8VW+TbPe0TclgWv+gyvqvgi0T
	TJGkxkxQ+hugqgLjl4ctEHoPtmr4XwkaYedI9OWfKwG5/8Qcn0m6QoCrSg==
X-Google-Smtp-Source: AGHT+IGBPnL04cIK/RvzoMNXO8G7E3kgkqM6NGDCaxaMHURy/VOmzuPGdu/qPoe10LSb6pWcCX+XdQ==
X-Received: by 2002:a50:9556:0:b0:57c:6953:2cac with SMTP id 4fb4d7f45d1cf-57c69532cbcmr3511945a12.22.1718036336278;
        Mon, 10 Jun 2024 09:18:56 -0700 (PDT)
Received: from [10.1.1.2] ([77.253.223.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0ca9c9sm7676044a12.22.2024.06.10.09.18.55
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 09:18:56 -0700 (PDT)
Message-ID: <6ae187b3-7770-4b64-aa65-43fff3120213@gmail.com>
Date: Mon, 10 Jun 2024 16:56:00 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: ein <ein.net@gmail.com>
Subject: RAID1 two chunks of the same data on the same physical disk, one file
 keeps being corrupted
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear devs and users,

I used BRTFS for few months in RAID1 mode on Debian 12 (6.1.0-21-amd64 #1 SMP PREEMPT_DYNAMIC Debian 
6.1.90-1 (2024-05-03) x86_64 GNU/Linux, btrfs-progs v6.2).
I created my filesystem by issuing:
mkfs.btrfs -d raid1 -m raid1 /dev/sda1 /dev/sde1 /dev/sdf1

Those are 2TB WD Reds, mix of CMRs and SMRs with good S.M.A.R.T. stats.
I am using on-die-ecc RAM memory modules.
I never did balance or replace any device.
I had couple of unexpected hangs because of nvme power management which made my root fs unavailable, 
but hopefully it's been fixed by installing new firmware for WD black nvme.

How it's possible that btrfs kept same chunk of data on the same physical device?

Jun 02 23:27:54 node0 kernel: BTRFS warning (device sdf1): csum failed root 256 ino 259 off 
140290392064 csum 0x1315675d expected csum 0x49271c1b mirror 2
Jun02 23:27:54 node0 kernel: BTRFS warning (device sdf1): csum failed root 256 ino 259 off 
140290392064 csum 0x1315675d expected csum 0x49271c1b mirror 1

The corrupted file is qocw2 image with Windows 7 on it and I think I am able to corrupt this file 
and only this file on daily basis.
I resorted my filesystem from backup, by:
1. wipfs any singatires on my hdds,
2. recreating fs from scratch,
3. coping over new data, few days later I see the same issues:

Jun10 07:22:14 node0 kernel: BTRFS info (device dm-10): read error corrected: ino 259 off 
39193079808 (dev /dev/mapper/vg1-lv1 sector 670864280)
Jun10 07:22:14 node0 kernel: BTRFS info (device dm-10): read error corrected: ino 259 off 
33579532288 (dev /dev/mapper/vg1-lv1 sector 199031056)

I don't think that it's RAM related because,
- HW is new, RAM is good quality and I did mem. check couple months ago,
- it affects only one file, I have other much busier VMs, that one mostly stays idle,
- other OS operations seems to be working perfect for months.

Sincerely,


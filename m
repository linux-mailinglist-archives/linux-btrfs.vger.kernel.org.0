Return-Path: <linux-btrfs+bounces-20325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CA5D08B71
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 11:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C647A301AB5F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785433A003;
	Fri,  9 Jan 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLl0gyHe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371B26E71E
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955977; cv=none; b=diSNyLnfR5N4rSNAF6S87ul0eeBsfmJEkXvE22OwN7Bvo74wfL2MRykgvFitWniaHhJiAlzosDjQuXh/XpRyw0WePTU2j5K9K3ksXfU4BbwydIQpQYlfb4wgtXqJgKSnRaj+D8ww1u5GkzE3tWiztvHiYhCWiICzR72xYcG5P6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955977; c=relaxed/simple;
	bh=q9gvI5eMYrrlocpNqGwYHbGrciYl84H9E+SHPCrQMCc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ESX/aNxH4vOpVfF5uVX9pmyrJFRpXpSkrG1fIq3t9cAakKyWlYfT4xi//CUZcJuEf0zaszpMZJPcRNtNK9nrWS7K7HFFgWJWAv6WHBP/IbEiUgykt/GTO4JkEYXeNS4Pzusk1ukS2foduPDI1dkbdE8LdhPT3Oa+WhGuZggk8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLl0gyHe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so2198419f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 02:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767955974; x=1768560774; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLhnj23iq+fSN2ntyOqmOCtbK3DR8O0ozsVPR9f9YXI=;
        b=SLl0gyHeCb2apT020raIduWMc4HltuhXeld1le1w/sUBENFi1FopCPGC2BCRvauBMb
         2xLny4X1a/SLGE0bYXXiHo4/AHSViRFz4o252KN7+CREbBeVSSXZITR7QpiZja+DlY1K
         VpT2YBzXNo1uUJMx7PmkcGwj0AlMun+MN3OMgjLH2gXHizHQ3+CvOEiUB/XBav/d5J3c
         3ZxbMrM8dZH1fzDSv6wxjJmFQBkcyyNKhexDVPRuYYIIUdOz/7nvPDWTTs5ACWGuril2
         ik23BRaWYWqtxU7+cN3aTBwpEmaehaLXjsitpurir+wPu2NbZLyCqWaL9n0pX5qY9q09
         9u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767955974; x=1768560774;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLhnj23iq+fSN2ntyOqmOCtbK3DR8O0ozsVPR9f9YXI=;
        b=HNmbuS2yGs79j3pBgjUnAzgsQ8oNpYOREhwcs2JdDKZTqh+8vvtfHI2pUCPQSZzzSD
         IufPT1XjzwVE2PqNbwPAZ37viAImJxg0lUCQdSvKTAfaCxm8gKbiJsMb/p1dqMylK1rq
         GAAFBwqFkMA4Q9/Z4C4AsOa/aFl1t5hsuMOiLgZma3Vd3hoesQxPuKbtQL2RK6fdhly3
         pCFx3E0FW3l5a/4J9Hia6IitisUE2uV3McXsJovnGBUBQCOOZdWXr3+D85cVI5A+Rwva
         FKHTu29dyGe0UAf0DzJlnuM6SUiM/5KA29Mi87HoCE3cTYS+lQg+PrlYbftKBmhPAKze
         r5pg==
X-Gm-Message-State: AOJu0YxHI9zBTh1lTkKord0y101VE93X179NHPqWrzvMqepX7KS8vTZo
	ZkyMOY9wLR/IHLso5/A4BlicG0pOwtStnJvZ6VPgovua7mZu5ZdxwJ8bMr8CKcMPFCrdOuuvJMj
	cOkdqLSOMkgISrCXFK1cUg2v+bmTmGnKuzAPYRVg=
X-Gm-Gg: AY/fxX6dIDJpTkkMb5NdkDZ79wYU9M5vSU58mtjN/Cofb79XQMALufdu+DvtxufmHHo
	TFpSU346zg8N+qpQI6G/pmdChiUt7o6F3G0dbEdhoxBTe2aTa6C473o+bOxVJuSPQ50bfP9wQd9
	N8hG24t9I4ogbHSFENKix75SSthneE90QJJy0rowB6yJZX+uRsh7H3kJ6BAGYVTZfft5ezvDCeX
	Quhw52mYmW3dU6OQFbGuFgfPnwowooMh8mixXSfS6vFP8OChZsV1CTkLisP7kwapzLE+kHHydRz
	wu6fNngyTs6O3kjHVQ+V5W6GcYEVZNjG2IXC+d7+VADjdBvs5Cz0wa9wqgY76b73p/QZm79pI4H
	d8FPDn94wj5cHlHpTxjnZa9xWIAjcQsZZGtL7hUJktDgAg9V4zyPbPA==
X-Google-Smtp-Source: AGHT+IFcAXemlIEhWtq3H9Fo+5ihzoll4RTapFsdOAboHdByEpBa5Zr/4OXXQMaOXZkEbWX+27oG3b0z4h4pkSXBq5Q=
X-Received: by 2002:adf:f609:0:b0:432:5bef:ecf7 with SMTP id
 ffacd0b85a97d-432c375b500mr9291259f8f.37.1767955973661; Fri, 09 Jan 2026
 02:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Neil Parton <njparton@gmail.com>
Date: Fri, 9 Jan 2026 10:52:43 +0000
X-Gm-Features: AZwV_Qhti4JWj1wlYXOzU89Qb1sPX7lUKB-5otQtUa_H698OIPf8dKN2OHv3l2E
Message-ID: <CAAYHqBbwwFUD5C7SyRYmrXKYtZfx=_=hQpXrSfk=oi5Dp=QUAA@mail.gmail.com>
Subject: After BTRFS replace, array can no longer be mounted even in degraded mode
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Running Arch 6.12.63-1-lts, btrfs-progs v6.17.1.  RAID10c3 array of
4x20TB disks.

Ran a replace command to replace a drive with errors with a new drive
of equal size.  Replace appeared to finish after ~24 hours with zero
errors but new array won't mount even with -o degraded and complains
that it can't find devid 4 (the old drive which has been replaced but
is still plugged in and recognised).

I've tried 'btrfs device scan --forget /dev/sdc' on the old drive
which runs very quickly and doesn't return anything.

mount -o degraded /dev/sda /mnt/btrfs_raid2
mount: /mnt/btrfs_raid2: fsconfig() failed: Structure needs cleaning.
       dmesg(1) may have more information after failed mount system call.

dmesg | grep BTRFS
[    2.677754] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
devid 5 transid 1394395 /dev/sda (8:0) scanned by btrfs (261)
[    2.677875] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
devid 6 transid 1394395 /dev/sde (8:64) scanned by btrfs (261)
[    2.678016] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
devid 0 transid 1394395 /dev/sdd (8:48) scanned by btrfs (261)
[    2.678129] BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
devid 3 transid 1394395 /dev/sdf (8:80) scanned by btrfs (261)
[  118.096364] BTRFS info (device sdd): first mount of filesystem
84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
[  118.096400] BTRFS info (device sdd): using crc32c (crc32c-intel)
checksum algorithm
[  118.160901] BTRFS warning (device sdd): devid 4 uuid
01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
[  119.280530] BTRFS info (device sdd): bdev <missing disk> errs: wr
84994544, rd 15567, flush 65872, corrupt 0, gen 0
[  119.280549] BTRFS info (device sdd): bdev /dev/sdd errs: wr
71489901, rd 0, flush 30001, corrupt 0, gen 0
[  119.280562] BTRFS error (device sdd): replace without active item,
run 'device scan --forget' on the target device
[  119.280574] BTRFS error (device sdd): failed to init dev_replace: -117
[  119.289808] BTRFS error (device sdd): open_ctree failed: -117

btrfs filesystem show
Label: none  uuid: 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
        Total devices 4 FS bytes used 14.80TiB
        devid    0 size 18.19TiB used 7.54TiB path /dev/sdd
        devid    3 size 18.19TiB used 7.53TiB path /dev/sdf
        devid    5 size 18.19TiB used 7.53TiB path /dev/sda
        devid    6 size 18.19TiB used 7.53TiB path /dev/sde

I've also tried btrfs check and btrfs check --repair on one of the
disks still in the array but that's not helped and I still cannot
mount the array.

Please can you help as although backed up I need to save this array.

Many thanks

Neil


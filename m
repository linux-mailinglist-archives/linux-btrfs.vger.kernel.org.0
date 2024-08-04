Return-Path: <linux-btrfs+bounces-6970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2F7946DE2
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 11:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810051F21667
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Aug 2024 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1B21350;
	Sun,  4 Aug 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw75P1/J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F917588
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Aug 2024 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722763211; cv=none; b=p4JQ70Z0hgAwCAsujdRCGHKI/6wEZw7Q+W8I8Um0FmZT/Vg3eHo17yk1yFOxRVlWIU8QChM/UBgVOBMtjli4mTRZ/EGcM2X5sAjZ+0eUsAHtnp9Uw4BO4Ahjphhe+eDVkXYkIN7qnny2jFJ17IYj78jv3xaXUMMMv4PkFIt7kt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722763211; c=relaxed/simple;
	bh=CMdMBBYdOPEwXVoBjZZDt7nbS9/xyHTAaT9CsaVXc6g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dDngEXn4mVEjUP2C/+8MTDcMhV5CDWUkQ/nLn5F7IRdzB9MRjf4OxDsOHDgYEO9kPWMgcc7yfD3HoXzzQo7/d+OcJLBnrPC+FFnrY8AT27F0C+QEB2VEiNphJR8Hcl3PLjolBIZiFwRU53+i0WivMxc09pE73bv/0rif8WP9xuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw75P1/J; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so106829431fa.0
        for <linux-btrfs@vger.kernel.org>; Sun, 04 Aug 2024 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722763208; x=1723368008; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :mime-version:date:message-id:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96hZbMMYAJiBYiBDzZjnavGQVWYd+m7IekPv7HePRjk=;
        b=fw75P1/JyLwwArmz7csx3hY2FWK6zRHk8L8SVP11MQsXVCKCDzUuf7TXIQBqH/FiTY
         DmLt3QMkYqxIlzlJXcOLhRBwTJVdEA+rIjA8TDShtxE6cs/4UwgNLYudrazdY44Ogjup
         CDh2BW0Y1/qRyVuw/ZE8D1oAkXppfxjLJ8R9Z+cmPTHGwTOuLFhJGXjmYJS+MBLsMG89
         0VPJnEBcOGHFOb1QgO5VTvSAFqdiMDZHYar3HyzxQFjEryJd9FPG8sBs2c/hs7fSUdt6
         cLWn2+huxpefsqYBy1ULB81n3h58uMqFHIDGtlTr0moGeeuF+ItmNtjfjqPfAgMeM50W
         s1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722763208; x=1723368008;
        h=content-transfer-encoding:subject:from:to:content-language
         :mime-version:date:message-id:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96hZbMMYAJiBYiBDzZjnavGQVWYd+m7IekPv7HePRjk=;
        b=GSo81haJhmftf4mdAEY1PQBuphGw6d32CBuQyd/OcAZ007Kl86fJhK8Gpx+pJWAkNd
         FG9ytOt2xTHo51Gf/eJz/Y5P6MVjJ1DS6RtlPMI/RVbkB7n9r3v8y/9QzvOU5zSNnTwS
         xY4HJM7WEAxnnsYtYJmSauS0Cu65tITOaD9bYFUpcC3wX5E9AXcEICCZF30dZnc4LeTj
         JThjq8UThY34wpB4VmUFHSRF1UoEC8iZ+F8ve2pVXlzdk1k4Wi700AM0mtCiazqgvLUP
         XCLoze2UhWjhDfoOGS924tPQWqEOiVA+O0YYK8btuUy4po3koQOQHb8Gz4dyfnfzAi1u
         SniA==
X-Gm-Message-State: AOJu0Yzz8/DjWUPL4CpAwqsqkieumJxUr/F8lFo+Xpw/FhHWgeSMOpNh
	2cv9Xtw7pMsG0B+y4uyGSP7mjwRU75xClKjMsJjyw7PDX2xojLfWnhwMUA==
X-Google-Smtp-Source: AGHT+IGMGW7wTIzDzU0lksQOmF7KEkj8cKczvCdEbUcyPMCxUqa3Wp+Vrk0FxsnMdgG+/s2J5eMZ8Q==
X-Received: by 2002:a05:6512:3d14:b0:52e:9b74:120 with SMTP id 2adb3069b0e04-530bb397864mr6308744e87.19.1722763207725;
        Sun, 04 Aug 2024 02:20:07 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba33ac2sm735076e87.190.2024.08.04.02.20.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 02:20:07 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
Date: Sun, 4 Aug 2024 14:20:06 +0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: i.r.e.c.c.a.k.u.n+kernel.org@gmail.com
Subject: 'btrfs filesystem defragment' makes files explode in size, especially
 fallocated ones
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(Originally reported on Kernel.org Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=219033)

There is a very weird quirk I found with 'btrfs filesystem defragment' command. And no, it's not about reflinks removal, I'm aware of that.

It is kinda hard to replicate, but I found a somewhat reliable way. It reaches extremes with fallocated files specifically.

1. Create a file on a Btrfs filesystem using 'fallocate' and fill it. The easy way to do that is just to copy some files with 'rsync --preallocate'.

2. Check compsize info:

# compsize foo
Processed 71 files, 71 regular extents (71 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      630M         630M         630M
none       100%      630M         630M         630M

All is fine here for now. 1 extent per 1 file, "Disk Usage" = "Referenced".

3. Run defragment:

# btrfs filesystem defragment -r foo

4. Check compsize again:

# compsize foo
Processed 71 files, 76 regular extents (76 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      638M         638M         630M
none       100%      638M         638M         630M

Oops, besides the fact that the amount of extents is actually increased, which means 'btrfs filesystem defragment' actually made fragmentation worse, physical disk usage increased for no reason. And I didn't find any way to shrink it back.

---

The end result seems to be random though. But I managed to achieve some truly horrifying results.

# compsize foo
Processed 45 files, 45 regular extents (45 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      360M         360M         360M
none       100%      360M         360M         360M

# btrfs filesystem defragment -r -t 1G foo

# compsize foo
Processed 45 files, 144 regular extents (144 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      716M         716M         360M
none       100%      716M         716M         360M

Yikes! Triple the extents! Double increase in size!


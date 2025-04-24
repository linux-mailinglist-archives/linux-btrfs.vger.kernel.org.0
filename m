Return-Path: <linux-btrfs+bounces-13389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8FA9ADD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 14:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FA63A5EBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7D27A918;
	Thu, 24 Apr 2025 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHJf/lX5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8322701AA
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498722; cv=none; b=c4rjLyCsmLeYMJrC4x+m9uW3Ji4C9idWmdAZKW0Q4TR7B2lN1vq6EzF5zf0HuF6CNTxCpGTrwu+5TzhGR94EnRE9irWTEkrx3+oC1waoevHcyv1DyxdRDOvKK++JV0FphXB7fQX2OusV3+rMB5E0GNGiL6yDuHFi1CsU5PR3Ghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498722; c=relaxed/simple;
	bh=1c1lx8Aun3m4hXx1rB74sfE8dbD+aeEU+Q/Y7ipxJdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OAQLcUmlKaoJkpxSAPkwtcR0sD2roP7QcSlUlNrqHb/sHqkziSUZ5NQzPXcpghgD0P2UGqlyg96AXC928vv6cChkHhg4llWLoPYVMtb9OyyJo9DitKYuoQ7TqCL50dT0VCbDdveSNgHohMAYMH1QASF2Ovd2mO4O+7C6SwZMSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHJf/lX5; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-73de140046eso116159b3a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745498720; x=1746103520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwpFu9Vm+qKRhH+ZClP3Ui+2afjZkwchqv7H+tiyZec=;
        b=GHJf/lX5ffMgiBKjMBdcYq7YualduWzLjP1x1LoFfIWMsSMr79qhZQ8QE/8gYQBqF7
         q2hL0yBlLfGaF/ZnKrmB1DvICEdYGrku1fp3xg+xZPM3PVRTYMR7oa71sj4dPEMcapU8
         FWHn6cqug+0W1TKXqcFxuHyzOk0DYi1BYAMx632XQp63kAHAXl7/J8Pxpm+IfyUAAvM5
         cMU3qOqxGrdcTdetMTiL3TgBgo4pSDI+0A341N8JP6nv4WOR3OuozO1NT0oSaC48S0+E
         zeR4Aat4C/K3k3NUjohBaBhHVQcjvpzIUmtrQyVCoRkNheRFN8TNClLierw2YqlqbGoO
         TogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498720; x=1746103520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwpFu9Vm+qKRhH+ZClP3Ui+2afjZkwchqv7H+tiyZec=;
        b=E26q3E/sMCZhW6l35c8WT1WcB2CPnP6XycMXk8djPjGP6AN7Lu0X8MAn0hFW1Exx+h
         k5P4at70H9RNnq+qZQGJVFGfDakfZlrMOhLotSDfk9bwkr/9GjO8hUjYuKQ1Qn5lMHeL
         deRll9T3KjdGhoe6DJIkONFi1O64YtlRhzl1Fw3tRV66jxY948ZtcH5xKSBxt+0NHCZ8
         bQSzUUkTtymya7BYN+E3FZeeyGndV3xz/wpQTGI8w8z2mOCbb38ydPeb47ziMymjj4gU
         FlyOADLmG421gqp0wDQGg7QZWRrLhTMWCWHfCDxXWsTEXSzijGoA8QC42hNCFfO0ysJT
         vCGA==
X-Gm-Message-State: AOJu0YwUi6F8w8dHmH8qIcZd30jE2zOEHbiQEaQe0l8QOn1tsox86iTW
	6mmmJY/niMddxidZ6Ukuy4u3l3EZTi7NHpfEL/RfJcOhCOVIZ1UBQNU+MARz4cAQqg==
X-Gm-Gg: ASbGncvHjNMwe5pC5KfEDmoO3gzTjjDsMaPirvJxes+7KkegmkBPYRVGjO+G8ZMzFkL
	lI/g4ff2K4kPCUIg0rVi4L7dqcOSkANm1YslY7Ey5EG6jVXnqpNSFKBaQSG3TZPCGgQzsHCYSjv
	9nBKKHV2kLhxknc3qoHlYjZLdsIPxrJ3reYPhtN9Fhzk5anB98e16LzJyyY7SkjwdbYz2OUs4a2
	xKMrNa9Yr2eccNxdCSTGmw0Zhg+ON0MXVIUk7RvqeIsQy1nmQ8f55gtceqMavh6zukuicMbSI/+
	1V80+LTxu7QkePugqKrwxLqA7OkxkYnzVEvUMMX90xkBct/mRvYFjDwjuJGt+LGTsTBZuDGbDUC
	xlJ5ydEw=
X-Google-Smtp-Source: AGHT+IEqNXPGjOPm6FNvEFZKPv0fBEaAVheeZA82ohYscs3j8H56HeLduUpbGgKJJy3lCT9Qnc9+Kw==
X-Received: by 2002:a05:6a21:6e41:b0:1ee:e16a:cfa0 with SMTP id adf61e73a8af0-20444f4150fmr1485874637.9.1745498719629;
        Thu, 24 Apr 2025 05:45:19 -0700 (PDT)
Received: from saltykitkat.localnet (tk2-227-23497.vs.sakura.ne.jp. [160.16.103.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f45bcsm1097375a12.13.2025.04.24.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:45:19 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: sunk67188@gmail.com
Subject: Sharing my faster compsize implementation
Date: Thu, 24 Apr 2025 20:45:15 +0800
Message-ID: <2235418.irdbgypaU6@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I love compsize a lot. However, It is a little slow for me. So I'm trying to 
write a faster compsize implementation, just for my use case, which gets a 
great speedup by both reducing syscalls and multi-threading.

I'm sharing this in case it might be of interest to others in the community. 
All feedback and questions are welcome. The project is on
https://github.com/SaltyKitkat/xsz

And followings are the performance comparison on my machine.

On a SATA SSD device, with some snapshots for backing up, and some large media 
files.
Cache is cleared before each run.
```
$ sudo time ./xsz -j1 /mnt/1
Processed 5663444 files, 1097233 regular extents (3859780 refs), 3459956 
inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       95%      827G         865G         1.3T
none       100%      811G         811G         1.1T
zstd        29%       15G          54G         192G
4.27user 37.46system 1:14.13elapsed 56%CPU (0avgtext+0avgdata 
31420maxresident)k
5060832inputs+0outputs (0major+46434minor)pagefaults 0swaps

$ sudo time ./xsz -j4 /mnt/1
Processed 5663444 files, 1097233 regular extents (3859780 refs), 3459956 
inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       95%      827G         865G         1.3T
none       100%      811G         811G         1.1T
zstd        29%       15G          54G         192G
4.89user 37.88system 0:20.42elapsed 209%CPU (0avgtext+0avgdata 
35820maxresident)k
5060832inputs+0outputs (0major+79430minor)pagefaults 0swaps

$ sudo time compsize /mnt/1
Processed 5663444 files, 1097233 regular extents (3859780 refs), 3459956 
inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       95%      827G         865G         1.3T
none       100%      811G         811G         1.1T
zstd        29%       15G          54G         192G
3.72user 72.98system 1:50.07elapsed 69%CPU (0avgtext+0avgdata 
80132maxresident)k
5254008inputs+0outputs (1major+24967minor)pagefaults 0swaps
```

On a HDD device, with a lot of small files, and some program files.

Cache is cleared before each run.
```
$ sudo time ./xsz -j1 /mnt/guest
Processed 393486 files, 215207 regular extents (215207 refs), 178308 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       29G          29G          29G
none       100%       29G          29G          29G
0.37user 3.47system 1:07.54elapsed 5%CPU (0avgtext+0avgdata 5436maxresident)k
830912inputs+0outputs (0major+7825minor)pagefaults 0swaps

$ sudo time ./xsz -j4 /mnt/guest
Processed 393486 files, 215207 regular extents (215207 refs), 178308 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       29G          29G          29G
none       100%       29G          29G          29G
0.40user 3.97system 0:57.72elapsed 7%CPU (0avgtext+0avgdata 8064maxresident)k
830912inputs+0outputs (0major+5093minor)pagefaults 0swaps

$ sudo time compsize /mnt/guest
Processed 393486 files, 215207 regular extents (215207 refs), 178308 inline.
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%       29G          29G          29G
none       100%       29G          29G          29G
0.42user 9.45system 2:49.78elapsed 5%CPU (0avgtext+0avgdata 12648maxresident)k
954080inputs+0outputs (0major+2990minor)pagefaults 0swaps
```




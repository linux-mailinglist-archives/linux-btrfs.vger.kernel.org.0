Return-Path: <linux-btrfs+bounces-8063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6373A97A299
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 14:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2776A28982A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C3156220;
	Mon, 16 Sep 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXbKNGs6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA625647F;
	Mon, 16 Sep 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491434; cv=none; b=T4qEnhnmxEWz8aQ/W6RsS1dlYCPXeFQ2OTK+wJJ5vKVGwo+iQ0kea99quMlA4jK3pL2u5qYKAIdCy86OUzmlyF66eLnhh16nAniNSn0QHEIH9PxurKdpg+5AhvnB02gyOvXcWXpqqMgjpWVCe/dXdG2WYvfTnf2BxnAhbBBItGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491434; c=relaxed/simple;
	bh=Pzu30nIk+MGmd/7TxDQ6ox8TQu4WXhSZpiY01xSj1d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8921j844EqmHRDXA/qrPKghHRihjDymFP//ae3OhibSEWCQa9I/VzbLtOQ2wdYs2CJrRuK6iYuFOzWSHm25xqUkPRc8qeSYDA2ZvVUtL2xROO5QVKYCnOHGT5sGlNCrR6mgUzDuo1RiOVGjyrqxDN3ThyhkZetYTCna/qwhJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXbKNGs6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso44081305e9.0;
        Mon, 16 Sep 2024 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726491431; x=1727096231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DweuH0H74B4UYNZP5RT2m4CP/0C6RF47K9ADWJGIcx4=;
        b=NXbKNGs62zv/f3rWM8ia9yxsj+xhI8ARG5uw6bctlaRDFMcWoD2PAW9nHh7MlrUwBH
         L8CpuejHMB6YCWimOtwiujuP+1MuKdFsGNiv/pImxIYHqNXTMSey95nLGmjOsciUs/5K
         1/LSx38Qldz57tCStq7TD32N/cOWLO8HG+s4Mgtsm4kB6EY8kA1FwoSDAuh9huNPe+qe
         jRqYn7L82G1Zy4W0eg+SoqUPUvklkoGMxIWMAnhXOEzA9UC3T8rk4GFH1X0YtRpN01dl
         34DCr2g9NbTMhm23in4CW02C4HTiqTPoWcY/0M383IOoT4soWQOSmJqwBG2a9PE4XTC7
         +u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726491431; x=1727096231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DweuH0H74B4UYNZP5RT2m4CP/0C6RF47K9ADWJGIcx4=;
        b=dvjkA6FvqyuYtzAKXC7luqF3led3KONqmAaPvxAP9SD/JJ/4uLOblZa3BaGQlapYpf
         ChKqBC5v5hgDULu12267+N+8PeOHWDQNKYekbQD1lqmdd8iRikD+7eDv4nCPSAQT9XxV
         e94nK3EOp7Bn+wV3uvQhvC+CI+vLe6O3e+rjpk/Nt7XPtTfjt8PPWCx5wtHA22zoA+SP
         JmmmW1zG3yDUZnSy990gDoNrHUlUhQTh6bTQqhux8APcilnHlzSKfoH/4IRjOZTLbzuv
         BRnll9PRL15EPrww0Ce3M2Z3QB1FcegfLctWjQw6UjdGPZxoFuo9/4XxhrNnwTVxBzSa
         RMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoWc3+rH0ye5a5ZYrNoSsTDEEdiZ39lQRgxSTGU53kAKd8FhIfZDvKgGcrDP5x0cCO1ZNt2GpUSm5EnSx2@vger.kernel.org, AJvYcCWsb5GR7RjBKnzWvNQjzeMO0utgO1Ap3jEGZRZUmadgmvEdzSSfgV/QMTNTSgQFolDfNIAM4chDmvXZ3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdYNA0MH9HXTwlwxvehvCT7GNDw/3KU4Ps51zIVpEKSbQJtR5
	9uLq7nZVwUn57/Q+ECvfs9TGgBSqU8BoFVWRm2/U8hLTOqOLXhbIQTDMzFuz
X-Google-Smtp-Source: AGHT+IF71couC/Uh6irPu3RQD8vHs1BpAW6/hVni7sTLg/nrWWJckW9ZSl4j5JxxoEsJCXRJPEnKzQ==
X-Received: by 2002:a05:600c:3381:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-42ce0daf908mr76994405e9.20.1726491430675;
        Mon, 16 Sep 2024 05:57:10 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42da242741csm77129615e9.47.2024.09.16.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:57:10 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] btrfs: Don't block system suspend during fstrim
Date: Mon, 16 Sep 2024 14:56:13 +0200
Message-ID: <20240916125707.127118-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v4:
* Set chunk size to 1G
* Set proper error return codes in case of interruption
* Dropped fstrim_range fixup as pulled in -next

Changes since v3:
* Went back to manual chunk size

Changes since v2:
* Use blk_alloc_discard_bio directly
* Reset ret to ERESTARTSYS

Changes since v1:
* Use bio_discard_limit to calculate chunk size
* Makes use of the split chunks

Original discussion: https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/
v1: https://lore.kernel.org/lkml/20240902114303.922472-1-luca.stefani.ge1@gmail.com/
v2: https://lore.kernel.org/lkml/20240902205828.943155-1-luca.stefani.ge1@gmail.com/
v3: https://lore.kernel.org/lkml/20240903071625.957275-4-luca.stefani.ge1@gmail.com/
v4: https://lore.kernel.org/lkml/20240916101615.116164-1-luca.stefani.ge1@gmail.com/

Luca Stefani (2):
  btrfs: Split remaining space to discard in chunks
  btrfs: Don't block system suspend during fstrim

 fs/btrfs/extent-tree.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

-- 
2.46.0



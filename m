Return-Path: <linux-btrfs+bounces-20481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CCED1C4C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 04:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F17301A1A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 03:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7069A284B37;
	Wed, 14 Jan 2026 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmx7anlE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3813FEE
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362701; cv=none; b=QWsa3URg+7ZavQLX48kAwbDd+LkXbXrMsvQIWaPANA0onJicGmce1YIS7THz7FEH6W/tmzU9IlWjXTX6u/Ki/X77tP9+t6wwge31SfZy4UVBCvNky0NCHOeivpGUI8m+87AeVYisH2qlh5CzRhtnikgR3E1aAZmcaWlUiaZLbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362701; c=relaxed/simple;
	bh=xg33aGGQbv41LjwudG7f1ns1RNqAPK92OXzw+6TaV2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPAw9sMy71JO22CPiqK9PGqe44YERONoiRrcYvJrY5D4JQRXORPCphrcZuvJqc7e31NvaEZjsSQlf0Hbi2sa6hT6BuHnwc1QWX8skhcJe8++Co9VS8foY+lkI8+j2oTk3lrDp5M7bovbhAV6bt06SnVhjBd5u8NPb7UQ1N9JDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kmx7anlE; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34eeffdb197so1068258a91.1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 19:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768362700; x=1768967500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsPoCdpB7pcCCLBs/1KT4bKZe7mrQSOJxqxrtrRblAg=;
        b=Kmx7anlEVg2aPWlZY2c/1j3PNgoxgFyONf6Twr1qH7WOHNM5kJrp22/mS06MYMKMDc
         MHdPMhj+23twkI5DEA4lpOMervICdKVYwB0deI43bJw+0SkGVcpG/7G/j9DecrlZdf5/
         sQFOgh2h+wjfi08/3IS6MvaOWzbfUU+eY8mMz7dJlx1cG+z2gtBHhF3cxTEyhlHvPILR
         U+DaJBeGtYsHNPBwEOZgbzGaMFAZ1pDGnn8RnKsZzs72TpU4BrXFfRB+VRfaiI7KknF7
         YmfuZ4Pc/729AAmAEwGtJzpIFVKEwC/6IlFPecDbXZ0NU6taZ4y6RF+SXnuYMiF0gfBL
         3m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768362700; x=1768967500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsPoCdpB7pcCCLBs/1KT4bKZe7mrQSOJxqxrtrRblAg=;
        b=gAKLD98odUvP7drtxI+pTqBlpW+i/wG5SGm0aztN4kKMB/FX2inzzQ4ltzCTzzhLtN
         rEqVTzzDdVzgVGowEBngPC6rCVzU++hIyIGLgYY2iqEGmIWQFmNvp5yYJQOH1uNUZFDC
         5GAYO6htiQ8pM3N3oAg+pKLMYh3FqTPB4WZf0LoyHl8UfiRCTfZIaJWMtUV65U15aNii
         7W/a5Ck0blv2Czh6rAu/L4vNmGvuS1qfjOCK6smVWmN3vPEOBLD8KDhLQ/Et9zkWYa+t
         ytzZFizcneZX8OQhCUpa2z2tlUPrH8U28/acaDyW+Lf1eUJOk2oXNM/+TmebF3I5DmNN
         rGbg==
X-Gm-Message-State: AOJu0YwPKG/qlc0aMSpLeoGJO/I0B0qJosDMFV0509fojPrKZSumUlAL
	3f1qUyaLpuIgFDZ2GPDpcAxz1MDGaf6t5kPKOEcVJCO+QyqCAasv7IHfzVGUKsmYXkVN/w==
X-Gm-Gg: AY/fxX5huSU50qbOBjZmURGPM76EQ/xA5BWZw053EECmVD+KguGzq7Y0j3UNhUFMytL
	NTzFnxNkO3igVi9kJNyxUU7mN27yA0bB2l7r5ZE5o31vAiRDU31vadsBCN/DbhVrfjnvfYUWvpy
	WqOuXF1VHjjXz7Oz5rtlJx80Qy9DaELqRxJlF6S0GqYFdpTUJTQbsEytkFjiynAwrhCCGvdIUyt
	bxm7IJQL6OB9TZHVbmMEsiPEGVwgfWsMR/sYzM+Qynhsyf9U+bwWrb/GkkgoQIfN6jNQuVJ1w0C
	ATioOX4zx/NkPlCDi0cLxdFtpVr88FcaAeuXGJvkemyUP/btRVkJjZv16WC0WZE8dG29XcbH45u
	KjI969X8OmM3INZ8jbYHFhJskwbwvqesTVl0D0BPlfXvgZ+7vjXQWFSdvA5YuLtJNwjg3aDgogX
	yMk7lGknog1fppLi1on+ZLglCRadS2T/0=
X-Received: by 2002:a17:90b:5185:b0:349:87eb:dfbe with SMTP id 98e67ed59e1d1-351092d8fccmr925195a91.8.1768362699869;
        Tue, 13 Jan 2026 19:51:39 -0800 (PST)
Received: from SaltyKitkat ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35109e7ee68sm525647a91.17.2026.01.13.19.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 19:51:39 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v4 0/2] btrfs: fix periodic reclaim condition
Date: Wed, 14 Jan 2026 11:47:01 +0800
Message-ID: <20260114035126.20095-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series eliminates wasteful periodic reclaim operations that were occurring
when already failed to reclaim any new space, and includes several preparatory
cleanups.

Patch 1 fixes the core issue.
Patch 2 is a trival cleanup.

Changelog

v4:
- Remove setting periodic_reclaim_ready to false when failed to reclaim a
  blockgroup since it's unnecessary. Sugggested by Boris Burkov <boris@bur.io>

v3:
- Fix the core issue with minimal changes, suggested by Boris Burkov <boris@bur.io>
- Drop some cleanups which might conflict with some other recent patches
  in mail list. I'll send them in a seperate serie.

Sun YangKai (2):
  btrfs: fix periodic reclaim condition
  btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()

 fs/btrfs/block-group.c | 18 ++++++++++--------
 fs/btrfs/space-info.c  | 21 ++++++++++++---------
 2 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.52.0



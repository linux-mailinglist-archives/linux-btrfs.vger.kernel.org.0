Return-Path: <linux-btrfs+bounces-20085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 834FDCEFF42
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 14:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F703007945
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500F2F5A12;
	Sat,  3 Jan 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNfEmOYE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122B15A86D
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445590; cv=none; b=YiU8OWPeI99BisMFMgLE1rF/wdFYWKF7yRDt2+deLKXLJXuRP3bBNCNazLc5b1nDUUE88L6aotS/HmAnDdHd0O8yWwKZukzgByD5r7FYBLCeesbCyzQnJpA7ZQ7rDtO0PR8qvXxQaXSRwVkmfi/83j7rN0rGGW6sTk+4APuhOvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445590; c=relaxed/simple;
	bh=4TuBOjxcUot5gUnt1Goh0d9Ev1SS+Z5X2QZhlCgUnyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J92iVu935NawfS6xLYLVT47LQB+ZasqGNJ6O9jwl+SagghgReDia3UTebYusxvjqfhp6Zsrzku8nK0eFxCaEoIenNogmwJS7GSieR9aQ03eJiZrpKOKYxBVhWAv5dN6ESDU1hXRyY11mmY/bpCjbhMC8YPZzNcxxUXMCBsPWllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNfEmOYE; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6447a204210so1812000d50.0
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 05:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445587; x=1768050387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgm4X4lFoynQSsq93atEaiNN27R/RIbroWJ+Kwft5+Q=;
        b=UNfEmOYE40F93kqpEPsjGcKg+NIdnzQFkYFjw9/AwMYG1ZTp444c1xInKewJzOQi6r
         dAKcGLK0DRZtrfyrA3+x/NezW8ZosLviExk9feWmElZdl3+S32yloZLsX4E5Ta68LF84
         rCeASqo34Y7apcdWTA0+dKwhlbtlbVqJg2x22CrrLnA59IahX/97iNjPQckzPruu3qRv
         81OSVWGI8NiJOuZjehfk16Oga4OcUl0GNz7CN3La1HVDOlWqMbaoDmlDAyfiowqI4xYU
         1iZTC0SGrcL/e5TQm+Ls6ryQRggWwgh4m/4SZn+CXS66bA0UtPC3kmzmurzyaVL5ej3h
         37MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445587; x=1768050387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgm4X4lFoynQSsq93atEaiNN27R/RIbroWJ+Kwft5+Q=;
        b=uHxEnit7OghxOe6beANOD3v+liGO2edw/Gd9pm8u10TrrbPDodAWQREXrUNcBxIfpn
         EwNvjXfL2Npbjc92NckPqi1OLpolQBAiYXpLfc05bEtfu9t13TR3e1EvXMYzHItrMnaC
         dtwjsipH3yc5c/LgRJhiC0s2IlogvIHHygq6ljdz7+cr1yDiumKno9xCJtp64rapHR2F
         bh+GEENu8+LG+8cvVOoCftiNj6iQJqioslkMlt0H4FRVBME/7t2wiVAprnFz+cLAmDed
         6BAAZGTCE9TBUCNBW/GrL6iKV7XQBowFQlTI2e8of0V9b3FmkUUoiyg06ILZu+SYcuFk
         5MCw==
X-Gm-Message-State: AOJu0YzeTsnSrWtHmRO+iWlkZvQmHjU45NFKBOb1ZshVHYSFFrsldbkq
	CAr0Pn6cQ57P2/pOEZdBDPkxF9K9EKDG7MftVshQp+RGBD7chngiu410a+FAfRJwG8koBQ==
X-Gm-Gg: AY/fxX4+QfgXYqjAbgZZhr9WoBGXnqPRNLkEeulqvL19gZHbRk6x0xv3QxNENs9UkNj
	E+w0UHDUwDuR6z6vElL7wf6DuAH8lcoVqz4V74XRyU2XHhCw12DpBVFtiBryEcB/HkiJGODaFWO
	DNfXXV+nz6dwh4T7mxetigSqHaINjWT6BeUmFTq5sR5SWVt36WB6pg7PQazq37YbuZQmS1PL7rq
	rp81+2PJeM93GWOH+sNLBeKs8gnKK2QPPDVkdgmKfTu2sGbC/Xpu2M1GZbfUzlMec5pCTyd/s5H
	bOcpWVaUfKt1Li3OfFqJ9BBIUy759OEQRKKwTEHZxTikLfopid81g1ofpxAq1nZRt8jivEBAdPf
	ztnHq7rsw9/VhMTOEtIlKIAQOLNBgoWHmMS5fWSMRZ7VRpHDkgChp7BVGjDPWZvhYQR3NJRARVQ
	iRFMnB/PSxCtAhM84QPVY=
X-Google-Smtp-Source: AGHT+IEj/u7GwiadxS2UMmhh2Ic8LbkS3xTruUmnVobS0mnUqT6emRLT+tUS4CAbVqybPGi+MLNxaw==
X-Received: by 2002:a05:690c:f13:b0:78f:dbdd:6546 with SMTP id 00721157ae682-78fdbdd67c7mr287674117b3.5.1767445586781;
        Sat, 03 Jan 2026 05:06:26 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm112554957b3.15.2026.01.03.05.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:06:26 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 0/7] btrfs: fix periodic reclaim condition with some cleanup
Date: Sat,  3 Jan 2026 20:19:47 +0800
Message-ID: <20260103122504.10924-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
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
Patch 2-7 are cleanup with no functional change.
Details are in commit messages.

Changes from v1:

- First fix then cleanup, adviced by Qu Wenruo <quwenruo.btrfs@gmx.com>

Sun YangKai (7):
  btrfs: fix periodic reclaim condition
  btrfs: use u8 for reclaim threshold type
  btrfs: clarify reclaim sweep control flow
  btrfs: change block group reclaim_mark to bool
  btrfs: reorder btrfs_block_group members to reduce struct size
  btrfs: use proper types for btrfs_block_group fields
  btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()

 fs/btrfs/block-group.c | 29 ++++++++++-----------
 fs/btrfs/block-group.h | 22 ++++++++++------
 fs/btrfs/space-info.c  | 58 ++++++++++++++++++++----------------------
 fs/btrfs/space-info.h  | 40 ++++++++++++++++++-----------
 fs/btrfs/sysfs.c       |  3 ++-
 5 files changed, 82 insertions(+), 70 deletions(-)

-- 
2.51.2



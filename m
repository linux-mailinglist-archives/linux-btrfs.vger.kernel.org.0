Return-Path: <linux-btrfs+bounces-19593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA8CAED19
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 04:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 617AA300F18B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 03:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215D30149F;
	Tue,  9 Dec 2025 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxMRYxC2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47792F1FCF
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251486; cv=none; b=M2B3QcKdOmizAnGaS4quqqVsNDAqubMFAJ6w0iL7DFTPQLh+7gx08hLZd3vTL4A77NL8qq1zteMbzK0dVZ0uLX+PNG7PeSLLV1VUFUZHQLC965PWqSMGZIvDo3LizdIexm5BKnUnidyDESPARhaX2IUsMvQklcXFOi2KndebGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251486; c=relaxed/simple;
	bh=yB3RyEj/oqUKbBmIeSSavLlNVpLyvwmVpRrygxIXVNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4TfEuMWGqmqSCpFiLmMkaOYmUdA4UxAlNl5tnDffXFR8UyIfT5Kzhkjbhz2AGKxo+CNo1/YPVXtNb3hI7IUmSTnJzONbVQV0oV2iG3rkSHfbCF2uslpOa68HL2F5/4hVn98tp20nKIKQ3lxop0jtkiAt5TzRZl3TsCvKY1YZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxMRYxC2; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7b90db89b09so564190b3a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 19:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765251484; x=1765856284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhqf5jwofzMsHmKf1DdMDZm52UhXy3shxr5zhKg0Y5g=;
        b=BxMRYxC2r3JKcIFgVFIYHsSUV8JDGVx1ybBKpe6bvTwBhwLcfP2uNR8SH8aKGbFFxf
         iD6V5Qvxcicugp/LA0pnyO93cAGM1lQ6EFGWot4aym1MvORS25oZ6mqKPxqmM6u9mbz5
         WoFMUTuKrOnVaPUDa0n4cr+xxcbD39W4oT1/O30BfyweORfjI7IdKKLtLRfMnYuBg1XL
         q5u02OtF/3zAVHw45kfRHIe38ctD/jElSHgcODbuXkmcnExRWq2zM2u+vfv3ME/+qFbw
         fRsOWVbaUqMYmu7O+ZZ187FGLOP/sbhcWYrKbwa0GFw5jQFm2Vm6Ji7/me1py+Evzo/E
         UowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251484; x=1765856284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhqf5jwofzMsHmKf1DdMDZm52UhXy3shxr5zhKg0Y5g=;
        b=pluIiP7MtcArW45caxeeN0DrooKTmm8fLan/QjjMMVGC6yAp3B7tf5JhxHf/xRHq8x
         Temwo+Co0Cj2ANwCVZNnmYOEYMvnQWxdroPT47MZwFwPTx/gKRE6WLFRoode+rItNxCD
         8EgWwr3NMrixT/6Eiin2dwDylbGkaFSqTkimS1jOKEaBXAup4QvoQzsTBpIZ0eXeIecG
         pLvhYXTtcKLZ4YLho7wdSFTac/bol7CXgdw6u5v4Qscc1bBzpDOTyddWwUfJnKuYANWK
         6GqM7puuTRpeyqE23UtuNL9F8YeYuD2emi8GQyL+CWETFot+l+I1oExZIGN+zbBZSrEY
         6w/A==
X-Gm-Message-State: AOJu0Yz0CY69MgAzXI7AR7eFdvn/Vns+u7HPENTwca6PcLOHiGFYH7ze
	Sv2yKIRqrUNiz7VsXcW3+csRcomVdH/v9HbO3/VZg4HWN389h+BD3kavDQBt6er1bapocg==
X-Gm-Gg: ASbGncstYQ5LaNLRhaGrYcdOP3PgjJ4db6vD71fcX6X8ouyq99q308MSNckTmIu6WZX
	Qlj7W6mz/dlF4qRC3Vk4saRmr1oLQs8R3EuYagzoEjzaE7wC4nleycP2b3sxjATkDx/9Go3W6uk
	0/F2A3X1FUGiJa6GFzJ31ddr0SFcwRXqGwmQoGhfTWHfQ1Bpm3zbvvXBmz/RCiXZwOMXhdkSLZV
	if3GREZu0GAoUYUUW26yraH3oqkhbDHNPPstamduW+SjaUwyQdEr7bAhGui5GjfUM64+B4l4yy5
	tky7lzsTwHeeHe4cix5WZ46Qm9yxwR8qxvVvG80KbxWW5kKUqxj5KrdYM4J9+BVbb/+qDac278n
	b4gaytbezQIMWEwl9PPkj7OOSp3tN2gO5hcooTihnyr7v0KC5tO8/19VjHcoQ+UbID3HqvN64yq
	2H+DScdyIPixKvu5WV9nzq
X-Google-Smtp-Source: AGHT+IGA2xlxzo32OI4mRcrxaCJ7840Q8IROcMM4GHYu4vghGFYiVnZZRbhdItgntZPpfh6pZelr3A==
X-Received: by 2002:a05:6a00:cc1:b0:7b9:e902:45d8 with SMTP id d2e1a72fcca58-7e8c44a8260mr6914659b3a.3.1765251483863;
        Mon, 08 Dec 2025 19:38:03 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7edac47617dsm3923900b3a.42.2025.12.08.19.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 19:38:03 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/4] btrfs: don't set @return_any for btrfs_search_slot_for_read in btrfs_read_qgroup_config
Date: Tue,  9 Dec 2025 11:27:18 +0800
Message-ID: <20251209033747.31010-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251209033747.31010-1-sunk67188@gmail.com>
References: <20251209033747.31010-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The call to `btrfs_search_slot_for_read` in `btrfs_read_qgroup_config` is
intended to find the very first item in the quota root tree to initiate
iteration.

The search key is set to all zeros: (0, 0, 0).

The current call uses `return_any=1`:
`btrfs_search_slot_for_read(..., find_higher=1, return_any=1)`

With `find_higher=1`, the function searches for an item greater than
(0, 0, 0). The `return_any=1` flag provides a fallback: if no higher item
is found, it attempts to return the next lower item instead.

Since the search key (0, 0, 0) represents the absolute floor of the btrfs
key space (u64 objectid), there can be no valid key lower than it. The
`return_any` fallback logic is therefore pointless and misleading in
this context.

Change `return_any` from `1` to `0` to correctly express the intention:
find the first item strictly higher than (0, 0, 0), and if no such item
exists, simply return 'not found' (1) without attempting an unnecessary
and impossible search for a lower key.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/qgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9e2b53e90dcb..d780980e6790 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -415,7 +415,7 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	key.objectid = 0;
 	key.type = 0;
 	key.offset = 0;
-	ret = btrfs_search_slot_for_read(quota_root, &key, path, 1, 1);
+	ret = btrfs_search_slot_for_read(quota_root, &key, path, 1, 0);
 	if (ret)
 		goto out;
 
-- 
2.51.2



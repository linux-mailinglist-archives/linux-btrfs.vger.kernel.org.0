Return-Path: <linux-btrfs+bounces-15847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D050B1ACFA
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 05:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF3F3B6DBB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 03:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E11F5838;
	Tue,  5 Aug 2025 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6d9ghle"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81B1F473A
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754366261; cv=none; b=QhP9crdg8n6QBp/Y15QM4h96AU4lGwWM1j1RpLdQshn35M6/8u7VhzGUq1LKzRIzK70AzSz+3kwYwAzrWhxvmAAMtS0FIZYdwnJ7oDMt6PPcwVQEHPBDeuQpVU5exM3giR6T1HthAGZ7DgzkRdIgvf4+6yatz5owCRnU2es0vsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754366261; c=relaxed/simple;
	bh=qV/EHRNvvR/18CZfl/AL8DFiGLakYlwhy5bqT3hJKVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEZwYuzuGf0PD3FMPtxkFYyGdVK34qZeJdGtaKijpH9QxE/eyZvnT3LxCj5M6O8ydyMRxJlf2NtSv6fj6Cxf7lZJVEEzw2ni3y0PAV2HGAG/cbKe9tx17CN7Knf0m7l+WroMYsQFdSrmYJ2TVTwozb5v6H138lPp/DWCy+hnxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6d9ghle; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-24050da1b9eso6147945ad.3
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Aug 2025 20:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754366260; x=1754971060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFLvRZFTcc/W18g6o4BdqpOJT2NlWkj2kjvAGk6etic=;
        b=G6d9ghlerUyiXVg60cP5y5yNDrQOap2qKOsIsx/XTI+SaZ82k9NpnPjwDbIpgBvtp5
         OHnruQQnefQvuC3eIhacGHy8TiT5Q7gKa2IEBXpcejEsYTZxnIE/P3gSOlsBqktZONLU
         gNFSbWzWYEFyC4UUxHSvpFC2U8HyV2MrzykKXhKH/VFE4UZh9oRf3/81wQ8DIkSZP3IT
         DDicfV8/jRiMcM7FBBv3UE+sGU6lG+FMpasC/8GZp8THC1mNcwo4YbGzdAhr33J5q8o5
         1kSgSeSHcYtemAfawLm832PKi8s4HwYwb1lJWG18PVeQQCPT1yPU2IMj9HJuddUQU0GC
         Tm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754366260; x=1754971060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFLvRZFTcc/W18g6o4BdqpOJT2NlWkj2kjvAGk6etic=;
        b=MgaoVlzHnJKaXgSEyHfejmfnZoMuAFl6fAlGin4tDfd69ctKXekfFbMzlQCvCluxVb
         16dpNjYSsh8Ak6kPkEi4PqVy5OvuHNx9XlJXclSrI+tJvosTNPXd8wkLV/U+Zgh4lclr
         k64BGiH62yD9G4QfD3UCvEZWOV+Fre0jw/W1zIWrDWA4fGu4fHVgN8zqcEFhyLsxZL2Y
         4uNZReaG3Yozv8hNd4nbDOsCppQEmcja/NA9te6Enca/Wa+qkt33/sG/9uvbiPd//REk
         TcE8gumIU10QdDy1zHxEe2jH0xST9qGjDuf5BzXClx+3TlXCmYZANRmbETvVP45xueN3
         by/g==
X-Gm-Message-State: AOJu0Yz9oWfmlvvd3mSkWqi2poFRlqXXWQTQAYgXUuzPQjpEhY6PVRTE
	l73dGbourcBc19dCrqe6klnUUb15xSPqGwQ85ymkeR2OtKWFQCRDHroJBQBK9Jl5Kzw=
X-Gm-Gg: ASbGncvUeA/bjEkS/HFMZF55NXMeKJaL54ETJTNTXetCoBbH870+PDY9JN72r5DYNJt
	uDbvBbD/+U3udbXzKS93LDRoyVRyWpfNaTgz+I9bpqrnBNnCuT0FesrZVkNvKLHtlDf8uA4l7f9
	OQ8KBSXmwgpcVrkjDJw4unc/mgY82d06nXr99JRLxMfToLTELHqAlZuWTktOQzhBlzha8eDa357
	oB6+kUcJYoqf2i62qW79YU9nid30SdGaNgF4pP/9aSXDO+hMZIhOMhEnsxBChrdWtHHsIKGuSu7
	vpWfSb69y6xzNeSh5KOgKizwLMAiz4uJeq4Rtn4f1aLAFE0HQkUiZTuv6GGdeSHg3XQ00sGz74h
	Dd5T6CeqnAwvvtGoRCohyEfq+pDzQ
X-Google-Smtp-Source: AGHT+IHREn9OAdKD3kGnZ4qFjAIVlsJDyqboLhucL/JRYs+h+aiXIHv/ATU+K08k+Am2ZM9rhMveyw==
X-Received: by 2002:a17:902:e743:b0:240:71db:fd0 with SMTP id d9443c01a7336-24246fcb42emr67470315ad.8.1754366259545;
        Mon, 04 Aug 2025 20:57:39 -0700 (PDT)
Received: from SaltyKitkat ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6c28sm121361455ad.14.2025.08.04.20.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 20:57:39 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: fix node balancing condition in balance_level()
Date: Tue,  5 Aug 2025 11:57:04 +0800
Message-ID: <20250805035718.16313-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cfbb9308463f ("Btrfs: balance btree more often") intended to
trigger node balancing when node utilization drops below 50% (capacity/2)
by modifying the condition in setup_nodes_for_search(). However, an
undetected early return condition in balance_level() prevented this
behavior from taking effect.

The early return condition:
    if (btrfs_header_nritems(mid) > BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
        return 0;

caused balance_level() to abort when nodes were still more than 25% full,
effectively maintaining the original 25% threshold. This unintended
behavior persisted for over a decade. Since setup_nodes_for_search() is
the sole caller of balance_level(), remove the obsolete early return
condition to:

1. Align with the original intent of commit cfbb9308463f ("Btrfs: balance btree more often")
2. Allow proper node balancing at the 50% utilization threshold
3. Improve btree performance by more frequent node compaction

Fixes: cfbb9308463f ("Btrfs: balance btree more often")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index acd85e317564..8cc52c8b38f3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -939,9 +939,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 		return 0;
 	}
-	if (btrfs_header_nritems(mid) >
-	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
-		return 0;
 
 	if (pslot) {
 		left = btrfs_read_node_slot(parent, pslot - 1);
-- 
2.50.1



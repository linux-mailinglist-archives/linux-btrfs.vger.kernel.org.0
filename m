Return-Path: <linux-btrfs+bounces-10855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A175A07B90
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A313A9680
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE8B22256A;
	Thu,  9 Jan 2025 15:15:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A872206A2;
	Thu,  9 Jan 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435726; cv=none; b=jGZBl1adhRxIaX+S1gZQmQCrKJYgcOUFjIwILJVludPoid3zr3cgsOX62hzMzz5eQBgzVQWGnwu1rny1vwVCluND8oZnqdNoYpzD3MqVdYv3KGe/AJ8OF22n140dv7qefD1hwzaf+SnUuKS70r11mmPoasSFizioUM1rYp+52Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435726; c=relaxed/simple;
	bh=TPpzFBz1Tfok3H7Juh1nfS2qBg6gCG/rB+9bQp42q6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLt3R8KwAuyuRFZL6GvpXbmGyU7AOk4VOMU78Ok5aCN8JVB87zkiUXcEeTsV4ZdNeDR7+EM+H7Yw0591Nv/DERHt1Ar2seU5komVXMayiBHAfA+c3j76JCvR3JXvhahBS8EatJ39sb4ucJBLIleQMl1QSkzG76t/JtaqfM9q3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaec111762bso213316066b.2;
        Thu, 09 Jan 2025 07:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435723; x=1737040523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zCcosPCtrb/W/+0fS/Fgj8H05OM3LWN+IlkXQWO1tc=;
        b=PFntVmtwcW3um8U3SHStGp7eBOyKCHm5LJhOtyfAc9OvFYcLhE5sSvAEBw+k4jVIAr
         0yYe7fpwAiSsiALRTLkPKNAn0gYGz533I0Ex0KPpuKJsK4kzXvQUYw8t3S7784WSm5nE
         5XQSLOk1uDQyvBN5d76fdVs/3DmcfYGw6x9u3pm6xN6X8kC4gMu4qQ7IdYvZC7ic3hED
         lJeNkvG3N+7kroTx+bEztW2vFMrFNTdWutnVxkaPPvCtpRDhHF+Ugw2srx+1Dt+kJjJT
         9vg8c4ei/o0Y5P4xsuKkDmP5SXe3QLCtRoXXWRU0hWc4nly5B8G9ceSd/tayV5WaMPhA
         5j1A==
X-Forwarded-Encrypted: i=1; AJvYcCW6CLoG69MUu9X/9hG54WbC2vZ4dfb+Z9D47rDdioYG0ofqjUD1TBQ9TthgL+vWqYknkJ7KzwFWTCNTfN4q@vger.kernel.org, AJvYcCXwGwIAsAdIl/+z8/C49npr0cFIEz2HPQDOepjpWETmj/9yw1kwvrCts5h6QVZqNubVL3TasPusAtvEQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZR/hQRpT2Xr8+b9HWW/4FTDUDc5cLqqqE1SYO6hMaDVzCSCmt
	jfSybWPUJR9gOa31vC1yK4QndAT9Gpe8LF+Hy2lR3YMQydsCXHVv
X-Gm-Gg: ASbGncuZn/srYdYcO+OIVfW4dvefmlIO9Lqull8z3K4t70dg3eabfvma4O7sRVwXnvX
	GndRy1wrkzl5ygzNbrmBiDnI2CiUx9/Fqo/Rd92B9G8e0eHLDiv7zCTmfmaBDyXtN1bMJhWDmbn
	fnnGonqVg+toeZHehyKU/oOC5wJbhZqSMOCDh1V0I9hUEpweBI4Zj12AXwtCTCdf65zTkYlOhmm
	SytxmAAtn9KrprX20zn/dE2zjsYwDeRLyJb+zl5Hlrarw5jx/f1K9YBiWZgMo/cQLEdGNnomkqv
	JP3HY1c5+sRP8T17HVHyeh24FxG4RaKALLuO
X-Google-Smtp-Source: AGHT+IFMZS8N6ajle8qw/ZE0uq7t8wx3XX+lJtOj6WkITaDfrFdr1C9nEgNfIu67IuCGjIN815loeA==
X-Received: by 2002:a17:906:4fd0:b0:aa6:a7ef:7f1f with SMTP id a640c23a62f3a-ab2ab6a760emr606877466b.11.1736435723334;
        Thu, 09 Jan 2025 07:15:23 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:22 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:06 +0100
Subject: [PATCH v3 05/14] btrfs: fix tail delete of RAID stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-5-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=jth@kernel.org;
 h=from:subject:message-id; bh=yBjlqqgQ2kb+Va+7H2jeNcFMvs3zrjoSGy7Zp6K5xgU=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2Dp0d8rs+2SDM93A12xxKwtGtdkfS5z/3nK4JCeE
 ljQddm4o5SFQYyLQVZMkeV4qO1+CdMj7FMOvTaDmcPKBDKEgYtTACay+wIjw7HZ8mW/+VZpbVOY
 Om3Oxb5rOTv4BH3ivm+6kyQ1958mpwrDP4vft6JLv0R/2F5/vDGUV/Kmz2RXx7lK07SC/1xTlXx
 nxgAA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Fix tail delete of RAID stripe-extents, if there is a range to be deleted
as well after the tail delete of the extent.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9e559ad48810b704c997ff5e51222aced0b91637..ef76202c3a38460c5a36d7309ac0a616f73b0cc0 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -119,11 +119,18 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		 * length to the new size and then re-insert the item.
 		 */
 		if (found_start < start) {
-			u64 diff = start - found_start;
+			u64 diff_start = start - found_start;
 
 			btrfs_partially_delete_raid_extent(trans, path, &key,
-							   diff, 0);
-			break;
+							   diff_start, 0);
+
+			start += (key.offset - diff_start);
+			length -= (key.offset - diff_start);
+			if (length == 0)
+				break;
+
+			btrfs_release_path(path);
+			continue;
 		}
 
 		/*

-- 
2.43.0



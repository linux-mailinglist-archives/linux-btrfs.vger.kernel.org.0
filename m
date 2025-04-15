Return-Path: <linux-btrfs+bounces-13024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B120AA893F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 08:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A6C17726C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 06:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599452741B8;
	Tue, 15 Apr 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="PtLsEI3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC043146
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744698845; cv=none; b=TsK3wt0LgCcqGQdYBFNoz/r0P1NXxLFcxMn70EUXXth2r9wZStNgx+1GmjuknIIpt0ZimnqMzw4Fj1wjGIpHhfX2UXaXcRZsHOhhih+xkLO3Xs35BpYdPALj8Z0RtTg6uxmXrEqsUQ0k20W2m9KivEItS5Mi8VRzl94Xaep9Xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744698845; c=relaxed/simple;
	bh=+7POf3BKDSADT6PugLY9he5PRCgO4fnWHxC07mK0z0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tA/SztnGY/2mf0pscgyIiXOrtXtSjS9gBLMuBRUWsnNmBI7/tZkZcq9yyR6sNqjO7rYBxeGq2ld15KthqgKT0RojUeWENu0R1WEs6qEmGdPV5nYaDv/kSqq3Z0pJ52bcJwkW+7ALZBxLQ042+72mVV+rByIrNoOUZqZr0EdKX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=PtLsEI3r; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from 11212-DT-014.. (unknown [10.17.40.185])
	by mail.synology.com (Postfix) with ESMTPA id 4ZcDrn2XD8z9mKKkV;
	Tue, 15 Apr 2025 14:34:01 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1744698841; bh=+7POf3BKDSADT6PugLY9he5PRCgO4fnWHxC07mK0z0A=;
	h=From:To:Cc:Subject:Date;
	b=PtLsEI3rRwbeTUp0rml37nNjIh/rj2iGHKUU5tEM4cKy6j6xGiyUsxdKtBIOqvdjK
	 GpOgv4BFl1ABFvsUfV+GSFs6BEGtGK5gUfmYZSz31kescV29cRc+Uw4XJ1aRmVfw9v
	 zs6isWp6UaDrcDXscSQZiyqcT3MpBUbcqUqqw4y8=
From: davechen <davechen@synology.com>
To: linux-btrfs@vger.kernel.org,
	dsterba@suse.com
Cc: robbieko@synology.com,
	cccheng@synology.com,
	davechen@synology.com
Subject: [PATCH v2] btrfs: fix COW handling in run_delalloc_nocow function
Date: Tue, 15 Apr 2025 14:33:42 +0800
Message-ID: <20250415063342.3033071-1-davechen@synology.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no

In run_delalloc_nocow(), when the found btrfs_key's offset > cur_offset,
it indicates a gap between the current processing region and
the next file extent. The original code would directly jump to
the "must_cow" label, which increments the slot and forces a fallback
to COW. This behavior might skip an extent item and result in an
overestimated COW fallback range.

This patch modifies the logic so that when a gap is detected:
  - If no COW range is already being recorded (cow_start is unset),
    cow_start is set to cur_offset.
  - cur_offset is then advanced to the beginning of the next extent.
  - Instead of jumping to "must_cow", control flows directly to
    "next_slot" so that the same extent item can be reexamined properly.

The change ensures that we accurately account for the extent gap and
avoid accidentally extending the range that needs to fallback to COW.

Signed-off-by: Dave Chen <davechen@synology.com>
---
 fs/btrfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b842276573e..394d5113b6cb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2155,12 +2155,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 		/*
 		 * If the found extent starts after requested offset, then
-		 * adjust extent_end to be right before this extent begins
+		 * adjust cur_offset to be right before this extent begins
 		 */
 		if (found_key.offset > cur_offset) {
-			extent_end = found_key.offset;
-			extent_type = 0;
-			goto must_cow;
+			if (cow_start == (u64)-1)
+				cow_start = cur_offset;
+			cur_offset = found_key.offset;
+			goto next_slot;
 		}
 
 		/*
-- 
2.43.0



Return-Path: <linux-btrfs+bounces-5594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C6901D22
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477CA1F21A0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F3974C14;
	Mon, 10 Jun 2024 08:40:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492356F318;
	Mon, 10 Jun 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008837; cv=none; b=Ub6jxvVQysZtnLDaB+DxXyoN63A75nVvaUUeX9JU6zriYAjd0M0PFNBySd//GaTQ+h6UBwaLrJDvM4A3Py6sCIw+/A4GGweX489Ijw8g2Z4h+vvMG9xKivNDgIhCCCCQqufaBoXi1DyIGPBF/88E8plZhk1NMjFODTZOxpqroPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008837; c=relaxed/simple;
	bh=9koIKek7qPhDHbcj/DeFDreV6Tr/KG7823SHacH9DrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrqf6oylXHPbdLhtESRGUOTzxzaKSMovdCYvaz0FJHcFRvLOR2qzMkhdPwMQ3UNGrDwFRNHvsLSlCyOUfWqWr/0skVc+xxOX7tzmvaxpJ3zCS9Wndm68dtK0aH2jzisQO3IQYaK6A4iKwwKPJLGgR74XU/eWmWAeiAYHaxwJsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so1117145a12.2;
        Mon, 10 Jun 2024 01:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008834; x=1718613634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYQOXrTi4xC9EJqXLJeGLPx4jx3qC+GA+AGgjQf+XgM=;
        b=RG0luP4JWDeifdo84tlIVpaLYMb6B5b7erwLXVrwaBvTBYK8WzTTgztoBej9Ztu1PD
         vTGBIRe9gKg698PLPuS/W7zc9AbRS9o7zQIaw6B0kh8Qu91IwsrejQ6TPc1JtDKA0YR9
         /Wpk1OBAlpsNyLXld+sZInMlAXYyqlZgcXrSP2GoLDGv9HWTYzgvno70xG/I3qByBT0J
         fR3Z1+ozPo5T27K/1aNc7f8vofIf3NmRf+b7JBhIHvCc7eIhnT8L+VDop5x/Pp8y07pq
         o5K/jgZxPwiEw/lEOaAr+eZv0ihJ8flEW0WdWhKl8/C206Cd1hv1wzR22yH7RxAq6ZVo
         refw==
X-Forwarded-Encrypted: i=1; AJvYcCUSGB028f5qhgavkxj3znSU2pwaPCBo+BUFyMYDIf4EpWeN0bZoxS8Ld2SBpqTmPdmDI7kzcKPA8RFPKNAtsVlUqRi27b/YxSqIe/HA
X-Gm-Message-State: AOJu0YzJU3MtJc2QMo7l+g2nvLHwNIg/iMK/ymZNmaGFU0Nhl3ZVqqMu
	SCbLazD3lveu1Bgfj7/8D/0o7i5dKLqCjRIvSiwZeVCimGrrXPAa
X-Google-Smtp-Source: AGHT+IEUssRf7aMIr7nHIHOQxBa4liSgGwzzqhTOMa9jN4/atsscpDFfJBN2AD426jikYbbe2pGgFA==
X-Received: by 2002:a50:f60d:0:b0:57a:1fef:619e with SMTP id 4fb4d7f45d1cf-57c508a12dfmr5204888a12.18.1718008834380;
        Mon, 10 Jun 2024 01:40:34 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c72efe054sm3259581a12.66.2024.06.10.01.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 01:40:34 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 10 Jun 2024 10:40:27 +0200
Subject: [PATCH 3/3] btrfs: split RAID stripes on deletion
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-b4-rst-updates-v1-3-179c1eec08f2@kernel.org>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
In-Reply-To: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 JohnnesThumshirn <johannes.thumshirn@wdc.com>, 
 Johnnes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3809; i=jth@kernel.org;
 h=from:subject:message-id; bh=xt1gqPtO3ScxjD8qUPejfcJ4eDxc3zKA784+waQ49mI=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaSl7f53OYHJt+TKzowdGx5+vhXkfvzEgdMPJ09aw/jw3
 CLzswxCbR2lLAxiXAyyYoosx0Nt90uYHmGfcui1GcwcViaQIQxcnAIwkUPxDP8dVf/+2Je3/97R
 9fvDFk33c5ycOPHLJrPKS/EbHXSnObm1MPwvKjpay326xq6T0Zn3yc97V27phqvfz0xsvHLk+H1
 lv098AA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: JohnnesThumshirn <johannes.thumshirn@wdc.com>

The current RAID stripe code assumes, that we will always remove a
whole stripe entry.

But ff we're only removing a part of a RAID stripe we're hitting the
ASSERT()ion checking for this condition.

Instead of assuming the complete deletion of a RAID stripe, split the
stripe if we need to.

Signed-off-by: Johnnes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 101 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 3020820dd6e2..41403217c3e6 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -33,42 +33,95 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	if (!path)
 		return -ENOMEM;
 
-	while (1) {
-		key.objectid = start;
-		key.type = BTRFS_RAID_STRIPE_KEY;
-		key.offset = length;
+again:
+	key.objectid = start;
+	key.type = BTRFS_RAID_STRIPE_KEY;
+	key.offset = length;
 
-		ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
-		if (ret < 0)
-			break;
-		if (ret > 0) {
-			ret = 0;
-			if (path->slots[0] == 0)
-				break;
-			path->slots[0]--;
-		}
+	ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = 0;
+		if (path->slots[0] == 0)
+			goto out;
+		path->slots[0]--;
+	}
+
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+	btrfs_item_key_to_cpu(leaf, &key, slot);
+	found_start = key.objectid;
+	found_end = found_start + key.offset;
+
+	/* That stripe ends before we start, we're done. */
+	if (found_end <= start)
+		goto out;
+
+	trace_btrfs_raid_extent_delete(fs_info, start, end,
+				       found_start, found_end);
+
+	if (found_start < start) {
+		u64 diff = start - found_start;
+		struct btrfs_key new_key;
+		int num_stripes;
+		struct btrfs_stripe_extent *stripe_extent;
+
+		new_key.objectid = start;
+		new_key.type = BTRFS_RAID_STRIPE_KEY;
+		new_key.offset = length - diff;
+
+		ret = btrfs_duplicate_item(trans, stripe_root, path,
+					   &new_key);
+		if (ret)
+			goto out;
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
-		btrfs_item_key_to_cpu(leaf, &key, slot);
-		found_start = key.objectid;
-		found_end = found_start + key.offset;
 
-		/* That stripe ends before we start, we're done. */
-		if (found_end <= start)
-			break;
+		num_stripes =
+			btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
+		stripe_extent =
+			btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
 
-		trace_btrfs_raid_extent_delete(fs_info, start, end,
-					       found_start, found_end);
+		for (int i = 0; i < num_stripes; i++) {
+			struct btrfs_raid_stride *raid_stride =
+				&stripe_extent->strides[i];
+			u64 physical =
+				btrfs_raid_stride_physical(leaf, raid_stride);
 
-		ASSERT(found_start >= start && found_end <= end);
-		ret = btrfs_del_item(trans, stripe_root, path);
+			btrfs_set_stack_raid_stride_physical(raid_stride,
+							     physical + diff);
+		}
+
+		btrfs_mark_buffer_dirty(trans, leaf);
+		btrfs_release_path(path);
+		goto again;
+	}
+
+	if (found_end > end) {
+		u64 diff = found_end - end;
+		struct btrfs_key new_key;
+
+		new_key.objectid = found_start;
+		new_key.type = BTRFS_RAID_STRIPE_KEY;
+		new_key.offset = length - diff;
+
+		ret = btrfs_duplicate_item(trans, stripe_root, path,
+					   &new_key);
 		if (ret)
-			break;
+			goto out;
 
+		btrfs_mark_buffer_dirty(trans, leaf);
 		btrfs_release_path(path);
+		goto again;
+
 	}
 
+	if (found_start == start && found_end == end)
+		ret = btrfs_del_item(trans, stripe_root, path);
+
+ out:
 	btrfs_free_path(path);
 	return ret;
 }

-- 
2.43.0



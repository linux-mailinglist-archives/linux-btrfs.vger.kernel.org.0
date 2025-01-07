Return-Path: <linux-btrfs+bounces-10767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E35A03FBC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF5B7A31A1
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9651F03CF;
	Tue,  7 Jan 2025 12:47:58 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3F1F0E52;
	Tue,  7 Jan 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254076; cv=none; b=EBPOZhlHJe7e9zyS1hwsxRypzLkY7mJpDShEqZYQxfaIp8pqKFpYmVSjEJ1ayONAoA/qN8X+fEcU4ULmk+So2wSYeuuJwkC8fYM2uGLvAapyKiew4qIOJgQw65SJ98ykWYB54R+DruNePlVIpYR63hIf75gIByrHWrY/QDdTep0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254076; c=relaxed/simple;
	bh=Ri/61TC1qvjbcGtqWjE7tlIVpIWdWIHK0k0XQdxDVGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLDjNxEJ3vSWIRmhjHJluaqPwWrA/zf2HIs5DXRrll2eWErWtHMRv6GCXJte3XC4li8h4k7aemD1M+53R+lFyKdcIzYkkgsXxhyNGr8cGzjSbCB3n++7fgAvlbCtcEmDZa74HwAHTnG++aTTx5nYIY8Q5iYmNFtGxm9R+Kl0s4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436a39e4891so55288875e9.1;
        Tue, 07 Jan 2025 04:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254073; x=1736858873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HMhazJ4aHrtYYO6dr59OnqHZ0soK8Yigb9JVzCFUHo=;
        b=hjeIFb0i9Hs15tfZ7uIjkZQpCBtV6jJK1ffrGnlYdhvE/dcMRFPpL9kCkBcmcqwmGf
         JeMj2EH4wswnTVp+9dyOAN+I/r6k9N6qSGPBBz9eAPT7hLptWE24GJ6T1mUvbufzWD0l
         iznF2yUYTUydp4Nu89/wJjMOts+Do03rhkaD7PpOx62Wqy2OBt8ROHPMUJ1h56dRCi0c
         izjuIYYcEEtgldF7RVmwgKDiEPESj6MZ6yQ5QozgJwBE1LD+ST6TyrChpBd05U26OYa2
         0ziQ50DZlKdMaQYGBv6F1sC2p1qZWR+pamqeZqm2W5eJ8rfV+x7eEONdESq4/A8JoRJj
         RCIA==
X-Forwarded-Encrypted: i=1; AJvYcCVxcSdsHcZpONB4uy5Q1rmpMLcBj1Y6hqZEYGOaw/2kdgtFNIgSKZoXQS1UxcDgnaBGt2RVejgGSsXkEPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4A6g7MKw+ua9ldATGn5o0wmYOze6/hENv/iLTNO0RLljE5O2h
	WPSkUDvayXJAk03qJDcNZxMz/HxlIfrbgmKITF/5xyaJwiz8JyJWq5yerw==
X-Gm-Gg: ASbGnctYzmcYvmr+SJSpVzcnFlwhBrX6CzmGtcgWad8pe87urBurTOvJl5xrrRF2U2S
	FIRSsOpG4JSk4si+OFMHFE4KJqgSgt/JdA8GvFWXKm6Jhw9f7FBfWV1gm2wq0tJrMtyE7e2EnwP
	mD5hzvoSIdKSC8kHIqZGAqg85WII4/zWZ5yPt2jccJGXa4RizD0IClOlJuFymR5NTNrXITaHA1E
	5AyHdh39wxNYrAeatAw9ZA+xSqqWFkHr7zRta9l4ocj5woRq0od5Pfzwm1Rd2LGKRyq8p0CpGx6
	1MFDve+5OgNOnZL7t1wojQxnQyxaHdVhU1lj
X-Google-Smtp-Source: AGHT+IGzWdzW9NRWzbdtYm7udxlFpnR2z7yKEn7GmU2WIQ6591jqL7Hc2I3gK4R++2PFtEZfs3IX0Q==
X-Received: by 2002:a05:600c:154c:b0:434:9f81:76d5 with SMTP id 5b1f17b1804b1-43668b49a47mr492588715e9.22.1736254073031;
        Tue, 07 Jan 2025 04:47:53 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:52 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:36 +0100
Subject: [PATCH v2 06/14] btrfs: fix deletion of a range spanning parts two
 RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-6-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=jth@kernel.org;
 h=from:subject:message-id; bh=pJGqsi9OfeqSzNQ9MPTfpV7JL3HzH6XVBbbaT6qHJ/4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhWe+73KVKhbpaT50G/Xsx0btuqc2Wt3zWTCZaepx
 S/abnRydJSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBExE8z/Pf8tlIuatMOFb9t
 OuvWbJtVfTRn++GOUyFyl+L9Sg5+LVdkZFhxTXvViez1q9/ortySFqURt9baTswzeJrzQ77PLPy
 T1ZkA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When a user requests the deletion of a range that spans multiple stripe
extents and btrfs_search_slot() returns us the second RAID stripe extent,
we need to pick the previous item and truncate it, if there's still a
range to delete left, move on to the next item.

The following diagram illustrates the operation:

 |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
        |--- keep  ---|--- drop ---|

While at it, comment the trivial case of a whole item delete as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 79f8f692aaa8f6df2c9482fbd7777c2812528f65..893d963951315abfc734e1ca232b3087b7889431 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -103,6 +103,31 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		found_end = found_start + key.offset;
 		ret = 0;
 
+		/*
+		 * The stripe extent starts before the range we want to delete,
+		 * but the range spans more than one stripe extent:
+		 *
+		 * |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
+		 *        |--- keep  ---|--- drop ---|
+		 *
+		 * This means we have to get the previous item, truncate its
+		 * length and then restart the search.
+		 */
+		if (found_start > start) {
+
+			ret = btrfs_previous_item(stripe_root, path, start,
+						  BTRFS_RAID_STRIPE_KEY);
+			if (ret < 0)
+				break;
+			ret = 0;
+
+			leaf = path->nodes[0];
+			slot = path->slots[0];
+			btrfs_item_key_to_cpu(leaf, &key, slot);
+			found_start = key.objectid;
+			found_end = found_start + key.offset;
+		}
+
 		if (key.type != BTRFS_RAID_STRIPE_KEY)
 			break;
 
@@ -156,6 +181,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 			break;
 		}
 
+		/*
+		 * Finally we can delete the whole item, no more special cases.
+		 */
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;

-- 
2.43.0



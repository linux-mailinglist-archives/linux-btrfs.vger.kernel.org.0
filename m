Return-Path: <linux-btrfs+bounces-5832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3891F90FE10
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 09:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBE01F2362D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E2548FD;
	Thu, 20 Jun 2024 07:55:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB443AD5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870112; cv=none; b=eUD6RDcF1kREopypm9Q6drwE5Jfcoavmjo1UCsvE2Eg4ITYaRAxGYRRbqvyDdPLdTYyRIiKzfvbsccvtB5+hiuptS1KB4jMp9O7tHkrJY1ekkh1t9ZdmsvZiQPejhyUMALS8V3YoYfmFxRVQp203GFKA3UVIah+PdeIUPCOTMNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870112; c=relaxed/simple;
	bh=tZBrkUc/vqrs0SO+nbyAWmBk9RybawwskVWFTNfvpOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOKIsGErAhkkcFR5d+IWzZTJhTqZdyFRHUuuioaCnO9In/I4U9H+4rS/P6UNYuVbmLQ9hUwblLyiVgiTpOEzBG8r7U50oIPECwNEVMR6M2DE31hqyhGMY8hyoCIUPQhzhatJN0JX4+GRSfG4XtBV8Y3WIBLLZe/Uhtj3ppaJzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so417842a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 00:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870108; x=1719474908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elmAi07NQZVRqEFdQYvwWbKsYTPBsw2x+SNJ+OioMtI=;
        b=pMcHBBEtmWNXULLp2oleEYd4rH7/nqMJwP4VszP02ASvvUvvx3VYt4oajZcccX9JB4
         iBD2sjQEc2QVyiDnhRbMfR6UO+Jh3G4N9f/rWgUn+aOw4g1348PkltQ6hwey64KNsb9T
         k5mrrkLRCAax992AWS+qCpFWDBRCVu6AXVuxJDHYFeNETLi/OtBIhe6WGW5sEmtFc8Fe
         wB8f/HK/Vpn+yKAtNSdjeYkJhdrDr/QVD6lGDPOL3hOkDu5o5pu6TDpT/FXydIo7T5e7
         H5biI1QlW86hghIL7mSLA099WJsHqciTRuBOr3+TVDymPLE3S8TDR579Ee1F5baQ2adw
         8TBA==
X-Gm-Message-State: AOJu0YyakOCOFZyIUWuWxFxevgVMFEuqAS0PBzvrlbdPGC05acQe4DfY
	M0EFNqq8jAndLoe/hdxH6RZPJuUzJTGgQvZ+mq0u9rHnZCHygtjR
X-Google-Smtp-Source: AGHT+IHJxCjMNKz3rcEV5nTLCWd64uANP85BYzt76zzDwsy5iEMyNq+fFOLxCOuxO9j8a7xsmK9TCA==
X-Received: by 2002:a50:c2c9:0:b0:57c:749f:f5ef with SMTP id 4fb4d7f45d1cf-57d07ed4f92mr2715925a12.34.1718870107330;
        Thu, 20 Jun 2024 00:55:07 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71f4100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:4100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d16160c18sm1151177a12.26.2024.06.20.00.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 00:55:06 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs-progs: remove raid stripe encoding
Date: Thu, 20 Jun 2024 09:54:55 +0200
Message-ID: <20240620075455.20074-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Remove the not needed encoding and reserved fields in struct
raid_stripe_extent.

This saves 8 bytes per stripe extent.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/accessors.h       |  3 ---
 kernel-shared/print-tree.c      | 33 +--------------------------------
 kernel-shared/uapi/btrfs_tree.h | 14 +-------------
 3 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index b17c675c1807..c2681698b3cc 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -322,11 +322,8 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
 
-BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
 BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
 BTRFS_SETGET_FUNCS(raid_stride_offset, struct btrfs_raid_stride, offset, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_encoding,
-			 struct btrfs_stripe_extent, encoding, 8);
 BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct btrfs_raid_stride, devid, 64);
 
 static inline struct btrfs_raid_stride *btrfs_raid_stride_nr(
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 6f78ec3512de..1692e6475865 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -669,42 +669,11 @@ static void print_free_space_header(struct extent_buffer *leaf, int slot)
 	       (unsigned long long)btrfs_free_space_bitmaps(leaf, header));
 }
 
-struct raid_encoding_map {
-	u8 encoding;
-	char name[16];
-};
-
-static const struct raid_encoding_map raid_map[] = {
-	{ BTRFS_STRIPE_DUP,	"DUP" },
-	{ BTRFS_STRIPE_RAID0,	"RAID0" },
-	{ BTRFS_STRIPE_RAID1,	"RAID1" },
-	{ BTRFS_STRIPE_RAID1C3,	"RAID1C3" },
-	{ BTRFS_STRIPE_RAID1C4, "RAID1C4" },
-	{ BTRFS_STRIPE_RAID5,	"RAID5" },
-	{ BTRFS_STRIPE_RAID6,	"RAID6" },
-	{ BTRFS_STRIPE_RAID10,	"RAID10" }
-};
-
-static const char *stripe_encoding_name(u8 encoding)
-{
-	for (int i = 0; i < ARRAY_SIZE(raid_map); i++) {
-		if (raid_map[i].encoding == encoding)
-			return raid_map[i].name;
-	}
-
-	return "UNKNOWN";
-}
-
 static void print_raid_stripe_key(struct extent_buffer *eb,
 				  u32 item_size, struct btrfs_stripe_extent *stripe)
 {
-	int num_stripes;
-	u8 encoding = btrfs_stripe_extent_encoding(eb, stripe);
-
-	num_stripes = (item_size - offsetof(struct btrfs_stripe_extent, strides)) /
-		      sizeof(struct btrfs_raid_stride);
+	int num_stripes = item_size / sizeof(struct btrfs_raid_stride);
 
-	printf("\t\t\tencoding: %s\n", stripe_encoding_name(encoding));
 	for (int i = 0; i < num_stripes; i++)
 		printf("\t\t\tstripe %d devid %llu physical %llu\n", i,
 		       (unsigned long long)btrfs_raid_stride_devid_nr(eb, stripe, i),
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index 271346258d1d..5720a03c939b 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -712,21 +712,9 @@ struct btrfs_raid_stride {
 	__le64 offset;
 } __attribute__ ((__packed__));
 
-/* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types */
-#define BTRFS_STRIPE_RAID0	1
-#define BTRFS_STRIPE_RAID1	2
-#define BTRFS_STRIPE_DUP	3
-#define BTRFS_STRIPE_RAID10	4
-#define BTRFS_STRIPE_RAID5	5
-#define BTRFS_STRIPE_RAID6	6
-#define BTRFS_STRIPE_RAID1C3	7
-#define BTRFS_STRIPE_RAID1C4	8
-
 struct btrfs_stripe_extent {
-	u8 encoding;
-	u8 reserved[7];
 	/* Array of raid strides this stripe is comprised of. */
-	struct btrfs_raid_stride strides;
+	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);
 } __attribute__ ((__packed__));
 
 #define BTRFS_FREE_SPACE_EXTENT	1
-- 
2.43.0



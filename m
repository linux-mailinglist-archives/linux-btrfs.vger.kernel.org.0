Return-Path: <linux-btrfs+bounces-12115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A0DA58167
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Mar 2025 08:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A32188F0A9
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Mar 2025 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A075118A959;
	Sun,  9 Mar 2025 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7sCJcQ0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5029A2
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Mar 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741507146; cv=none; b=NPnNtgdEE0Pu0mzEbXt276vimpKNAOsp4Gf92a6s2q1otYvm+LLOenHbSXMi9WIrOaS8HV8C5xBCdRxu63DEqRclR534TNHnvN8Ost26TS9xONo/wa8cMPDp5uGT39pHrQuuKRumC6XqQTp5uTTm+Z1A6uebZ/hLTUp3mXx8fas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741507146; c=relaxed/simple;
	bh=Ai9MBwncVws7vac+CkVcTPqd4Amuvk5luK3+TQ6zBdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP79Du2MeEaQw6JKt0V641KlCd9sr7zMewC0hzeX6Cy3Hyr4mn9VhH9Ac0SJYzHqe5+lgn1+LE+5bCaGWG7wl3Gxq+3DYd5PAyxG0oM77AnbwhCADGcT3Wb1mKs1e1ixgB4xl4P5SlGwc7PeuZBwGQaTbLRDp3sRD9mP3AREZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7sCJcQ0; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so782202a91.0
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Mar 2025 23:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741507143; x=1742111943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QyIoWgqVWzCts78lhYX44xA14AvJmrWTvLWgeS5+bs=;
        b=d7sCJcQ0SdgjbkPd2MPfjxJdpINjr8ngji9K/QQghQwpOmbIz5iATa/QcRWSkgEYqJ
         Vwk+eDeCyZCK7+pZ3eoJDrSnuElY4cGPI2BD0+cLml5xaTq+E26//ydymQqD8Pp5Gt7H
         aWKI0D8EtuObHAjCGcQH3bjUoxKKuvnp7D/0GhWNAOyRROpU1Vv+Lbw+zuqRxMEfbsNF
         ukDtrXa/9zGSPhmI4UWxBaDaavUcbi0cAF7BrvsNR+s9B06bpzt6BQDHgF0Afd0otvN6
         XFExKn4gxvMa9awM0mlOQa5W4Vn/HuDjImOLrm92JH6wMj4jYTRmYM+6gR3ajDDkcjo+
         sz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741507143; x=1742111943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QyIoWgqVWzCts78lhYX44xA14AvJmrWTvLWgeS5+bs=;
        b=pg8NsrVVitCyxWghbClhh2/z85hQoakhTcksZ7ixOZJVtmr2U8+36UM82ax8zUhRa+
         MEUG1tc+QCmBISOFIQw9lOwbb6lkONilsYc9KHtm3V/ZWrOq1646KKfglK+BrJbj95Eg
         QQtqOPretHYpIrBus5l8zdzDeAEGV2cyT1G32NZsLKQHC9PnXHqd156kgUQoS/ddTSnF
         lwy7OcE93dj3hPTpwm1WGaoDjqhEf2xSyyEmcIxgnJ8Y//DztWqXudJnWm2rnvXTcnR4
         eCquciPGBUkYQh2kC3OXzKoo5DTaDdacfcdXxb7ZGcl2BqmZc9vOsHRzcj0t5u2eFz0p
         HMjQ==
X-Gm-Message-State: AOJu0YzBJ27Gf4chCGLJY5xrlHmc9wAYMMYwvdB3xYw+rHfOlpJlHUaA
	gtHbPiiDuJgZcSWwLFozBz48/fBJXnH/WOS6HXNQVdjnX86gZDGETMuHuIsgcSy9IA==
X-Gm-Gg: ASbGncvB62f7HXikmWLyJhy42smcX6rqls1p4rAzLW/rDdwftBCGuUff1Tld831LyKf
	AbcPPaPNPAR5hMeELu0h7EV7QxavTtbQKDcwwKFxtDnDENVmsmAYbbDu+qjO9ZJQAmfTbQlqDlr
	FFTLznc0FTbJT08srmh7iPKkdTcO86SyhzHefMAZQr3kn4zte7hbqjQqOyOFeLfKksrXBJS5l6c
	NJPZFJC+w26alqVoKv9CmSebu15eOQxiBU4GjdjWCGF0pqKqqbEBHgQ/88rjsl/Rj619k2QHRbL
	wi0fXB3oT6nMwPU8zEdlsQFMwyI6Z2vB+DZQuBDQIIVqww==
X-Google-Smtp-Source: AGHT+IHuAzP+lu19+xMYmwgwGsJBMIh4za+kOa0jN13LIKjpzgZFSMAH/VonOHHi7psOxffTBilwmQ==
X-Received: by 2002:a17:902:f543:b0:224:c46:d164 with SMTP id d9443c01a7336-22541eaa6cdmr28492645ad.2.1741507143547;
        Sat, 08 Mar 2025 23:59:03 -0800 (PST)
Received: from SaltyKitkat.. ([2403:18c0:5:3e0:98c6:7dff:fe56:ac2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd627sm57045605ad.50.2025.03.08.23.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 23:59:03 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/3] btrfs: remove unnecessary 'found_key' local variable in btrfs_search_forward()
Date: Sun,  9 Mar 2025 15:58:00 +0800
Message-ID: <20250309075820.30999-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309075820.30999-1-sunk67188@gmail.com>
References: <20250309075820.30999-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'found_key' variable was only used to temporarily store a key value
before copying it to 'min_key' at the end of the function when returning
success (ret=0).

This commit optimizes the code by:
1. Eliminating the intermediate 'found_key' variable
2. Directly populating 'min_key' at the exact loop exit points where
   ret=0 is set
3. Removing the final memcpy operation in the return path

This change improves code clarity by:
- Removing redundant variable usage
- Simplifying the success path logic
- Reducing memory operations

The found key value is now stored directly into the destination 'min_key'
structure at the point of discovery, maintaining identical functionality
while:
- Eliminating an unnecessary memory copy
- Reducing code complexity

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3dc5a35dd19b..1dc59dc3b708 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4608,7 +4608,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			 u64 min_trans)
 {
 	struct extent_buffer *cur;
-	struct btrfs_key found_key;
 	int slot;
 	int sret;
 	u32 nritems;
@@ -4644,7 +4643,8 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto find_next_key;
 			ret = 0;
 			path->slots[level] = slot;
-			btrfs_item_key_to_cpu(cur, &found_key, slot);
+			/* save our key for returning back */
+			btrfs_item_key_to_cpu(cur, min_key, slot);
 			goto out;
 		}
 		if (sret && slot > 0)
@@ -4679,11 +4679,11 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto out;
 			}
 		}
-		/* save our key for returning back */
-		btrfs_node_key_to_cpu(cur, &found_key, slot);
 		path->slots[level] = slot;
 		if (level == path->lowest_level) {
 			ret = 0;
+			/* save our key for returning back */
+			btrfs_node_key_to_cpu(cur, min_key, slot);
 			goto out;
 		}
 		cur = btrfs_read_node_slot(cur, slot);
@@ -4702,7 +4702,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	path->keep_locks = keep_locks;
 	if (ret == 0) {
 		btrfs_unlock_up_safe(path, path->lowest_level + 1);
-		memcpy(min_key, &found_key, sizeof(found_key));
 	}
 	return ret;
 }
-- 
2.48.1



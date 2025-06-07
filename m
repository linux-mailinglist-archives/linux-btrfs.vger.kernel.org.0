Return-Path: <linux-btrfs+bounces-14540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A152AD0D0B
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CF718932F1
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jun 2025 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE118215F72;
	Sat,  7 Jun 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy3PAqZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE272AD22
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Jun 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749294972; cv=none; b=Cq88GQ49EACeyk4nUvDTCQY01wr5wOyDVdYSXufsHG6fCyWZ89BVTavyIKBpzcoR04ctpwd2Xu9BmdiUpi4l7bHRiFlDKeO2R4LvYmbvGQllhr6y6po+2R6/JWk7PFGgO3gOHPJ6P/gdzLHoQ3c74nEjQJi42zJupYKSMagUR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749294972; c=relaxed/simple;
	bh=ayVWcoag3WnJ8FTbVZls2B2BI09Ef15gTvtDCof/FGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyQPnR3ToxS6kSDZUJQACeiUGDRm/9824VTSZs9p8v+VXkQM/E2owxmy6BrFayyrIF65RK2VULlpYeapTnRE4PjXrOHDbNv1pWSRRNqJRUOe2+ldClPmEiOfiCEFqA9HsvTB/VK1h3re80eBOBtKyJ6IWcluJsjMSbJ6ZygAAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy3PAqZA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b9dfb842so27440545ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Jun 2025 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749294970; x=1749899770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFtn0Grzkeo53vOPXKtSCwhFZzfIPZaxqqtzSCxu904=;
        b=cy3PAqZAXZeP8KQX4NGAWTE8tsYOmKznrRINqLtL/dLdsfcEgBZMcoikF4pqerRA+9
         y5bvgDBukzu1PReC6DdJ8ISUs/2Xf5GtozYJ1wNOGOY988W86p7FtiMZF0uN4wiIRMc0
         Ptj+uUDJm8CriCIgC1jjvFTeo1YmBJT3tpL7Mxjhx+jwAUGHDY1j1A8h6cSE/oQ/y6yo
         RxdSn6ESHS/fms6Szz4R64w8ymVKTz7AlUpfnG/M7dO0DiVmVsEo5i2ABRAmP8t6KN8n
         UxruXHUM1okmj6eFh42DJAcZ/sX1NJaZ5UNJb3bSVQu5c2dQN5IXb2SdEcSZHJoq5JZy
         KiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749294970; x=1749899770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFtn0Grzkeo53vOPXKtSCwhFZzfIPZaxqqtzSCxu904=;
        b=MLqOH3QH+zSwYIjBuo5y8vhbIx5AP3YBzq3A2Sk+S8pQ8VjFtfHyeeCxF8Fnyjam0P
         j5lTHNTJXxMwuIoC7tNcVSiuJiZEw77oyzqIhzAC0D2wuPkO2k3/j8yEp4dtiFQbd9DN
         uEPfU6PuioMnNSljc0EscRi75DAJFfzWcFWEtg9TSHRtmjqRnBb94yLaY6hg0CrKrrfZ
         R5/8Pn39LB5CHZV8Yy7BBgQgLs1FXE4qIbc5MuZBifwCco4Wh4FXfZmEeIVXrKKLmOjc
         iN/nOt764hqvHmxuMa9CtaL8H0nmtf3HbPi0vrlcBO1v+5Qaf3PpfsCENss2AsR00lLv
         PZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX8o+qk66DaQ0U1XQi9S4TS69gjwPXypFckVg+N3pqW6klDN/fa8DROu8E0BFS2xSguZWx/v6EkIZPtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+o6fsqILqYyreDwqmSDeTGgQWV8ErkAiR90RWLiQdPAQi9xp
	A/yDz2JjDtm02ic7KSwdPlSPS3h4nRR+vIofRDMu1BstjEP7hbLBlwkD
X-Gm-Gg: ASbGncseWM4dSDgQFxqX/0mFHnh/7++CSF8a+oYJ2S4MdSbZc3b8UhyXBFD+5RaF+fB
	o7CPUlY9wo9A50XFSNr0vheO0eCgUEe7kv5ghLG7sW99t/RIPaP/OqPCFxOqhn7K1RmYcDBPZZA
	EwY/S30pCZCMYbW+58+wjAmcjQU0Z9aPi/7p06aRI1Y94PqfPJ+wv+7wU1T7wv0L0vIUzgErRNy
	Ao6skQ2TCRwvqPOw9fD76zsQODksuWgxxubn9uFEbfnW1BdKzQTIT+j9RK4UAlCzJYGFKt/QPgP
	+sJsQLwoedrjwHTuzwOW1Ya9UzJW45aaI8KJxpergUb3P1IUoFHQfAbVuTdWPtpiSkKEyToI3yS
	MPNES26b7pO9VaNDQR9sq
X-Google-Smtp-Source: AGHT+IGj8Y3beDLd8B89DysVAkGjhZrYakTl1t52JJY2q29jh/DimMB4x4ykJmLhFqAoyZ5S0EEWaQ==
X-Received: by 2002:a17:902:f54b:b0:234:f182:a735 with SMTP id d9443c01a7336-23601dc5075mr94478975ad.34.1749294970046;
        Sat, 07 Jun 2025 04:16:10 -0700 (PDT)
Received: from avinash-INBOOK-Y2-PLUS.. ([152.59.197.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360340664esm25316985ad.182.2025.06.07.04.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:16:09 -0700 (PDT)
From: avinashlalotra <abinashlalotra@gmail.com>
X-Google-Original-From: avinashlalotra <abinashsinghlalotra@gmail.com>
To: 
Cc: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	avinashlalotra <abinashsinghlalotra@gmail.com>
Subject: [PATCH] btrfs: remove ASSERT in populate_free_space_tree for empty extent tree btrfs_search_slot_for_read() returns 1 when no items are found
Date: Sat,  7 Jun 2025 16:45:11 +0530
Message-ID: <20250607111531.28065-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 but populate_free_space_tree() has ASSERT(ret == 0) which panics on empty
 extent trees. Empty extent trees are valid (new block groups, after
 deletions) so remove the assert and handle ret == 1 by skipping the scan
 loop.

Reported-by: syzbot+36fae25c35159a763a2a@syzkaller.appspotmail.com
Signed-off-by: avinashlalotra <abinashsinghlalotra@gmail.com>
---
 fs/btrfs/free-space-tree.c | 62 ++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 0c573d46639a..beffe52dfa59 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1115,43 +1115,45 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
 	if (ret < 0)
 		goto out_locked;
-	ASSERT(ret == 0);
 
 	start = block_group->start;
 	end = block_group->start + block_group->length;
-	while (1) {
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-
-		if (key.type == BTRFS_EXTENT_ITEM_KEY ||
-		    key.type == BTRFS_METADATA_ITEM_KEY) {
-			if (key.objectid >= end)
-				break;
 
-			if (start < key.objectid) {
-				ret = __add_to_free_space_tree(trans,
-							       block_group,
-							       path2, start,
-							       key.objectid -
-							       start);
-				if (ret)
-					goto out_locked;
+	if (ret == 0) {
+		while (1) {
+			btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+
+			if (key.type == BTRFS_EXTENT_ITEM_KEY ||
+			    key.type == BTRFS_METADATA_ITEM_KEY) {
+				if (key.objectid >= end)
+					break;
+
+				if (start < key.objectid) {
+					ret = __add_to_free_space_tree(trans,
+								       block_group,
+								       path2, start,
+								       key.objectid -
+								       start);
+					if (ret)
+						goto out_locked;
+				}
+				start = key.objectid;
+				if (key.type == BTRFS_METADATA_ITEM_KEY)
+					start += trans->fs_info->nodesize;
+				else
+					start += key.offset;
+			} else if (key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
+				if (key.objectid != block_group->start)
+					break;
 			}
-			start = key.objectid;
-			if (key.type == BTRFS_METADATA_ITEM_KEY)
-				start += trans->fs_info->nodesize;
-			else
-				start += key.offset;
-		} else if (key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			if (key.objectid != block_group->start)
+
+			ret = btrfs_next_item(extent_root, path);
+			if (ret < 0)
+				goto out_locked;
+			if (ret)
 				break;
 		}
-
-		ret = btrfs_next_item(extent_root, path);
-		if (ret < 0)
-			goto out_locked;
-		if (ret)
-			break;
-	}
+	}	
 	if (start < end) {
 		ret = __add_to_free_space_tree(trans, block_group, path2,
 					       start, end - start);
-- 
2.43.0



Return-Path: <linux-btrfs+bounces-10331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A29EFD7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 21:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FA5167811
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4B1AF0B4;
	Thu, 12 Dec 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5Paaeyi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2F1422D4
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035490; cv=none; b=ZWV/CLCYM+YQdiJ12qHK4B25Kt9LH28YDSkJJzQ6L9+Kl3NigHDqzplwiLCLVqaerm0DeqXonT89ZxXPHog5ZYLRtkKBDakFN++F2rBAleJlORVcyfK8HiB2IJBlSNS4s+X6iMcL4YA/dSUNrFj2abUx3aqqUHQoYmbluMuOPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035490; c=relaxed/simple;
	bh=m70gGDD9rv7gX4sEOszgR2G4jyWwJ3V+WEHM5UpVgQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaOoUoaoustO8y0tr6JceV9vN/SVuKw50RaDxBwCHG27jVYPoF0UI3jT3slj6smU0pKcdVHtQgbt+HguZQVoZ1sXHxn6se1vxT5h4Z6HEEVbFcZYnkt1lQXooHn+mw4YXe+0P/zrEV/tG6yACS5O20IrKz8/74OhORQRtSmezhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5Paaeyi; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844d53c62b1so81832539f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 12:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035485; x=1734640285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pKpgct01RWYCYkwHKO61wqMtLnVKqyX6S0glBH4EZY=;
        b=M5PaaeyiK050Gmk/fDyl9+JdqSARrxUIyxaHFfIpQEPTiZhvqnoSHkp8h7FWuegWyc
         59JyItarob0DIgO586bLfzc5GzQgHyO3WGhztjzkiNeern25JvTDMY8AfEH1J31/cyde
         AG6I2tDO4lJkpQD/frvWJXquB3Yk6ZfQVoByGMpITb7ZkK0tyqXbcbaDW3vNsRjrsP3e
         UHeh/X+sL/g2NPRYMY7BqOLeXvWm+QG5Ddw4nPSM2pndsQCMkDKa32dbIWAn0+mCmwSY
         BkNYQN66HiVoXImUrtgJeDipQO/nfVLihyvwqM99k0iVDuZwTVzx522CciATDVQQEJL7
         s2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035485; x=1734640285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pKpgct01RWYCYkwHKO61wqMtLnVKqyX6S0glBH4EZY=;
        b=eEbiqKw+7u4D0CgWNf5k97nOb2JXH31EptH8iYO1JgclR7srRDgFV6yJl8SzpfGecb
         Z60AaYxQwJR1p8DtQyEDPFLUp8MmG23HGTOYZ7A68nA6Qa0fXIppFMj5wx2DDcfgFw6t
         JQJ1EEa5zPLPI6zf1SmnUHODNSePnNUCyBkXFaBvo9fmC6GS/jlffH4aXmar6N4JAXQy
         5btBrWshDXMHNl5i7lKUNjJK/qPV4xLKgtE7CtU43GXQyWe99NXiR92hYHuedufrQuPE
         mx9RhbVJztEqEjoIE3adaKRp7TrpolmLNOg/tJUYmdyKoZ+nosWEFPpFKQ5fAF5LMtXb
         wR8A==
X-Gm-Message-State: AOJu0YySm+b7KghnRjAyU/vg58cJ/q8PnMpgX0bMJtheCOTs9z6UUZ7L
	9uake/fBPteeWn+gpzhkZOQQryuLSRpp5HgvZWbWnntb2neSwwbz01y8D1T2FCg=
X-Gm-Gg: ASbGncsCjqeg12XZ2MvypcK6QxQntYpjMD9RUSN/2vj3dXbm7xPSwRyk3lANlkaG1Jg
	TLR1VQZTNjXaA7ITnoKOARu/gxgRx8eUFBoLMJpelwe+STrN28EKL2WD0ZRB0EdJCIowrnK3R/H
	iUR3uGnbaI4dGLuC4sPo33J7W6nmS6rL2s+gqf/HiDSHTMYNOQh57wDTWOsSKbj1nd6pW1jPJ9P
	YIwtElVlPcmBopHU3QAN+DUhNACcdECNUsUr+STYf9RwiRUrxTG/UyHo4KOlts6VQ==
X-Google-Smtp-Source: AGHT+IGPrPw9YZGYv+VDh/iEPd7te97Ne9LmCJa0x9Q8Pp1Fhoa1fgab5njTQkfj3vhSEtOHtdqIDA==
X-Received: by 2002:a05:6602:14cb:b0:83a:c296:f5b0 with SMTP id ca18e2360f4ac-844e885f35cmr26570939f.9.1734035485009;
        Thu, 12 Dec 2024 12:31:25 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844e29b6103sm28642939f.29.2024.12.12.12.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:31:23 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: beckerlee3@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: update btrfs_add_chunk_map() to use rb helpers
Date: Thu, 12 Dec 2024 14:29:43 -0600
Message-ID: <121af810c0bb755a83cad52f3500ebf552c6a02c.1734033142.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734033142.git.beckerlee3@gmail.com>
References: <cover.1734033142.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update btrfs_add_chunk_map() to use rb_find_add_cached(). add
btrfs_chunk_map_cmp to use with rb_find_add_cached().

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/volumes.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..b39723a95f26 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5513,33 +5513,30 @@ void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_ma
 	btrfs_free_chunk_map(map);
 }
 
+static int btrfs_chunk_map_cmp(struct rb_node *rb_node, const struct rb_node *exist_node)
+{
+	struct btrfs_chunk_map *map = rb_entry(rb_node, struct btrfs_chunk_map, rb_node);
+	const struct btrfs_chunk_map *exist = rb_entry(exist_node, struct btrfs_chunk_map, rb_node);
+
+	if (map->start == exist->start)
+		return 0;
+	if (map->start < exist->start)
+		return -1;
+	return 1;
+}
+
 EXPORT_FOR_TESTS
 int btrfs_add_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map)
 {
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	write_lock(&fs_info->mapping_tree_lock);
-	p = &fs_info->mapping_tree.rb_root.rb_node;
-	while (*p) {
-		struct btrfs_chunk_map *entry;
-
-		parent = *p;
-		entry = rb_entry(parent, struct btrfs_chunk_map, rb_node);
-
-		if (map->start < entry->start) {
-			p = &(*p)->rb_left;
-		} else if (map->start > entry->start) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			write_unlock(&fs_info->mapping_tree_lock);
-			return -EEXIST;
-		}
+	exist = rb_find_add_cached(&map->rb_node, &fs_info->mapping_tree, btrfs_chunk_map_cmp);
+
+	if (exist != NULL) {
+		write_unlock(&fs_info->mapping_tree_lock);
+		return -EEXIST;
 	}
-	rb_link_node(&map->rb_node, parent, p);
-	rb_insert_color_cached(&map->rb_node, &fs_info->mapping_tree, leftmost);
 	chunk_map_device_set_bits(map, CHUNK_ALLOCATED);
 	chunk_map_device_clear_bits(map, CHUNK_TRIMMED);
 	write_unlock(&fs_info->mapping_tree_lock);
-- 
2.45.2



Return-Path: <linux-btrfs+bounces-10385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760789F249D
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C693164F37
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050C11922F8;
	Sun, 15 Dec 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/sF0eop"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93821917F0
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276457; cv=none; b=jD8aY5pUp9T1Xy2HSM5zuztzLDsEvUwYE8hj7TW2OjsHEGCVw769Lkyf4uzQioJHAwjeZhLyLi2paC2IRZkhoWFjxdNKDzEjXCaw//75vpqapOHwrARw/caPzaxpY0rTyb94ImELQL5DmwFLTOmwy7q6R272XciK5C40ZM2nHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276457; c=relaxed/simple;
	bh=YwO42G2oq+KUZyS468HRqz6bQgTi4n+qu7siRhposnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vg8ZSkZjZQ5Mlrta5iKW3CmNkRXXvV4e6Am+vwKeRG2j7rI/ftn4zUmSe6kzvY9thu8rf/trjVP1uPvKxO97VAYMFNqski9uk0/px/uvTIh8Ix0WvzbyD7Xon/r5zwY6UcIh++6RMDot7edAGw8phnCBFFrD94x1OqXEpBtIv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/sF0eop; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e9b7e50dso208118639f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 07:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734276454; x=1734881254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlzuCIv0NjdXnzAT2fw9ny9uemDQRQ/7ztmhsOYboYQ=;
        b=Q/sF0eopfqpFmqXa0nf2kQCI2oXEx7vGbUSjnufv6foOIWCg3ouC1hMkIULmMoygmQ
         1cSXt4tS2/P+YTFf+Kk7pNKc/0WgHjt6HdM1wY0/FcfGyrctPICvL/CJ14pxiHOXm+tP
         pzkPhzthkk6NmyOsAcgwFvsyn3o4yTYSoOP/xQicAWolCpi6RcgVsBhvAGZBD6jeTJQT
         W9ng0ig2Kx/Iy5qx9ZmPzl3e7Qi5zJ+FY5G4ZWCCtt92VUHxA/wdnib6TSJj3Vxsk7jL
         hBr/fqTx1uguEj8MDpaGC9YC5rgym04BNQ4vmARl1UfzdklmCw2m/2uMPPKwMDaFZNPf
         az7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734276454; x=1734881254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlzuCIv0NjdXnzAT2fw9ny9uemDQRQ/7ztmhsOYboYQ=;
        b=FWetwbkgkQEY7jtN60021QPm0GvITEFy+9ExFnnVBIefISwxmNQz2J5gh4L1VJMGMw
         Jw/6BR7CnkgGSnOkpjL5ciAAhjQvU9aFvt8hcRPh0EpftvEhAWcXvgP+ja3q+PjP1aO6
         PuhPsdML/9OOKrSVSaKj5Wmj1FL9+5SJaUL8+l4JcduokfkaIP3JeimyxyBA0mnejkbd
         y+lU6aNDYX6vrX/jNqZGETMLT0r9jQkyb4U2baZN/2j//CDF5YyD/u4tiSbU3mJOPEQ+
         qednse2/Hha214E7hUUow8R1YnaW1ISUesFiA52iagkeuLjLUE8ZvNYUarbZzc+1WN/P
         I+SQ==
X-Gm-Message-State: AOJu0YyCIULtweFbOOI0PvcKfqLWEkciF0pWnJHuglAAsHE9Y3GvYe/A
	/aqcSnaid3jYXbtVeloUMYJx7KXVqe9Gx9nMm+WbTl0TEu5a9IGUF0mETw==
X-Gm-Gg: ASbGncuB9XicrUcs7gqJe/93xrNWBTXdNWbBMJivYNJCdWUJvv5qZW5jv854lJakd7U
	vrKxnm+ilEMj/zG/Z4ODo5WSRxCNoZJoeJUAfRXH3kPYZuTQRdYll7Pg+GjOMv/hqdI4BgH74b8
	5Qsx0cp6Qvtl9D9G/Rp8jT+d13yuBfSc8s603jqPqZkof7rqXG55vrS4cvb6TvDeYq/8afhAQtB
	aiphMB+SC3wS3KUhjt+EA3NaPPiCMTbDglQnV2lBYRQX+F4VHIyjRJ7EEbQiJOXiQ==
X-Google-Smtp-Source: AGHT+IHCB6M26kAy+J6h1uaP58KItg3OKpHof+pKoGQ1b859Lq4dL8eueRDSuVyMiwcVRqVbPz9bCg==
X-Received: by 2002:a05:6e02:1a8b:b0:3a7:44d9:c7dd with SMTP id e9e14a558f8ab-3aff50b2ff0mr126014955ab.6.1734276454506;
        Sun, 15 Dec 2024 07:27:34 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e37817e7sm773846173.114.2024.12.15.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 07:27:33 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 2/6] btrfs: update btrfs_add_block_group_cache() to use rb helper
Date: Sun, 15 Dec 2024 09:26:25 -0600
Message-ID: <e5a958037e7f03b124b66f392d20343482b65e61.1734108739.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734108739.git.beckerlee3@gmail.com>
References: <cover.1734108739.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update fs/btrfs/block-group.c to use rb_find_add_cached(),
also implements btrfs_bg_start_cmp() for use with
rb_find_add_cached().

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/block-group.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5be029734cfa..a8d51023f7a4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -173,40 +173,35 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 	}
 }
 
+static int btrfs_bg_start_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	struct btrfs_block_group *cmp1 = rb_entry(new, struct btrfs_block_group, cache_node);
+	const struct btrfs_block_group *cmp2 = rb_entry(exist, struct btrfs_block_group, cache_node);
+
+	if (cmp1->start < cmp2->start)
+		return -1;
+	if (cmp1->start > cmp2->start)
+		return 1;
+	return 0;
+}
+
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
 static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 				       struct btrfs_block_group *block_group)
 {
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct btrfs_block_group *cache;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	ASSERT(block_group->length != 0);
 
 	write_lock(&info->block_group_cache_lock);
-	p = &info->block_group_cache_tree.rb_root.rb_node;
-
-	while (*p) {
-		parent = *p;
-		cache = rb_entry(parent, struct btrfs_block_group, cache_node);
-		if (block_group->start < cache->start) {
-			p = &(*p)->rb_left;
-		} else if (block_group->start > cache->start) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			write_unlock(&info->block_group_cache_lock);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&block_group->cache_node, parent, p);
-	rb_insert_color_cached(&block_group->cache_node,
-			       &info->block_group_cache_tree, leftmost);
 
+	exist = rb_find_add_cached(&block_group->cache_node,
+			&info->block_group_cache_tree, btrfs_bg_start_cmp);
+	if (exist)
+		write_unlock(&info->block_group_cache_lock);
+		return -EEXIST;
 	write_unlock(&info->block_group_cache_lock);
 
 	return 0;
-- 
2.45.2



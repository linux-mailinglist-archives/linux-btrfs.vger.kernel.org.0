Return-Path: <linux-btrfs+bounces-8506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17898F2FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B171F22C83
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DBD1AAE1C;
	Thu,  3 Oct 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Kc844qN3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1919C54F
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970211; cv=none; b=YGV7dzsC2MDfvCowAlIxpr7FHtMdogFaUk0IBWcka+mr9C4f/ID8mGPl4d6xNHDnmKVlpiULjWtfxJLn3PXNFap+SlLNXhMy4Ggte5l2NjElyrP5NT9AyKpaFlu3/U8uZfjOSQebgUB9Nv4qqo7oBcvmSxCI8FHUxXgYFKQCLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970211; c=relaxed/simple;
	bh=I59iBGAsHrSKibdMRzIn8wAX874FGgPIa9VBmNHUJWg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOrb7E1n0v/RR7HPHavWMPij18CfX0HNzn9Oyk7VOExrUQGY3iq+UTei62IIQLcxyVkEZ6/JH+ZVIJZbPiHi57ArfDiJMNKShyMslyfA8Qjmop/BMuw6j7NI/UBgcxIJDbJT2kYghzaoOqcHut0k0jAtWHACPueYp7cXu/QgHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Kc844qN3; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e5568f1baaso565881eaf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970209; x=1728575009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASkxMtmiEpJxg83Wz3eOxS/S1cbVACE0l9mdDOdbESk=;
        b=Kc844qN3BYhgbwW23p8qQiTndUc+oGBwP3VNnUB6+c9btJXEsZmW2ywni/DCmnIhq+
         8fSGQo6FW1Naf5SjOZfZ146UN/68W1oPwTFHCnDMmy4LB2a57/8bAyueGvQmurJDrowW
         dhUCWhpz8/HhVtvwslWYq7QzCnWRFTcj4LxRKwaJDZcWsJLWLgBNYRC+tq1hrqbmNCQ7
         T7yqDBhiXtGJAImC82EKoot+/iqnti6yaeek1WrsNPRTlbKfJddS+HhTGso4Jj74mW2T
         BsIP/zRiszBwyO2vflWy+0+4SoPipZRsnrKzGSMaO8iMC0Tn08ZOW/HwKAF9iPauS+5o
         CqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970209; x=1728575009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASkxMtmiEpJxg83Wz3eOxS/S1cbVACE0l9mdDOdbESk=;
        b=ZU8N5Uq8hiz3PLh1yPPaZiVhCDNCML9wEd+1sfPwizONEvuexaWZGaElUmNPw+3tx/
         RUHdb8dpMbqyhqeaDSFwKCruySIG3OvnlXqdT3Bt2nibW+kedjyIsdAIavApV5CGs4RF
         myDE2AemLP6cKz1gnAV/FZxsyCYoSXzhwzsFtPSBwDJMKOp0eGaBLsGmcyN4hHo7Rz1h
         LY1miZj6nvoAfBst3hKXczxn8tWsJ+RVwuQjapqoYyy4CI+KdmRNtCU6bR/Poj7PFs9c
         aumzC3GkHoTQwoeG6OYJd2+jonePLGcT/OJpVwA3qFP4OOsLyVxUv6e/XthBx+rpiPES
         OPtA==
X-Gm-Message-State: AOJu0YyS0QY0HL9HJ3JGZzGB9CZ/oQCtexQC5g2D5ZPcDlOPbm5i8I4y
	i46hD7gWV1HcKtP1rg6fc3yb35UYZNSpjCR4oV/sUTap8/lunCcU/IrfsnPMGFvbJlegqewcreo
	J
X-Google-Smtp-Source: AGHT+IFRBusUy4M/8ZtJ0mwQPEKGYiozagmtAPJFEQ7kBZQLXLhc+/Ma/nU2O6WsaCszXRDus2hA+w==
X-Received: by 2002:a05:6359:5f8c:b0:1b1:a666:2bba with SMTP id e5c5f4694b2df-1c0cee929edmr543286055d.24.1727970208921;
        Thu, 03 Oct 2024 08:43:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3d3d19sm59580985a.84.2024.10.03.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 07/10] btrfs: do not handle non-shareable roots in backref cache
Date: Thu,  3 Oct 2024 11:43:09 -0400
Message-ID: <da131cc45c57e37862d7adc60b05afd22bdc9692.1727970063.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we handle relocation for non-shareable roots without using the
backref cache, remove the ->cowonly field from the backref nodes and
update the handling to throw an ASSERT()/error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c    | 62 ++++++++++++++++++++++++-------------------
 fs/btrfs/backref.h    |  2 --
 fs/btrfs/relocation.c |  2 +-
 3 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 881bb5600b55..9c011ccd7209 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3313,8 +3313,16 @@ static int handle_indirect_tree_backref(struct btrfs_trans_handle *trans,
 	root = btrfs_get_fs_root(fs_info, ref_key->offset, false);
 	if (IS_ERR(root))
 		return PTR_ERR(root);
-	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
-		cur->cowonly = 1;
+
+	/*
+	 * We shouldn't be using backref cache for non shareable roots, ASSERT
+	 * for developers, return -EUCLEAN for users.
+	 */
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
+		btrfs_put_root(root);
+		ASSERT(0);
+		return -EUCLEAN;
+	}
 
 	if (btrfs_root_level(&root->root_item) == cur->level) {
 		/* Tree root */
@@ -3400,8 +3408,20 @@ static int handle_indirect_tree_backref(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 			upper->owner = btrfs_header_owner(eb);
-			if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
-				upper->cowonly = 1;
+
+			/*
+			 * We shouldn't be using backref cache for non shareable
+			 * roots, ASSERT for developers, return -EUCLEAN for
+			 * users.
+			 */
+			if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
+				btrfs_put_root(root);
+				btrfs_backref_free_edge(cache, edge);
+				btrfs_backref_free_node(cache, upper);
+				ASSERT(0);
+				ret = -EUCLEAN;
+				goto out;
+			}
 
 			/*
 			 * If we know the block isn't shared we can avoid
@@ -3592,15 +3612,12 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 
 	ASSERT(start->checked);
 
-	/* Insert this node to cache if it's not COW-only */
-	if (!start->cowonly) {
-		rb_node = rb_simple_insert(&cache->rb_root, start->bytenr,
-					   &start->rb_node);
-		if (rb_node)
-			btrfs_backref_panic(cache->fs_info, start->bytenr,
-					    -EEXIST);
-		list_add_tail(&start->lower, &cache->leaves);
-	}
+	rb_node = rb_simple_insert(&cache->rb_root, start->bytenr,
+				   &start->rb_node);
+	if (rb_node)
+		btrfs_backref_panic(cache->fs_info, start->bytenr,
+				    -EEXIST);
+	list_add_tail(&start->lower, &cache->leaves);
 
 	/*
 	 * Use breadth first search to iterate all related edges.
@@ -3654,23 +3671,14 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
 			return -EUCLEAN;
 		}
 
-		/* Sanity check, COW-only node has non-COW-only parent */
-		if (start->cowonly != upper->cowonly) {
-			ASSERT(0);
+		rb_node = rb_simple_insert(&cache->rb_root, upper->bytenr,
+					   &upper->rb_node);
+		if (rb_node) {
+			btrfs_backref_panic(cache->fs_info,
+					    upper->bytenr, -EEXIST);
 			return -EUCLEAN;
 		}
 
-		/* Only cache non-COW-only (subvolume trees) tree blocks */
-		if (!upper->cowonly) {
-			rb_node = rb_simple_insert(&cache->rb_root, upper->bytenr,
-						   &upper->rb_node);
-			if (rb_node) {
-				btrfs_backref_panic(cache->fs_info,
-						upper->bytenr, -EEXIST);
-				return -EUCLEAN;
-			}
-		}
-
 		list_add_tail(&edge->list[UPPER], &upper->lower);
 
 		/*
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 754c71bdc9ce..6c27c070025a 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -341,8 +341,6 @@ struct btrfs_backref_node {
 	struct extent_buffer *eb;
 	/* Level of the tree block */
 	unsigned int level:8;
-	/* Is the block in a non-shareable tree */
-	unsigned int cowonly:1;
 	/* 1 if no child node is in the cache */
 	unsigned int lowest:1;
 	/* Is the extent buffer locked */
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index db5f6bda93c9..507fcc3f56e6 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2544,7 +2544,7 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 		ret = do_relocation(trans, rc, node, key, path, 1);
 	}
 out:
-	if (ret || node->level == 0 || node->cowonly)
+	if (ret || node->level == 0)
 		btrfs_backref_cleanup_node(&rc->backref_cache, node);
 	return ret;
 }
-- 
2.43.0



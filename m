Return-Path: <linux-btrfs+bounces-19225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F348C748F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 15:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4D934E7193
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4C33EAF9;
	Thu, 20 Nov 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0RZTDd/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9ED345CB1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648417; cv=none; b=VKMsp8ejj2C52r6nCxh3klzRLhxV0ORN3Kh8qy9JR+uUaIqNe1co0WaPnRfXtkKTEcGwGAp2jHRNFUc5usf3oCOOAmJ6h6UuKmovAhOa8+aVF1YIWrjHNhcqR2VuJdv+JPT+caP8guTUY+Ew3Shc9ojf9JZUlCa24nQih1PCt+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648417; c=relaxed/simple;
	bh=CnKX9adBhmkmfqIAMV6NCREgkfgNNhadlKbCqrDEtzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1gbmTCG0vQ+t4SPi9/gRPcCJIg8L0iuukVpf+fBDXwiwFjeYLRTcUc6YLvm7ECcf0yzfDzWVlX8cZBWljxvDn6lQTFpv5kdrkwwz+UwbuACSbG7HNe6LoClx5T7tu+N1P2FnLNUAZkPYXzGgU6AyE8VmY7i2CjpCn5q20fqAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0RZTDd/; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-297ea4c2933so796295ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 06:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763648415; x=1764253215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktKQNq+nto/OZUl8/0N2bD2SM1gOdDLYdqmyrrEyEoc=;
        b=K0RZTDd/qnWYwnb/+wMw7fi91Nmc82D7yO5E3WyrBtnQjomQLpDZAzRokdGjM5gY51
         mtEEcDoKN0RQAdwZ9xbnsruLR73VB3A9wEA2qrvbSl371Gd7jFR1ogauGM+1pslQTHB1
         PgT7L2os2CUBBzwtsLKxemRqJDQIobfM5wQuBs5Tp+MSEheUEMw0I9H95xdby/yvl4AI
         vSMNKw2NbDarz6BOoqOKObB8cWwboQqxIGDHdBSwZgSlHrQaliyZ9mPO7Uks2RitJsGn
         Wai4SvcLa2Ra8PDDWF1NW/dNexl8FB6S0/RPKgRdkzqXkp3IVkU2VhmcwX2GTI1A/KyA
         h3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648415; x=1764253215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktKQNq+nto/OZUl8/0N2bD2SM1gOdDLYdqmyrrEyEoc=;
        b=R3t/8A8crztcUAziGsa1TighSe5hRCB7yqxWv1l2i1wH6zGI7aaxaHZ8RI7671xZkC
         isaISYin0k1izPE1vPAGOoCmxsVqh+z6gwwXBIeOP6Gwa3pbxvFo3wwxd7t4uVDpMyOo
         xiqlmgM3HbD5RHiXajfWMSWxPoYxewWz32dB3RJF1+ViW2N3SYM0b91rUds9MfLWc3sd
         pj1kgNpA/r+DUF8Owt5Rkdwc9MwLOvwqTMpxDaR1whO3k5vFESMYBeMj+XkMslBBiN/S
         2zTKtH/SKwRzKVPHtIgSO64E2r0yc4qH8KzuXFmsJ9GtBEf1lIlDNFk/Z6iEmCdEtRsh
         Vkbw==
X-Gm-Message-State: AOJu0YwhXfIVVFRCPgXejNXDLldCkAxKKe5HHD+SkY8i615TV4cnEUNO
	xnGsUPIgxJvjLIN6IDAHjGyzkglgiCBoWGzezdoBg+mvE271086Kn4DmqCtEVeUZdKg=
X-Gm-Gg: ASbGnctXjF5H0GmigokdieW7h01xXygagELhogCDV+PehUvLjl9tcfcStcBarDfrfko
	Xqltf4jXKg+MwodkdSM8QyxxhM2as544KDtO0J3AvIw15X1F6QUYRlC+tfDEsMgpxbbuhZ1C7uz
	sfO8ypzFj6ynLFtc4AH+8WjWHjrllgelgumBmNvhqwoDLWHeRMKsNTKCRi7B2hG3idDrJ9+5xiq
	jKLSOthMCbUlckNqrRVfun3VsVoGCKD+Rgazq80xe//feahjz9lsohsIQQWf0NUhAUd+UR5eU62
	Rwq74zgLNhqI0xXtrwcNJykXfE0e8dcJY3/WMKq10czHPBf6gOGf8GtQmt7dUMmTsvaJAMnZ7cn
	ZiiLFCEZogKZUxReP9bYFJ5/v+X3DaLDHh2SdgkmUXEjGYwDXPpzZ1qRloZITtWlvF/EMYqUAYV
	lBSKVIi05y8vwiSMMxjoKG0k+GyWhZBTA=
X-Google-Smtp-Source: AGHT+IEWHzH4q7o+38041EOnoGp9y44GqDei7Kz2PpPLhaDKOMFf8uouSFot39rP7Vht49WoYg0lDQ==
X-Received: by 2002:a17:902:cf0e:b0:258:a3a1:9aa5 with SMTP id d9443c01a7336-29b5ecb6362mr21269355ad.0.1763648414902;
        Thu, 20 Nov 2025 06:20:14 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e4ca0casm2781600a12.10.2025.11.20.06.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:20:14 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/2] btrfs: simplify boolean argument for btrfs_{inc,dec}_ref
Date: Thu, 20 Nov 2025 22:19:14 +0800
Message-ID: <20251120141948.5323-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120141948.5323-1-sunk67188@gmail.com>
References: <20251120141948.5323-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded if/else blocks with the boolean expression
directly, making the code shorter and easier to read.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c       | 25 +++++++------------------
 fs/btrfs/extent-tree.c | 17 +++++------------
 2 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1b15cef86cbc..e056dedec221 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -291,15 +291,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
-		ret = btrfs_inc_ref(trans, root, cow, true);
-		if (unlikely(ret))
-			btrfs_abort_transaction(trans, ret);
-	} else {
-		ret = btrfs_inc_ref(trans, root, cow, false);
-		if (unlikely(ret))
-			btrfs_abort_transaction(trans, ret);
-	}
+	ret = btrfs_inc_ref(trans, root, cow, new_root_objectid == BTRFS_TREE_RELOC_OBJECTID);
+	if (unlikely(ret))
+		btrfs_abort_transaction(trans, ret);
 	if (ret) {
 		btrfs_tree_unlock(cow);
 		free_extent_buffer(cow);
@@ -437,20 +431,15 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			if (ret)
 				return ret;
 		} else {
-
-			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-				ret = btrfs_inc_ref(trans, root, cow, true);
-			else
-				ret = btrfs_inc_ref(trans, root, cow, false);
+			ret = btrfs_inc_ref(trans, root, cow,
+					    btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID);
 			if (ret)
 				return ret;
 		}
 	} else {
 		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-			if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID)
-				ret = btrfs_inc_ref(trans, root, cow, true);
-			else
-				ret = btrfs_inc_ref(trans, root, cow, false);
+			ret = btrfs_inc_ref(trans, root, cow,
+					    btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID);
 			if (ret)
 				return ret;
 			ret = btrfs_dec_ref(trans, root, buf, true);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 527310f3aeb3..8e6f362de649 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5875,18 +5875,11 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 
 	if (wc->refs[level] == 1) {
 		if (level == 0) {
-			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
-				ret = btrfs_dec_ref(trans, root, eb, true);
-				if (ret) {
-					btrfs_abort_transaction(trans, ret);
-					return ret;
-				}
-			} else {
-				ret = btrfs_dec_ref(trans, root, eb, false);
-				if (unlikely(ret)) {
-					btrfs_abort_transaction(trans, ret);
-					return ret;
-				}
+			ret = btrfs_dec_ref(trans, root, eb,
+					    !!(wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF));
+			if (unlikely(ret)) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
 			}
 			if (btrfs_is_fstree(btrfs_root_id(root))) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
-- 
2.51.2



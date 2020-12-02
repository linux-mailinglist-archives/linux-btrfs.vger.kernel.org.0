Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB252CC737
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389851AbgLBTxi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389842AbgLBTxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:34 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B96C061A4C
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:49 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so2451695qkc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LPT7aEYnMVET6RU2QhdABJEzg5OVvT3nShfG4ZVnk/g=;
        b=ycXwQm9TMvGKme5FhtoGwX7eyaxVL30DFN68RO9esM3eE28uYYt0cLOwacfw6IfmBk
         SbNomiu0droGPbQvyt650kUUc/cVEy/OhaV1D0e4DXLE/kdCgHLetLTIbdniAj4ihNqK
         52Y2cNlEqJAN2u4hs9ki+RyUyrPmm6ZGIlz/edTgN+WAPDI8YhuFqu00GWpVzjaQ5xuk
         sIcJBUe+ExoKF2gSuTdRaBakaQlV++BB6TNT02iZUHYSohOaBSBbpWgBoH1kgitORQdu
         Wsv9Mq0ET7UvZutNsvM+vQ75SnJHxnoyYqpAxC58Ak+pytxR8M09ewULnr17t9/sYq5t
         ck/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPT7aEYnMVET6RU2QhdABJEzg5OVvT3nShfG4ZVnk/g=;
        b=peimameqSXzWtD3CWDvwhjakk13jge9Ubun3Mo6F6xXte0naBwAJHD+qcT1LP9jfmF
         WpSevzzwiT8RRxpfNg19/IpDP8V7M/ryE30IpNFfY9Do23ercG9cQ47cmE3qr5jMQ/So
         6R/w9IGV+Q/Ga9VUpMlYtSBxA3uDDTlML3o69SeLmEuWTpzKGLTJH/c5OomlAH/vDpLa
         hrzANwxj3qb6EkHuXIR8zyi4hC7jp663sxsNBBV2VloAH6skyBJhUply5YxHamaLuDXQ
         zGOeMlWs+s4HlfAUA5boPcQhiSsH5owIQFQLSUftQsu2QBKSAquVZQv0ENjw1f2ueGQZ
         eIlw==
X-Gm-Message-State: AOAM533NphPS9K+lKYTh1wnHN+2QMZR7RdbWs+galsuV8o30TVpD5RDS
        qbvePbfH4xcEZng52M0XBIA0QEVU/HFIMQ==
X-Google-Smtp-Source: ABdhPJweSXAOCHyCxPq4H4IOCQ7Nr4Ic4gpZaO7xotn8C4WSziiPEo7N8B7i+Gs++3fYGUlefZrA5g==
X-Received: by 2002:a37:afc6:: with SMTP id y189mr4317134qke.361.1606938768501;
        Wed, 02 Dec 2020 11:52:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b73sm2934309qkc.87.2020.12.02.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 52/54] btrfs: print the actual offset in btrfs_root_name
Date:   Wed,  2 Dec 2020 14:51:10 -0500
Message-Id: <3575cc74f0d9f63647e92082979fa8cfd3901e90.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're supposed to print the root_key.offset in btrfs_root_name in the
case of a reloc root, not the objectid.  Fix this helper to take the key
so we have access to the offset when we need it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c    |  2 +-
 fs/btrfs/print-tree.c | 10 +++++-----
 fs/btrfs/print-tree.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 46dd9e0b077e..c73d172aa1f7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1458,7 +1458,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
 		root = list_first_entry(&fs_info->allocated_roots,
 					struct btrfs_root, leak_list);
 		btrfs_err(fs_info, "leaked root %s refcount %d",
-			  btrfs_root_name(root->root_key.objectid, buf),
+			  btrfs_root_name(&root->root_key, buf),
 			  refcount_read(&root->refs));
 		while (refcount_read(&root->refs) > 1)
 			btrfs_put_root(root);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index fe5e0026129d..b8137dbf6a3a 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -26,22 +26,22 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
 };
 
-const char *btrfs_root_name(u64 objectid, char *buf)
+const char *btrfs_root_name(struct btrfs_key *key, char *buf)
 {
 	int i;
 
-	if (objectid == BTRFS_TREE_RELOC_OBJECTID) {
+	if (key->objectid == BTRFS_TREE_RELOC_OBJECTID) {
 		snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN,
-			 "TREE_RELOC offset=%llu", objectid);
+			 "TREE_RELOC offset=%llu", key->offset);
 		return buf;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(root_map); i++) {
-		if (root_map[i].id == objectid)
+		if (root_map[i].id == key->objectid)
 			return root_map[i].name;
 	}
 
-	snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", objectid);
+	snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN, "%llu", key->objectid);
 	return buf;
 }
 
diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
index 78b99385a503..802628dd1a6e 100644
--- a/fs/btrfs/print-tree.h
+++ b/fs/btrfs/print-tree.h
@@ -11,6 +11,6 @@
 
 void btrfs_print_leaf(struct extent_buffer *l);
 void btrfs_print_tree(struct extent_buffer *c, bool follow);
-const char *btrfs_root_name(u64 objectid, char *buf);
+const char *btrfs_root_name(struct btrfs_key *key, char *buf);
 
 #endif
-- 
2.26.2


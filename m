Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D4460E8BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiJZTL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiJZTLe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:34 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389113C3D8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u7so12403320qvn.13
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFZTFqnXe1S/H1W1OFRC1EZQYoPF4k11sOc3QYaLULU=;
        b=c1HFRhEMVoYj7Aj7jYRlgWau8vB7Sooj/0NlXmNEAIzedNL8mygQEGFPXoKjUdVSsb
         ajHsTNTNL/3g1kTFTWCsHEwc+KrzME6T9XxtlfEWR48vWOI4PuqWreior93n2DdiMqPi
         ZLRcM3fdrFE1tA4IB0iR/VL4hX4we0Lp+uF2Dfzkk5w3jMymJvd2gnlLxOdSBlEQKt1t
         U2/ID90Y0JKafGyT3hYjfAaDrkHRdA3pDNx/b0l2tacvFLbY2J6X2YGr1vG4MwlQFVDo
         wejpq+Pi8foZvjgnugYKZvRwt4qKGi0dCxYOa2dTPTzyUnFLUF4a3km+ilEsLmSNAj5c
         g8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFZTFqnXe1S/H1W1OFRC1EZQYoPF4k11sOc3QYaLULU=;
        b=YxPfDyb5qwqgfDLV7+5kBv0bXFAMEhUoIoUKczvJrvn9OCrQGbDIu+zlerlQauTVju
         aEW1nYt4kZvoBZ7j/wIJfD7Z1WWV3msSzZEvF1mBLZYT6EOmGULDxcsCq5sFEZg42PIE
         HHnq77+PwLTdwJzqD76ujBLliNEQtdSOgnn5kNi5iD5zEkKk/7Ki8QNqQ0JtvpAyHQAm
         5OA7jK9LQJDF3JEj96X3Nxy7bmJGT65a3MWxTcn9CGyVvoeszmDjZHOtjx1mpu5G+IZB
         d69G/JWpMBh0z119QxeIDa0EJdPJ+h/t+0xz5iKC39U5OS575ZAnfW3qrUjR5eMz9IQF
         nOrw==
X-Gm-Message-State: ACrzQf3S600xaQd7sG4ul8L/8LpVnr0hMEXiXRVmXBeyv8Jc9b0j/D5Y
        vZQQpJTmIGeq6nMNSHCOVMEemqIBi4goPg==
X-Google-Smtp-Source: AMsMyM6ocPn9Znqqt84sFg/3P1n1Z5eax4aK8Y5EJnMM3aZlGhI1/1Kkp63FjG44YFSjl/HF/V0ZRw==
X-Received: by 2002:a05:6214:2a4a:b0:4bb:64a3:7268 with SMTP id jf10-20020a0562142a4a00b004bb64a37268mr18382749qvb.85.1666811341604;
        Wed, 26 Oct 2022 12:09:01 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006cf3592cc20sm4348378qkh.55.2022.10.26.12.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/26] btrfs: move uuid tree prototypes to uuid-tree.h
Date:   Wed, 26 Oct 2022 15:08:28 -0400
Message-Id: <5f0b2d67f001541482da9ef9067a0dcf97727dbe.1666811039.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move these out of ctree.h into uuid-tree.h to cut down on the code in
ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  7 -------
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/ioctl.c       |  1 +
 fs/btrfs/transaction.c |  1 +
 fs/btrfs/uuid-tree.c   |  1 +
 fs/btrfs/uuid-tree.h   | 12 ++++++++++++
 fs/btrfs/volumes.c     |  1 +
 8 files changed, 18 insertions(+), 7 deletions(-)
 create mode 100644 fs/btrfs/uuid-tree.h

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6bfea55c82a0..910a23e7cd8f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -682,13 +682,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct extent_buffer *node,
 			struct extent_buffer *parent);
 
-/* uuid-tree.c */
-int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
-			u64 subid);
-int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
-			u64 subid);
-int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
-
 /* orphan.c */
 int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 offset);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fe7c6f4ac20b..c5ff0b12cd5b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -48,6 +48,7 @@
 #include "extent-tree.h"
 #include "root-tree.h"
 #include "defrag.h"
+#include "uuid-tree.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 237efcab7c34..0be05e267283 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -62,6 +62,7 @@
 #include "defrag.h"
 #include "dir-item.h"
 #include "file-item.h"
+#include "uuid-tree.h"
 
 struct btrfs_iget_args {
 	u64 ino;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e728bcec9419..d255757b3450 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -56,6 +56,7 @@
 #include "root-tree.h"
 #include "defrag.h"
 #include "dir-item.h"
+#include "uuid-tree.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 910d176ccec0..ded084cb46d9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -30,6 +30,7 @@
 #include "root-tree.h"
 #include "defrag.h"
 #include "dir-item.h"
+#include "uuid-tree.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 70304b89f31f..7c7001f42b14 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -12,6 +12,7 @@
 #include "print-tree.h"
 #include "fs.h"
 #include "accessors.h"
+#include "uuid-tree.h"
 
 static void btrfs_uuid_to_key(u8 *uuid, u8 type, struct btrfs_key *key)
 {
diff --git a/fs/btrfs/uuid-tree.h b/fs/btrfs/uuid-tree.h
new file mode 100644
index 000000000000..ffd28106f429
--- /dev/null
+++ b/fs/btrfs/uuid-tree.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_UUID_TREE_H
+#define BTRFS_UUID_TREE_H
+
+int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+			u64 subid);
+int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+			u64 subid);
+int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
+
+#endif /* BTRFS_UUID_TREE_H */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0182ae70911e..2495c8f62d87 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -35,6 +35,7 @@
 #include "zoned.h"
 #include "fs.h"
 #include "accessors.h"
+#include "uuid-tree.h"
 
 static struct bio_set btrfs_bioset;
 
-- 
2.26.3


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17F81A47EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDJPmv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 11:42:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44068 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgDJPmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 11:42:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so2467213qkc.11
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Apr 2020 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWuF8/K5yV7++n/KrsD8j3cLJLPqBW8N6607wBDXXbI=;
        b=OzIVFC75vP9r/Xm1XZX+xaI1QIx1tzcO6wQmJIQ1204u/anvNgwmChiTcNY7Zki/2q
         M52OHqb/10T/Na7tjNp950vgJbKZn4thty76ghIwAThzdLleeNB1pD+mYcCksOJCAbBd
         XL1yl2pqq6/fz9eDkiClQi1WDqiAzg2L3XqiWyPZiDRx/RBM/hbPK7IObcb+GSoC6A3K
         VeiVG7ObDtt22cn5xP4KSf5XAMaNmGpvBDMfS5D6JRvyUfcXIDGcdzDYPl+PE1QoDx3q
         fZavkpxjVEHlCVj8QYrIG/QTOTbstKGqocH839Y8PQ7cuveXkrMBfQs0yvpm/4CDBgk8
         x18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWuF8/K5yV7++n/KrsD8j3cLJLPqBW8N6607wBDXXbI=;
        b=MAxErr9KA8yCQ+lMqStkakEvM2QEsnXyJEaK9opE3jh2mxYuOq9hlesm2yBzJedAsy
         448PlWYbzBAwLsneaN7qJri08rOQntBXDuigDBhA00miYVctsOwnOCojdyzfeFWPU2NY
         3MqUC5MQYqhC+hseg7KY85OiuJdsIj3dsv8g7de+nDHQ7EiAmJZy2ksdcfmkBl4DSCM6
         EBgcvip6+54un6gXmQL3LrO+8fycNePQibQ8dTbshmXL4KqxBaxqpEbr8nKklDHqoljL
         P2cUAuvNN3wlGbA46EPkqJbDuTIVvuVc3UOAk5MA/emLMy+81OVunvjqdF5PI78gmiYO
         PZRg==
X-Gm-Message-State: AGi0Pub3/JfDTN3KjlcZOHoiKL9UPWJ4YGPpBftlh1vfQebrJBcq5kDk
        ubEXGR4tNbmVG1HDnIkqPg6xuFsgPVArpA==
X-Google-Smtp-Source: APiQypJ1ZH9MtqtM5xCVNGkO/uDVZgcXNqFFDkSfl2UY9oIEiKyM4pP3FHVba9hlPXRwmRs2TajNxg==
X-Received: by 2002:a37:a4d1:: with SMTP id n200mr4563268qke.156.1586533371020;
        Fri, 10 Apr 2020 08:42:51 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o128sm1780123qkf.116.2020.04.10.08.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 08:42:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix setting last_trans for reloc roots
Date:   Fri, 10 Apr 2020 11:42:48 -0400
Message-Id: <20200410154248.2646406-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I made a mistake with my previous fix, I assumed that we didn't need to
mess with the reloc roots once we were out of the part of relocation
where we are actually moving the extents.

The subtle thing that I missed is that btrfs_init_reloc_root() also
updates the last_trans for the reloc root when we do
btrfs_record_root_in_trans() for the corresponding fs_root.  I've added
a comment to make sure future me doesn't make this mistake again.

This showed up as a WARN_ON() in btrfs_copy_root() because our
last_trans didn't == the current transid.  This could happen if we
snapshotted a fs root with a reloc root after we set
rc->create_reloc_tree = 0, but before we actually merge the reloc root.

Fixes: 2abc726ab4b8 ("btrfs: do not init a reloc root if we aren't relocating")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d4734337127a..76bfb524bf3e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -830,8 +830,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	int clear_rsv = 0;
 	int ret;
 
-	if (!rc || !rc->create_reloc_tree ||
-	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
+	if (!rc)
 		return 0;
 
 	/*
@@ -841,12 +840,28 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 	if (reloc_root_is_dead(root))
 		return 0;
 
+	/*
+	 * This is subtle but important.  We do not do
+	 * record_root_in_transaction for reloc roots, instead we record their
+	 * corresponding fs root, and then here we update the last trans for the
+	 * reloc root.  This means that we have to do this for the entire life
+	 * of the reloc root, regardless of which stage of the relocation we are
+	 * in.
+	 */
 	if (root->reloc_root) {
 		reloc_root = root->reloc_root;
 		reloc_root->last_trans = trans->transid;
 		return 0;
 	}
 
+	/*
+	 * We are merging reloc roots, we do not need new reloc trees.  Also
+	 * reloc trees never need their own reloc tree.
+	 */
+	if (!rc->create_reloc_tree ||
+	    root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
+		return 0;
+
 	if (!trans->reloc_reserved) {
 		rsv = trans->block_rsv;
 		trans->block_rsv = rc->block_rsv;
-- 
2.24.1


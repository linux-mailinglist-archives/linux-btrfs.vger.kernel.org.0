Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73969C2114
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfI3NAs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 09:00:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34206 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbfI3NAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 09:00:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so5594529pfa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1QHgdw6qTH1NYu+hc4JO05dVDlYXutZpqChz9USyLms=;
        b=heZ3/hWJOvfDigWdKhOChAWw9eODDLJbAwJ1vuxgOykyiytW9fyUrJqO09XG1ThRtk
         GLCOmRLiJmsdsz1x6cY0W8DceVTz0HCbkV0zJI5z13aegR3aQ7+jXY69dxBBO9VYBY6T
         VzZnlLLUBcf3rW9qjirIQt2WAaFIjzP+FwJQlBeqExW3LBpidPYVqZJgWxte9QEZ3a3i
         iZAWFPm8fC1PwlQnHgKJo+69r4B/klg/L7mHX95j9ZcRgHIT5V8AD0KL662oTAYZYnIe
         Byuox+LkZVXAkvECrCyVPlTudTYUEgP8vTmqN2fX6j2GkBchMDWrjH+ojtiY0fHx+tAI
         e+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1QHgdw6qTH1NYu+hc4JO05dVDlYXutZpqChz9USyLms=;
        b=o2ifbxH6vN/h/HjPbtcbiUHEhVwFm5ROFXdGvF315y0DGuVwy/pGWa9x3w7YNYPLeU
         pOnC9RjfMnDIJyPjUNq/hP7HYq0cykfy7PHaLQ1jFJRMGH9B5t/kCNH5XZQF/KbZxh2m
         l1/8foLZnmcm9+KoDNszoUl5tv6lJ4cZw6MgyO78kl/xFckmbnhY6w5m6adoG3HSIZxR
         Wsre5TS8LgnRV45TP2qKiflTd7YwtqMAyLmy/amJrCKq4S4aI6Y+TUWWlcgwuNlSoofw
         cbJ8qANzM1D69AfF4VNK6zqQ6Sx1xFAuN5/YQj6d5Q4X/AAA6VrMsvUzAhkCU+1mu3SK
         IueQ==
X-Gm-Message-State: APjAAAVgxoWvtyLHSiyYVKh/+4cOlI5i79UKki3MHwjgQc0R13dC4IG+
        3CWdgaROmtKwMV7kLsakejc=
X-Google-Smtp-Source: APXvYqwtwDs1d0nxCjfEQULm/YYUsqtKCr/R3yhSWcyfsY1oIwx/Ip56YGtMRywf0KKlWA0Ehdy+dA==
X-Received: by 2002:a63:5566:: with SMTP id f38mr23906154pgm.389.1569848447587;
        Mon, 30 Sep 2019 06:00:47 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1951:51d2:1ea:5074:6a35:df7d])
        by smtp.gmail.com with ESMTPSA id u4sm12813119pfu.177.2019.09.30.06.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 06:00:46 -0700 (PDT)
From:   Aliasgar Surti <aliasgar.surti500@gmail.com>
X-Google-Original-From: Aliasgar Surti
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Subject: [PATCH v2] btrfs: removed unused return variable
Date:   Mon, 30 Sep 2019 18:30:21 +0530
Message-Id: <1569848421-25978-1-git-send-email-aliasgar.surti500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Aliasgar Surti <aliasgar.surti500@gmail.com>

Removed unused return variable and replaced it with returning
the value directly

Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
---
v2: Made btrfs_destroy_delayed_refs() as void and removed its declaration
---
 fs/btrfs/disk-io.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 044981c..0a8243a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,8 +52,6 @@
 static const struct extent_io_ops btree_extent_io_ops;
 static void end_workqueue_fn(struct btrfs_work *work);
 static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				      struct btrfs_fs_info *fs_info);
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
 static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 					struct extent_io_tree *dirty_pages,
@@ -4249,13 +4247,12 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 }
 
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
+static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 				      struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4263,7 +4260,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_info(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4306,8 +4303,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	}
 
 	spin_unlock(&delayed_refs->lock);
-
-	return ret;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
2.7.4


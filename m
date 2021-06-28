Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E9F3B5AB1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhF1Iv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 04:51:59 -0400
Received: from m12-15.163.com ([220.181.12.15]:42151 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhF1Iv7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 04:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ode9v
        3e6crJ10ED+WHlug9qXebICX8vhtMeH4FWBSmc=; b=SE7kir8WwQUWVMUYRFcn8
        DSSqcxzg1m1tF/2EiQ7nP8zF4jMOKL5EK+e84+MImBqxcCzYwmL2Lq1TGBASMbuI
        6oNrYFlYsM/TuGV1Vkc20QPW4vuTJQvXcsq3G2EFi4McsUv8XQYjCRt211tslVxH
        RSQtFdsPjH31AjAKxK6jak=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp11 (Coremail) with SMTP id D8CowADn5xLBiNlgg0yUAg--.46S2;
        Mon, 28 Jun 2021 16:33:24 +0800 (CST)
From:   13145886936@163.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>,
        gushengxian <13145886936@163.com>
Subject: [PATCH] btrfs: remove unneeded variable: "ret"
Date:   Mon, 28 Jun 2021 01:30:50 -0700
Message-Id: <20210628083050.5302-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADn5xLBiNlgg0yUAg--.46S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1rGF4fWr47Wr4kXw4rAFb_yoW8Jw1DpF
        WfCrn8K395Jr1kGrs3W3y0gr1SyFZrA3yxW3say39aqw45Jrs8XF4vyr1Fqr1vyrW8uF4U
        Zr45WFWkZanFkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-wIDUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiXBW-g1Xl0HHbrAAAsT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Remove unneeded variable: "ret".

Signed-off-by: gushengxian <13145886936@163.com>
Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b117dd3b8172..7e65a54b7839 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4624,7 +4624,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4632,7 +4631,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return 0;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4695,7 +4694,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 
 	spin_unlock(&delayed_refs->lock);
 
-	return ret;
+	return 0;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
2.25.1


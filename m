Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B702E3339
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Dec 2020 00:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgL0XdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Dec 2020 18:33:02 -0500
Received: from mail-m965.mail.126.com ([123.126.96.5]:57612 "EHLO
        mail-m965.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgL0XdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Dec 2020 18:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=XTOC6utOIdkkWN03zN
        YpID2JHZZBjUcwiL+beXqGabc=; b=lvFi6U+6G3YggggOPIBHAG4Ev78JPRY8X+
        0CO61Pddb7HcqPNJFqKDD2tkS1q5XSmutb43Y6jjpXblafvyIEmbJ1oNx/KkFiRJ
        hwdDg3ulB0T85nouL2wDGsIRHkUfSWg8G+1BIDxLmr4TX48/jjt/dlYgCTAxXKrJ
        jm69V0SRs=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp10 (Coremail) with SMTP id NuRpCgC3ja1poOhfAcMsig--.39941S2;
        Sun, 27 Dec 2020 22:55:38 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH 3/3] fs/btrfs: avoid null pointer dereference if reloc control has not been initialized
Date:   Sun, 27 Dec 2020 22:55:31 +0800
Message-Id: <1609080931-4048864-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NuRpCgC3ja1poOhfAcMsig--.39941S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyUZF4xAry3Kr1kJw1kXwb_yoWDCFg_GF
        ySyrZ5Cw4Utw1Fgrs2kws3XFyftwnYgF4UKasxKr47tF4Utr909rs7ArZ5uF17W34kKF45
        GwnYgr1jyryxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUCeHJUUUUU==
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbi4woI11pD81aI6QAAsr
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to commmit<389305b2>, it turns out that fs_info::reloc_ctl can be NULL ,
so there should be a check for rc to prevent null pointer dereference.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 fs/btrfs/relocation.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3602806..ca03571 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -626,6 +626,9 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 	struct mapping_node *node;
 	struct reloc_control *rc = fs_info->reloc_ctl;
 
+	if (!rc)
+		return 0;
+
 	node = kmalloc(sizeof(*node), GFP_NOFS);
 	if (!node)
 		return -ENOMEM;
@@ -703,6 +706,9 @@ static int __update_reloc_root(struct btrfs_root *root)
 	struct rb_node *rb_node;
 	struct mapping_node *node = NULL;
 	struct reloc_control *rc = fs_info->reloc_ctl;
+
+	if (!rc)
+		return 0;
 
 	spin_lock(&rc->reloc_root_tree.lock);
 	rb_node = rb_simple_search(&rc->reloc_root_tree.rb_root,
-- 
2.7.4


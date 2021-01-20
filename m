Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19C2FCFE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 13:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbhATMRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:17:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:37898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730340AbhATK11 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 05:27:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611138330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/rbgAgA3yqs3tyfJy3HHB2rvWCt4iTowzO89M9PuuU=;
        b=kSk4KSbpCeguXdBDZK3pAJ4GM3NKGrlrYYGEJDEW0Nck4C7FOigMXPRxeBv1zsKNLFtv/X
        wm8xoP+qcpB0xYxQ+iC+RoxqNStSeZaZz34m/w7RKV8xJnQi/dFjmb8JXuEGrNr6CSyVaU
        gBVkEP43oCyM4BCP+psY8NJahhjShp0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B45DAFF2;
        Wed, 20 Jan 2021 10:25:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 09/14] btrfs: Document btrfs_check_shared parameters
Date:   Wed, 20 Jan 2021 12:25:21 +0200
Message-Id: <20210120102526.310486-10-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120102526.310486-1-nborisov@suse.com>
References: <20210120102526.310486-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/backref.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ef71aba5bc15..50334b8cb64d 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1503,6 +1503,12 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 /**
  * btrfs_check_shared - tell us whether an extent is shared
  *
+ * @root:   root inode belongs to
+ * @inum:   inode number of the inode whose extent we are checking
+ * @bytenr: logical bytenr of the extent we are checking
+ * @roots:  list of roots this extent is shared among
+ * @tmp:    temporary list used for iteration
+ *
  * btrfs_check_shared uses the backref walking code but will short
  * circuit as soon as it finds a root or inode that doesn't match the
  * one passed in. This provides a significant performance benefit for
-- 
2.25.1


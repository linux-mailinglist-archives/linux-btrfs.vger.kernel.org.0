Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433743555CB
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbhDFNzO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 09:55:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:57144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244310AbhDFNzN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 09:55:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617717304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VfZ5EUJ2C820A7VzEpQevLX6CSNWgc/P+MmuishEowc=;
        b=SpH71tvbFCNjWlt4IQMC/ja/78wZs/zD/5W7UULx8Na7kGqu/puWu1iUyGuvWSMjn977+q
        HU7VgUdwBa9c4cnoJyFoehnte5oU4AUZ99LRzJVHF7zBKrucC0ubWdlbp+Ve8cmYTu+Rd/
        9FfXRz2+VV/Ys9iPBDr9dWmEfWmxc/E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD724B1AE;
        Tue,  6 Apr 2021 13:55:04 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Fix null pointer deref in balance_level
Date:   Tue,  6 Apr 2021 16:55:03 +0300
Message-Id: <20210406135503.164590-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In case the right buffer is emptied it's first set to null and
subsequently it's dereferenced to get its size to pass to root_sub_used.
This naturally leads to a null pointer dereference. The correct thing
to do is to pass the stashed right->len in "blocksize".

Fixes #296

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 kernel-shared/ctree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 4cc3aebc1412..3a82286cc914 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -927,7 +927,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 			if (wret)
 				ret = wret;
 
-			root_sub_used(root, right->len);
+			root_sub_used(root, blocksize);
 			wret = btrfs_free_extent(trans, root, bytenr,
 						 blocksize, 0,
 						 root->root_key.objectid,
-- 
2.25.1


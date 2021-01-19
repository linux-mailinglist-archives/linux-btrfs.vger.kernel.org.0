Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BCC2FB9F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 15:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbhASOkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:40:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:37986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390969AbhASM3F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 07:29:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611059213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5m0sGFZpVEjOcOT0q5KPiYixNj8MSTPswDz50f26LKU=;
        b=akGxUwloHm8C3Iwxzspkz45RDMBXMRL1xCQfWz9hI6JBX7PET/NPCeBcTZAx+Ull1J7nRK
        kpcUGqeN7mgyQdHqZr4CjvF4BF7ErrljLIHp4DALisjUqsl+8Pd8ovEdarQompws43vGbk
        uQKeqfDSn042S84TS7fsDlUKD9o8PSg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDED7AF48;
        Tue, 19 Jan 2021 12:26:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 07/13] btrfs: Document fs_info in btrfs_rmap_block
Date:   Tue, 19 Jan 2021 14:26:43 +0200
Message-Id: <20210119122649.187778-8-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119122649.187778-1-nborisov@suse.com>
References: <20210119122649.187778-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes fs/btrfs/block-group.c:1570: warning: Function parameter or member 'fs_info' not described in 'btrfs_rmap_block'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0886e81e5540..1b71e7be04a9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1554,6 +1554,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 
 /**
  * btrfs_rmap_block - Map a physical disk address to a list of logical addresses
+ * @fs_info:       fs context
  * @chunk_start:   logical address of block group
  * @physical:	   physical address to map to logical addresses
  * @logical:	   return array of logical addresses which map to @physical
-- 
2.25.1


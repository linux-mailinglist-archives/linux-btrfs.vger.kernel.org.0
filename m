Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4EF2FB9E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbhASOi4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:38:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:37190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404818AbhASM1j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 07:27:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611059213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsbSPpwqYVObLx3Zx9RGJx0UI0glhIFWKhYSHN1BOgg=;
        b=Y2DEvxzDO/g6FkDj32XgfMapBLGCBjePLkKTAq04npBEIm4v5QeVwHnoIh+Jcts9S7Ffaz
        jDY/xOw6OdxyZ8oi2WhXy96JaOEek9C5S3wUD7Rq8lwI5H6k6xbw9pIV/uYb8HC2jZqEAp
        W1mzTK3F7n1Wo8buHM5V5YPBLlAaUoQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A40BAF3E;
        Tue, 19 Jan 2021 12:26:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 04/13] btrfs: Fix paramter description in delayed-ref.c functions
Date:   Tue, 19 Jan 2021 14:26:40 +0200
Message-Id: <20210119122649.187778-5-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119122649.187778-1-nborisov@suse.com>
References: <20210119122649.187778-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fixes the following warnings:

fs/btrfs/delayed-ref.c:80: warning: Function parameter or member 'fs_info' not described in 'btrfs_delayed_refs_rsv_release'
fs/btrfs/delayed-ref.c:80: warning: Function parameter or member 'nr' not described in 'btrfs_delayed_refs_rsv_release'
fs/btrfs/delayed-ref.c:128: warning: Function parameter or member 'fs_info' not described in 'btrfs_migrate_to_delayed_refs_rsv'
fs/btrfs/delayed-ref.c:128: warning: Function parameter or member 'src' not described in 'btrfs_migrate_to_delayed_refs_rsv'
fs/btrfs/delayed-ref.c:128: warning: Function parameter or member 'num_bytes' not described in 'btrfs_migrate_to_delayed_refs_rsv'
fs/btrfs/delayed-ref.c:174: warning: Function parameter or member 'fs_info' not described in 'btrfs_delayed_refs_rsv_refill'
fs/btrfs/delayed-ref.c:174: warning: Function parameter or member 'flush' not described in 'btrfs_delayed_refs_rsv_refill'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-ref.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 353cc2994d10..ab8c11f05dca 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -70,8 +70,9 @@ int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 
 /**
  * btrfs_delayed_refs_rsv_release - release a ref head's reservation.
- * @fs_info - the fs_info for our fs.
- * @nr - the number of items to drop.
+ *
+ * @fs_info:  the fs_info for our fs.
+ * @nr:  the number of items to drop.
  *
  * This drops the delayed ref head's count from the delayed refs rsv and frees
  * any excess reservation we had.
@@ -115,9 +116,10 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 
 /**
  * btrfs_migrate_to_delayed_refs_rsv - transfer bytes to our delayed refs rsv.
- * @fs_info - the fs info for our fs.
- * @src - the source block rsv to transfer from.
- * @num_bytes - the number of bytes to transfer.
+ *
+ * @fs_info: the fs info for our fs.
+ * @src:  the source block rsv to transfer from.
+ * @num_bytes: the number of bytes to transfer.
  *
  * This transfers up to the num_bytes amount from the src rsv to the
  * delayed_refs_rsv.  Any extra bytes are returned to the space info.
@@ -163,8 +165,8 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 
 /**
  * btrfs_delayed_refs_rsv_refill - refill based on our delayed refs usage.
- * @fs_info - the fs_info for our fs.
- * @flush - control how we can flush for this reservation.
+ * @fs_info: the fs_info for our fs.
+ * @flush:  control how we can flush for this reservation.
  *
  * This will refill the delayed block_rsv up to 1 items size worth of space and
  * will return -ENOSPC if we can't make the reservation.
-- 
2.25.1


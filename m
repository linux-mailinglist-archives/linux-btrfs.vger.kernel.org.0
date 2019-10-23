Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E06E12A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 09:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbfJWHE7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 03:04:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732481AbfJWHE7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 03:04:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32FA8B435
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 07:04:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Remove btrfs_bio::flags member
Date:   Wed, 23 Oct 2019 15:04:47 +0800
Message-Id: <20191023070447.6899-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This member is not used by any one, just remove it.

And since it's between two pointers, such removal should save us a
pointer size of the structure.

Furthermore, if we just want to know the block group profile, we have
btrfs_bio::map_type, which is much better than this ambiguous member.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7f6aa1816409..5ab2920b0c1f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -331,7 +331,6 @@ struct btrfs_bio {
 	u64 map_type; /* get from map_lookup->type */
 	bio_end_io_t *end_io;
 	struct bio *orig_bio;
-	unsigned long flags;
 	void *private;
 	atomic_t error;
 	int max_errors;
-- 
2.23.0


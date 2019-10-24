Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9461E27C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 03:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404928AbfJXBig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 21:38:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:34764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbfJXBig (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 21:38:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1AA3B4B0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 01:38:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: Remove btrfs_bio::flags member
Date:   Thu, 24 Oct 2019 09:38:29 +0800
Message-Id: <20191024013829.17931-1-wqu@suse.com>
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

The last user of btrfs_bio::flags is removed in commit 326e1dbb5736
("block: remove management of bi_remaining when restoring original
bi_end_io").

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Mention the when last user of btrfs_bio::flags is removed.
- Don't mention btrfs_bio::map_type in commit message.
  Since btrfs_bio::flags is for another purpose, it has nothing to do
  with btrfs_bio::map_type.
---
 fs/btrfs/volumes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a7da1f3e3627..5acf5c507ec2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -330,7 +330,6 @@ struct btrfs_bio {
 	u64 map_type; /* get from map_lookup->type */
 	bio_end_io_t *end_io;
 	struct bio *orig_bio;
-	unsigned long flags;
 	void *private;
 	atomic_t error;
 	int max_errors;
-- 
2.23.0


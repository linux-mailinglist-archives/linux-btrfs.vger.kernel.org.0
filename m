Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B0E30051
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfE3QqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 12:46:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:34854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbfE3QqE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 12:46:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46F91AFF9
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2019 16:46:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5131DDA85E; Thu, 30 May 2019 18:46:57 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use file:line format for assertion report
Date:   Thu, 30 May 2019 18:46:56 +0200
Message-Id: <20190530164656.7085-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The filename:line format is commonly understood by editors and can be
copy&pasted more easily than the current format.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 504589647290..b89e595689d4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3527,8 +3527,7 @@ __cold
 static inline void assfail(const char *expr, const char *file, int line)
 {
 	if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
-		pr_err("assertion failed: %s, file: %s, line: %d\n",
-		       expr, file, line);
+		pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
 		BUG();
 	}
 }
-- 
2.21.0


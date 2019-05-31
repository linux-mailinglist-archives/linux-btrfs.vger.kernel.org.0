Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8B3133D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEaRAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 13:00:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:60012 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaRAf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 13:00:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6945DAD6F
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2019 17:00:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 235BFDA85E; Fri, 31 May 2019 19:01:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/5] btrfs: assert delayed ref lock in btrfs_find_delayed_ref_head
Date:   Fri, 31 May 2019 19:01:28 +0200
Message-Id: <2486e63872673c042972a57ad015928f600c4984.1559321947.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559321947.git.dsterba@suse.com>
References: <cover.1559321947.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Turn the comment about required lock into an assertion.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-ref.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index a73fc23e2961..a94fae897b3f 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -957,13 +957,14 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 }
 
 /*
- * this does a simple search for the head node for a given extent.
- * It must be called with the delayed ref spinlock held, and it returns
- * the head node if any where found, or NULL if not.
+ * This does a simple search for the head node for a given extent.  Returns the
+ * head node if found, or NULL if not.
  */
 struct btrfs_delayed_ref_head *
 btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs, u64 bytenr)
 {
+	lockdep_assert_held(&delayed_refs->lock);
+
 	return find_ref_head(delayed_refs, bytenr, false);
 }
 
-- 
2.21.0


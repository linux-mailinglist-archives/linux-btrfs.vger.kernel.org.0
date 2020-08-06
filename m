Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4642223D74A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Aug 2020 09:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHFH3V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Aug 2020 03:29:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgHFH3T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Aug 2020 03:29:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B2D1ADB3
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Aug 2020 07:29:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: update the stability and performance status of quota
Date:   Thu,  6 Aug 2020 15:29:06 +0800
Message-Id: <20200806072906.358641-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are a lot of enhancement to btrfs quota through v5.x releases.

Now btrfs quota is more stable than it used to be.

So update the man page to relect this.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-quota.asciidoc | 43 +++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/btrfs-quota.asciidoc b/Documentation/btrfs-quota.asciidoc
index 85ebf729c2fa..1c032f11d001 100644
--- a/Documentation/btrfs-quota.asciidoc
+++ b/Documentation/btrfs-quota.asciidoc
@@ -23,16 +23,47 @@ PERFORMANCE IMPLICATIONS
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 When quotas are activated, they affect all extent processing, which takes a
-performance hit. Activation of qgroups is not recommended unless the user
-intends to actually use them.
+performance hit.
+
+Under most cases, the performance hit should be more or less acceptable for
+root fs usage.
+
+There used to be a huge performance hit for balance with quota enabled.
+That problem is solved since v5.4 kernel.
 
 STABILITY STATUS
 ~~~~~~~~~~~~~~~~
 
-The qgroup implementation has turned out to be quite difficult as it affects
-the core of the filesystem operation. Qgroup users have hit various corner cases
-over time, such as incorrect accounting or system instability. The situation is
-gradually improving and issues found and fixed.
+Btrfs quota has different stablity for different functionality:
+
+Extent accounting
+^^^^^^^^^^^^^^^^^
+
+Pretty stable, there aren't many bugs (if any) affecting the extent accounting
+through v5.x release cycles.
+
+Thus if users just want referenced/exclusive usage of each subvolume, it
+should be safe to use.
+
+Limit
+^^^^^
+
+Should be near stable since v5.9.
+
+There used to be some bugs causing early EDQUOT errors before v5.9.
+But v5.9 should solve them quite well, along with extra safe nets catching any
+reserved space leakage.
+
+Corner cases and small fixes may pop up time by time, but the core limit
+functionality should be in good shape since v5.9.
+
+Multi-level qgroups
+^^^^^^^^^^^^^^^^^^^
+
+Needs more testing. Although the core extent accounting should also work well
+for higher level qgroups, we don't have good enough test coverage yet.
+
+Thus extra testing and bug reports are welcomed.
 
 HIERARCHICAL QUOTA GROUP CONCEPTS
 ---------------------------------
-- 
2.28.0


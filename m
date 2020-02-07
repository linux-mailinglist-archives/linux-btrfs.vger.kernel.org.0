Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3B31554DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgBGJjM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 04:39:12 -0500
Received: from mail.synology.com ([211.23.38.101]:60862 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbgBGJjM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 04:39:12 -0500
From:   ethanwu <ethanwu@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1581068349; bh=yHM7AQ19opYeeJxP9mcqOgXIcW08MB4niZ3uoj7neWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Dqx7g135KMxpDYCuWoVT+qa2VemepN1z/GlrjbsEWJVTPKVPwsuH0PrUHV/y5wrCq
         SQbZ7hw7UbYgBp8MhK3CaYUkzWm5cUEGrpm++aBmZKUYOUifOdpT1B+cJuQxjQrrSY
         7TtsSAlb7glRnoIQ56It1GMW5/wVmKOC5GJCAvqU=
To:     linux-btrfs@vger.kernel.org
Cc:     ethanwu <ethanwu@synology.com>
Subject: [PATCH 3/4] btrfs: backref, only search backref entries from leaves of the same root
Date:   Fri,  7 Feb 2020 17:38:17 +0800
Message-Id: <20200207093818.23710-4-ethanwu@synology.com>
In-Reply-To: <20200207093818.23710-1-ethanwu@synology.com>
References: <20200207093818.23710-1-ethanwu@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We could have some nodes/leaves in subvolume whose owner are not the
that subvolume. In this way, when we resolve normal backrefs of that
subvolume, we should avoid collecting those references from these blocks.

Signed-off-by: ethanwu <ethanwu@synology.com>
---
 fs/btrfs/backref.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index b4b68af48726..7e2e647ec846 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -443,11 +443,13 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 	 *    slot==nritems.
 	 * 2. We are searching for normal backref but bytenr of this leaf
 	 *    matches shared data backref
+	 * 3. The leaf owner is not equal to the root we are searching
 	 * For these cases, go to the next leaf before we continue.
 	 */
 	eb = path->nodes[0];
 	if (path->slots[0] >= btrfs_header_nritems(eb) ||
-		is_shared_data_backref(preftrees, eb->start)) {
+		is_shared_data_backref(preftrees, eb->start) ||
+		ref->root_id != btrfs_header_owner(eb)) {
 		if (time_seq == SEQ_LAST)
 			ret = btrfs_next_leaf(root, path);
 		else
@@ -466,9 +468,12 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 
 		/*
 		 * We are searching for normal backref but bytenr of this
-		 * leaf matches shared data backref.
+		 * leaf matches shared data backref. OR
+		 * The leaf owner is not equal to the root we are searching
 		 */
-		if (slot == 0 && is_shared_data_backref(preftrees, eb->start)) {
+		if (slot == 0 &&
+		    (is_shared_data_backref(preftrees, eb->start) ||
+		     ref->root_id != btrfs_header_owner(eb))) {
 			if (time_seq == SEQ_LAST)
 				ret = btrfs_next_leaf(root, path);
 			else
-- 
2.17.1


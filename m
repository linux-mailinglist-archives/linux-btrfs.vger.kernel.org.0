Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62615A25E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgBLHrD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:47:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:41038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbgBLHrD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:47:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 74B53AB95
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 07:47:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Add comment for BTRFS_ROOT_REF_COWS
Date:   Wed, 12 Feb 2020 15:46:51 +0800
Message-Id: <20200212074651.33008-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This bit is being used in too many locations while there is still no
good enough explaination for how this bit is used.

Not to mention its name really doesn't make much sense.

So this patch will add my explanation on this bit, considering only
subvolume trees, along with its reloc trees have this bit, to me it
looks like this bit shows whether tree blocks of a root can be shared.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 36df977b64d9..61ab6e8c9a18 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -971,6 +971,15 @@ enum {
 	 * is used to tell us when more checks are required
 	 */
 	BTRFS_ROOT_IN_TRANS_SETUP,
+
+	/*
+	 * Whether tree blocks of a root can be shared.
+	 *
+	 * All subvolume trees, and their reloc trees, have this bit set.
+	 *
+	 * While all other trees, including essential trees like root, csum,
+	 * extent, chunk trees, and log trees don't have this bit set.
+	 */
 	BTRFS_ROOT_REF_COWS,
 	BTRFS_ROOT_TRACK_DIRTY,
 	BTRFS_ROOT_IN_RADIX,
-- 
2.25.0


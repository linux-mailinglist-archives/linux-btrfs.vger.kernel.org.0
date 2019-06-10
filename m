Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2E83B505
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2019 14:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbfFJM3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 08:29:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:46878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389001AbfFJM3A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 08:29:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A330AE48
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 12:28:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E918ADA867; Mon, 10 Jun 2019 14:29:48 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 3/6] btrfs: document BTRFS_MAX_MIRRORS
Date:   Mon, 10 Jun 2019 14:29:48 +0200
Message-Id: <4232edc0e74874203db470d99855ad5508bd5841.1559917235.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559917235.git.dsterba@suse.com>
References: <cover.1559917235.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The real meaning of that constant is not clear from the context due to
the target device inclusion.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fb7435533478..31198499f175 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -46,7 +46,16 @@ struct btrfs_ref;
 
 #define BTRFS_MAGIC 0x4D5F53665248425FULL /* ascii _BHRfS_M, no null */
 
-#define BTRFS_MAX_MIRRORS 3
+/*
+ * Maximum number of mirrors that can be available for all profiles counting
+ * the target device of dev-replace as one. During an active device replace
+ * procedure, the target device of the copy operation is a mirror for the
+ * filesystem data as well that can be used to read data in order to repair
+ * read errors on other disks.
+ *
+ * Current value is derived from RAID1 with 2 copies.
+ */
+#define BTRFS_MAX_MIRRORS (2 + 1)
 
 #define BTRFS_MAX_LEVEL 8
 
-- 
2.21.0


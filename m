Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677C83489F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCYHPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 03:15:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhCYHP0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 03:15:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616656525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Oooa8vclbzVAq1az0XFOyb+rSSQGFzmtjqYPGdN2Ug=;
        b=uLYozO6Cti0hvjmIVrjX+KvSkKVlAiJXIGUWerN51HnGUQf/d/Xi7PvR9261F59WpUiyp5
        DK7DX1cBAGow8COyt1lsx3FS1mHQ5NXszpnEragHgw6mjYLuS2H55o3+Eo1Gpw0UXLxYdp
        25ZZnslFXp4hLIwgqCL1Vqcou4QQL6E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43D04AA55
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Mar 2021 07:15:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 13/13] btrfs: add subpage overview comments
Date:   Thu, 25 Mar 2021 15:14:45 +0800
Message-Id: <20210325071445.90896-14-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325071445.90896-1-wqu@suse.com>
References: <20210325071445.90896-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will add an overview for how btrfs subpage support,
including:

- Limitations
- Behaviors
- Basic implementation points

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 2a326d6385ed..c35db695886b 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -1,5 +1,59 @@
 // SPDX-License-Identifier: GPL-2.0
 
+/*
+ * Subpage (sectorsize < PAGE_SIZE) support for btrfs overview:
+ *
+ * Limitation:
+ * - Only support 64K page size yet
+ *   This is to make metadata handling easier, as 64K page would ensure
+ *   all nodesize would fit inside one page, thus we don't need to handle
+ *   cases where a tree block crosses several pages.
+ *
+ * - Only metadata read-write yet
+ *   The data read-write part is under heavy tests, while still have several
+ *   bugs remaining.
+ *
+ * - Metadata can't cross 64K page boundary
+ *   btrfs-progs and kernel has done such behavior for a while, thus only
+ *   ancient btrfs could have such problem.
+ *   For such case, btrfs will do a graceful rejection.
+ *
+ * Special behaviors:
+ * - Metadata
+ *   Metadata read is fully subpage.
+ *   Meaning when reading one tree block will only trigger the read for the
+ *   needed range, other unrelated range in the same page will not be touched.
+ *
+ *   Metadata write is partial subpage.
+ *   The writeback is still for the full page, but btrfs will only submit
+ *   the dirty extent buffers in the page.
+ *
+ *   This means, if we have a metadata page like this:
+ *   Page offset
+ *   0         16K         32K         48K        64K
+ *   |/////////|           |///////////|
+ *        \- Tree block A        \- Tree block B
+ *
+ *   Even if we just want to writeback tree block A, we will also writeback
+ *   tree block B if it's also dirty.
+ *
+ *   This may cause extra metadata writeback which results more COW.
+ *
+ * Implementation:
+ * - Common
+ *   Both metadata and data will use an new structure, btrfs_subpage, to
+ *   record the status of each sector inside a page.
+ *   This provides the extra granularity needed.
+ *
+ * - Metadata
+ *   Since we have multiple tree blocks inside one page, we can't rely on page
+ *   locking anymore, or we will have greatly reduced concurrency or even
+ *   deadlock (hold one tree lock while try to lock another tree lock in the
+ *   same page).
+ *
+ *   Thus for metadata locking, subpage support relies on io_tree locking only.
+ *   This means a slightly more tree locking latency.
+ */
 #include <linux/slab.h>
 #include "ctree.h"
 #include "subpage.h"
-- 
2.30.1


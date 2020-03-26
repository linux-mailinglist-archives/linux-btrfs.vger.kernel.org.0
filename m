Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10D11937EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 06:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgCZFgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 01:36:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgCZFgH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 01:36:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62D7CAC51;
        Thu, 26 Mar 2020 05:36:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org, Marek Behun <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v2 2/3] fs: btrfs: Reject fs with sector size other than PAGE_SIZE
Date:   Thu, 26 Mar 2020 13:35:55 +0800
Message-Id: <20200326053556.20492-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326053556.20492-1-wqu@suse.com>
References: <20200326053556.20492-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although in theory u-boot fs driver could easily support more sector
sizes, current code base doesn't have good enough way to grab sector
size yet.

This would cause problem for later LZO fixes which rely on sector size.

And considering that most u-boot boards are using 4K page size, which is
also the most common sector size for btrfs, rejecting fs with
non-page-sized sector size shouldn't cause much problem.

This should only be a quick fix before we implement better sector size
support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Cc: Marek Behun <marek.behun@nic.cz>
---
 fs/btrfs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2dc4a6fcd7a3..b693a073fc0b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -7,6 +7,7 @@
 
 #include "btrfs.h"
 #include <memalign.h>
+#include <linux/compat.h>
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN	\
 				 | BTRFS_HEADER_FLAG_RELOC	\
@@ -232,6 +233,13 @@ int btrfs_read_superblock(void)
 		return -1;
 	}
 
+	if (sb->sectorsize != PAGE_SIZE) {
+		printf(
+	"%s: Unsupported sector size (%u), only supports %u as sector size\n",
+			__func__, sb->sectorsize, PAGE_SIZE);
+		return -1;
+	}
+
 	if (btrfs_info.sb.num_devices != 1) {
 		printf("%s: Unsupported number of devices (%lli). This driver "
 		       "only supports filesystem on one device.\n", __func__,
-- 
2.26.0


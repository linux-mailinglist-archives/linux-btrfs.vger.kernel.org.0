Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21F79CE7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfHZLsm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:48:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbfHZLsj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18FEAAFCB
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:38 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 1/4] btrfs: turn checksum type define into a enum
Date:   Mon, 26 Aug 2019 13:48:31 +0200
Message-Id: <20190826114834.14789-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190826114834.14789-1-jthumshirn@suse.de>
References: <20190826114834.14789-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Turn the checksum type definition into a enum. This eases later addition
of new checksums.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/uapi/linux/btrfs_tree.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 71246c1941aa..b65c7ee75bc7 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -300,7 +300,9 @@
 #define BTRFS_CSUM_SIZE 32
 
 /* csum types */
-#define BTRFS_CSUM_TYPE_CRC32	0
+enum btrfs_csum_type {
+	BTRFS_CSUM_TYPE_CRC32	= 0,
+};
 
 /*
  * flags definitions for directory entry item type
-- 
2.16.4


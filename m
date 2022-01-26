Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B06749C5C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 10:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiAZJEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 04:04:10 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42199 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiAZJEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 04:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643187849; x=1674723849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=buyDLja0gBK2FizwtvRYNsG8yQHYxk4n0K99c+xIbl4=;
  b=dJNDUall10JgFlpeog7h1nXsfmwE/22pxl1r07mivBA+YdQfBD9S1OWr
   Kr+Jwykt2HJCZfvJC8C1TAkjL5iEaVnYihd0CZOOye26yhfxpKBv9DYCR
   elle4820aI4f7UJaNAfzueRejG7fYsBbZToI1zoA6O3cYTNdapAUh1PjF
   L+Lngeoif5i2oDQszO94KQaPYHyUUxcoxgEwJy68FLTl0fbqv8cy6+Sq/
   9iE/nzuZ6MEKftpoKq2KPi40DEXp1mk+fJl6HDzOmvVCeLh5fi2W5YEFU
   cXQ/eQsAV1dwBDkcYYWQnqjWMatz3GKvx1XwO1sKsrpveJYc+LgtTiB+r
   A==;
X-IronPort-AV: E=Sophos;i="5.88,317,1635177600"; 
   d="scan'208";a="190359872"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2022 17:04:09 +0800
IronPort-SDR: MfEdpfWuG8+bs3YIup4UN1lIQY/PrUs5csf90GjLFMOUbYYqntbcMuHOcXTKUe2pTNshtL1cE3
 8TM8VaBFUdiwp39P8FZcP3ZyXm9N/D55lGEMe9VvJCCiXLs76ykNgKKQGbLdmGjlwedyszjjJu
 9C1RLSKaB74F8xIat4kPbu7LqR2hsxl0jqS3DgO/cVSW7n9KzPtuh/NrMrXlFxyXjgd0SdQNnf
 NLti+PRMoWZty8BTj0OlVHnUBrueWALVUGIWBzOIGL5CZ5AcsYwSwF3xBEcF3OQHziNmlA7CHb
 QVJP8pVO8qnxxvIbQKhLVTeV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 00:36:14 -0800
IronPort-SDR: oTiMdo2rNrOx7psKKrwqU1kgIjfP4DhwP3FGuY0Yf9y7LzLxBy/K2LIDLIRFAUgQnqUhIbVVh3
 X4p+P5fNmXh7wjGjZalMgEaprQy4NKs29edJdV984poNAPlVZKLBkzrejtbrIB603+z9uRWNf4
 MXED/37w2eXR6njWOBDeedCbqSC/OsGFhXlQ3hon+6bIq9xruXd7EsEOsRVX5NzQq4jbUFuBhS
 5XRstin3aJi5Q9a4AFwrc+MFdBQCUI02EZObmFLri8B6AAvnWBY+Vet7gxj5hJVYo1TOeD9ywR
 sPk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2022 01:04:09 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: zoned support DUP on metadata block groups
Date:   Wed, 26 Jan 2022 01:04:03 -0800
Message-Id: <20220126090403.57672-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220126090403.57672-1-johannes.thumshirn@wdc.com>
References: <20220126090403.57672-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Support using BTRFS_BLOCK_GROUP_DUP on metadata (and system) block groups.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 kernel-shared/zoned.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index e6fd4b31b9d6..f9f55626115e 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -808,14 +808,20 @@ out:
 	return ret;
 }
 
-bool profile_supported(u64 flags)
+bool profile_supported(u64 map_type)
 {
-	flags &= BTRFS_BLOCK_GROUP_PROFILE_MASK;
+	bool data = (map_type & BTRFS_BLOCK_GROUP_DATA);
+	u64 flags = (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK);
 
 	/* SINGLE */
 	if (flags == 0)
 		return true;
-	/* non-single profiles are not supported yet */
+
+	/* We can support DUP on meta-data */
+	if (!data && (flags & BTRFS_BLOCK_GROUP_DUP))
+		return true;
+
+	/* All other profiles are not supported yet */
 	return false;
 }
 
-- 
2.31.1


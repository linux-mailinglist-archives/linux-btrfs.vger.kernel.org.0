Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2655400172
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbhICOqM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:46:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12660 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349135AbhICOqJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630680310; x=1662216310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Ohw8+ybSIjVsjs5LzNsaXBrxLTuHbJ9sIJFja805HI=;
  b=Ybk6+y7s53MB2iR58aprpx45JqW3XPvOXczg7MK+RMV7nam4i5u/XVhv
   4gMXDvVaElKeu9NnWYo3i9PWC1d975YdBjSq/FPFOshcWgazbFdUR1RV4
   0WVIHegcRlTkjwasbXluQPAjLnNglcaDQ1/8yaN9NSlVeoEMzozj7vSWS
   IFX3ofDIZNMcAQPe9fRkMu6a80ZHpwqiycwSUSTn7QHCy7o8hK4vWwjnZ
   /jbYSiVKvjK4gt3SbqCao8TN9mvJukrUAd66ywb1Zx5apTY0Y2zT1++nP
   elGuLW4jkI4U4NHxdOae4RRZXagvWs+9UGPipRwmO88BxWA70IU4msRor
   w==;
X-IronPort-AV: E=Sophos;i="5.85,265,1624291200"; 
   d="scan'208";a="179681189"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2021 22:45:10 +0800
IronPort-SDR: 1lQk6pd0v+EGDQG1zpJYcN+s0Mo/RPYM7TnYQi8a3SxhV8oXZzgcBFLwVpRszPgjuv5I5WzQI7
 /IzhgoFNOp/J7m0b8zlrEK4Ef640hjAUGHtXUicP1xM0YuOgRvbUvhLWLdR7t/6qTZ79QWCGqo
 OG4bxIxlx/cRiAlJyQ7E0+CZRJhyGykkyafvrIdZ1rtNJvMvSoRNuJrwYcG4YUtANB7g5SqUH7
 2kgqVoQBitlZ9a/QOBHceTJ+wqRWSe+8Q9jHn60w0/rzXJ+M8Xrf/91Xy0CeMTIELDhqairjq7
 0qSITCVd5NDw0WW3EI0p4vey
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:20:12 -0700
IronPort-SDR: Am02pkSW4UFvIuJEFHD/qmYeCH6jxeszT5E1QTPI+9ui15jC4U0h456ddzwGT5hS5xt6Pxt9Gy
 ctUsTlioknOmTygiHDRGsSidLYjNROP20Semi5rPok5gZbH12Q2llfpU6it5z71l2lVdep7jfl
 1IPAymEY3iIqvfcJpmBGr4DJESG3Dpw/lns0oFS7Uh1G8sEpdsgGMQgZUZzwSAdmMJCEoVZTkw
 oF77xICqDoLIZD/OwrSVFno+hpMta3JB5dWn2tKJ/W2pdr34RxHT18jpR3QaBlnI0LPmpf144s
 4ow=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2021 07:45:08 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 6/6] btrfs: rename setup_extent_mapping in relocation code
Date:   Fri,  3 Sep 2021 23:44:47 +0900
Message-Id: <87ead9c989e3d09804d9d210f16075a4930eab07.1630679569.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630679569.git.johannes.thumshirn@wdc.com>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs we have two functions called setup_extent_mapping, one in
the extent_map code and one in the relocation code. While both are private
to their respective implementation, this can still be confusing for the
reader.

So rename the version in relocation.c to setup_relocation_extent_mapping.
No functional change otherwise.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 6f668bc01cd1..bf93e11b6d4e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2880,8 +2880,8 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 }
 
 static noinline_for_stack
-int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
-			 u64 block_start)
+int setup_relocation_extent_mapping(struct inode *inode, u64 start, u64 end,
+				    u64 block_start)
 {
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_map *em;
@@ -3080,7 +3080,7 @@ static int relocate_file_extent_cluster(struct inode *inode,
 
 	file_ra_state_init(ra, inode->i_mapping);
 
-	ret = setup_extent_mapping(inode, cluster->start - offset,
+	ret = setup_relocation_extent_mapping(inode, cluster->start - offset,
 				   cluster->end - offset, cluster->start);
 	if (ret)
 		goto out;
-- 
2.32.0


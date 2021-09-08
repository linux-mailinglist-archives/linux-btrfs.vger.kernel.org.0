Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97B9403D7F
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349283AbhIHQVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:21:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349216AbhIHQU7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117991; x=1662653991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Ohw8+ybSIjVsjs5LzNsaXBrxLTuHbJ9sIJFja805HI=;
  b=mJ0qPmYNbs877/7nWX2UZg8mSlgiY4/rLgVw0AjBToDW7yRQ0IdIZsmr
   EzILKk5ra4Rz97ekITsHRGt+ZqgR91z8tEH7wx5PBj92iYSSnmiH7/4Fh
   D1G+0VvTWDceLdMRar18hLXlp3Q7ehuDJgL2Dc584XDU78tfrfu7ZtuG7
   enXtBA6uoosHHkON2lw9iYfRUMOVHyfHP/lx/TbjNP4Pu6ChqJaVPsVum
   kk7jI5YH6WUo8FS1tTd3VLp0HbhqEsOATLG5SmiuuUAodsMFS4F9o2Gq8
   fbP5kS5NGaXFO38ZrL+P6VJj/207riNlhNq/kz9ZzYqW8B3d5rq+kiPFY
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493950"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:50 +0800
IronPort-SDR: 5R2wNYTffDQGQaHZaS/2K0iVD9+bJ2RQ1wnvFiD9qxyGhxW9dwYzHHGJrYrZRep8sIQeE1ECeP
 rMTuY8C2o101if0kQTUPQrXfSoQGjwQIho5+TPd3kL88LhgwIcK+Ei0KCcW2hmla0OayEKDU9r
 zWGUum9q1KNpQYb8JitT6ulLSXRPBisix6dwI7BNI5yMTQLDb6RFg3T/sVGUTQ/FxrcBdrK3L3
 8wErq1HEztgPzA98Dk58ds72OBhA2tNVPx4tHa5sHeWN51cFW6e8d2GeCl6xA8rFRepAIZ+vjw
 Xdfi5xcrLhpOqoRCnVpU0HjZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:48 -0700
IronPort-SDR: Mbh3OstPmfJ6A9kjTN8K9cmyr4+V9bexrTLypD5LtJzdOCyzUGfx2Ax4McaNuIP6neWK4JoLTQ
 U9taTlP7C8H/BxS+YB1ZlJ6sjcWnvK8jS9gaNqQootHLRtsG4U7g0s2V4z5wjDxpKwmIuSauuj
 mBUA7gtkBtGvB0sAqDboniC+iG5GOj4Z1iJ5k6DeI5tzp3jUNSDON60fYkzyVtg3KA56QZfFFh
 gFywf31yvkGoWTSgO6MLfjAKeqTfMAnoPaJXqeq5n+RuHLCrvpEX34nnWTJ1/IIy4ThhClLf4t
 J7I=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:51 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 7/8] btrfs: rename setup_extent_mapping in relocation code
Date:   Thu,  9 Sep 2021 01:19:31 +0900
Message-Id: <564a5ffba7fd303ee5d6330dbb36326fbfb1981d.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
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


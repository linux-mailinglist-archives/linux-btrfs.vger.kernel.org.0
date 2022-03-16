Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44874DB22F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351602AbiCPOKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352804AbiCPOKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 10:10:38 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FA4D623
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647439764; x=1678975764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+jZp1mel7Nc/JPEAlj08v7gIYU1Um1djZWu1JJgWLI8=;
  b=kLfJtMSpAJs+1gedp6UhVWR+VXHF+MqY5aPlX7nbbeTewAlFyr4yPjtV
   nrLMLxrftEnr4COR2+WiYzJyaFrueJqZ3zRAWkkeT7IsUwmHfh59REbO/
   TWbtothsSDNgJVfSeZ5MKLofPH7E/MjBviqb96jN+XWkZWYuh6ymrorOe
   WEzzFKjB/riWu+f5uAfIuQ3bfI+bRGhlf2e5czhN5K0xH4HOmafyoUre6
   Eub0wdtHGthNROPvT6KJbQu5wlM3euitk2ucNF/PrzuYsDaGGXGKttLrz
   uylDJ+hI4RtJUOPaf+P0wtMQAyOz9gk6okjK+5YciJS7HD9Iy+ndpR7CW
   A==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="196448087"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 22:09:24 +0800
IronPort-SDR: j0jXG9Au0KcdfQUWt8j54ut27RLRJq10oEjYqVw+jng6OH9NtEafiSXN/YHYz2cZFoDuskZIZf
 1MK3Rbv4avZwbDaXGx60xRDpJN3u/RL1VD3UU+scFko3osPj6yFkDkStkzoaMTpDJxpXPKKEoi
 iDqjohkXPIJZ/k1cRP+/DAqJzZXLUEpZ7qydbWBdDTYMOUQvTx4MzarUctkSiEG0FeVDJFf5MT
 E1ikAnnc+wIQdEHCpGXdJX2X/76x9w6FGYIypm5bLk2WU/Pp7Hw4j+ZybEo0zCKN/FDw9R2lMD
 Jx7OnOR327b1VkMx/+5iHve2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 06:40:28 -0700
IronPort-SDR: rL807EC4zy4Jdtu1IvGZV3IjNJR3iDtofX93QiTjJapy42iMT+i0/iM2IX5CZ62HsqtuS++zdg
 e866HFtWYoqMOVWe/7cjQ7VigF/xsKUFY38klZafP6RJQGC0eC9Iy+kbT3AWVZMKjaeXn8YgJm
 RGSzMYMJq+ZYM6YjGilHbAOnKcJuU37c4re3DUyLaQK99iYMYcs4QRE11hFI1i0duRjL/sN6Cq
 MiFRI9LeKUi5kiwmaJ9dsXSnQT9KnJoRsd9YVeI17ihPwoyeJX3ZuoW4zuNERa6j2i7Ja4zXHE
 5ZM=
WDCIronportException: Internal
Received: from d2bbl13.ad.shared (HELO naota-xeon.wdc.com) ([10.225.55.209])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Mar 2022 07:09:21 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/2] btrfs: return allocated block group from do_chunk_alloc()
Date:   Wed, 16 Mar 2022 23:09:11 +0900
Message-Id: <c7d1b9109dd0c4c94eed22321c3c25f1aed7646f.1647437890.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647437890.git.naohiro.aota@wdc.com>
References: <cover.1647437890.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Return the allocated block group from do_chunk_alloc(). This is a
preparation patch for the next patch.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 59f18a10fd5f..d4ac1c76f539 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3433,7 +3433,7 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
-static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
+static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 {
 	struct btrfs_block_group *bg;
 	int ret;
@@ -3520,7 +3520,11 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
 out:
 	btrfs_trans_release_chunk_metadata(trans);
 
-	return ret;
+	if (ret)
+		return ERR_PTR(ret);
+
+	btrfs_get_block_group(bg);
+	return bg;
 }
 
 /*
@@ -3635,6 +3639,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_space_info *space_info;
+	struct btrfs_block_group *ret_bg;
 	bool wait_for_alloc = false;
 	bool should_alloc = false;
 	int ret = 0;
@@ -3728,9 +3733,14 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 			force_metadata_allocation(fs_info);
 	}
 
-	ret = do_chunk_alloc(trans, flags);
+	ret_bg = do_chunk_alloc(trans, flags);
 	trans->allocating_chunk = false;
 
+	if (IS_ERR(ret_bg))
+		ret = PTR_ERR(ret_bg);
+	else
+		btrfs_put_block_group(ret_bg);
+
 	spin_lock(&space_info->lock);
 	if (ret < 0) {
 		if (ret == -ENOSPC)
-- 
2.35.1


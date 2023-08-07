Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E155772A3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHGQMx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjHGQMw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:52 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B626F9
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424771; x=1722960771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y9F4/2b7B6y7uANBCszkRR+x1t0pFNhnUBGzLLPhKKU=;
  b=ps0Dcbo29vbZvDbsP31QnJ6P1HjY5fU9W5wf/mTQFv77pBW6rkKrG3Yq
   RjQFkQs28x7ARxT1XwuoCzILfZ70XpWShfwJeH8m53N7IihijLhnjh/1z
   nKT3NCPw5BxMwA/731TS8thlJ01b0TAMIKdhuisG1DytPbH4W/jvcLvW1
   xbL8mpoWh5sVejbMP6dEgbpz6t9xwAmbaTq2cKVXlkaodNBxPScChpaEm
   qPdCyHBwHFNKOJWDweCSpp3jvZQt7w+Tcqi4sDPTeYvaxHHtIp8gKoLJI
   uMz/usN0NecTsYDVFF8F7RRzk2UaAa3X5JMdvdNQkD9QGUHUgv4I7oRBi
   A==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240710995"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:51 +0800
IronPort-SDR: 0TFohbFnPbqxe4CXMUOozDPxqQRASL3TB7ulS/oiEzCxOLztjrhFRh1ycT8VXgEOZyZsRA7pqK
 5WyOt0ZbRTMGMlUPjbU5G3ts47oBvPy2DqK+1ZZuoZ4Nt+IO3IsF0LtlJ+ugW7pM1D30Q1xVOb
 SvI/8rUKNANBgj6sMAhSp9yWSvVCNxlkdg0l9PJhl8M1xRH6E42iAs5j7Ce4UedTkDCDnXBON3
 0Qa6WAqu0jbw2qaIT10Lr8Vnk7UEDPzITf/Xws07TUBPVV0t6UTeHOIeSnC7HTSz/S9++NvU8v
 HfY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:20 -0700
IronPort-SDR: WNvew3zBecp8CGMD/dwe2Dk8ZfJ8atpEHj2dVskKXmKcz2cGKwCITQcWa9xt7Tp1oMABPzxfIK
 vKyZUSChYGXctOzvvaJCNV3yBHer5FpLPlxfLkKSre4Rpi9PeP3MzNekj+bAxiACKJjPOx6T7z
 NTWVN1c+1nQP2Gyg282i3+cDyJ/ZFTwU/LRfVL2kohqBWfUTmL4BsvA+dBrpjqyozELTmHpDp9
 D345eVaQ9lCh8HE+HjeBfMToQ16kk7OUYUSqo33VnNNVcMHacYq7NX3Yggz3Lja/dhctPcc6vO
 R+E=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:51 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 05/10] btrfs: zoned: update meta_write_pointer on zone finish
Date:   Tue,  8 Aug 2023 01:12:35 +0900
Message-ID: <5af45dfa56b6dca2189d2cd03c6a1ff526a155e6.1691424260.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On finishing a zone, the meta_write_pointer should be set of the end of the
zone to reflect the actual write pointer position.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3f56604bdaef..fd1458049b18 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2056,6 +2056,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 
 	clear_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
 	block_group->alloc_offset = block_group->zone_capacity;
+	if (block_group->flags & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM))
+		block_group->meta_write_pointer = block_group->start +
+			block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
 	btrfs_clear_treelog_bg(block_group);
 	btrfs_clear_data_reloc_bg(block_group);
-- 
2.41.0


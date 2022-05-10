Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FA95224FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 21:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiEJTnu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 15:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiEJTns (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 15:43:48 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4092297D6
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 12:43:46 -0700 (PDT)
Received: from LT2ubnt.fritz.box (ip-062-143-094-109.um16.pools.vodafone-ip.de [62.143.94.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0AA503F212;
        Tue, 10 May 2022 19:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652211824;
        bh=l/18fW1038Vux2vA0RjcrkK428VKlopqwAlUHLoi6V4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=n+r8rakjyFLhl891q6Gd7V0LWkvwt8JDFIFeXtL7D/l21ui41TN+RBtIP2DQbT56n
         rgBQZhmxpZdUmFS/OsWGqPaI/oI61172QtNfi2YUksfwTjx8MGatxPFUYARxijPClV
         iU4jeu7eoqoVCTctnCl9GfeM4UdYTPTPihFjp2uE8iKfOyU84bS1WaDi5+QDeiTstD
         d+PZK+Yog2wwLBej9veYXScA+aLxaIXfwNBwl9/08V0lNPS/V74NZ06TxepYKULnRF
         tmlliId8gd5sSvQs6OOokYWegX0K/MOzWz/6yj3ND1dPDQC03sm1qiHEvrlVbdnBGc
         56//FfDONFckA==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] btrfs: simplify lookup_data_extent()
Date:   Tue, 10 May 2022 21:43:38 +0200
Message-Id: <20220510194338.24881-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After returning if ret <= 0 we know that ret > 0. No need to check it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/btrfs/inode.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d00b515333..0173d30cd8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -546,15 +546,12 @@ static int lookup_data_extent(struct btrfs_root *root, struct btrfs_path *path,
 	/* Error or we're already at the file extent */
 	if (ret <= 0)
 		return ret;
-	if (ret > 0) {
-		/* Check previous file extent */
-		ret = btrfs_previous_item(root, path, ino,
-					  BTRFS_EXTENT_DATA_KEY);
-		if (ret < 0)
-			return ret;
-		if (ret > 0)
-			goto check_next;
-	}
+	/* Check previous file extent */
+	ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		goto check_next;
 	/* Now the key.offset must be smaller than @file_offset */
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 	if (key.objectid != ino ||
-- 
2.34.1


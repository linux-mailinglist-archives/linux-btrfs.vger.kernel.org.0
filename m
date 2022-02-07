Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4344AC258
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiBGPDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 10:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbiBGOjH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Feb 2022 09:39:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1FEC0401C1
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 06:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 779C5B8125D
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 14:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8D1C340F0
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644244744;
        bh=bPnSGZ8/6cI+sQMctwfZG9DX3CO1c6Y2Zr46yYFpVO8=;
        h=From:To:Subject:Date:From;
        b=NTQBjh6Gx1bT0A5oJdJp1FoPfeHDooTBmU8m4LE3iZkCNJ+BJOUI4XrAsVnDFeX3k
         TpRYII/DppZV3+X9L9Cc/qhrVcRM6WnqinepPRVh3dEf//43yG7FLrSHWkh+pBJFPG
         KOzBgJZZhI80Lqx3FBTRHbIkeW6nHthjssagKiavRRRrlvxhTeMIIciudf5A6gtHNV
         25ZANG02NOtV23Ol5sykSdIyGlUL2os4LWcW10x2E75ej8DQUje4+iXbCzUwOWgAfY
         NqUASVfWSeTuAXiajKVmtTLdCH5ljzgRBHLidS0d9AOBSzdsSfQO8sK+fV5AtmzNIM
         FbWp9Q8vBo0Ew==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix missing log mutex unlock after failure to log inode
Date:   Mon,  7 Feb 2022 14:39:00 +0000
Message-Id: <b98e09dd2c88d71e92ebcfd083dc5687d53b9006.1644244472.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Before starting to log an inode, we check if the inode was logged before
by calling inode_logged(). If we get an error from that call, we jump
to the 'out' label, which results in returning from btrfs_log_inode()
without unlocking the inode's log mutex. Fix that by jumping to the
'out_unlock' label instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

This is meant to be applied on top of:
"btrfs: avoid inode logging during rename and link when possible", which
is only on misc-next, not on Linus' tree yet.

David, can you fold it into that patch? Or I can send a new version
of the series. Thanks.

 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e9b6eba7c42d..a483337e8f41 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5720,7 +5720,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 	 */
 	ret = inode_logged(trans, inode, path);
 	if (ret < 0)
-		goto out;
+		goto out_unlock;
 	ctx->logged_before = (ret == 1);
 	ret = 0;
 
-- 
2.33.0


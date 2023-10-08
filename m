Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9C7BCB2B
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Oct 2023 02:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjJHAwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 20:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjJHAwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 20:52:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9402738;
        Sat,  7 Oct 2023 17:51:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D5BC116AB;
        Sun,  8 Oct 2023 00:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726258;
        bh=DmB7PwNeVaJXOtoW4WnOeidz7LG20wOuun6mr2crmog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWJXJrqgTiJTT462tcmM0WOWUBmoZylAS8GglXGD65/pCUyfyA30/JaAkMizi4KEp
         QjAVz5UatJnOXDxcrtEUDngyGAUpN5tDXzx7fbtYVdKvGaNGxqY9BAjEwEbpDXL/Xh
         ZAerbWYyHPfXzA6pv/AJyZ1hgnJBsDeYy0CBLbeoLWCnVGCB4NHqMo6H5JK0jE7/Am
         R8OhJt4cfiKtfBTHOgeyYn/3JhT2srvsuEtJCMHhamlmGRvWkIuoHa9YBIDkWYSwo9
         Sx4bLdcZuPMHaZYPbU1tj7oKtjXGZvN++jxMRqbO+i8sLCDPB97qAuBF3jUAIHoi25
         2Uw+7JYn/0AcQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/7] btrfs: initialize start_slot in btrfs_log_prealloc_extents
Date:   Sat,  7 Oct 2023 20:50:48 -0400
Message-Id: <20231008005053.3768625-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005053.3768625-1-sashal@kernel.org>
References: <20231008005053.3768625-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.326
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit b4c639f699349880b7918b861e1bd360442ec450 ]

Jens reported a compiler warning when using
CONFIG_CC_OPTIMIZE_FOR_SIZE=y that looks like this

  fs/btrfs/tree-log.c: In function ‘btrfs_log_prealloc_extents’:
  fs/btrfs/tree-log.c:4828:23: warning: ‘start_slot’ may be used
  uninitialized [-Wmaybe-uninitialized]
   4828 |                 ret = copy_items(trans, inode, dst_path, path,
	|                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4829 |                                  start_slot, ins_nr, 1, 0);
	|                                  ~~~~~~~~~~~~~~~~~~~~~~~~~
  fs/btrfs/tree-log.c:4725:13: note: ‘start_slot’ was declared here
   4725 |         int start_slot;
	|             ^~~~~~~~~~

The compiler is incorrect, as we only use this code when ins_len > 0,
and when ins_len > 0 we have start_slot properly initialized.  However
we generally find the -Wmaybe-uninitialized warnings valuable, so
initialize start_slot to get rid of the warning.

Reported-by: Jens Axboe <axboe@kernel.dk>
Tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2407a231d9ad4..f73a1438a6ac1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4191,7 +4191,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int slot;
 	int ins_nr = 0;
-	int start_slot;
+	int start_slot = 0;
 	int ret;
 
 	if (!(inode->flags & BTRFS_INODE_PREALLOC))
-- 
2.40.1


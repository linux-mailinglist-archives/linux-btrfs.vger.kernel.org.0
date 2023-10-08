Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7757BCB0E
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Oct 2023 02:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjJHAvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 20:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjJHAvX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 20:51:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA1610C6;
        Sat,  7 Oct 2023 17:50:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A67C43140;
        Sun,  8 Oct 2023 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726230;
        bh=EkHoCInJwksWFH4F14Ao5+S5PAaPJwPimOj1qvbbhLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vb4uVprR4c5BHTfNLkrlZHsrauYjluAS9cvaLwOXHjb8uio2MuE1BfPOH0TQReJzh
         mwwzhQKoyzwyr90vNkK20rZPnyTkEUZlhKb5kdVTSikYzIKwGZ43c0P5WlRdg2Nhx4
         J8v6NHBFYadc/V267xnx8Fgcihe+AgwnJC1HUhBicwL/xAwJW9Q3wWDotAmwc35ak+
         5bzsxYcLi32Nhq5bfFOUBMm1HJYBm4lS6qCW64Ybp4FWmBsRCkCobtLBW2etvsNDq0
         GP9RMOy1mZ7FpRLMZm+vJWxLGwx0rRNtVKYql5rG1HsoVtFF1vNIh1Ob3I6DSmVvds
         TC2eYB9zEY5Ug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/8] btrfs: initialize start_slot in btrfs_log_prealloc_extents
Date:   Sat,  7 Oct 2023 20:50:19 -0400
Message-Id: <20231008005024.3768418-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005024.3768418-1-sashal@kernel.org>
References: <20231008005024.3768418-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.257
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
index 926b1d34e55cc..f75333d7b78a5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4283,7 +4283,7 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	int slot;
 	int ins_nr = 0;
-	int start_slot;
+	int start_slot = 0;
 	int ret;
 
 	if (!(inode->flags & BTRFS_INODE_PREALLOC))
-- 
2.40.1


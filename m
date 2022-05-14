Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9B5270F8
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 May 2022 14:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiENMBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 May 2022 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiENMBg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 May 2022 08:01:36 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C138B9
        for <linux-btrfs@vger.kernel.org>; Sat, 14 May 2022 05:01:33 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id pqSgnpJ0Kpmc6pqShnl8Uu; Sat, 14 May 2022 14:01:32 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 14 May 2022 14:01:32 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Fix an error handling path in btrfs_read_sys_array()
Date:   Sat, 14 May 2022 14:01:29 +0200
Message-Id: <d915ceb4d459aff89c0264113db21592a6806db1.1652517184.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If alloc_dummy_extent_buffer() we should return an error code, not 0 that
would mean success.

Fixes: a1fc41ac28d3 ("btrfs: use dummy extent buffer for super block sys chunk array read")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b2d5a54ea172..9c20049d1fec 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7359,7 +7359,7 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	 */
 	sb = alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET);
 	if (!sb)
-		return PTR_ERR(sb);
+		return -ENOMEM;
 	set_extent_buffer_uptodate(sb);
 
 	write_extent_buffer(sb, super_copy, 0, BTRFS_SUPER_INFO_SIZE);
-- 
2.34.1


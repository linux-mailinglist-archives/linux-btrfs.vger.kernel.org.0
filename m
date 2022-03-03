Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58BB4CBC82
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 12:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiCCL0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 06:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiCCL0q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 06:26:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA7D155C3C
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 03:26:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BC87B824E9
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 11:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A294C340EF
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646306758;
        bh=ocgvhSTOR6hg4bKXLixKY+R3JUh62swB5BNlBkua8qQ=;
        h=From:To:Subject:Date:From;
        b=o4/l95gC317USv13QwmtfpJCVXq37nyztC5w5hq7/2RogtexuIwhXDGFv2iHImdUT
         xRO6mYKJsWevROKnfUJIPStiEgQBYipzn5NtnBYQln/DduCibg8sMylkRWMmJcm5yr
         /mapKkmTdksqA8WTuhLZk3dzsnYNys3901qdvLCsBsmraQb831neFZyGfJGw1CxE+9
         4O3E+vW0FgkCbAaA+0HxodW7iXlD/B3xSlrEkITNU7LHZzIj8AVwtNbtQGfGWSixUK
         iI2/SoU1iYO71Md2oLhNmQofLYuF+EfGRpCBlgXBv9dQd+qr/wOt4U3DHizWl0kZUY
         3eyDb47d3yxpQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix a NULL pointer dereference during device scan
Date:   Thu,  3 Mar 2022 11:25:55 +0000
Message-Id: <f0a7cc9b024432855337990f471b91054504cc92.1646306515.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At device_list_add(), we dereference a device's name inside a
btrfs_info_in_rcu() that is executed in a branch that can be triggered
when the device's name field is NULL, which obviously results in a NULL
pointer dereference as rcu_str_deref() tries to access the ->str
attribute of a NULL pointer to a struct rcu_string.

Fix that by not dereferencing the name if it's NULL, and instead print
the string "<unknown>".

Link: https://lore.kernel.org/linux-btrfs/00000000000066b78e05d94df48b@google.com/
Reported-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa7fee09e39b..f662423fbeb7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -940,7 +940,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			}
 			btrfs_info_in_rcu(device->fs_info,
 	"devid %llu device path %s changed to %s scanned by %s (%d)",
-					  devid, rcu_str_deref(device->name),
+					  devid, device->name ?
+					  rcu_str_deref(device->name) :
+					  "<unknown>",
 					  path, current->comm,
 					  task_pid_nr(current));
 		}
-- 
2.33.0


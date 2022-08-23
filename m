Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056FF59E65A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiHWPtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 11:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbiHWPtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 11:49:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1EE12C434
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 04:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6E2FB81CCF
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 11:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8544DC433D7;
        Tue, 23 Aug 2022 11:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661255154;
        bh=0mLq45u8hAqqmWepsmurbU6mJ9Eite/dXJDaoubv1io=;
        h=From:To:Cc:Subject:Date:From;
        b=L37Zd+kOvFUt8McqrKjN1eoZ+mfUy7TmdS2u5+HupcAE39Ig9k/2Ia2MxQRzOXmmn
         zNAFyw9YN/ggFoyPqurLZtAsSsRyuRI2Ql82jBWJSdghuy0ny6t+2Gm/FWsRV8PZ/d
         XdLp/fE7+R0ZnOA/nGulWH0VsfDybdbUPRN4oK/m5M71pzRGMeaC6+jrkJnvu2mA9E
         CLTm8SCPk0na3W9BJMSilnIerBoIsurTNkSl1+B/Kc9WWiDJOyafgaS1IwWXtH02AW
         Paq+v8WzyegmVx/i+xSsM/lQjY2Tlw6ma8Rs7XldfsO+zo+l9N7Y0vcHaTeA0Usaoe
         WiYdZoYJD08jQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     yebin10@huawei.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: fix race between quota enable and quota rescan ioctl
Date:   Tue, 23 Aug 2022 12:45:42 +0100
Message-Id: <a95c38a253bedfa00d073e120a2599faa0f8139d.1661254155.git.fdmanana@suse.com>
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

When enabling quotas, at btrfs_quota_enable(), after committing the
transaction, we change fs_info->quota_root to point to the quota root we
created and set BTRFS_FS_QUOTA_ENABLED at fs_info->flags. Then we try
to start the qgroup rescan worker, first by initalizing it with a call
to qgroup_rescan_init() - however if that fails we end up freeing the
quota root but we leave fs_info->quota_root still pointing to it, this
can later result in a use-after-free somewhere else.

We have previously set the flags BTRFS_FS_QUOTA_ENABLED and
BTRFS_QGROUP_STATUS_FLAG_ON, so we can only fail with -EINPROGRESS at
btrfs_quota_enable(), which is possible if someone already called the
quota rescan ioctl, and therefore started the rescan worker.

So fix this by ignoring an -EINPROGRESS and asserting we can't get any
other error.

Reported-by: Ye Bin <yebin10@huawei.com>
Link: https://lore.kernel.org/linux-btrfs/20220823015931.421355-1-yebin10@huawei.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index db723c0026bd..ba323dcb0a0b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1174,6 +1174,21 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
 		fs_info->qgroup_rescan_running = true;
 	        btrfs_queue_work(fs_info->qgroup_rescan_workers,
 	                         &fs_info->qgroup_rescan_work);
+	} else {
+		/*
+		 * We have set both BTRFS_FS_QUOTA_ENABLED and
+		 * BTRFS_QGROUP_STATUS_FLAG_ON, so we can only fail with
+		 * -EINPROGRESS. That can happen because someone started the
+		 * rescan worker by calling quota rescan ioctl before we
+		 * attempted to initialize the rescan worker. Failure due to
+		 * quotas disabled in the meanwhile is not possible, because
+		 * we are holding a write lock on fs_info->subvol_sem, which
+		 * is also acquired when disabling quotas.
+		 * Ignore such error, and any other error would need to undo
+		 * everything we did in the transaction we just committed.
+		 */
+		ASSERT(ret == -EINPROGRESS);
+		ret = 0;
 	}
 
 out_free_path:
-- 
2.35.1


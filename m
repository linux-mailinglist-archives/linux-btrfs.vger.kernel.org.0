Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA42B66CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 15:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgKQOGy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Nov 2020 09:06:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47164 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgKQNHJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Nov 2020 08:07:09 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kf0hM-00087K-NP; Tue, 17 Nov 2020 13:07:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: fix spelling mistake "inititialize" -> "initialize"
Date:   Tue, 17 Nov 2020 13:07:04 +0000
Message-Id: <20201117130704.420088-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a btrfs_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4402dcb00cb5..70633fafff54 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3310,7 +3310,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	ret = btrfs_check_zoned_mode(fs_info);
 	if (ret) {
-		btrfs_err(fs_info, "failed to inititialize zoned mode: %d",
+		btrfs_err(fs_info, "failed to initialize zoned mode: %d",
 			  ret);
 		goto fail_block_groups;
 	}
-- 
2.28.0


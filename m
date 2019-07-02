Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0165D13E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGBOMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 10:12:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53199 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfGBOMQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jul 2019 10:12:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hiJUL-00016H-48; Tue, 02 Jul 2019 14:10:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: fix memory leak of path on error return path
Date:   Tue,  2 Jul 2019 15:10:28 +0100
Message-Id: <20190702141028.11566-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if the allocation of roots or tmp_ulist fails the error handling
does not free up the allocation of path causing a memory leak. Fix this by
freeing path with a call to btrfs_free_path before taking the error return
path.

Addresses-Coverity: ("Resource leak")
Fixes: 5911c8fe05c5 ("btrfs: fiemap: preallocate ulists for btrfs_check_shared")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1eb671c16ff1..d7f37a33d597 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4600,6 +4600,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	tmp_ulist = ulist_alloc(GFP_KERNEL);
 	if (!roots || !tmp_ulist) {
 		ret = -ENOMEM;
+		btrfs_free_path(path);
 		goto out_free_ulist;
 	}
 
-- 
2.20.1


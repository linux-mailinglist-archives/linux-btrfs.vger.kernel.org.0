Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8583CD384
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhGSKaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236234AbhGSKaa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E8436108B;
        Mon, 19 Jul 2021 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693070;
        bh=qNhbnO0VWX/6D4T+zgjTmjl3LP3DUGsO0RSESM4YihA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8tRzLJfQUKgNFB22IGVnPBkyt1VqonOONuDEw2EtLcOvT6+o12tDBGRxfXfPbJgT
         JEdhqw4dqOZK1OBn3SvEyRiHwzx+4xAfOUp1t2zjFpeaVaU/sVbEMWEdCeMFfYjjZ+
         V1TgGIuK1z7a2ANaf8Q4z9Oab5D3R3hmJExZBpVHLdsIXaF3aMFsBNo/QiT35Xr/9Y
         kHkDIbrwh/CsnjAz3PMx85onyi8dISiqwwAE2n5StHaCujk5BMCmDl1mF7sZbUsqRt
         AL8BTxa7d+WlF1qsSUssADZoZgCI67nOCXECGta3yhruBXlKXZBGbIw+/4KViw0pDr
         9cEQGLevCRQYg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 04/21] btrfs/inode: allow idmapped getattr iop
Date:   Mon, 19 Jul 2021 13:10:35 +0200
Message-Id: <20210719111052.1626299-5-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; h=from:subject; bh=cQVCA+o4p9p+j6MuVDM6PxlYmBDNqjbRk309Wy8Chs4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd0SueDzg8IzHMuNq83SJtj35U057G52tG3BnA9NS8Xi Xlm0dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE4TQjw3++zvsHTCdYzLZSXuduaL bkuuomU9UHZyV63qjffe4iOY2R4eu3bSUCiS7bvav4D73bGdtnUHr0jd9zpVmPjhmeNTygzwwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_getattr() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6e4e9f4fbdf3..9b345af1c3e0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9195,7 +9195,7 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP);
 
-	generic_fillattr(&init_user_ns, inode, stat);
+	generic_fillattr(mnt_userns, inode, stat);
 	stat->dev = BTRFS_I(inode)->root->anon_dev;
 
 	spin_lock(&BTRFS_I(inode)->lock);
-- 
2.30.2


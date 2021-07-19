Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270083CD38C
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhGSKau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236619AbhGSKar (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86FE961181;
        Mon, 19 Jul 2021 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693087;
        bh=nMTMNxyJcEo9K1ozLBMPSdFnOdaMIeQIOWxmveqYTrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Quww9GjPZYJwfxx/DXote/Ek//DMiq49PWm/Jx6OKRkIFcrbidZIKDtEVCmZUMMYm
         oLCNMxHfXLZ8YI5baAhWoMFb8wF31ceIuO+1U8BF4KoVRF6FVUCQhG/dBR8YMHX9Or
         66pUofXCwKLXXsR2w9cHfcrW32sJLHiyupGREDuQGteK/3JJgToZLSKTwkRiev0GSQ
         zIExotK4wOJ66h2vulXH5372Avzh8Yv3slCp2qO40Xlqq+Qu9kw/Kz+dy5c7FtZMhx
         rFQ2TiXIeWywPCC1DLvKHITRmrBNXijSkxM+gZh64xH+kimIZjWpTaM1z13YxzWwad
         H3FeT5lyGwLxg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 11/21] btrfs/inode: allow idmapped permission iop
Date:   Mon, 19 Jul 2021 13:10:42 +0200
Message-Id: <20210719111052.1626299-12-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; h=from:subject; bh=UB3qI906TzplOANkGHMYQ0hDC06vJuELU9QDNAzTHgU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd129eGVWL4nt7QXNd0P+BNZI3YgyI3/6Mx167n8+38z Ly4t7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIswLD/5y+q3oNFzMPWfyo+7L3TK Uje/vL+40O21c9Fzhg03mpei/DXxmN+JuVrKtvXX7rviyf4WXX0TyTfcmLXpb/k3xW6Wq1mRcA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_permission() to handle idmapped mounts. This is just a matter of
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
index 53b038029440..a2a36a45998e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10274,7 +10274,7 @@ static int btrfs_permission(struct user_namespace *mnt_userns,
 		if (BTRFS_I(inode)->flags & BTRFS_INODE_READONLY)
 			return -EACCES;
 	}
-	return generic_permission(&init_user_ns, inode, mask);
+	return generic_permission(mnt_userns, inode, mask);
 }
 
 static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
-- 
2.30.2


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8FF3D73B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhG0Ku5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236431AbhG0Kuz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B8386135A;
        Tue, 27 Jul 2021 10:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383055;
        bh=W8n859/SRlGQ7exT3uSV5aE2VA+wYWi1b4nP9t7In+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mhchuf1og1/Tluz5Fc2+/0o4S+vSmgqSoE8JUOZLDr9ss8HCfxmRKrwKGQcQjl+ny
         JYgTqcKw92Bsp0qI4yy4fkOjpkFjBTMK4vS7kBti6upqy6gRMeFCp01USttWxZdE3G
         47BDcOJDmQ2MwZZnDyLAQHb2opqmgofUjocg3tBBk7Q30ItppY+NoxoqTDfw8Y+Gdx
         FFGaOqD7unavSeuzqJbLREVRjr1PO4LuNOlzVF92tNMqzAarcOkLDcE+/3pdOaI37L
         Y6ER/c6jRGUIqhRouSV87d6xnLF1Gk8cy/jpnW9bvlVFryKY1B4qpiAYcoHO1oXqSD
         Tt9qvX6Zsg76A==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 11/21] btrfs/inode: allow idmapped permission iop
Date:   Tue, 27 Jul 2021 12:48:50 +0200
Message-Id: <20210727104900.829215-12-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; h=from:subject; bh=7QZtZ22YWM5l3X750lvv/oKj3lzulOrOb1OJQSL0Ewg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzIl/+Wtn+br2dVvfu5w3zYhpLJsLedn6WVmvnll798d 3uLp3FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR5kmMDJNy/zNn+wh8PTn/3UW/8t SjqbpKqkKGt3TWyhseWcWiZsLwv3j2m+IQp4OF0qz5dRN4Vuu7b3Awmb/nefOEVdwTAme2MgEA
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged

/* v4 */
unchanged
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2d9717861a6b..5e0b8e394ae1 100644
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


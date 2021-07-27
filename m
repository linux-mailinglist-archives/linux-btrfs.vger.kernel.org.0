Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E53D73AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhG0Kuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbhG0Kup (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:50:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C55976135A;
        Tue, 27 Jul 2021 10:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383045;
        bh=JlWbVPDY7Emg9MPciE0A72YP7Zxo6ca/9CS/YxtNWcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISHhUbw6ShGuzElWuOHZpW6HnG0AEjWR67LDBNRRfZhjAOQKWp0jX08kFPlKTMud8
         RAMWW7hbnGAaYWqlSPwc3coDDERb5Q8z7E2fskbNP+ruf6nJ2l/eFqYi/fAD3hDge+
         ZzfWZaxmZeojK2tHbY+qS67sisG2Q1+a1l/nvERAyP8euwHyCuSEvRDb1fFw4wiUsc
         tJ6tqZkM7fm2FEqe5egElWI9bMu4rfO+PRqmsB4wJcJKoUeyWZ9pV2MM/+JKV5Fk1f
         P3RohXqc2dPgb+iHhNnyom4Ikxn92wppBqSTsv4rPuVZ5pGH2kvvi8AVTl8gmduM9K
         esczo4hHUR1VQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 07/21] btrfs/inode: allow idmapped mkdir iop
Date:   Tue, 27 Jul 2021 12:48:46 +0200
Message-Id: <20210727104900.829215-8-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; h=from:subject; bh=PQ4iDIDeI5TxtGz3xTVWKJXns4+ldNh8A1UA4gyrxBk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzLZ2nDfU5aWK1Ov/1m5YbP6O9HaOezFR8QSU0Nf7xB/ 8NE1rKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi0zUY/ukoft0/ZcrpBpv9KVEn8k uLjv15aNprcXkb5ze+owcjdXYw/C/hmLbSOfyJ66QHPS8PlKesT9ygVjTz0AkVNc0XkimCMhwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_mkdir() to handle idmapped mounts. This is just a matter of
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
index ffbb995de590..bb50e21a4569 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6874,7 +6874,7 @@ static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_fail;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir,
 			dentry->d_name.name, dentry->d_name.len,
 			btrfs_ino(BTRFS_I(dir)), objectid,
 			S_IFDIR | mode, &index);
-- 
2.30.2


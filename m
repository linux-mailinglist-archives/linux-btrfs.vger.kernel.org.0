Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3238947E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbhESROk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbhESROj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 13:14:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA382C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 10:13:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o27so13424167qkj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/g6vwxbPWDNevkeajUbinjQOrBAUer1ObIW8M7SqF0=;
        b=WoDI6Bc6muLDXJCDxq5EXUplXdCXXQMfDz8wsT6pa62Uhb7GPaU6iYyOnK0OQHCIZK
         zFfnJfnLAB3b6/oanki16ofmSCozIEdR0QwWhKw4O0TQUWQjfgyGoIUXn9/rN0DFsWl6
         LHmbpBFNly6lBfVnF/MfzNrn2biWiPab0QR2noSVhXDX125uKNLomVe4xaONG6G0cmTs
         mk7VZH68p8do+RRjjWCPp2un6ENVsguyb38/nEe+ATR1VlxQhw6EGj3rm730pA5aIDAr
         rE25o6xipmxIoFX8a6Ak/s3UT0llxWXzM9vZUHwSxbOIPDU16ev8rPbCbm4s0KZXDK55
         Hl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/g6vwxbPWDNevkeajUbinjQOrBAUer1ObIW8M7SqF0=;
        b=jUDKKgX5CEjKdgeXXwDE/8R1VeAJSnWuNwGR/YsichDnLkX1hcNBSQ9qibWR4wrlsP
         nfGvArUFp6VUMtATvnWkMI5Tyw3SDAdaRLOBJGewtLSnXZPia1UkRFX7Z52KgfKNU1D5
         ujmhZIxN2DVIctjyXOf8Kp2nUlyLIw/pmecCBQiCp2nLY4LeppPLzWU3L1R+ILH5pdMR
         3Hn4fBXFhysiqX2vr6weFdnEWDcq+KIgh7e1DVrpMau2IAprL+DVQmSgo7lpIi0dDWpT
         7p1+mdVfYXZT1cQ/BDTWk3Gy+Bml1jZwvfC5uAtyGr77oldBGK+NhJJUMHriDYvGsNXz
         +o8A==
X-Gm-Message-State: AOAM530WZzn+higAWDcAZl6vE7tOraLsODyfJ2r/NY1Rns3uwQerv4pE
        pg+1hb5z2ZTMDJWaqi1NcFD3PYqbp/uxUQ==
X-Google-Smtp-Source: ABdhPJw2CGtNIKbDUYzsGonxKQgZ+DBz2nsBozetWwSafqa7AiE74hHseClNbH33FdEggSmu2KpDyg==
X-Received: by 2002:a05:620a:574:: with SMTP id p20mr450018qkp.70.1621444396801;
        Wed, 19 May 2021 10:13:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c14sm20009qtw.42.2021.05.19.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:13:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fixup error handling in fixup_inode_link_counts
Date:   Wed, 19 May 2021 13:13:15 -0400
Message-Id: <3490883fc4ea908bcefbf2507ba4c7235c2464e4.1621444381.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function has the following pattern

	while (1) {
		ret = whatever();
		if (ret)
			goto out;
	}
	ret = 0
out:
	return ret;

However several places in this while loop we simply break; when there's
a problem, thus clearing the return value, and in one case we do a
return -EIO, and leak the memory for the path.

Fix this by re-arranging the loop to deal with ret == 1 coming from
btrfs_search_slot, and then simply delete the

	ret = 0;
out:

bit so everybody can break if there is an error, which will allow for
proper error handling to occur.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 18009095908b..f8f708c02462 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1778,7 +1778,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 					    struct btrfs_root *root,
 					    struct btrfs_path *path)
 {
-	int ret;
+	int ret = 0;
 	struct btrfs_key key;
 	struct inode *inode;
 
@@ -1791,6 +1791,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 			break;
 
 		if (ret == 1) {
+			ret = 0;
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
@@ -1803,17 +1804,19 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_del_item(trans, root, path);
 		if (ret)
-			goto out;
+			break;
 
 		btrfs_release_path(path);
 		inode = read_one_inode(root, key.offset);
-		if (!inode)
-			return -EIO;
+		if (!inode) {
+			ret = -EIO;
+			break;
+		}
 
 		ret = fixup_inode_link_count(trans, root, inode);
 		iput(inode);
 		if (ret)
-			goto out;
+			break;
 
 		/*
 		 * fixup on a directory may create new entries,
@@ -1822,8 +1825,6 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 		 */
 		key.offset = (u64)-1;
 	}
-	ret = 0;
-out:
 	btrfs_release_path(path);
 	return ret;
 }
-- 
2.26.3


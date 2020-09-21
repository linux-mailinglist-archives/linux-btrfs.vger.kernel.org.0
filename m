Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111B5273295
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 21:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgIUTNX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 15:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIUTNX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 15:13:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE05C061755;
        Mon, 21 Sep 2020 12:13:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so13978613wrr.4;
        Mon, 21 Sep 2020 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPi1IscOmPCDTsGEXayQqIEZk0OLwEPpIOImWgP4cnQ=;
        b=bnj1JHq7CcAGVKoKWOfIh+tsUynbNk25F6tBjfR2b7ExNP9P3sPNDyyFOlV53LMkcU
         OtcZyoh+5k+zdWgFqCZLq1hlEP7T6vNBO5eCAksb9FzrElsiEViZ2yB5VL0f684DDq7b
         ARsRJf05ILNP9eqxtEGyRcc8a6fX+O3/xyaAHoR5BjAU+ScuqXK8Ekjs1RDTkSz5Utke
         785ruqM/npzdW3xwJ6BS+eriz2YIM+AiE8N75ICc+S9mwHvLz6qwkKb1Gua5QJ1R0vgh
         y3Y+USuwmL3DfmA0KzQYDSpmev9MDtGa/fEeGcCCQBI4U2OQFnHEOz1hlz8CLDc2bQqP
         XO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPi1IscOmPCDTsGEXayQqIEZk0OLwEPpIOImWgP4cnQ=;
        b=o+JDlkWsBjGB/RItsqMsIXoaWULccm/mDOEcyc8S3LC7aa1h3ei4wvrOLzKCJRfUZK
         K5wdnvH1CCG8acXlYdynEppKNSHzFatKSdW872+MBBrbriarIMC4BXxzmARlSA9hI5P/
         tNWvrhMEAa1g+Iws+WKjOnPkZUhA+hhTBOctS6n6lxsO8J+vLoTO3D7smZYwlLOXzoZO
         OuI757U94Ba6Z7Ab3ptfIwKOePWCDkhFwEr5CfdAjsaMd5H1uPzF1uccZ52SbroxyQaY
         x1KbAFhEjniGdtWAt2Av9vHo0JzJr5N82B3ygMXMtjTjeINPjcVAfHS4PMA8cqfw3Fn2
         X5Kg==
X-Gm-Message-State: AOAM532bnop/6OC4RhV5bqXik7MtJQL8c+QwytZ4l1eWeXDby25eLgqO
        dZEPX4H7eo5j6FnFz0eX00w=
X-Google-Smtp-Source: ABdhPJxvfPxZM/4oUFnZ0MvIM9LiFCHrzJweXb63DAr++LmDEgMfMhW3R4OIuoyfgW8omvxEmzXGHA==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr1282186wrs.19.1600715601388;
        Mon, 21 Sep 2020 12:13:21 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id z83sm874068wmb.4.2020.09.21.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 12:13:20 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <a.dewar@sussex.ac.uk>
Cc:     Alex Dewar <a.dewar@sussex.ac.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Fix potential null pointer deref
Date:   Mon, 21 Sep 2020 20:12:44 +0100
Message-Id: <20200921191243.27833-1-a.dewar@sussex.ac.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_destroy_inode(), the variable root may be NULL, but the check
for this takes place after its value has already been dereferenced to
access its fs_info member. Move the dereference operation to later in
the function.

Fixes: a6dbd429d8dd ("Btrfs: fix panic when trying to destroy a newly allocated")
Addresses-Coverity: CID 1497103: Null pointer dereferences (REVERSE_INULL)
Signed-off-by: Alex Dewar <a.dewar@sussex.ac.uk>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a5dae53c1e27..8f230b7bfe65 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8648,7 +8648,6 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
 	struct btrfs_root *root = inode->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	WARN_ON(!hlist_empty(&vfs_inode->i_dentry));
 	WARN_ON(vfs_inode->i_data.nrpages);
@@ -8673,7 +8672,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
 		if (!ordered)
 			break;
 		else {
-			btrfs_err(fs_info,
+			btrfs_err(root->fs_info,
 				  "found ordered extent %llu %llu on inode cleanup",
 				  ordered->file_offset, ordered->num_bytes);
 			btrfs_remove_ordered_extent(inode, ordered);
-- 
2.28.0


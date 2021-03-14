Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCCD33A789
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Mar 2021 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhCNStu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Mar 2021 14:49:50 -0400
Received: from smtp26.services.sfr.fr ([93.17.128.215]:35348 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhCNSt1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Mar 2021 14:49:27 -0400
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by msfrf2639.sfr.fr (SMTP Server) with ESMTPS id 3DE011C03A869
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Mar 2021 19:49:16 +0100 (CET)
X-mail-filterd: 1.0.0
X-sfr-mailing: LEGIT
X-sfr-spamrating: 40
X-sfr-spam: not-spam
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=neuf.fr; s=202006;
 t=1615747756; h=From:To:Cc:Subject:Date:In-Reply-To:References; bh=uVD7n1IWj
  Lfc3YS4tm35F+yYmm3y4jTHDf+OYPglIjY=; b=mv2YRsGC88a5ANBmvJK/6p7tpUHTF5uhrlSNG
  VIGekJW0Bm5/1dJI/oZLedcZTwZWi2/ejw0eDtMTBha8DZeWLFQRbCHkxpva+eMDGfRvyarncqBz
  OoKFKDQJtWzGKzThALfA7lJSW7EBtpO6YE27Bp0A+UOlj4/P34DGtYQ6HmzqqT5SfCgY2wO8U4a9
  ijAR4G2ZPkY+J0F08dcDMSuE7NO0rmY2C5miC27n6nAKTsWBBBY4pL4RgSBWJtIzbXzW3GtqiyJW
  Kaxv4w3J+BXd5R9S6sxdbRtdxmx0sP7Hq6mUffaNMzKmZ14TRvfvRavaA0ajE3DGfXGhuSbzs/qE
  w==;
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        by msfrf2639.sfr.fr (SMTP Server) with ESMTP id 179BE1C03A86A
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Mar 2021 19:49:16 +0100 (CET)
Received: from neuf.fr (91-171-27-54.subs.proxad.net [91.171.27.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pierre.labastie@neuf.fr)
        by msfrf2639.sfr.fr (SMTP Server) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Mar 2021 19:49:16 +0100 (CET)
Authentication-Results: sfr.fr; auth=pass (PLAIN) smtp.auth=pierre.labastie@neuf.fr
Received: from pierre by neuf.fr with local (Exim 4.94)
        (envelope-from <pierre@neuf.fr>)
        id 1lLVnf-0001Uj-MX; Sun, 14 Mar 2021 19:49:15 +0100
From:   Pierre Labastie <pierre.labastie@neuf.fr>
To:     linux-btrfs@vger.kernel.org
Cc:     Pierre Labastie <pierre.labastie@neuf.fr>
Subject: [PATCH v2] btrfs-progs: build system: Fix the test for EXT4_EPOCH_MASK
Date:   Sun, 14 Mar 2021 19:49:13 +0100
Message-Id: <20210314184913.5689-1-pierre.labastie@neuf.fr>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <d7b1445f25866bf5c8d5016b7cd7a94e68f67dd8.camel@neuf.fr>
References: <d7b1445f25866bf5c8d5016b7cd7a94e68f67dd8.camel@neuf.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Pierre Labastie <pierre.labastie@neuf.fr>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After sending the first version of the patch, I realized that it
was flawed, because of some formatting by the MUA. It took me
some time to set up an MTA so that git send-email works. Now the
patch should apply cleanly. Please remove the present paragraph by using
git am -c. Apologies for the inconvenience(s).
-- >8 --
Commit b3df561fbf has introduced the ability to convert extended
inode time precision on ext4, but this breaks builds on older distros,
where ext4 does not have the nsec time precision.

Commit c615287cc tried to fix that by testing the availability of
the EXT4_EPOCH_MASK macro, but the test is not complete.

This patch aims at fixing the macro test, and changes the
name of the associated HAVE_ macro, since the logic is reverted.

This fixes #353 when ext4 has nsec time precision. Note that
the test fails when ext4 does not have the nsec time precision.
Maybe the test shouldn't be run in that case?

Issue: #353
Signed-off-by: Pierre Labastie <pierre.labastie@neuf.fr>
---
 configure.ac          | 8 ++++----
 convert/source-ext2.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 612a3f87..dd6a5de7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -251,10 +251,10 @@ else
 AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [0], [We did not define FIEMAP_EXTENT_SHARED])
 fi
 
-HAVE_OWN_EXT4_EPOCH_MASK_DEFINE=0
-AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK], [],
-		[HAVE_OWN_EXT4_EPOCH_MASK_DEFINE=1
-		 AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, probably old e2fsprogs, will use own definition, no 64bit time precision of converted images])])
+AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
+                [AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
+                   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
+		[AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, probably old e2fsprogs, will use own definition, no 64bit time precision of converted images])])
 
 dnl Define <NAME>_LIBS= and <NAME>_CFLAGS= by pkg-config
 dnl
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index bd872086..fb655ec0 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -698,7 +698,7 @@ static void ext2_copy_inode_item(struct btrfs_inode_item *dst,
 	memset(&dst->reserved, 0, sizeof(dst->reserved));
 }
 
-#if HAVE_OWN_EXT4_EPOCH_MASK_DEFINE
+#if HAVE_EXT4_EPOCH_MASK_DEFINE
 
 /*
  * Copied and modified from fs/ext4/ext4.h
@@ -769,7 +769,7 @@ out:
 	return ret;
 }
 
-#else /* HAVE_OWN_EXT4_EPOCH_MASK_DEFINE */
+#else /* HAVE_EXT4_EPOCH_MASK_DEFINE */
 
 static int ext4_copy_inode_timespec_extra(struct btrfs_inode_item *dst,
 				ext2_ino_t ext2_ino, u32 s_inode_size,
@@ -786,7 +786,7 @@ static int ext4_copy_inode_timespec_extra(struct btrfs_inode_item *dst,
 	return 0;
 }
 
-#endif /* !HAVE_OWN_EXT4_EPOCH_MASK_DEFINE */
+#endif /* !HAVE_EXT4_EPOCH_MASK_DEFINE */
 
 static int ext2_check_state(struct btrfs_convert_context *cctx)
 {
-- 
2.30.1


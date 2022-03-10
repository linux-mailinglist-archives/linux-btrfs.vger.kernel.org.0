Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E54D3EC0
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbiCJBc7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbiCJBc6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:32:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033F2127562
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:31:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b8so3875177pjb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0MU99Yu1EcOnek3TeS7+SF+mqhOyT6POCtZbtX4L9A=;
        b=RlKiAYrM7vx/7PWgbtlK08m8aHCSEEbl0oBgiZk7qkqAI99AkZIkHGMGwXYoOqywZI
         9nYj6PReRjUXo00aamykIbnouaDTqLyTW0GdvUITZonJXPb3clHsu83nKxKHal3F/otL
         gfB0AlGwG2uPB633/JLHOGwt2rhFM8wRHhqvbUh9ef8YIj5da2Po0RuDxza+yOuWq5Nq
         RxojFgfjJeGP9OC/BrMlfkVWlJndYoHDWKXmqcIN4r1HYjRKP+2c3vfOqaI4Nss/YOc0
         Q3s3lux7dJ2yHoxJQHEA8CHF1+AyoNaFr+hNfPjKj0+uyTZ9IbE1vu/i1ypB5IGRxkxa
         LUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0MU99Yu1EcOnek3TeS7+SF+mqhOyT6POCtZbtX4L9A=;
        b=R9F9o2fviHhs4ylEloIfFgYUJZJPxbTlSKx7EvLdW7BUaXUcIB5Kq4r7UGOX/N9UsA
         p2rv/TtEhUq1Yr318Jc9WUO0w1cTkQ34aFacUy/ucgwVQLnLNPVC8q9DjleOM3PmgneQ
         uV/+np/Zu97pyQHtLdxSkHvh2Nm4K2jwhfFTsaAUk2ci1QG5GWuXIW4XCd1/kSvZLZbo
         Ds/nrnpOtu9qvVlVD7lEDFKXW/DYHl+gDQscUyQqFFjoXT2CX7OrVMNTvMx1HfPp+JB1
         ZomlVYazHBkH11YfzHmV38ytiwTkh7GL/DS6XIUht3HTmePRRulZuqMbfuPig6xIO9yG
         HuXg==
X-Gm-Message-State: AOAM530lTGtbIwkFft8vO0EyWrSHuhxM6mnAajTE3v+TdjNe4m7TcKfP
        nh0R+VNV3QpQqDRA4QLn+4yjsRDmtD/piw==
X-Google-Smtp-Source: ABdhPJx1nevodj3K5SAaTybbNn1EtIUvrtVFHR5MWalFz62kuxgMLmQ6y/VM1BCzNbVME7J7ko61UQ==
X-Received: by 2002:a17:90a:aa83:b0:1b9:7c62:61e5 with SMTP id l3-20020a17090aaa8300b001b97c6261e5mr2454271pjq.118.1646875918181;
        Wed, 09 Mar 2022 17:31:58 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:31:57 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 04/16] btrfs: get rid of btrfs_add_nondir()
Date:   Wed,  9 Mar 2022 17:31:34 -0800
Message-Id: <097edf27db0e152e71abb948417093c9d86b1806.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is a trivial wrapper around btrfs_add_link(). The only thing it
does other than moving arguments around is translating a > 0 return
value to -EEXIST. As far as I can tell, btrfs_add_link() won't return >
0 (and if it did, the existing callsites in, e.g., btrfs_mkdir() would
be broken). The check itself dates back to commit 2c90e5d65842 ("Btrfs:
still corruption hunting"), so it's probably left over from debugging.
Let's just get rid of btrfs_add_nondir().

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index be51630160f5..9c838bdd51cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6355,18 +6355,6 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_add_nondir(struct btrfs_trans_handle *trans,
-			    struct btrfs_inode *dir, struct dentry *dentry,
-			    struct btrfs_inode *inode, int backref, u64 index)
-{
-	int err = btrfs_add_link(trans, dir, inode,
-				 dentry->d_name.name, dentry->d_name.len,
-				 backref, index);
-	if (err > 0)
-		err = -EEXIST;
-	return err;
-}
-
 static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
@@ -6413,8 +6401,8 @@ static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
-			0, index);
+	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+			     dentry->d_name.name, dentry->d_name.len, 0, index);
 	if (err)
 		goto out_unlock;
 
@@ -6481,8 +6469,8 @@ static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		goto out_unlock;
 
-	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
-			0, index);
+	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+			     dentry->d_name.name, dentry->d_name.len, 0, index);
 	if (err)
 		goto out_unlock;
 
@@ -6541,8 +6529,8 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	ihold(inode);
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
-	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
-			1, index);
+	err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+			     dentry->d_name.name, dentry->d_name.len, 1, index);
 
 	if (err) {
 		drop_inode = 1;
@@ -9324,8 +9312,8 @@ static int btrfs_whiteout_for_rename(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = btrfs_add_nondir(trans, BTRFS_I(dir), dentry,
-				BTRFS_I(inode), 0, index);
+	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+			     dentry->d_name.name, dentry->d_name.len, 0, index);
 	if (ret)
 		goto out;
 
@@ -9863,8 +9851,9 @@ static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	 * elsewhere above.
 	 */
 	if (!err)
-		err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry,
-				BTRFS_I(inode), 0, index);
+		err = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+				     dentry->d_name.name, dentry->d_name.len, 0,
+				     index);
 	if (err)
 		goto out_unlock;
 
-- 
2.35.1


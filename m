Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853A60E8C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiJZTMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiJZTLi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:38 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28853FD38
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a24so10687806qto.10
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYBbXbK70OGGIRrFHuuc26mJLZm2GL/jLIYaVt7pyFA=;
        b=nHt+JjpHGOeBEC0QCQkqOJMtaL+qo+l/IGHHoCj66v0gdUZU96mKk7mybPo9Qmnnir
         G9pcXX70bLiJtZJiAgXN6wZcU06vXwP7VgB/atT0mAVQ6RHK1CzdTZwyv51HHFbZyyCw
         YwuE7zAtJaOoEhdCI1T1sqWndsOuj+9tNDEQR/yhxVvhmrlbJ2sWwcW4bQyl8yh2+YvW
         xSF1/I5ZWI24UYt7akujED3D7nm0GxR/CwUKVVvK+MG8BBvpoB+wHXz3G2b1t9f5chY+
         lVEhT7cGG9LtCwaK8mPLx10muLnIjP9/99eXe9P2D7fhLCd/pixBczQ0kCVX8Dv3WAZy
         xslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYBbXbK70OGGIRrFHuuc26mJLZm2GL/jLIYaVt7pyFA=;
        b=o5JqE8s22MwW7LyaEHoRzWKnsiubpzX+0JuCpxdWdn+SPPVZz8T6+tc+3eHKLtJo5m
         uxjjr5cDS8yUMtz6iCDrOZSKm6i/iCkCc421zAiEHqruQHgaXB/8Z66RHdsCV1CHLHAV
         L6Atb6dRKw6YlQ1DQu2pla0nsagYvcZPzaB2df6m6H5j4p4DVoWHrmjVn6E+8+jMez2G
         AIPOhk5N2eTNfO7XFCDX70tAV4/DFr3D7mIgMPdQDUrLU9DFvtoxK4xva95mlyVFSyBg
         NlitqujVFPmJzKvRRdk1l7EZh3gyQjOKtIQGSjsaVJIUO3QC+NjKwgKnrDPrCwfbXuWh
         uOiA==
X-Gm-Message-State: ACrzQf3mvvK9ZuEYnL0eW0KGiItWhgl+G7lbhpnjbR+lf4sJxmZVEf2G
        T96W5lKNL0mk2jsyBHYfXJhLiooDPszzqg==
X-Google-Smtp-Source: AMsMyM7tFdPO7mxr2dPSr9uNvcSr6V4Z24BxN4Wq6iEiaXV541T/TeUUxcHxccvSAU09TJz1uQoxhA==
X-Received: by 2002:a05:622a:2c2:b0:39c:fa23:5cef with SMTP id a2-20020a05622a02c200b0039cfa235cefmr35505083qtx.522.1666811348979;
        Wed, 26 Oct 2022 12:09:08 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s15-20020ac85ccf000000b0039cc22a2c49sm3584035qta.47.2022.10.26.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:09:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/26] btrfs: move acl prototypes into acl.h
Date:   Wed, 26 Oct 2022 15:08:33 -0400
Message-Id: <dd1f77b68f21366e0898e4415588e7a97a12112e.1666811039.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move these out of ctree.h into acl.h to cut down on code in ctree.h.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/acl.c   |  1 +
 fs/btrfs/acl.h   | 23 +++++++++++++++++++++++
 fs/btrfs/ctree.h | 18 ------------------
 fs/btrfs/inode.c |  1 +
 4 files changed, 25 insertions(+), 18 deletions(-)
 create mode 100644 fs/btrfs/acl.h

diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index 548d6a5477b4..fe01e97f5e77 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -15,6 +15,7 @@
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "xattr.h"
+#include "acl.h"
 
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
 {
diff --git a/fs/btrfs/acl.h b/fs/btrfs/acl.h
new file mode 100644
index 000000000000..b1ce80f2626a
--- /dev/null
+++ b/fs/btrfs/acl.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef BTRFS_ACL_H
+#define BTRFS_ACL_H
+
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
+int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		  struct posix_acl *acl, int type);
+int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
+		    struct posix_acl *acl, int type);
+#else
+#define btrfs_get_acl NULL
+#define btrfs_set_acl NULL
+static inline int __btrfs_set_acl(struct btrfs_trans_handle *trans,
+				  struct inode *inode, struct posix_acl *acl,
+				  int type)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif /* BTRFS_ACL_H */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dcbfb1b9d269..040b640b0222 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -732,24 +732,6 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 #define EXPORT_FOR_TESTS
 #endif
 
-/* acl.c */
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu);
-int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
-		  struct posix_acl *acl, int type);
-int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
-		    struct posix_acl *acl, int type);
-#else
-#define btrfs_get_acl NULL
-#define btrfs_set_acl NULL
-static inline int __btrfs_set_acl(struct btrfs_trans_handle *trans,
-				  struct inode *inode, struct posix_acl *acl,
-				  int type)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
 /* relocation.c */
 int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start);
 int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 19d4f1f16723..e5443d44610c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -65,6 +65,7 @@
 #include "uuid-tree.h"
 #include "ioctl.h"
 #include "file.h"
+#include "acl.h"
 
 struct btrfs_iget_args {
 	u64 ino;
-- 
2.26.3


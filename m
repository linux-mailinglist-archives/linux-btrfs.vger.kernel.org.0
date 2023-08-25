Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF10788FBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjHYUUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjHYUTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A6171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:47 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-410af8f75d9so7654181cf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994786; x=1693599586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=359EXyjrgYnw0qy+pnTckUd50Ihk3THkdm2GNkP0MAk=;
        b=Uty/XYQgdc9QPn2h8RH0ncDbfhPsdyMnCXj6q0XlAaCDqvlf/q6QQlZMlc2IE/SGwT
         PQmgkdu3pLt1O85476QEu+F9yWQ75w1D44qn4pkdQYspUNMY0jxQl3O86Do7PbRG+NXk
         zyKHHUEMmsirxV/RAkZfoQsJ6konJd1HDiXwna9YMNT8t+6JOcxThjQOCWq6yCBNPJ5n
         RXO+d1wcsoJACU65zF4zW6wMabCt0LcquBCKpaj03bsTGbDXBwA6R1fMJdg+fc7e7Y25
         uHCs9G5lYnOExfiFYUHooNHaACO2PvwLOvVvtFX+GzDUzo7XhMb1HfbZ1LtWvkB552na
         7lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994786; x=1693599586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=359EXyjrgYnw0qy+pnTckUd50Ihk3THkdm2GNkP0MAk=;
        b=KSrNt7bRE3KqVuwX91jn04XZda+zKxmWf9p7Z0czV0jzAkFjO3ptwJPhg2R5qsAiak
         64spVm+/rngOyS9zZITgU8OT2hdXxVBpnhj0iRlsJxpElpMFbeRAR+67ohddCV3qiFLo
         egH3Y5/MWUuW3IF4N09g6CrfegbLOBSRtMkxzVowAgDBvoclmYij6X4xbCMxHpu0CBI8
         1LBj/nH8l3bgkLkkgGuQ6gRQ+YdhM41CCqbFBsj2zFJuEWr/TKvkDilSbwHrzvbdp3+w
         D2uxSwgfkhuJFzKJ1Y7TJ1m3plfjjr3A+443JzHkWAArB+sZTMcXwPnbDYzAuA7Vd+qu
         YkFA==
X-Gm-Message-State: AOJu0Yyys3YzaefH/oyllqLBniWGTeScoEE1fCTBEaTPt6f6yPn3phin
        plNE5jsB1uQJmKrPEqt3dOEEGUCs6QrR+iRMg/k=
X-Google-Smtp-Source: AGHT+IGUmvhcuecxTcvCY5ekG0n/Tt4lP+CqXD9tBCv+EZmEhzA1NnyUvzXcl6ZPS4UM56/NP6i4XQ==
X-Received: by 2002:a05:622a:3c7:b0:412:191c:ffa with SMTP id k7-20020a05622a03c700b00412191c0ffamr127664qtx.26.1692994786439;
        Fri, 25 Aug 2023 13:19:46 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b00400a99b8b38sm724813qtp.78.2023.08.25.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/12] btrfs: add fscrypt related dependencies to respective headers
Date:   Fri, 25 Aug 2023 16:19:26 -0400
Message-ID: <51e817ceddd3f694740c7fcc6f9dbe7f2d720fbe.1692994620.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692994620.git.josef@toxicpanda.com>
References: <cover.1692994620.git.josef@toxicpanda.com>
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

These headers have struct fscrypt_str as function arguments, so add
struct fscrypt_str to the theader, and include linux/fscrypt.h in
btrfs_inode.h as it also needs the definition of struct fscrypt_name for
the new inode args.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/btrfs_inode.h | 1 +
 fs/btrfs/dir-item.h    | 2 ++
 fs/btrfs/inode-item.h  | 1 +
 fs/btrfs/root-tree.h   | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index bda1fdbba666..bca97a6bb246 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -8,6 +8,7 @@
 
 #include <linux/hash.h>
 #include <linux/refcount.h>
+#include <linux/fscrypt.h>
 #include "extent_map.h"
 #include "extent_io.h"
 #include "ordered-data.h"
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 5db2ea0dfd76..e40a226373d7 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -5,6 +5,8 @@
 
 #include <linux/crc32c.h>
 
+struct fscrypt_str;
+
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 			  const struct fscrypt_str *name);
 int btrfs_insert_dir_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 63dfd227e7ce..a4a142f1b5e3 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -13,6 +13,7 @@ struct btrfs_key;
 struct btrfs_inode_extref;
 struct btrfs_inode;
 struct extent_buffer;
+struct fscrypt_str;
 
 /*
  * Return this if we need to call truncate_block for the last bit of the
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
index cbbaca32126e..eb15768b9170 100644
--- a/fs/btrfs/root-tree.h
+++ b/fs/btrfs/root-tree.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_ROOT_TREE_H
 #define BTRFS_ROOT_TREE_H
 
+struct fscrypt_str;
+
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
-- 
2.41.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A97D6E8396
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjDSVYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjDSVYk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:40 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFCC83CD
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:16 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id oj8so995328qvb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939455; x=1684531455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JogPAGMmyJ5vrU1UmjHbuPsmtHvZG94tIlFd63G5PoQ=;
        b=vKEXPNR+eDG3uqUm/jr4bL8GB4WGhpG2tc38bw9GIRLqPL5t27u3M09sMpwrgVXhr6
         hXmsH31/dO2Z7ZY+An+6qDDLEbnDrbyaG3IOp1Q2q1W5bp00iY0Km9hR7zUXyHEUxA81
         dJC5RcD4pmFlSMwMfuHc51h/0pI/s/a9RR9o1/B40PxEl3Z5sbTnBk7lTcZJW/ZYT4bp
         9z/XuQs2jYc1cdBaYJZMMmT0Qy/c3y2H7ERsPNKnBEfBhexijDOZC8UJHrbz/mFVpPkZ
         x1R7XOB7ZmyeJg/jl8/oB9PgDiEzrIqKTE43R2WJvB+CjS49s21jEZobkF7bMoi4HJ8N
         kqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939455; x=1684531455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JogPAGMmyJ5vrU1UmjHbuPsmtHvZG94tIlFd63G5PoQ=;
        b=S0v8u58D8ctdoj0cr0XYi6ztIrSHg9BTrgq8ifbrHqp9qO6gS8o5J9V7U+mjdHrgOL
         ArL+VL84hy+4077SOgblVUIu+PUQx2UDBIFR5UwCv5Gitr0z4np24FaY7GmdxLq7+UwQ
         90LpMo+uLKb9332IsELDbUw0n+3wiqtZ/CrbpnHAUwaJr1wKrzM+SLvY1qjIeIs3ulSs
         Ou39ERQPq/b+V0twUk/H9YPmdFqJvOAHXsB1yYrkYi+zL4uw8JtjGn8b/vbZ4bf/tKHk
         1W2u6eLueRMLu39uLtsjtjNkpgeS/r49btoPSH90CNqi//a082kh/PvkkXfivDiRu67X
         tMig==
X-Gm-Message-State: AAQBX9coTwfrPnZjEGtrPXXeb9vkTiesrLEI9nvfSfThQ/W0RUQE9gTM
        l3ylUVkn4+DZ5H7QjIPettH3ut+M+sbCWsmmWw4I+Q==
X-Google-Smtp-Source: AKy350bShD0tINuVZcdu6Osh24jE5HA+vXYsj5HlSiM+fZ0zd8o6peyVw0V6eyauCN36zUlbR4fQRA==
X-Received: by 2002:ad4:5baf:0:b0:537:6416:fc2b with SMTP id 15-20020ad45baf000000b005376416fc2bmr28845642qvq.52.1681939454658;
        Wed, 19 Apr 2023 14:24:14 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b005eee320b5d7sm1103qvk.63.2023.04.19.14.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/18] btrfs-progs: sync and stub-out tree-mod-log.h
Date:   Wed, 19 Apr 2023 17:23:52 -0400
Message-Id: <41610cf9074900784876cb85b00dfa3846778598.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
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

In order to sync ctree.c we're going to have to have definitions for the
tree-mod-log stuff.  However we don't need any of the code, we don't do
live backref lookups in btrfs-progs, so simply sync the header file and
stub all the helpers out.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/tree-mod-log.h | 96 ++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 kernel-shared/tree-mod-log.h

diff --git a/kernel-shared/tree-mod-log.h b/kernel-shared/tree-mod-log.h
new file mode 100644
index 00000000..922862b2
--- /dev/null
+++ b/kernel-shared/tree-mod-log.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_TREE_MOD_LOG_H
+#define BTRFS_TREE_MOD_LOG_H
+
+#include "ctree.h"
+
+/* Represents a tree mod log user. */
+struct btrfs_seq_list {
+	struct list_head list;
+	u64 seq;
+};
+
+#define BTRFS_SEQ_LIST_INIT(name) { .list = LIST_HEAD_INIT((name).list), .seq = 0 }
+#define BTRFS_SEQ_LAST            ((u64)-1)
+
+enum btrfs_mod_log_op {
+	BTRFS_MOD_LOG_KEY_REPLACE,
+	BTRFS_MOD_LOG_KEY_ADD,
+	BTRFS_MOD_LOG_KEY_REMOVE,
+	BTRFS_MOD_LOG_KEY_REMOVE_WHILE_FREEING,
+	BTRFS_MOD_LOG_KEY_REMOVE_WHILE_MOVING,
+	BTRFS_MOD_LOG_MOVE_KEYS,
+	BTRFS_MOD_LOG_ROOT_REPLACE,
+};
+
+static inline u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
+					 struct btrfs_seq_list *elem)
+{
+	return 0;
+}
+
+static inline void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
+					  struct btrfs_seq_list *elem)
+{
+}
+
+static inline int btrfs_tree_mod_log_insert_root(struct extent_buffer *old_root,
+						 struct extent_buffer *new_root,
+						 bool log_removal)
+{
+	return 0;
+}
+
+static inline int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
+						enum btrfs_mod_log_op op)
+{
+	return 0;
+}
+
+static inline int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb)
+{
+	return 0;
+}
+
+static inline struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
+							      struct btrfs_path *path,
+							      struct extent_buffer *eb,
+							      u64 time_seq)
+{
+	return NULL;
+}
+
+static inline struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root,
+						       u64 time_seq)
+{
+	return NULL;
+}
+
+static inline int btrfs_old_root_level(struct btrfs_root *root, u64 time_seq)
+{
+	return btrfs_header_level(root->node);
+}
+
+static inline int btrfs_tree_mod_log_eb_copy(struct extent_buffer *dst,
+					     struct extent_buffer *src,
+					     unsigned long dst_offset,
+					     unsigned long src_offset,
+					     int nr_items)
+{
+	return 0;
+}
+
+static inline int btrfs_tree_mod_log_insert_move(struct extent_buffer *eb,
+						 int dst_slot, int src_slot,
+						 int nr_items)
+{
+	return 0;
+}
+
+static inline u64 btrfs_tree_mod_log_lowest_seq(struct btrfs_fs_info *fs_info)
+{
+	return 0;
+}
+
+#endif
-- 
2.40.0


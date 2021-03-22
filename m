Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6198F3449FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 16:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCVP7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhCVP7C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 11:59:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318AAC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 08:59:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s21so8713169pjq.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Mar 2021 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BH0LWLhmvSwn1yLtndzkmylhNQJvq0wW2kmcfF2Zyqo=;
        b=CY5UKTJALTg0sCwtsRg90k+Q+jekDKWGugmRKIdoP57vmgBsem56becNnawuYvOm42
         tqf3r4p4coKWyE5BBuYlWT3P2DDtZvNVWZdOr8cJPmTmSK772jUM5bTa3tvj8cM0QRi3
         NDHqnbYcaJ2kXBMc4tFWYj/NE3gaHgbZF6meZaWJgRxz/7kbdVCCayFVYEhJJUT9003j
         DyOCxav3rt2RqWZP3Gi4Ad2zQSqq7lDT5yG8cccin68cFrytQuHOjxrVgq/NC4zGZOlI
         /SBnyDoTQ03U146tU78xQYuQZAf2KWwTNju5uSrLg4R91gI8YZo/HPZt2WyEUGoyv5Qx
         Ue0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BH0LWLhmvSwn1yLtndzkmylhNQJvq0wW2kmcfF2Zyqo=;
        b=jChipFNbJxNxpAfG602fNeu1ZQyPonfp8Hkubz2UxP9b5wGVRxMZGgrVeIsI4gLJj9
         uJ9klbZ0VkRAzkodYhhfW+YYqxVwCohPk1ceeB10DE4F3se9OgCufMgZSOeUyI6l0qEj
         4DorMN7sNQmZ0YUz1kFj6pb5qDDzo1KliGQyZ0IR5IZSwE/ORiZ59iDYDlDvaxFvYuH0
         pyN9r6j8KUp2wGTjOuuG5imjnQ9LzmjLmD2iDWrsEQKuGbnGd8emMlfEYvaeqv4ruoLw
         lbaKpJPEbLKdH38fCPADnaa1Pup6DuZLayx1PuBzluwlNWgD1TZp2HgiQ//GSfZOuj3/
         bCXg==
X-Gm-Message-State: AOAM531dJYu7JVmGaEFEvrlkN9/GXZ05tOt/9kUyV+v0pwnwxgmrlQw5
        xrunczbbLa+jzNMZwqy/WB1D1cM6OaaxhA==
X-Google-Smtp-Source: ABdhPJyV4C8zoowUj1ohq1RVpcicvHOWOkvP+k4YKV0q8iTSetYpUrlWQBwU79CRz1Qz3l0Zo2hrLA==
X-Received: by 2002:a17:902:e309:b029:e6:c17b:895a with SMTP id q9-20020a170902e309b02900e6c17b895amr352787plc.74.1616428741684;
        Mon, 22 Mar 2021 08:59:01 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t10sm14833538pjf.30.2021.03.22.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 08:59:01 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs: qgroup: reuse btrfs_qgroup* in add_qgroup_relation
Date:   Mon, 22 Mar 2021 15:58:53 +0000
Message-Id: <20210322155853.1565-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_add_qgroup_relation(), this function gets btrfs_qgroup
with calling find_qgroup_rb() and checks its validity. if it's
valid, it executes opeartion that add qgroup relation. But in this
logic, it calls add_relation_rb() and it finds btrfs_qgroup again
from id. This process can be skipped if we reuse the pointer get
before. This patch adds add_relation_rb_qgroup() that receive
btrfs_qgroup pointer but id. and replace add_relation_rb() to new
helper function.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 fs/btrfs/qgroup.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 14ff388fd3bd..2e82259fa368 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -259,6 +259,27 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
 	return 0;
 }
 
+/* must be called with qgroup_lock held */
+static int add_relation_rb_qgroup(struct btrfs_fs_info *fs_info,
+			   struct btrfs_qgroup* member, struct btrfs_qgroup* parent)
+{
+	struct btrfs_qgroup_list *list;
+
+	if (!member || !parent)
+		return -EINVAL;
+
+	list = kzalloc(sizeof(*list), GFP_ATOMIC);
+	if (!list)
+		return -ENOMEM;
+
+	list->group = parent;
+	list->member = member;
+	list_add_tail(&list->next_group, &member->groups);
+	list_add_tail(&list->next_member, &parent->members);
+
+	return 0;
+}
+
 /* must be called with qgroup_lock held */
 static int add_relation_rb(struct btrfs_fs_info *fs_info,
 			   u64 memberid, u64 parentid)
@@ -1409,7 +1430,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	}
 
 	spin_lock(&fs_info->qgroup_lock);
-	ret = add_relation_rb(fs_info, src, dst);
+	ret = add_relation_rb_qgroup(fs_info, member, parent);
 	if (ret < 0) {
 		spin_unlock(&fs_info->qgroup_lock);
 		goto out;
-- 
2.25.1


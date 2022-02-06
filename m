Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5AA4AAF49
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Feb 2022 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiBFMw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 07:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiBFMw7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 07:52:59 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBD5C06173B
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 04:52:58 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c9so9122934plg.11
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Feb 2022 04:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/aC9ZnstcwTIiCPOiD8gqW0YNDZLcZz7ZBGQ6Ot0As=;
        b=cILhaMKVjVoPeAASsXUqbwMZfO58Z0ZvJ5d4oy5KK88+IX+QRc/nD3j0FoUDyDXgUt
         ElqOIzsGjw8CBBHqmwAbTApewK8Rj9e3HgTpp/DIb3/Ay7Hj9OQPRt77u+r4vwFVi5bB
         mKt3j05O60Pto7GRgrwoCqzDwJMCLI+ma/ai12qex80FWZd/VGtdmO7ieHclRiShljrD
         NIoXhefa/I1UrPwSOfBRj+wGNnPcBkOtSTeHyIJ3K4GOnFT2vDYbS7tfU+8rCNes0Xmc
         71hZu7Wz10h0+RJidqVy9zXc7QU9qTcrcr9tHrCZfhcQIqNL9op0PlY4w0nOWR3RIqN1
         ghGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/aC9ZnstcwTIiCPOiD8gqW0YNDZLcZz7ZBGQ6Ot0As=;
        b=QLt5tgZNiz1e7q5CSlrKUZBs6D2f54SMz1A44WbRyjL+nepSHwm4oMjG7KVUerrz1g
         hsTqc59xII+hNLzTq4Z7HvoaFYTTTPih6/FjoO1TuQHyH8XE1AJDAhYww/CLU3xn31vO
         kVKEz2qyR+j3FITQw3uvIV0X+aupyfJtciwPF6T9SB4I6kMpnaffzSNlPext5Eq8lwPl
         Srj54TabnNlRGXHIATYZa3PMjPlX1lTpnXrATGXu/MXHpk3rLk1yLnV9gfFsadtXbmsP
         8ECgZHwGTLVGhdNZcvLvs/yUa/kfsTvhex1HdsKuTOgllfFQA3Cq50pRXMw6hVOWlgnX
         xSow==
X-Gm-Message-State: AOAM532zfMNN0p3d32wxvItsXv0z8ht/9dRzL+/KGX8YogR/Wlc8mP/T
        rd/XIXdVwi9cSinZmk9KYM89dKIAIOs=
X-Google-Smtp-Source: ABdhPJyXeU1xxmbPZSO5JdVOeV11Roq9W5qZ4aWp/N9x5SKfWc9tWvyMR/jigmIUYjMEAVViQgFc6A==
X-Received: by 2002:a17:90a:be02:: with SMTP id a2mr3918329pjs.113.1644151977742;
        Sun, 06 Feb 2022 04:52:57 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id d70sm5862544pga.48.2022.02.06.04.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 04:52:57 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs: qgroup: Remove duplicated check in adding qgroup rels
Date:   Sun,  6 Feb 2022 12:52:48 +0000
Message-Id: <20220206125248.940534-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch removes duplicated check in adding qgroup relations.
btrfs_add_qgroup_relations function add relations by calling
add_relation_rb(). add_relation_rb() checks that member/parentid exists
in current qgroup_tree. But it already checked before calling the
function. It seems that we don't need to double check. This patch addes
new function __add_relation_rb() that adds relations with btrfs_qgroup*
not id and make old function use the new one. And it make
btrfs_add_qgroup_relation() function work without double checks by
calling the new function.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 fs/btrfs/qgroup.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8928275823a1..29ffd37d8525 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -259,15 +259,11 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
 }
 
 /* must be called with qgroup_lock held */
-static int add_relation_rb(struct btrfs_fs_info *fs_info,
-			   u64 memberid, u64 parentid)
+static int __add_relation_rb(struct btrfs_qgroup *member,
+							 struct btrfs_qgroup *parent)
 {
-	struct btrfs_qgroup *member;
-	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup_list *list;
 
-	member = find_qgroup_rb(fs_info, memberid);
-	parent = find_qgroup_rb(fs_info, parentid);
 	if (!member || !parent)
 		return -ENOENT;
 
@@ -283,6 +279,19 @@ static int add_relation_rb(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/* must be called with qgroup_lock held */
+static int add_relation_rb(struct btrfs_fs_info *fs_info,
+			   u64 memberid, u64 parentid)
+{
+	struct btrfs_qgroup *member;
+	struct btrfs_qgroup *parent;
+
+	member = find_qgroup_rb(fs_info, memberid);
+	parent = find_qgroup_rb(fs_info, parentid);
+
+	return __add_relation_rb(member, parent);
+}
+
 /* must be called with qgroup_lock held */
 static int del_relation_rb(struct btrfs_fs_info *fs_info,
 			   u64 memberid, u64 parentid)
@@ -1430,7 +1439,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	}
 
 	spin_lock(&fs_info->qgroup_lock);
-	ret = add_relation_rb(fs_info, src, dst);
+	ret = __add_relation_rb(member, parent);
 	if (ret < 0) {
 		spin_unlock(&fs_info->qgroup_lock);
 		goto out;
-- 
2.25.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC211538C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLFOqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42054 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfLFOqp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id a10so6643347qko.9
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O7zBvaSKAyD6OCWpsvhd1OfmsSFvdhkYskFZqQuyvWU=;
        b=Jq0ini2x/MEBw+DltEb2FpcDl3UPAkubulE9Ebq/x6uPLhMp85Oq3qYThK8kg0FMuj
         xZ090AoyRnVEFwN3cSN4wcKkyNnAkC488JIa6XQ+KLBcbteuyw9pkxzK02gbciJiEWqc
         HghHERTNtGkUlF9XVg2aw7GEhQMDOnH9sXMvGkoaAwM61YpZikhWocLhelm4bNINPim1
         oA/fgWAJNSiJXyZDSHCKIGSSc/JymBaKThFdhb18U8A6DX2kOyYDZcVmVpNE6KBNbfAA
         EsaGRnju+TlkadHrtZo6PcK3REOJRqwS4oPz4mbhedvZzkx34jxhnJUctVXsq4NJUUr4
         /2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7zBvaSKAyD6OCWpsvhd1OfmsSFvdhkYskFZqQuyvWU=;
        b=HNODSn6ag7RoT/UZztKMNv6zch8GKzcqOOl8P+ih1ng1JcgfnVgevbj/GLOHYsKFPS
         9tApRtwD4qEWq7Qpzrm/AUj/ogGWX5GRL6h4jWgfr1MiS/cAiz1kQWETh8u+4FGl80NC
         XsIYHvVNUMGEpWTSZwgc+S8nUmn300fyifx/K31JnQ60+5ymI8QgHYYucp0Rc3kCgT/e
         ckfKJx9QP9xIf6j4FVbFhc3kwdTakQjLWzj+qfj3sd1qVMWn4fc6/e7pvWZLwCdaAIG7
         0jZ6rY4KH4/WiV4FkhXEKamlQhQnCv7AIgc1GCvnhccdzZiJE+jJV9EQoTGUMHg7S48A
         t7Ng==
X-Gm-Message-State: APjAAAWVAQysTd02mhX5vAyxDKO313512/Igjtph36zOapyHXJoEuoqW
        XuhbfEalzV2V6yoO2GEjC4rCecTRAdS1Ug==
X-Google-Smtp-Source: APXvYqwBVDbg7TRAb93Era2Rgbi0gV+FptGhUVDDcPJrG3ZKLOoGFvpsXlHuRVF8pA4zpn8Vz/jhBA==
X-Received: by 2002:a05:620a:2103:: with SMTP id l3mr14404660qkl.93.1575643603953;
        Fri, 06 Dec 2019 06:46:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q36sm5090525qtk.16.2019.12.06.06.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 36/44] btrfs: hold a ref on the root in btrfs_recover_log_trees
Date:   Fri,  6 Dec 2019 09:45:30 -0500
Message-Id: <20191206144538.168112-37-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We replay the log into arbitrary fs roots, hold a ref on the root while
we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a4321bdcbf3e..07e7fd508213 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6292,6 +6292,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.offset = (u64)-1;
 
 		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
+		if (!IS_ERR(wc.replay_dest)) {
+			if (!btrfs_grab_fs_root(wc.replay_dest))
+				wc.replay_dest = ERR_PTR(-ENOENT);
+		}
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
@@ -6348,6 +6352,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = NULL;
+		btrfs_put_fs_root(wc.replay_dest);
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
 		kfree(log);
-- 
2.23.0


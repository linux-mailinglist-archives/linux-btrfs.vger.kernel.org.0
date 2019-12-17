Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEEE123079
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfLQPhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPg7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id b3so9009974qti.10
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JLk4SYGy37fJBjRDw7Ytdl7Bh55Sf6BqQikAUfeWGHU=;
        b=vGUvYuPpnxDjZYYAq3k1EyK/wh2XpWsMgJrJb6lDIAybMccd6NyfdrhiHQ5QwmN9MT
         w9oSlqJ9J3mklZVvUqS0ctHiXL7pBv+a1brjdJ/kzLVEhR80GaIkxnlqHDLMOlxz3Tyd
         tPfKoUk9WNWluDnH2JtGtwMKdmANg+5cfFFu/Ro8A6sYRh+c1Itu0sg5osIdZSWWLGfG
         KnGPvwp/qZZ99rDWUiTxndMdMWF7NobYWQyCo1xXNtYxOzzxsXJGMEuurqNItcitTjr/
         pN6v5PTyzlpGoNPcCek4YeMp9OoIsHax87kR9ymqFZ/R9K8/tgXIkyM5MbNsX/Pu8VDn
         LkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLk4SYGy37fJBjRDw7Ytdl7Bh55Sf6BqQikAUfeWGHU=;
        b=auFNyK8AWQXb9wQurjjDyEw2jaNh/2TGMlh45vnTRsubZ23p+uI8Q+gsrfBsBSofkP
         F6SblhCwsNNq/maxuAd/LD4vHvxBQ4v5wVHgsgfkyUIpIVIbwIQS2KW5VSeWKxW+DfWD
         ix7v2LR04Y54iO2gP/VuOO2wymcLBYjKV8YAP99cpj0kxQUmqH//XcURsp/pLse0Gf3a
         s3qsG4YhKoiz/Kowr7j+QHscFswQehtyg6X+32To5eoWqZaTmHK3Zd5jP9IEE99KoDjY
         lv8EwfD3BvGrS8NGERZL5xLcWYT//My3xraftk0bMeU6dZq9Sto2hcDqQV/13SRYC4DW
         ZG2g==
X-Gm-Message-State: APjAAAWjwSgqV7dFwQaFdqczbJcV117MXaNiUKC8ljZw/EoUyIos/2zI
        r77Nh7m+tqbfqNlz+5UWGaNZTwVgt9lHLA==
X-Google-Smtp-Source: APXvYqyD5zzb724ca24pYCz7kg0vbbNCGeWv5d9Q+bEd+3/1ccgRD/Lk6dJALlR5KT6efk1Bvo7vtA==
X-Received: by 2002:ac8:75d8:: with SMTP id z24mr4897777qtq.193.1576597018286;
        Tue, 17 Dec 2019 07:36:58 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o19sm8418654qtb.43.2019.12.17.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/45] btrfs: hold a ref on the root in resolve_indirect_ref
Date:   Tue, 17 Dec 2019 10:36:01 -0500
Message-Id: <20191217153635.44733-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up a random root, we need to hold a ref on it while we're
using it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e5d85311d5d5..193747b6e1f9 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -524,7 +524,13 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(root)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		ret = PTR_ERR(root);
-		goto out;
+		goto out_free;
+	}
+
+	if (!btrfs_grab_fs_root(root)) {
+		srcu_read_unlock(&fs_info->subvol_srcu, index);
+		ret = -ENOENT;
+		goto out_free;
 	}
 
 	if (btrfs_is_testing(fs_info)) {
@@ -577,6 +583,8 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	ret = add_all_parents(root, path, parents, ref, level, time_seq,
 			      extent_item_pos, total_refs, ignore_offset);
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	path->lowest_level = 0;
 	btrfs_release_path(path);
 	return ret;
-- 
2.23.0


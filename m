Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95A115348
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLFOhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:37:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44791 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfLFOha (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:37:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id i18so6600511qkl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v+z2SkDbccNVosD6dQOgtBQoLlmbc33cD/hYLUh/w3o=;
        b=OdOmkkXyFeE8dR7Mmb9iTlxGUdm4D0KoTCuYit2Ili5qNbSr1PVrHcY9wskAGyxJAn
         ldu9fg0XllpYm6LDL7Duj4XURPzsFTmN+gJekXmz6Vo+GYUd8lUscIk1UQvRz+LfLmu4
         +JC7giA7LoC4cYB5heroGOpy+qdUORTu+/3WobGZ1vftldw1qDmvKqN+LFn5470fHmeG
         b6BXxpOjJGOV26oFJsb6kFrCFEJVTWe0ZGPOAw8BwnkYbRk92b8SzMfGZeji8z6evIhq
         uhvQHwT6ks7wqO9nhv8GR8OvSZyxVXHt17C/aRo9q3deNrw92SU9bEtKSYbCskonoFT5
         KFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+z2SkDbccNVosD6dQOgtBQoLlmbc33cD/hYLUh/w3o=;
        b=fVyTf4K+SgNOiqBH2FTA8MrML9cJuVy1rhiKLuvgLl0dSBqJKr6uEHoUCks4u9yFrg
         3GYTlTU9L4igOSfkURa+lGG6slMnsXW1fCpWFuwtHmpwmHXXOjCzkZEhNR9veSyioDVX
         87nwLRiA/8fS+yakgofon41ce1TroKD+eE/ZjiIhLOxqjoB2JBQy/QHHSDmXoqCosRZ5
         IdU5UuVjsz28SY8yMaYhdNtZMRpv5oOj6BbO7p9v2/rReIikUQLTB2mobQ7t3yt989WF
         DoSweg4lp1DCpJ4MgME+d9uOWNMxAxNquM84W/HSEAa7u1BUD+zFbtiwXu9/RRowdnsQ
         X1IQ==
X-Gm-Message-State: APjAAAXeEBmB3/FPkilOnCQivavduwMF+Npd/5PlhKggKAmkZJWxqQyM
        wiTFpN0PUVmXsnLmF03SNwDn5iLQT78+Fg==
X-Google-Smtp-Source: APXvYqx1jtBLGVwMpUPHSqMb/QIdoAK9esNkxZReiZhWkQX/1Qa3DxpOTghlfCgZdxZ1K+fcJ9JT3w==
X-Received: by 2002:a37:4d45:: with SMTP id a66mr14294252qkb.65.1575643049014;
        Fri, 06 Dec 2019 06:37:29 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s27sm4589696qkm.97.2019.12.06.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:37:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: skip log replay on orphaned roots
Date:   Fri,  6 Dec 2019 09:37:17 -0500
Message-Id: <20191206143718.167998-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206143718.167998-1-josef@toxicpanda.com>
References: <20191206143718.167998-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My fsstress modifications coupled with generic/475 uncovered a failure
to mount and replay the log if we hit a orphaned root.  We do not want
to replay the log for an orphan root, but it's completely legitimate to
have an orphaned root with a log attached.  Fix this by simply skipping
replaying the log.  We still need to pin it's root node so that we do
not overwrite it while replaying other logs, as we re-read the log root
at every stage of the replay.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6f757361db53..4bbb4fd490b5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6294,9 +6294,28 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		wc.replay_dest = btrfs_read_fs_root_no_name(fs_info, &tmp_key);
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
+
+			/*
+			 * We didn't find the subvol, likely because it was
+			 * deleted.  This is ok, simply skip this log and go to
+			 * the next one.
+			 *
+			 * We need to exclude the root because we can't have
+			 * other log replays overwriting this log as we'll read
+			 * it back in a few more times.  This will keep our
+			 * block from being modified, and we'll just bail for
+			 * each subsequent pass.
+			 */
+			if (ret == -ENOENT)
+				ret = btrfs_pin_extent_for_log_replay(fs_info,
+							log->node->start,
+							log->node->len);
 			free_extent_buffer(log->node);
 			free_extent_buffer(log->commit_root);
 			kfree(log);
+
+			if (!ret)
+				goto next;
 			btrfs_handle_fs_error(fs_info, ret,
 				"Couldn't read target root for tree log recovery.");
 			goto error;
@@ -6328,7 +6347,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 						  &root->highest_objectid);
 		}
 
-		key.offset = found_key.offset - 1;
 		wc.replay_dest->log_root = NULL;
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
@@ -6336,9 +6354,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 		if (ret)
 			goto error;
-
+next:
 		if (found_key.offset == 0)
 			break;
+		key.offset = found_key.offset - 1;
 	}
 	btrfs_release_path(path);
 
-- 
2.23.0


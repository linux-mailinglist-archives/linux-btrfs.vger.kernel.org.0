Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548BB14894B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390886AbgAXOeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:34:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45237 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390638AbgAXOeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:34:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id d9so1608358qte.12
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pM6Baxg4dx7swLymggU9GXTkL1FxfAoUeQLO3SfFwWk=;
        b=DHfDZgaS8S61ib5N78m7kcAXlLUdR7Y2wUETQFaxB0nWBslwR/xcZpFReDvh9/Gyzr
         OgocaT42DWiB8MYGv1TfcRsqyMPS/65UUt2wHEyTf9U6DLGZ65SLMi99vDrtk3VITPQd
         BgDzv+M9eN2/I3IW+DY7BSa4CdR5kqVw6Gb0/rYWMNy6i6Lwc7JDOFyCw7ZK0nB6rfdw
         QdtlWDxZSkvYREIUrzLb5co45TYrp+5zqMPbw0xh7p7e4SAhrNvXB8cmjXI7Jc3o/atH
         FrR2NMZrfYbgxHvPEjimJYNKHi/WIRA0EgcWqvLuyKYXV0KV1+Ge147voT7CTWh+fLO+
         oURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pM6Baxg4dx7swLymggU9GXTkL1FxfAoUeQLO3SfFwWk=;
        b=YKMgtTOJYVy6+r0GcoqPzfUDmd/2eBplR/CqbM8dp8py178EiyZIlJC7YVC8KQI4St
         V3F3wYZDTEJQky160tHmEc6RO/2JYpkH90kHUeLUeXB1qz9/8Pbjc12v3vCBCU6VNDrR
         2v8P78QZcYKhlH99qWsrf+fN5isnh6DqCc28TqEleo8mXVk8i22tcgkqVobmTJfkTH4Y
         1dAe783An794TwC7gAuDK/hwxZpLnEYKYEg3Bv22AqSrO7UA0pV9cCPf+19TK8QqC07c
         obPt3BI5i3mHzu3scnHBBBOLFIOYWOustuV+K0v1fBPrDjiKzhNnduupWKSquXUYKNuV
         YPuA==
X-Gm-Message-State: APjAAAV+qcIGfIrD7/dgM8KJ/dxFnyUZFuPPAO8v2q9euuISbr05EI8L
        91SYxhbUYAl538iaO61o634jGw==
X-Google-Smtp-Source: APXvYqxWBFzqLxVUQu7YxmtFNmIZaSLtese8uLIrJ0A/9QCkEY15vsOEK/3MtIQKz9C+0PCH4HrH0Q==
X-Received: by 2002:ac8:148b:: with SMTP id l11mr2427109qtj.390.1579876445484;
        Fri, 24 Jan 2020 06:34:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k133sm3198078qke.134.2020.01.24.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:34:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 34/44] btrfs: hold a ref on the root in btrfs_recover_log_trees
Date:   Fri, 24 Jan 2020 09:32:51 -0500
Message-Id: <20200124143301.2186319-35-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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
index db803765b500..5b05419a0f4c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6114,6 +6114,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		tmp_key.offset = (u64)-1;
 
 		wc.replay_dest = btrfs_get_fs_root(fs_info, &tmp_key, true);
+		if (!IS_ERR(wc.replay_dest)) {
+			if (!btrfs_grab_fs_root(wc.replay_dest))
+				wc.replay_dest = ERR_PTR(-ENOENT);
+		}
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
 
@@ -6170,6 +6174,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = NULL;
+		btrfs_put_fs_root(wc.replay_dest);
 		free_extent_buffer(log->node);
 		free_extent_buffer(log->commit_root);
 		kfree(log);
-- 
2.24.1


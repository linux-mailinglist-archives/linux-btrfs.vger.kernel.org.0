Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A924612307B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfLQPhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:05 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38733 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfLQPhE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:04 -0500
Received: by mail-qv1-f66.google.com with SMTP id t6so3904729qvs.5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CrGSROngNYHMrJo4yO4MKSjdAhSy80c70V3zqgJu568=;
        b=MmsF3EkdY14zA9Aree7aNiwmScKfn/3Fw8oTBn9wHLZq95e1SuvlfRyPCzikPpx5Uh
         fAoQTWCnb1voP8QQw8HE/nIvPpaijsGWocvWOcFFbNLsLpw2QaSkYOGOQIFmCiEXx8I/
         VjYsa53BkQ66/D6TA8vQ1Yon5fVGWoLcHY8I0tMaXpfzXHvsSgm4tSaVipi2a2R9lgID
         fQvF9Wvq6bF+MqKPfBu+WkkzmDM2iU9UQXzOt5pt6kMZoTLyc/kbxur+aWNUYOLZWgs1
         AOGX34D4MYsd9cK8T4b+btS0gVASMaCbJ5qqFBsNUEtGxX7Jen7/55E7v83uCxWGFd0l
         kgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrGSROngNYHMrJo4yO4MKSjdAhSy80c70V3zqgJu568=;
        b=EdskjR42re+DDMUp0q3Kt0I52DxMFYCdGAySXx6YskCZf0a2Cxds96csYIrYwiTomY
         iUFNxf6ZyQXjQrXP39pge/+TJ74MN0J5YyqK677DeZCQobF1xjqUbhuKIx7XBb6XmG2+
         /vRtoCM0zfrVViNKVzGUcgTAV8n4HyDxMNplFuVXjQdwAI7oGI6sFf3W+f4Ob+p+wYh/
         6HQlBn9ecvC7O0cHVBprSFu9zFpMHQjS677uMK9V32L9ZTnpe/WywZWYmWdLeTi1xvEp
         vnQZrmPew/48rfe1MhdSWTV9Ob5hcE67qEAZg/qTreb2t4m/EJ5L1g4OmE5a28ZYEuQ5
         NJSA==
X-Gm-Message-State: APjAAAUnNs7VBl6l1yUfFSKl/jJ8/Odv9Lap4PwwW2fTIed5AystHWnd
        6TRixhNS3yP5ZuqC0nrDq/RAnkIZHGfCBA==
X-Google-Smtp-Source: APXvYqzWcbID5NIR3rAhvmRKZk3Nl/C4XhG8od8EIRaZdGtSMIT6V4zrU94qT5lSwLghYRFvqhr2Ew==
X-Received: by 2002:a0c:a184:: with SMTP id e4mr5198358qva.56.1576597023528;
        Tue, 17 Dec 2019 07:37:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 124sm7203763qkn.58.2019.12.17.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/45] btrfs: hold a ref for the root in record_one_backref
Date:   Tue, 17 Dec 2019 10:36:04 -0500
Message-Id: <20191217153635.44733-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up in an arbitrary root, we need to hold a ref on that
root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 138c21f5ed12..88f3d6eace7a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2523,6 +2523,8 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 			 inum, offset, root_id);
 		return PTR_ERR(root);
 	}
+	if (!btrfs_grab_fs_root(root))
+		return 0;
 
 	key.objectid = inum;
 	key.type = BTRFS_EXTENT_DATA_KEY;
@@ -2532,8 +2534,10 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 		key.offset = offset;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (WARN_ON(ret < 0))
+	if (WARN_ON(ret < 0)) {
+		btrfs_put_fs_root(root);
 		return ret;
+	}
 	ret = 0;
 
 	while (1) {
@@ -2603,6 +2607,7 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 	backref_insert(&new->root, backref);
 	old->count++;
 out:
+	btrfs_put_fs_root(root);
 	btrfs_release_path(path);
 	WARN_ON(ret);
 	return ret;
-- 
2.23.0


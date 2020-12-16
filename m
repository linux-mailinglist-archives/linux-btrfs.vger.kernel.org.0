Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20CF2DC441
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgLPQ26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgLPQ26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:58 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15051C0611E4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:25 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h16so7179927qvu.8
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3ibYZhMwxw/1VXxtPFoqzKcxQU4zMIzevD0bFWZZbw=;
        b=lzvHphS9Nt989SsoyE4Z4be6A1mdMZSjDERMKnaIAwDtq7PBl4IetlMjMKgn786/6N
         loBcsnt5Ya+AuELdjVHEDVCaa+ESHd3Coo9KJg4QSKs0F9dgK4CzThxrbGyZxw5QfsTg
         u+qvuGXZDU7xAp8dul+mzXS6Eg4vOHHMkJ8reDd9Pt9jgn5VFzF6JcNlf/Lne7nHTFEw
         mMAFoByvpl0FAPLfLYQ6TClWV2iDiMlyqqgcblYhw1KK9EaGcf4/ourEgBa12VTWXBfA
         b7QsjUAaNUldRRhwn0eJhnFuFGAe2y++H4fPjTUhSD0ZnD+cnntXGzSV02qp+PgFgEWc
         ZMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3ibYZhMwxw/1VXxtPFoqzKcxQU4zMIzevD0bFWZZbw=;
        b=WH7gjJ24yWBSEwrlYYqdgRTuUOLNxK7gEtpwitm0TR35UlvJMO6QBHL2tqbromPsWM
         qnmzVSputZySIayixsZn/kmhRhJuB3GqNfDOtvfXmi8Wxr9C9EfFlip/zGOOWeGwahPr
         hkS8n4wZ7/reYygVyuToDh8WtBi4PmUdwe9KDiy9qdlbEUzNb2y/1FGySNchy48krHYY
         dnp2j7iP9MwiufPWCdeRSTz9EqmnOVhWRT+1cu4NYhbI3jTeAaVyzBl4d8zNIzx43Ipm
         kWiwAx38z+IdSkZLlD4r/X/kW4hD1ruVQCKXBfEyVJ/9BBsPjLd3EvzyOOBAlCxnluRK
         i8jQ==
X-Gm-Message-State: AOAM532WeLt/UVrw7bbk2zfphkN9HyzSmeMauzWdlAsSp0nme9HfA9Na
        xxXyfeetQXSFJxEuyH/Xjg+ATEZDjJkDybqQ
X-Google-Smtp-Source: ABdhPJy82sXLTZ+EPlDqitPHKuoD4xOyws52J5FaGtdbCj8TnSn9omPWFnJ5aWRIIKPQAZqRzPLkOg==
X-Received: by 2002:ad4:4f11:: with SMTP id fb17mr13087291qvb.46.1608136043976;
        Wed, 16 Dec 2020 08:27:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z15sm1378493qkz.103.2020.12.16.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 16/38] btrfs: handle record_root_in_trans failure in create_pending_snapshot
Date:   Wed, 16 Dec 2020 11:26:32 -0500
Message-Id: <5a0847d1968a6bc91ba995d6c7ce389915715544.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can currently fail, so handle this failure
properly.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 4efdb87df27d..0663675354a2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1568,8 +1568,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	dentry = pending->dentry;
 	parent_inode = pending->dir;
 	parent_root = BTRFS_I(parent_inode)->root;
-	record_root_in_trans(trans, parent_root, 0);
-
+	ret = record_root_in_trans(trans, parent_root, 0);
+	if (ret)
+		goto fail;
 	cur_time = current_time(parent_inode);
 
 	/*
@@ -1605,7 +1606,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, 0);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 	btrfs_set_root_last_snapshot(&root->root_item, trans->transid);
 	memcpy(new_root_item, &root->root_item, sizeof(*new_root_item));
 	btrfs_check_and_init_root_item(new_root_item);
-- 
2.26.2


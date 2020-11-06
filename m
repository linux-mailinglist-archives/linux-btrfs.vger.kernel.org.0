Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2C2A9F14
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKFV1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgKFV1w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:52 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E74C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:52 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id s14so2452814qkg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7TwCapBQWVGENvu894XeJrvu3KYvudrxlH3JkjYHkkY=;
        b=s45dXHebKdrYQ9RKUtgIkIJF6bLuw1z+hr0td7R41kV/z25OWMwK0EM9lbNzJeOggd
         5OGtZ6CAeZd+goFh6gHd0E9y+TobdPEsiSNN0zfT4kjFBBYE+UxOTqQ4V6r5JmTruY18
         79M7UUaHy0v5g7GBcgidAJyA6S94ejBrhsq5vY7TSCfSf1UcllSBSKccX6LSSIdu+sjf
         bzKjh8A5Txk/OgnzUrlJP4e1R21/ZjG+sc8IbOk5yF5kfAdAO4z44lGD/nBYu8wmmjnm
         xZAMGqbBWKfe49JG3QjpBYSfec7ZumfYAjjL36CcVajp7E2n9XkgUrSi0d53t0aG77vv
         W1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TwCapBQWVGENvu894XeJrvu3KYvudrxlH3JkjYHkkY=;
        b=gYPMg0/3NXyMc68rFmRpovL5txpMCZRCuGc2bqVs7st812CgOB3/PoU0dwnBxIagj9
         RMBlFA6jw+AcNAJFxAItQJTT9oWkMsbuuh71z0UgYzpQBcHkd2lYyBwRhENs6xx15sIc
         eny4r3d3SJD907OZXzN+DrSYJ6ZgOKY8SOZkA44nNehC4d1Omi2vdZbETWYvzakMkIbR
         p7SiXQRThPDc1/OHersRiEwVlEilizPiBAdr56X0MTRbtyjZIGnotIV1wOoq1tAL5kFf
         6od2xyWaihDRFl5MoUneG6FVkRdhaL26OnZMgZwoHZpzivt+CioMTRvDVp77KZHosTGp
         ReFQ==
X-Gm-Message-State: AOAM532Q0/iEI/N1Y5sapuDL1uKbv9BtJxmvEzu4WCqObM+9zS4tYkmZ
        f7a0U9+xRbrtG3brSpxHT597RR8MboSZd6Qc
X-Google-Smtp-Source: ABdhPJzPzKnh5F+v2GPvJs1/Fw+cSn4vYUc8nhugVi1wF8qhNa+iFMg6ZkfsK3E3VwlEjRuitO6zZg==
X-Received: by 2002:a37:480e:: with SMTP id v14mr3529312qka.414.1604698071179;
        Fri, 06 Nov 2020 13:27:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e188sm1396645qkf.128.2020.11.06.13.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: remove the recurse parameter from __btrfs_tree_read_lock
Date:   Fri,  6 Nov 2020 16:27:35 -0500
Message-Id: <64f17b720411228ac68fae00852ea391103aedc5.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It is completely unused now, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/locking.c | 6 ++----
 fs/btrfs/locking.h | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index c8b239376fb4..e6fa53dddbb6 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -34,13 +34,11 @@
  * __btrfs_tree_read_lock: Lock the extent buffer for read.
  * @eb:  the eb to be locked
  * @nest: the nesting level to be used for lockdep
- * @recurse: unused.
  *
  * This takes the read lock on the extent buffer, using the specified nesting
  * level for lockdep purposes.
  */
-void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest,
-			    bool recurse)
+void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 {
 	u64 start_ns = 0;
 
@@ -54,7 +52,7 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 
 void btrfs_tree_read_lock(struct extent_buffer *eb)
 {
-	__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL, false);
+	__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL);
 }
 
 /*
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 91441e31db18..a2e1f1f5c6e3 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -87,8 +87,7 @@ void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
 void btrfs_tree_lock(struct extent_buffer *eb);
 void btrfs_tree_unlock(struct extent_buffer *eb);
 
-void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest,
-			    bool recurse);
+void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
 void btrfs_tree_read_lock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
-- 
2.26.2


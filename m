Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4990B151E28
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgBDQUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:16 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36148 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBDQUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id w25so18510167qki.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZp4ylw5L6xI61gIZ2B8yJ37JUeyJ4woBXocFbEMg9M=;
        b=VR7zaKCLJybMTAtu/7m2gwBYlrtxRdFU8z8hRMsA4+MrHGRPhSf5ogcigfA3nuSb+f
         l0Nq79hOdtqQ7JriHhcg1oaCIkaLWBVyapC+MpMxCPUAkm8ZqnKPPt1DNW8Vvw6ROZq0
         UT2Ko0xE3MptCxm9HoMa0KJi2+MjHXKhBUy5l+FOMS4Q9L9GHY/+qBYkR61TK9sXY4J6
         XSy78gQiY7TOu8GU3Gbd++u5GsEMWLA/JixMIo2LcllTw/TfGXHHvcTdOa5lGOS+hgfE
         E0Q5/ODiqY9nwJdGMmzpJPN9mAwvvtQ2ea54IGbVRHhKTYrWo1VUqYyikl43HCs2gCLg
         VmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZp4ylw5L6xI61gIZ2B8yJ37JUeyJ4woBXocFbEMg9M=;
        b=qTHGTsFF0OJ4Nes4tz4mpCyCpmGhp6DB5M46/xk+TDy7amIJmen9Re1Ye8RjvleTEi
         XbzjIb7xjG8227OqRv4FJg+8rxRMLcRW+WuhBifbpIFOmC9N9/8tLcFAkactmxplxkHI
         vpyhnMqrarqP1gRIbnPLtrNDsp4HM+T6nMljinZjfq1QBYV2QNxzWYxYmkmjBbx3Q6CL
         asN5JFcaOtHieSyx2ZvFt3218VwceCuWZ2szO5enoZ988dMZ4QVsVWdTLsGBPSyTQWou
         zk9vOK7V+5AeUTjnHrDcHNXNGYPkxmBoaRPq2iqDPS9drgXu9R/ye7IBf08ZbCOoFwTW
         hmNg==
X-Gm-Message-State: APjAAAUnDP4/ghb2N3RRDHiFkV4SdC7l0KAFaTaC4Od25S9x63wSevHd
        GjdDONLaITWldM09FXGfyHCTmgx6Ujxxiw==
X-Google-Smtp-Source: APXvYqzHeD44r9NzlUaU5+paPoBpVYF6lWIslrVp2RPk4vFyyy3BrIIXvF63jc8Z54vIwue+jiJq0g==
X-Received: by 2002:a37:9f57:: with SMTP id i84mr29425133qke.29.1580833214039;
        Tue, 04 Feb 2020 08:20:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 141sm5318951qkk.62.2020.02.04.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 12/23] btrfs: add flushing states for handling data reservations
Date:   Tue,  4 Feb 2020 11:19:40 -0500
Message-Id: <20200204161951.764935-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the way we do data reservations is by seeing if we have enough
space in our space_info.  If we do not and we're a normal inode we'll

1) Attempt to force a chunk allocation until we can't anymore.
2) If that fails we'll flush delalloc, then commit the transaction, then
   run the delayed iputs.

If we are a free space inode we're only allowed to force a chunk
allocation.  In order to use the normal flushing mechanism we need to
encode this into a flush state array for normal inodes.  Since both will
start with allocating chunks until the space info is full there is no
need to add this as a flush state, this will be handled specially.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 2 ++
 fs/btrfs/space-info.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6afa0885a9bb..865b24a1759e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2526,6 +2526,8 @@ enum btrfs_reserve_flush_enum {
 	 */
 	BTRFS_RESERVE_FLUSH_LIMIT,
 	BTRFS_RESERVE_FLUSH_EVICT,
+	BTRFS_RESERVE_FLUSH_DATA,
+	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
 	BTRFS_RESERVE_FLUSH_ALL,
 };
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 955f59f4b1d0..e348468489c7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -802,6 +802,12 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
+static const enum btrfs_flush_state data_flush_states[] = {
+	FLUSH_DELALLOC_WAIT,
+	COMMIT_TRANS,
+	RUN_DELAYED_IPUTS,
+};
+
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
-- 
2.24.1


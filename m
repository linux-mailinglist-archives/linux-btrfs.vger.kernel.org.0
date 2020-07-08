Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519E32189AF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgGHOAp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgGHOAp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B10C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 145so39065941qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAww/7Sh8UavgDUq52mopahUOAupYHHSLg89+z5kfPk=;
        b=nmVNR2sWMbejPqbnlZMrJcj2cMhUDO1uGg0LWnDVs9I4jxmopMRHBKe3IwIo6DZUr5
         IAX/n9HEyOMgfBv7OV80LkSjkJKXvwcN51XPwTd+p3FWcZZGFcEEJQG3SZod4HynX40H
         +G8Zs4BkBJswE38NuI3gW74hKDEZzTJhFtjIO9C9QB2FbvmAKJWsDr46HzGRRJj2Kpjg
         3qK6rJsiay1zaasOMmhTZV99kITgWwNUCPazL39vd5Q6fGJcn7AgBejKS2h6ov7AN71Q
         YoXClT8r6GMMh+2ctcP9WvQAhbE0BXQUlbCBdp+AU3PiSALM7mfMq35y2QmwKKgBfsCN
         ekWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAww/7Sh8UavgDUq52mopahUOAupYHHSLg89+z5kfPk=;
        b=eFHbu4QqgG/jF+rMRAfXwKQBfb7tEPLf4jM73gVT/Cs40dz2mErobOMfVe5A03nOrr
         Cj9SsO76WdekDsoL4WJsBJ93Z7Zv1cvAajtaE0Boe/iUyqAi6wy4sKTllllsztFo6b31
         DB3leyya778YAKgn6ADCtAkl9UNll8dfehVL39JDiBdUhM1KDo7DA7SAXIlIOP7SYAK2
         wQ40q6uXSptLV/ykjUaQQ06TpqWC+W3rQDD0yTewX6O+uWKMsLX5NU+Qvp28DK595iOA
         GkkjHyTAYclsJkuQYYNPlJkJSPiXSdX8Kt4loiXvAxFfCIHL55RKzj3bGK7Xs7UuKMxv
         BlsQ==
X-Gm-Message-State: AOAM53279d6FyEO9rHy8NH+4ZGRHyrQgI4fY7moh0IJG6wKla+VrBYEe
        dk37J5A2gfceLKkBxclyzGXrkO51eMbMkA==
X-Google-Smtp-Source: ABdhPJxB2MPy25irrrQ4z3c0OrLAIJ23PCFDzKGQdY9Mzdkohj6/pEYmmgvTirhGxHLlHLYsx+UBcA==
X-Received: by 2002:a37:6609:: with SMTP id a9mr57157609qkc.337.1594216843791;
        Wed, 08 Jul 2020 07:00:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p36sm18874208qta.0.2020.07.08.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 12/23] btrfs: add flushing states for handling data reservations
Date:   Wed,  8 Jul 2020 10:00:02 -0400
Message-Id: <20200708140013.56994-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
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
index 6f1ba19c6705..4eabad429440 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2572,6 +2572,8 @@ enum btrfs_reserve_flush_enum {
 	 */
 	BTRFS_RESERVE_FLUSH_LIMIT,
 	BTRFS_RESERVE_FLUSH_EVICT,
+	BTRFS_RESERVE_FLUSH_DATA,
+	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
 	BTRFS_RESERVE_FLUSH_ALL,
 	BTRFS_RESERVE_FLUSH_ALL_STEAL,
 };
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3b5064a2a972..94da7b43e152 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1018,6 +1018,12 @@ static const enum btrfs_flush_state evict_flush_states[] = {
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


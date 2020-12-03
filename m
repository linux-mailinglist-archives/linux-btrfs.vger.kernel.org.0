Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0782CDD8A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502072AbgLCSZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502050AbgLCSZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:21 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DDDC061A51
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:49 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y18so2982994qki.11
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6SwMiIl7xCj/qRuKVOl1tDZKoRT8yn5nA+uaKsjDZ0=;
        b=HasKLKTaFv+n6cUXrWqDHUre4tLgOqnmYPMU9fW24g2Ez0tYkOubZkZRgNQ+i/ORUx
         MEmwUEUpNOFZcwwMQjWChUViXvfmXC4GCjb39oYIVJm4oaHUSDcFJRQwrABgpoBAQbdp
         yAorKtu1ZmXrJiKecUB0CR3JKZit/c3D+yYgcEx68gQCK+k+YmDuHGgrLdOgNSubQWqa
         ZJiOW1DVsdD4JuMlyhCqUjTsu3ngDagLEHjABnM59sz5iQxXd3R4ZAVF2pie1CQ0SOXt
         AZPz2kyquc/D9VrtLJhEO+BArl1B3M1mYxeetfJ3vMTm9hvA34dJuEd9TFlu9kbQkpJh
         2Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6SwMiIl7xCj/qRuKVOl1tDZKoRT8yn5nA+uaKsjDZ0=;
        b=aUqDRHnTcCgWwWd2SeI4oH9k/GO5GFFZv86c1hFPldKgXMW+ao6qB0cRNjKH/SUf28
         hEQ/bhppu5iszOdbh/8bX6XUySVoURas3RmDYRTmuxwvF3y0ZddlofyRrm8h3PdJitZO
         Xlp9cE8Zrw+mjxuME3Tu2M/HQvYH7ZsYg6ftnZZrz1nGbWpwNnokyT+R9BrozJmMEjXW
         ppPlED8HjnzU7e8DIM67/5s7OAjp7L2yLAeh7z+6HOfBJmRyZYrnG3iVzsf6IHjIKSWT
         kp5oZvI4C8sSFOCNOZNrkBWZEWjQMoW1HtNfKdonQxBhx70xw/oTzNh4/9MBoOmm69y6
         /v5w==
X-Gm-Message-State: AOAM53132iMwmITTThxEH4MUcP9qi495aaZVgvpRW3H69iq8/+yPf6ou
        rM+tv5UkrKj1F1XolwGIcNtNDdjswQQO1f+G
X-Google-Smtp-Source: ABdhPJwOSp43jgSn1QUNYs/K3Dxug/3vU5qGlO9KHNmfBsvrReBlu7O7ToT4siY/5aVWc3qfkKjifA==
X-Received: by 2002:a05:620a:8d0:: with SMTP id z16mr4355977qkz.492.1607019828385;
        Thu, 03 Dec 2020 10:23:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 131sm2031359qkh.115.2020.12.03.10.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 27/53] btrfs: handle record_root_in_trans failure in create_pending_snapshot
Date:   Thu,  3 Dec 2020 13:22:33 -0500
Message-Id: <5916e756f3262f282bacfb8b85b4ee7b306a6cd1.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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
index 087d919de9fb..5393c0c4926c 100644
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


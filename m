Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB51412D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAQV0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46482 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so24116897qke.13
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MLBOgsB9gJ9L9KSeDm3NlcZBDe8/qJV/rRnXG9wy7vM=;
        b=wt2gtDa9C9farjZ/umhyJzFCLjTkY2j+haGAVPzidczwTY4vQsv3yMqQoTL4UQDl3g
         IPYqTpHkwNDAuM3NLS6p5GJjZEtdJzsuJVHl5Ku/5afbLL+oqrwihZCPt1Uy8JKxScq1
         2R6c7igTf6OzHfq1iCyiuzXY+9Sb34ZCQVxaGINiqr1od+dod/uxpT/rlGdGH+zntqWl
         EnebQYlNKcDjwBBK6ZTKUc/c5qlE1XZ4ephyQiORCr0/9JOBp1oPITDkjgb8zPXpJ4Uh
         SbBnqKI5KyaShD7pWYfy8+/cKVjaV0BqhfzFDE8FDV8V7kv+9wdfkgrbYW/+u+oI9hkU
         QVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLBOgsB9gJ9L9KSeDm3NlcZBDe8/qJV/rRnXG9wy7vM=;
        b=p9AtGoNj/wKYXTPdhfVg00VIuJAEVPHXwBTFBbP3Ok4QTPNx49Nb7LlLE04bATnxps
         tdO4mgQ6MEhv/bJSAupv1ziqN45TrZvX3hg8wcszNHwjAefm6wytJZ2p/jKHSS22M+2G
         itL3Sa1TBgJEti+wkP9nDLlUV6kwa+LdHAU6WaKgVJZSvgRAMZPQli+t4DeN5kzQ1H96
         ajB0rQNnNPIkrL7RIr5PMTdgzhUIUmVhNx66OlD70FWyp+pK796BySUKu8GTuMR8olZX
         8v8tvETyRVapDGtO7jLatkwRPXwUD7UyrFRYxEGmNtAO1M6pzgj1rZw+wYqFzcZIIhjQ
         XMzQ==
X-Gm-Message-State: APjAAAVhhIriKWQzYeZYM12hAEimB5XL31W5MTsgDu1yZRe/Fkxd/61p
        JmQ6MQNp/z8tW6aAEyoV+JYg6Wj4LCdw8w==
X-Google-Smtp-Source: APXvYqwOK91kqbq6tAd9zdDs6u7V/M8Q7iQ2mTeFLiMVHo96iAgtfci/GGWE0XqDsMMOaVXAsWKnYQ==
X-Received: by 2002:a05:620a:16a4:: with SMTP id s4mr34555033qkj.488.1579296388358;
        Fri, 17 Jan 2020 13:26:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d5sm12515557qke.130.2020.01.17.13.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/43] btrfs: hold a root ref in btrfs_get_dentry
Date:   Fri, 17 Jan 2020 16:25:31 -0500
Message-Id: <20200117212602.6737-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looking up the inode we need to search the root, make sure we hold a
reference on that root while we're doing the lookup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/export.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 08cd8c4a02a5..eba6c6d27bad 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -82,12 +82,17 @@ static struct dentry *btrfs_get_dentry(struct super_block *sb, u64 objectid,
 		err = PTR_ERR(root);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(root)) {
+		err = -ENOENT;
+		goto fail;
+	}
 
 	key.objectid = objectid;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 
 	inode = btrfs_iget(sb, &key, root);
+	btrfs_put_fs_root(root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto fail;
-- 
2.24.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEA5148930
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404294AbgAXOd0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34542 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404149AbgAXOdY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id d10so2220843qke.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MLBOgsB9gJ9L9KSeDm3NlcZBDe8/qJV/rRnXG9wy7vM=;
        b=B8x8Ex/i22lAYQB4MW53BjVW+O/grOWtf/9o+Is0mAW1WYa2fEsLq5Ecylta0cPbxx
         q6d1UldXRHQXjczbVUuUNjjy/Wi5HY6G3AV1p6fUvtaR0nqifspFIxKaqAkr3P+68rK+
         GkBAjkGD+4d7BP0lr/tYXKSpvhOAqJ9lWoeBxSjJyW75SJ4IwIjskL+Gu//3ZeKUMyT+
         +iwOBZ5R49VXNiQVJ9A+21Ouf33s16+kBfPvhZjS4skLSmtEgiy7Hu1g1HfgCJD72BnJ
         vUeQsx/V5SHNxbHFq8noXJtM61fyM4QtSrmmEfTCp6s3GrThVthjwYeb1HzHwyVoA4Y3
         4JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLBOgsB9gJ9L9KSeDm3NlcZBDe8/qJV/rRnXG9wy7vM=;
        b=BYRKbD20El34F/7sUK9tUxZfZhlEk9dfGB/2lVPqQDZn0hRl5VCykBrFbR8+IbXDMn
         ByocJegIAXZaHmf+cHu3MRvZo3DqFE5cwPrtDIn7in87usK2Zd9utoopizN89n3UqOXk
         xAlq6q4zwNRRXjFucyr/KHypRsxq6k56acLR4dr3TG/cvdOlz1ZFfa2swRXx0t4BUCWp
         FCxXvwVfCZdPZ4XqGqN5MHiPtBOvyJbRXZgKd+3yDtW5iA56sLhxhkm7R2q6kaXt+FP7
         GUlmCbiW/2qXiSX4SOQhZ8tBnFBUy+1u5XlB9fo6nMe5SGWAGFzogrjugh/FgsBU6Dob
         6yZg==
X-Gm-Message-State: APjAAAWk3JBinlHlI+dXV9mGfo1u532ZihPpw3u9o09dRnV0eCrRbFng
        ACfWCHe1nWMDrYwebdOsgCYmjy5ZwtwgXw==
X-Google-Smtp-Source: APXvYqympu1ot1srqpmsumUEzyJzKvOfoZNTFmLQNyXRNDWvMMxUo5Kuljr0FDKJbE739VYTZECTew==
X-Received: by 2002:a37:2751:: with SMTP id n78mr2928494qkn.177.1579876403645;
        Fri, 24 Jan 2020 06:33:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n32sm3328418qtk.66.2020.01.24.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 12/44] btrfs: hold a root ref in btrfs_get_dentry
Date:   Fri, 24 Jan 2020 09:32:29 -0500
Message-Id: <20200124143301.2186319-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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


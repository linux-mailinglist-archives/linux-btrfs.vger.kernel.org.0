Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB9140B79
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAQNsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:47 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34777 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgAQNsq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:46 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so10715577qvf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FKaIAG5ejC7cil3B6hb3ysVYfUPN0rHA8gaVhgcF0h8=;
        b=rAQkCnkbqbRYAQ+aTnVs5P8+OQlVjMaJkYx/Os4EyRSqN83uq3DtGt0hpUvuVdJbnc
         fUZPJ0Kdrqwe2DIdMa23wlpg4pMwBqGNAGe9RnNs2WGvbGOqX96VZDqMQURsa0iJBfjm
         wOsXLoTfKMImW9NQBQNOzQkTfA4wiilaSu/TUtkI+WNDDbhaF2AAmvF4pgmwJjal664i
         2DL6CEZwcqgjl/hoJsrZervrayKURwrerAuyXK3E4zBKYXxvthDIcojNkLbyR7xFNPhz
         EK+gpvw2EwAVcT/O1cve3AeipvsQnnSmQcC5OxHayRwzUyOOb+3aXezNiIdAg077a4YM
         8R4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKaIAG5ejC7cil3B6hb3ysVYfUPN0rHA8gaVhgcF0h8=;
        b=TzNlrNm1TJYysRHTa6OkWbbeTZK1xt/bw2oARC0SumCI76x3G6o+pRMNOApekS1r7T
         jNrY8LwR/bEPIovRUlumZKm4d3YU6Fq+gBN6cbeqeV3+/xJUUjUrpiDWui+ABBi4j/Zr
         DoDVDY6Z1DUexA+k/AjfDui2GJperwAbWNZrhV0XffQjjpq8CLD7rzRX+Wal9pqhSueG
         l53o4hLW6tHCLtPIrZWCGZNhnqSZ5Q4nwYuRBsspc6XOOttX0WVs+L2whZQVWNGRQfgD
         dniKn7conkSq0bfzXc2Oq347cMndpYj/M57RarspTFnsJpLdjkO4us9yUuNSvNMqj/uA
         QN6A==
X-Gm-Message-State: APjAAAWPlhWfpAqF1E/OMOpue+lmkw9AN/W2iWvize1TA355b2HKZdvw
        eJJdsX+Vi0uFDZMZiH0uYNIe0ubc0N4PoA==
X-Google-Smtp-Source: APXvYqzD8zP4jo7HGlxCmbP018d9wDCAeL3vgsyxSrJ6F7KT+TX9Vv7SL5uZcom9F0lvAUVrj87aqg==
X-Received: by 2002:ad4:46af:: with SMTP id br15mr7842365qvb.216.1579268925194;
        Fri, 17 Jan 2020 05:48:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e3sm12861856qtj.30.2020.01.17.05.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 26/43] btrfs: hold a ref on the root in create_reloc_inode
Date:   Fri, 17 Jan 2020 08:47:41 -0500
Message-Id: <20200117134758.41494-27-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're creating a reloc inode in the data reloc tree, we need to hold a
ref on the root while we're doing that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index eaf945d515a7..8238ff6a3b58 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4308,10 +4308,14 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
 	if (IS_ERR(root))
 		return ERR_CAST(root);
+	if (!btrfs_grab_fs_root(root))
+		return ERR_PTR(-ENOENT);
 
 	trans = btrfs_start_transaction(root, 6);
-	if (IS_ERR(trans))
+	if (IS_ERR(trans)) {
+		btrfs_put_fs_root(root);
 		return ERR_CAST(trans);
+	}
 
 	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
@@ -4329,6 +4333,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
 out:
+	btrfs_put_fs_root(root);
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err) {
-- 
2.24.1


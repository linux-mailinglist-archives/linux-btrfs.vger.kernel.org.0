Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786F8123073
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfLQPgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44107 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPgy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id t3so1703002qtr.11
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eM74Qhf90adFFXMMYOsNfwd0edDFEp5pWt/y2NDeBzU=;
        b=lb9lKIPN0It6MfoMNpgrJSTadGw/vEx18B8tDgYX/zGZTnwPscFlqkLOutbk25T/Js
         nfCFTh025lqrlFmjnYLZ4RjAkm9sCQpTKuuwaEo6IH57FaySJq1VLfC0JlsimetTHQKl
         avg8bciVqvv0L7xWd5lAHOd5PV8H+DnflYf1jL/7r4jb5TW2MszDNpDtfKeKcPDCRHBG
         dO0deU2+BSZc+QrLNUF6T6cz0PSqE4G0hY2KiNjF7jWuGtiPry9/dDuIj1enrX/ZkO5h
         16KrK0kkjBZFVU4fnZ2jxjnRw55GgnzBN8U4P/m2vTcEQo1xGiWfCpAFyygY4PXQyy8G
         iZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eM74Qhf90adFFXMMYOsNfwd0edDFEp5pWt/y2NDeBzU=;
        b=OwhWwEU7kdNreOZyL9pTc2a4cp3tzzf/I6wFc2eJ6Xy46Yx1qQoi1hPYqf86Ud0CI+
         W+lWi12NkedK7HNg602e8IT+KCffvDBsYNTCXS3g7fO8PkkiwQvTbc1paxZ7XTcoUQFK
         MOmDfdxt9zUw4hxaO+LiQkMydCj9OS8CtHFi7CYoSFdhncXFMebrD5bj4xev5xz5mrUO
         HAW/ECRwSeidnyR29vRqyEcol4aDGgD8ZgcB+X/w/pECQrk8vsKW1C9ndsmCi7w6gtOt
         2PmslJD4Sv+EShHsT2jJLsVU+W1kk2sjkpKBumeRW4ds9kQ3uXSpbAPSiY5zHEs3iBFh
         eVlQ==
X-Gm-Message-State: APjAAAXxGBaAmLRmqRELPiYjvp9kd6MudhFChkPH23IeI302YGybzFQo
        CEANRU8c8/fXV8Tg/nH9ri2UB053yvyvag==
X-Google-Smtp-Source: APXvYqyRxm8eaFY9RUhrRAVpNLxP2kUWb4qR1ASJtcT8PXwadkpN6r8P7K/BDerQPsLX0iv3GDrhfg==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr5135271qtl.66.1576597012703;
        Tue, 17 Dec 2019 07:36:52 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k21sm5604411qtp.92.2019.12.17.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/45] btrfs: make the fs root init functions static
Date:   Tue, 17 Dec 2019 10:35:58 -0500
Message-Id: <20191217153635.44733-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the orphan cleanup stuff doesn't use this directly we can just
make them static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 fs/btrfs/disk-io.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fba2ca4965c4..4c55db4b3147 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1439,7 +1439,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	goto out;
 }
 
-int btrfs_init_fs_root(struct btrfs_root *root)
+static int btrfs_init_fs_root(struct btrfs_root *root)
 {
 	int ret;
 	struct btrfs_subvolume_writers *writers;
@@ -1490,8 +1490,8 @@ int btrfs_init_fs_root(struct btrfs_root *root)
 	return ret;
 }
 
-struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
-					u64 root_id)
+static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
+					       u64 root_id)
 {
 	struct btrfs_root *root;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index f5ef9ace903a..5b38558e164d 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -60,9 +60,6 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
-int btrfs_init_fs_root(struct btrfs_root *root);
-struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
-					u64 root_id);
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 			 struct btrfs_root *root);
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
-- 
2.23.0


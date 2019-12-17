Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3867012307A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfLQPhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:03 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40813 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfLQPhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:03 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so7785061qkg.7
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jwJhWMl33WBxBZPZsNUeTq/Ywm6VHshAJl9lKM0tdLc=;
        b=KTyzNFbQkHQC78RJ/mZecMwx14OvtjhUfVQNhKkLh1SyoNbos3uaV6+RXl+CF54NuM
         KDwZ3toetlWdi63gSqtYsnd/y5W9HO0crh2OO1qn4tvmqi/H9aoyHnHhMBNHuiX8SB1Y
         tyfrp9yeT28p45SCZ9a6wRxx1mGmXRLYfF/GRYKrUro9T19AofE5pYk0Fcptj+aGLOLy
         HZzsO8ukUWHMGuQcaKc/cPEwxIvo+7y7Mf38a6JiemchOhe0Rpz5HfnSygywoY/cNwb3
         eJw+m09TYIM1bdJlamedfx31n5RcWLVsgj1vZuMK1tmUB/AgCvzKyrcssd0iRxZI8IRK
         YLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwJhWMl33WBxBZPZsNUeTq/Ywm6VHshAJl9lKM0tdLc=;
        b=UUsQLqJ1O4adIU3/1nIeEuRu4m+4WirCAowvnDgt5DRrYiBRS20PAfwPMnaNCgGBY7
         OAj3noOw7jIV9w4MYZAPeVjtWJ5qCMa5tIAH9TFZWKtMdtNxxAB9B2xX7RIq/+GVgGUL
         Z+niU055aj/H8Oo3D2d3NjCwnHXTcegmOVxDhwZo448d9u5WxJ6SSqJfNMcOH8xlfnN8
         h97bAkKdkokE9I8cCv4rWqGK0LROK2w4zrjv0XwH/Cm/+zqOEO3yuHCkOvc1n9gwI1Py
         nCBEFBDvmVCVD/yv2XZEE+cdLT1/7Bpzy6Yg3sJivKuTjydg0NoNmLpv1XCLOomDbHkT
         XOfQ==
X-Gm-Message-State: APjAAAWLsVDijlW+0m3C0rtujrBZ4Agfi/HZzMIJM/T8nMMy7pEL/Ge+
        xIupGi9IHc8UcqPo+hcR7ZDCg4IPXOGQ7A==
X-Google-Smtp-Source: APXvYqxUXLSgw4ywJNT9BFB1aE/3UQDjc63YK1a1sbT2GxwjA/U/ZQbAKni+zZ4GnSI9r/BbJ00Z1Q==
X-Received: by 2002:a37:e408:: with SMTP id y8mr2601274qkf.39.1576597021591;
        Tue, 17 Dec 2019 07:37:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o6sm7084516qkk.53.2019.12.17.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/45] btrfs: hold a ref on the root in __btrfs_run_defrag_inode
Date:   Tue, 17 Dec 2019 10:36:03 -0500
Message-Id: <20191217153635.44733-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are looking up an arbitrary inode, we need to hold a ref on the root
while we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8baa1b44d514..f8e16f44a970 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -292,11 +292,16 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
 	}
+	if (!btrfs_grab_fs_root(inode_root)) {
+		ret = -ENOENT;
+		goto cleanup;
+	}
 
 	key.objectid = defrag->ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	inode = btrfs_iget(fs_info->sb, &key, inode_root);
+	btrfs_put_fs_root(inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto cleanup;
-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7662912306F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLQPgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46342 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPgs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id 38so9007558qtb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ENVsROW9UDKoUK9mSa8sWB5bCjOT99XVr3GA2//FRrM=;
        b=yXPStgxAJJ9YRnk+9Ii+7xNDmiUGtYub4NCkZI/GEOJnhz+s6FYDbsrBLgRJw9nMel
         08pqAFIfAr5XVGJ1/eObAbVt9Sa1hkCmS7fyK1JN5l+YHk2rGFdC9hLMIW7VFOCLBtHr
         02kPoxrEc7e/5elW2e0ndmGm1Sw5CymVMPreAj2eUSsK3KH04i/8SbcQIDHKTBwy9T23
         5R//EaOe8C+2VKnoLvm98VwihiEgIRedbvr9kJ7yf1Y5NAtxgXr9lSEEqPQ+I2BJk/1M
         ZKZDS6ocFb9rAN0krKKDN/W3LWBjOs8SbW0xug6sZlVE5VGswFU52lt/Z6Vs0xOhnc1w
         km2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENVsROW9UDKoUK9mSa8sWB5bCjOT99XVr3GA2//FRrM=;
        b=Bv+5HLqofdwjqEKeaB5WljJR3QM2jduaedFQhdEocDDLL/cqett0+TY7NE/zCvooc/
         qWZwKI4yK1yKoNQnZMn9X7TfY/XOYq3Rjy6ffwX4hVrqG6Po9GbrSxniUxDre16r1sJ0
         /pEaV+9QiKGDilSvIVZ8Zg7FtD/6eWaX8OV73wqfNsyWpp9dCeN1wKDfARP/1wBkPYD/
         VrMvlcPT7GjZW8ncGFSwT23/CV0Ah5UHFjzqNHwwgK/HLIATaWvhF9kaTi7y+7LSjAs1
         1C05vIXcrGLRe7eXI5T4lIvIyzhLfgfnfJumiwJE1taU4Xlv4QlqC+oU//+pIG+VgyXH
         9KBQ==
X-Gm-Message-State: APjAAAWdZlJUTXq8Kx5Jmqz0b3Xu761FdOcvQbrAJBnFL4akGqdoVJqO
        1Ivjp/sdvXAR9G17KYwlSMQeSmILHWzByQ==
X-Google-Smtp-Source: APXvYqyjkrkLxncWWP5UYsCw4d+QJL817BeenvIrpTgD1Z4lkSKcmJbTutratVJsC25SaGmAe6C1YQ==
X-Received: by 2002:ac8:3108:: with SMTP id g8mr4945263qtb.30.1576597007408;
        Tue, 17 Dec 2019 07:36:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a63sm7073887qkd.37.2019.12.17.07.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/45] btrfs: make relocation use btrfs_read_tree_root()
Date:   Tue, 17 Dec 2019 10:35:55 -0500
Message-Id: <20191217153635.44733-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation has it's special roots, we don't want to save these in the
root cache either, so swap it to use btrfs_read_tree_roo().  However the
reloc root does need REF_COWS set, so make sure we set it everywhere we
use this helper, as it no longer does the REF_COWS setting.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c5fcddad1c15..3f11491e01eb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1415,8 +1415,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	BUG_ON(ret);
 	kfree(root_item);
 
-	reloc_root = btrfs_read_fs_root(fs_info->tree_root, &root_key);
+	reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
 	BUG_ON(IS_ERR(reloc_root));
+	set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
 	reloc_root->last_trans = trans->transid;
 	return reloc_root;
 }
@@ -4486,12 +4487,13 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		    key.type != BTRFS_ROOT_ITEM_KEY)
 			break;
 
-		reloc_root = btrfs_read_fs_root(root, &key);
+		reloc_root = btrfs_read_tree_root(root, &key);
 		if (IS_ERR(reloc_root)) {
 			err = PTR_ERR(reloc_root);
 			goto out;
 		}
 
+		set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
 		list_add(&reloc_root->root_list, &reloc_roots);
 
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C172211536D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFOpw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43793 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOpv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id q8so7324709qtr.10
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ENVsROW9UDKoUK9mSa8sWB5bCjOT99XVr3GA2//FRrM=;
        b=QmL2cazWKkTucPs7XrkPJQfW8Co/p0mj84QenbArY+9cIj9bY0UHQrChWX8eb6tIRj
         INAwyxgiTs820zMBINP9mcd9DxE2agHTGUSUBvM7QcX0YmdKYVKOZ52aaiWl3y7pWtVj
         vyBSPrUiqAJuTLsxiqjpVnSsAW1aODKZmEEraBHxq6IYIZcY8zhBRwqDm4se5kXMk3po
         Pv2lNdvtkMTFM0WNLkH/22sx5QoF7K8BgjuMvORqVggXI+aWksiId5T1kaYlHWF1VAJA
         hK/DrFUUPkkqF6TbfkceulYddN+3xDtfivoa5rsSvJCi4lSXpU1ab5htP7MY1k3ZvXhr
         78Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENVsROW9UDKoUK9mSa8sWB5bCjOT99XVr3GA2//FRrM=;
        b=R7cOt7FKbburX76k8c02BWFeuEG8Tn7P/6jA6MDm9Lt5YKpgz90/paib40lUlf+C2L
         1c3Z7qt5wkRL8EBo+5zOFxmqxx1G2VKVTL/M0Db0/XnDbZ7S1bhTopFQRYiBk/l4KmJO
         WfxnaII61obJdE/Q7zTrzQxylSEm/nt1jGyWjmScaO/rwgDOBQ/DgO6Fh8bMgQWLL6Rq
         e4ypRVv7T0zJIU+/xcfsv8xoiq04ExZQJzvLfKLmbzprmeM7vRGmc/YztExJ+2vu/cXa
         LG4qeX2SRlh4ASmU753lzqTTn2xT0iCUoT3+A8ZAwnr2ZylUROocGvE3GdnqBiXH8XQZ
         BavA==
X-Gm-Message-State: APjAAAWnHQcjKKwsWHZdYFfAssFtTE6QEdvDbDdLnqr2LBT64rIsx+We
        YQZMZh0STx5LtNn63OGPtURaKQVRtaQtMQ==
X-Google-Smtp-Source: APXvYqzYeOV+yXmmCb413aAHYeJtKudtNiZwnYAobedLNPcl58+qriyf829SnEc+x6GClfJu1MqPJw==
X-Received: by 2002:ac8:5319:: with SMTP id t25mr13148552qtn.242.1575643550165;
        Fri, 06 Dec 2019 06:45:50 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p126sm5981611qke.108.2019.12.06.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/44] btrfs: make relocation use btrfs_read_tree_root()
Date:   Fri,  6 Dec 2019 09:44:59 -0500
Message-Id: <20191206144538.168112-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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


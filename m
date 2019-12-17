Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6F12308D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfLQPh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:28 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46101 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfLQPh2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:28 -0500
Received: by mail-qv1-f66.google.com with SMTP id t9so4311423qvh.13
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=98+1b8oFGLaRfzg8C5aM6Su3ReXVCYbXLcjBOBU6crI=;
        b=QiFzw7gBLGSFd9LOvY8mb6tZaPeCEOmN+56sg7Zkmxt0MUCB3rm553I4zAL+PqY1gP
         X6L3ZDD9gkB3Oh4sQZOPQ2W8zpZoI5tMGwvMOhYl7Lejo37ZSOxo4tGuOAtstMu9PkEp
         XCbhlXJBblAxG437woMu0eyQ6ugURbD8GLKtEXqxxlunyp+OOvYc1DkXuf1vghLXykP5
         CRuMvQE1w0FpHpMc6ccch6bqhuXTxAEuQhLLTV1KzeURAsTffdSFT/k+jCFel/PV+rrh
         J7WUEJux+9z/R/9l8wDFANNtLV2XAcyF184nN+z5b5Fdjt0/0L9ZBQMvVUNj/6sC6s1n
         GUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98+1b8oFGLaRfzg8C5aM6Su3ReXVCYbXLcjBOBU6crI=;
        b=MWrOsNb1IiZaMDrMG6GbimAUR6XMF5TxwkT6ta3n9tjDOdVolC0KJimqtcCJKJzhxk
         +QUpgMefx7N55Hks4t9C9OKWhEr+5H9pZAoD6+5KCKswgyY2mw4RHxJec5KhNslABkod
         GPZcGJ+S78J5jqAE7Itp+NV2RplC47OerHF1Co+NvmtZgK/E5uiNY6kKLjRXP/gch38G
         WDVoyCO5Th0G0/ppqkUeudYPDbWlebnCf27BqCrJ7GMljRVu5NR5HqMOBtvvRMrG8eHe
         raLaoZiAel/rOIjcJab33Wc49tgykM6jFODDLQJbh+WpXRRq8U+vKZnmsjQZxAh7p3cL
         GOjg==
X-Gm-Message-State: APjAAAXUYACgTVW6/keRKw7tRkK5m8Y6uUx4im+7dAAlw+oWiBc3ifcR
        njAkR8FPdIYEHHEd8ZX55e4R/K3b5I07rQ==
X-Google-Smtp-Source: APXvYqzaQMZD/7DnRQRXUZcwVzlMpIsbBq6U133OCKvWCUIPqfeNlwK1wzsGgJgLXyxSo+iOdf2Zpw==
X-Received: by 2002:a0c:8d0a:: with SMTP id r10mr4936809qvb.7.1576597046902;
        Tue, 17 Dec 2019 07:37:26 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x27sm7111720qkx.81.2019.12.17.07.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 27/45] btrfs: hold a ref on the root in find_data_references
Date:   Tue, 17 Dec 2019 10:36:17 -0500
Message-Id: <20191217153635.44733-28-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up the data references for the bytenr in a root, we need
to hold a ref on that root while we're doing that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c3cf582f943f..3b419a4e4829 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3669,7 +3669,11 @@ static int find_data_references(struct reloc_control *rc,
 	root = read_fs_root(fs_info, ref_root);
 	if (IS_ERR(root)) {
 		err = PTR_ERR(root);
-		goto out;
+		goto out_free;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		err = -ENOENT;
+		goto out_free;
 	}
 
 	key.objectid = ref_objectid;
@@ -3782,6 +3786,8 @@ static int find_data_references(struct reloc_control *rc,
 
 	}
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	btrfs_free_path(path);
 	return err;
 }
-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5C140B6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAQNs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40307 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAQNs0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so21780080qto.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SAiiIaHYxAwFxdCh+4UtFgo8Rs8ZoelHWG4/dfLjKQs=;
        b=uZIqXWFCpOE3+7JhQ9E+NbsoYfLIRrowq3MkcouQFx/t64JLfrX2mbsv0zuLsImckg
         HcyCYB6MM09pNu3SHRjSYYX7HFtHzyzwwycElIoSDPlRK/bUKYmIG/vtier1WwgKkygz
         mxYtW/Breo86oBN2CuXWvbYhmwfNhfLIggSPUBf3gDElOCE7ZL5ZPvHOHBcCqyiimwvM
         vamAmBHATGNMfdC1H/pbCt8nl123BJ5y85SKSp5EurGJNFGDBsr5C1c5XLO4kwEOisun
         oycDp/5sU+gDiz1pU866lSgg7w0df0IlMhBF2T+P8WztBC75o5FCRHYSYWmHIqxd0Lg6
         cDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAiiIaHYxAwFxdCh+4UtFgo8Rs8ZoelHWG4/dfLjKQs=;
        b=spFtVCQkbt82pdUXrka07mxPC2n3Y6FFXwpnfl6OimkwZfAuWK48Zx0ePi9wSG8Aeo
         OedwqGvI4SUD1N8lWjM+ANhmvsk8LZKJJYP/AhRRBVQNmY6vLXioMNEAgMH6/B0I9Sn1
         I/rBb4fy4s9OzgNuQkg+HPQd+ZV/WN3CavvJ3HTgT+cIDtUkhlzTuW1I768HWTqAvXOP
         nNXIjQ+zRuVeoc9pQ9CPisFxpgk8gheQSigx36l/mlOJ6w5nNnTSe+Zx4YXRDwLGAArt
         ph3HeR2wKx59R+va6Esu46+a7g5Ze8sd5pYkb0NN2qjapg5gO+jIJQEcJni4uH9axPVs
         g4uA==
X-Gm-Message-State: APjAAAX2oJAaf81k8fFcztRen7nUbfWefNPTSt59WQsDMwcGy5Zcexqd
        08ilL6eUp3Rrp3kV1n38/4E8HQK6FP99VA==
X-Google-Smtp-Source: APXvYqxdv5PTgHM1StNdjrp9aQOQFz2KeSpweYUWneI/oJoTLKrSjt9jCCPRvtqtVwSQHzulKTCqXw==
X-Received: by 2002:ac8:410f:: with SMTP id q15mr7452734qtl.192.1579268904670;
        Fri, 17 Jan 2020 05:48:24 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c16sm11610726qka.18.2020.01.17.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/43] btrfs: hold a ref on the root in fixup_tree_root_location
Date:   Fri, 17 Jan 2020 08:47:29 -0500
Message-Id: <20200117134758.41494-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looking up the inode from an arbitrary tree means we need to hold a ref
on that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8cd1b11c3151..85104886c1e7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5026,6 +5026,10 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 		err = PTR_ERR(new_root);
 		goto out;
 	}
+	if (!btrfs_grab_fs_root(new_root)) {
+		err = -ENOENT;
+		goto out;
+	}
 
 	*sub_root = new_root;
 	location->objectid = btrfs_root_dirid(&new_root->root_item);
@@ -5268,6 +5272,8 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	} else {
 		inode = btrfs_iget(dir->i_sb, &location, sub_root);
 	}
+	if (root != sub_root)
+		btrfs_put_fs_root(sub_root);
 	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	if (!IS_ERR(inode) && root != sub_root) {
-- 
2.24.1


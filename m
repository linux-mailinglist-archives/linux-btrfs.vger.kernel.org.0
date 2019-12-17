Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB6D123081
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfLQPhK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43908 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfLQPhI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so2361888qke.10
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=L+SLHrm//pr6D5i2OoJyRB3MnVU2ycD5RwwNC/XSITA=;
        b=ZlEC6/xD0OhYdSFegl3161qVYepn0S91Oj8D1yPTC/2IPg9MyNNS2Pne8DgsRsW3Yl
         4wCup8OJEEiaM9CNr2mubzdggNCyCACtTcZ8Pc3Dvb30fpsD+7CWHyTtdTM35Fs1utSn
         m8uIqrcnG92Hkg6NGSgQMbWIUSPm4LaGpdUIV1LunpvU37l+ySU1d5wcCchLt2bcP12o
         fg9XGZWyUoC4/HBEaiWi3BWFBsAKV0/TP5WUIXbvEQNnX+hA+fiJcmxsl/ZKA41gtAJv
         29f4FFrRRzO/rsYVkJlmU2n0TrrpgsaduT01/nLzMOs6sPAIez0fP4bhpndkScvwXntU
         qBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+SLHrm//pr6D5i2OoJyRB3MnVU2ycD5RwwNC/XSITA=;
        b=d8nvIZZUIJxrXKyNWD/N4RAWs4QlKfQHWAOmiR5l4ovHeT70IenA8N7k18UHVoX+FL
         RzlhGlFDoQBRqgWv1mrPIWpOtc/2fQKJOI/7inGuviRRG4//67hlHSbi0EnUMvushgvo
         n9+ItQcJd/OmzdmgAl5Ub/BsmOdKydJz5m7v+sNfRvqVAtf/zFfaOxtg6x5YUmr9p1lf
         NX9UaS/AlMZceb/xk0O4AjN8pLtkr4eK4SuwQb7lIE6mSkn1wHPZLiD3r7OBVTzypTo8
         nh/erCcTxr/7rE/fJMBZoVw1gqgSH8XlxSiMOHcMsScVw2x07t2OrWVUg0DS3XRaPVNY
         +JSw==
X-Gm-Message-State: APjAAAXKnRurMBB1qlf96XzFzcc6MVdKb52Nc5n4qqs08aiqkpFtwI88
        8ca1DSP/CrH7XkTIkVnAG/2NbK2Wmn6jLQ==
X-Google-Smtp-Source: APXvYqyYZT7688mNvqeipvgSUSDXAyBHg6v2C8Y7UuxOUVjXY3HH4F011Q+gQM2eWbNKuncEPB014w==
X-Received: by 2002:a37:6551:: with SMTP id z78mr5878570qkb.144.1576597027300;
        Tue, 17 Dec 2019 07:37:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n32sm8194531qtk.66.2019.12.17.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/45] btrfs: hold a ref on the root in fixup_tree_root_location
Date:   Tue, 17 Dec 2019 10:36:06 -0500
Message-Id: <20191217153635.44733-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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
index d46e3ec6ba30..0eb0035618f1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5690,6 +5690,10 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 		err = PTR_ERR(new_root);
 		goto out;
 	}
+	if (!btrfs_grab_fs_root(new_root)) {
+		err = -ENOENT;
+		goto out;
+	}
 
 	*sub_root = new_root;
 	location->objectid = btrfs_root_dirid(&new_root->root_item);
@@ -5928,6 +5932,8 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	} else {
 		inode = btrfs_iget(dir->i_sb, &location, sub_root);
 	}
+	if (root != sub_root)
+		btrfs_put_fs_root(sub_root);
 	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	if (!IS_ERR(inode) && root != sub_root) {
-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08594123082
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfLQPhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34227 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfLQPhK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id j9so7627987qkk.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7VlXuMmW6vkmcDdGX4eAWzkcyjFhrGSVL6+MEgHg3UY=;
        b=KOvsorSdmtpm2jzijvyrFqVCjhG13BN7iHf/xjGwgC0HE/n2yewqidT1N3y16RMh9/
         ZYIsWVK9O3IaEWXTR9mjnPb/DlZOlHkv7+ShjYRpexWIjJ3ffIMwxYzbhw0c1MzrrJOJ
         vxwfJtvyI1qfWZgUgVQkTKWHymBVwgAhNaRk79lidDX8zvGdSto6ohAiPSa4e5zpQkZ+
         5NICCOoQEs3+AFHsTTWcITXi/84NF083RTzzabhldQrzQNl9yRQI7B0oUDpSAbJoNN0U
         UFbg1FGRyc/KbuzotE8HG3meWZnL1xWxhx3iFjS/ecnGZ3gpn7j80Ajx4R+q5OC8FKIM
         fLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VlXuMmW6vkmcDdGX4eAWzkcyjFhrGSVL6+MEgHg3UY=;
        b=WpYvQGs+Tuf6hTmr8x4NlVjW22nUbX/RVL+1lhe7yaUX3uVX0rCSe42TISZljDrzl2
         ESjjJeYMyrBN17ib3r5SG+Dp2s1dcEzcRvNOyoW/1Awj7RZexMsJSP2RxSFirRYo2Abf
         qDvGgF5uWPu6DYurU246FNPr4Ay/qoPRjpPlgVpLGK1XVC84CicTvhZngtiO4DHXFF9D
         2NRMKOkVGBcoX8PGm1Y9z0NBiy5SnPU794iZtcLLFWilVBnX9/QiQGX/xACCdBAAylQm
         0ga194EsP3qXbhW9yGUEcKK/dkcqYRhhjshqWITzuq9ZrftKZ7fBIepyYQXDd8N3gtIg
         F3Zg==
X-Gm-Message-State: APjAAAUDbHPtKZkCEMVA8SrvGW4PUgdmN+DGWlXCsypIldpmSrCctAls
        9Fq0U8zlr8rLbSF8us8Isy3y9SETmyvCzw==
X-Google-Smtp-Source: APXvYqxELs/HnNoA0S6vVO17fZKlmuayzJdvji5el1s/545Ns1XLkrRInjpDvWTqbDUm8MNnCfMAHg==
X-Received: by 2002:a37:648c:: with SMTP id y134mr5541784qkb.175.1576597028950;
        Tue, 17 Dec 2019 07:37:08 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r80sm7191989qke.134.2019.12.17.07.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/45] btrfs: hold a ref on the root in create_subvol
Date:   Tue, 17 Dec 2019 10:36:07 -0500
Message-Id: <20191217153635.44733-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're creating the new root here, but we should hold the ref until after
we've initialized the inode for it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 95b0488b7da6..29c363a70fe7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -672,10 +672,16 @@ static noinline int create_subvol(struct inode *dir,
 		btrfs_abort_transaction(trans, ret);
 		goto fail;
 	}
+	if (!btrfs_grab_fs_root(new_root)) {
+		ret = -ENOENT;
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	btrfs_record_root_in_trans(trans, new_root);
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
+	btrfs_put_fs_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
 		btrfs_abort_transaction(trans, ret);
-- 
2.23.0


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9691412CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgAQV0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:15 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41831 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:15 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so24134620qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M3LkiDIKKCvPn6ztuTVPBW2ShU9Zg/epWtM2vuFkQSE=;
        b=IaerLTh30LHPUr4GByNBACVSCTSXZElG7vbVclYCVqXH03Qc56ACRH2eMp1ZjQIz0R
         m8VrQ0oQ77pM+kZlD/aS5p+Q3AQRhCIOdjYFC56TaiwrFAfzFss/RPmbqDdT0mHvomHU
         7MNEpdX5zT3XES4aOe+uP4yU6NzY90n9CtYP6+6Gk/PRlStufs8/T8dum7LrgKaQEhwZ
         MUUyL+DhXHJjBuFh+FUw19ZBsezfxSy9hcmJ0c/tMqt/q3HmasoL4lm7jy3jJBAm8pYZ
         gzlKosRbHrsrdiBJSaBWSZU2U44ifJErMbS/83MiB7KDzg6ZhC2+6bM/HB/Z+59SqW/t
         1Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3LkiDIKKCvPn6ztuTVPBW2ShU9Zg/epWtM2vuFkQSE=;
        b=p4eMjJHxfUUAQgN6EvokfWpN7rR1QaUK2KFHcAnISX9lbbfNSGSwO7rgOGyanS4//N
         YRahVRKok9SwsTIdLm8V5mQi7uuIgcM6ypNVHZTglnJK1ZC2BvsBuscNCj1ImsswscHJ
         ZA0PkzTI/0vlahjhRhL75Luq0Qx7HPAz1e6QlpkSYLqZ7B+KYrlBzvyhMYETGo5W50VT
         QXfsM0vuQAG2+WC3GeLtdhmXUaAgzRMoQdhFXUlxbajhFmsagRgYvNb0gu9JHqycY6aF
         kLrYYxPWh5dz1Ar4x7Ax4ImVk10IQ9p8DPClrpgzTjkM14LmH29SGEyVw+QNNzf2+lea
         Tgrw==
X-Gm-Message-State: APjAAAU30xklb16VzHqqJgMrX9CGJJhU07HnlbhKjIOz5GxSRu07GMD9
        QyHB74dGKNF77pwdXjbmg3ZuVg917plGYA==
X-Google-Smtp-Source: APXvYqyD/BwXKRjE7uy1hBssfpXoqWN33ZrTYiLnoUARts8CkAU5/ZKnH2CN3AQpIBmBRxpKdbLd5A==
X-Received: by 2002:ae9:f106:: with SMTP id k6mr41006626qkg.189.1579296374150;
        Fri, 17 Jan 2020 13:26:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n129sm12423910qkf.64.2020.01.17.13.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/43] btrfs: make relocation use btrfs_read_tree_root()
Date:   Fri, 17 Jan 2020 16:25:24 -0500
Message-Id: <20200117212602.6737-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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
index 995d4b8b1cfd..aa3aa8e0c0ea 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1447,8 +1447,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	BUG_ON(ret);
 	kfree(root_item);
 
-	reloc_root = btrfs_read_fs_root(fs_info->tree_root, &root_key);
+	reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
 	BUG_ON(IS_ERR(reloc_root));
+	set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
 	reloc_root->last_trans = trans->transid;
 	return reloc_root;
 }
@@ -4537,12 +4538,13 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
2.24.1


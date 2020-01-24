Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21877148941
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391959AbgAXOdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:50 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37878 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbgAXOds (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:48 -0500
Received: by mail-qv1-f65.google.com with SMTP id f16so982820qvi.4
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q0WxG9jK50p7ua/c+vZWCANharCGvbWEZUCcaKh7TSw=;
        b=pI0u8lqohtVlsg91IhfgCjms7/x9+fFMXAzkk7rHw19ZaK06upEAHvCjmlC+x9COk2
         uN2kRNyX0u+676xbuIof8JX5QjwjIealpCuXtqWGdlMzJoCGKGBbiDt2EabTvNc+1Iii
         9RSXREAzcBs8Zo+cgP4Z5tN4WyI8WoCnZI4Li7eQKfhK/WwLcNbkeF2zQyOlgBtmEcHd
         x+MfI7TJeOwZPbVfVREszyOs9juCcIZHqKis1OJyZS+kx/jDLfg2OECIGDGkrgkE+Uat
         9srRoKrI0w7iAyYn3XOkUnk5NOfUgoCHEVS5JBvTVTE11SBxdQscqQS4GqHSqaGU9utp
         FyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0WxG9jK50p7ua/c+vZWCANharCGvbWEZUCcaKh7TSw=;
        b=d+SJCHTH5O+fVhEzVB3CYHkcf9YWrKnT2cyPR6ezsPnltQkjAwGREliSmtIUnSZPOD
         o1istVrrPwrezl187mlFcKeR4IXvv5RHI/i4FukSQ7h/b22mXAmYJHJ/yshdKP4pXKIN
         utg9HjI38Qw86sPyxzYnr3Z3WFdzWn4PQInXvsF4rKVAGiIv9gBv2xwVlUw3LSWexucH
         TnEaBUENoD8rXzGM248J6AXpqNAbRy8rqa+LgXysf6JqYj5HV2AfekI8NkJok5rJkWXU
         5JVxotXST+RaKCazKJb2ML8w3lrTUKXUxS2uPj1GyqfUmb2CymHvjmWMeWqS/yY5m2p8
         ZPZw==
X-Gm-Message-State: APjAAAWc8v49mZItfFd9wh36kvNMdWE6sVquvdMVAYEs8/fV37d7Wg+L
        rlO+hv24zlX28NuQhCZn5yZHDw==
X-Google-Smtp-Source: APXvYqzen/8IiMSdMDzjK80CYOet/2PUqSs+B8kx6HbyFBMRByMaqJ8jl8LXX1hq7gPSOplYq7kOwg==
X-Received: by 2002:a05:6214:a08:: with SMTP id dw8mr3036532qvb.121.1579876427715;
        Fri, 24 Jan 2020 06:33:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h28sm3124214qkk.48.2020.01.24.06.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 26/44] btrfs: hold a ref on the root in create_reloc_inode
Date:   Fri, 24 Jan 2020 09:32:43 -0500
Message-Id: <20200124143301.2186319-27-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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
index 0c75ae09a3a8..9531739b5a8c 100644
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


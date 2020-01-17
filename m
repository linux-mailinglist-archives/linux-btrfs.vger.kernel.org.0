Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123CF1412E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAQV0x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37364 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAQV0w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so24198115qky.4
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q0WxG9jK50p7ua/c+vZWCANharCGvbWEZUCcaKh7TSw=;
        b=abrl4KMXjt76g3p/BESkJjIuOSCMc45e2AkrydT4WKXkBSYS8HIOl2wXIQagZQtA/q
         rXILVT9LB2ugQilGWcDr56s+hRSG+0Gozg1TX2zn8u/t3sftjBXzykgvhkfgtUxEbBgl
         ay5OhXjgQuUyglcGrRb5ORkzRwSwdK2OTHTaZykk9MW0n8riz0PS+l618R/2KgiM6nTk
         Dd03rGOeI5JWmFD9bN/M5qEyX6FDKRfzycf0SLoh1dL3+mfjqqC4lFK8ufH0+CkEHPOO
         bWEi5xKP994UbBZ+pYUwNZ0x7mxVd87eLEX6QfHF1jI4aPOVwMVbSxpxMwwQOfz/9qsH
         1lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0WxG9jK50p7ua/c+vZWCANharCGvbWEZUCcaKh7TSw=;
        b=IAG2DVIlg0nggnDETt0pYOw2QFie6ZPtSQpMLwGmX1FRR51tTRV++Ua4bS0bJ1wrr5
         tRXX9cWNyW9KngThojTPwa4/xd04DxNNskDJ1jYBSGYskyfdu4/sYJKrI3ICkfFXR1BD
         dxddTnK0zbRRoY1nwZvLlQutsaQ9Q/q21zDmqbRd36mSCEoM3RcThXgN73X0KZX1+cae
         mi0eeuxXHxOKoIi+umQ4zKfmlo1Kq5qG2jypMo2upa68s9sFxikyn5iiZhTW06I2tp0W
         sf7dhktQyOEKkjfXY6zRsQ5FtC+tIBfT+ezdDmZED3OuY9JQYbY/pv5qAoM9tm0fW8KN
         r6vg==
X-Gm-Message-State: APjAAAUhOUK/tBgszZ9a6S/D2MejoQaLlgNsnNADOGd2lx85WXuqCbIw
        NaUqg/WnldZ/KRsXYeHXTY7GGPafNh085A==
X-Google-Smtp-Source: APXvYqzH75/KMsJQsqbLtTTlrQkvB/AVvoxCjMG/AIiJ9d9l7s1N6wiItuEC6MZCicCVWAeJl7Z5SQ==
X-Received: by 2002:a37:7685:: with SMTP id r127mr41100803qkc.166.1579296411718;
        Fri, 17 Jan 2020 13:26:51 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d5sm14057228qtk.96.2020.01.17.13.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 26/43] btrfs: hold a ref on the root in create_reloc_inode
Date:   Fri, 17 Jan 2020 16:25:45 -0500
Message-Id: <20200117212602.6737-27-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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


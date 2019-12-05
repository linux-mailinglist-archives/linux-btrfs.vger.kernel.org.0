Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB72B1146F8
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfLESgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 13:36:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46852 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 13:36:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so1973488pgb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rknafHQQd0fEz6WOANULYovuTGeKMLQRJ02D7s5rFOY=;
        b=pXrqv+V4dGLFjbro3GrAmKEerUp3z47OJtX8551+skE2SyLg0IQEtrio/s6nYi6ARR
         r8H7vTfAo/duuXzln31SUL5JmbPQkd4onBKaYloGOnqhkWIrZ5I1FdadZfFOzFCgOwvK
         njCT4bSwIr8C69gVGNRSQTcdW2d3lfsZdgVh89ytF51oKtUF6tLespluVfTKdLFGeDcK
         piapBFRhiTRd98+ICPTAFmHpZgt318mW8ILnD2pHiBnUD2uRHRCyhlZ7I3zGvGwUHvHf
         CWpiCIo55WTqyLTY7xPgxsF++782WYDFaR0kvRt8OdjsWXqB97IAdgec9IISdbJNbz33
         njpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rknafHQQd0fEz6WOANULYovuTGeKMLQRJ02D7s5rFOY=;
        b=Gby/SWQQfxQlIPrO6nWVTEH7fX105W95ivsmK/9tns+7Dt567YtJ+R9OA5Q2lvK70O
         n9COO08ilKA7WyKwVjK4x9ACqX28Btkx0eUs7e1560FNGwItLJzTiGqded9CcJSNzuoJ
         Hcg32JWtK6X0FdRXMEhHHW7ICuMEfbbCa0yml+KNvQXbl8Zy/rDH4C8ZeMB7GZ2eatbp
         Kw6X5Th+Ag3JctjSlT9Ol1CLdYsoSZ1OOGblP/H/3gZcy8kRWoNbb24z5k4OjGNAt4FG
         92DSj4ieE0ELz/FUt92zYkOfuzE3x/h7YBkl4Ohe8mrIFrA+1qbTcjDhNI1EDp3+Fvnp
         x94A==
X-Gm-Message-State: APjAAAUuArHWbRm7ip09hM05AddeOcceKVJrStMQ+12c17VXFDtYlgxR
        AkZr54toeOur+tK21FIk0XES5278bJZ8Ng==
X-Google-Smtp-Source: APXvYqxKhcxKS/u/7Sc60uz4xOSaFtgnQK3PzqpU2BLD8WiSYQmF7cGbmdVgvfvcIV3JGi8o0n0Kew==
X-Received: by 2002:a63:770c:: with SMTP id s12mr11195236pgc.25.1575570996588;
        Thu, 05 Dec 2019 10:36:36 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:cb2])
        by smtp.gmail.com with ESMTPSA id o12sm427873pjf.19.2019.12.05.10.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 10:36:36 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] btrfs: use simple_dir_inode_operations for placeholder subvolume directory
Date:   Thu,  5 Dec 2019 10:36:04 -0800
Message-Id: <3cc2030c10bcef05fe39f0fe2e8cdfb61c6c0faf.1575570955.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When you snapshot a subvolume containing a subvolume, you get a
placeholder directory where the subvolume would be. These directories
have their own btrfs_dir_ro_inode_operations.

Al pointed out [1] that these directories can use simple_lookup()
instead of btrfs_lookup(), as they are always empty. Furthermore, they
can use the default generic_permission() instead of btrfs_permission();
the additional checks in the latter don't matter because we can't write
to the directory anyways. Finally, they can use the default
generic_update_time() instead of btrfs_update_time(), as the inode
doesn't exist on disk and doesn't need any special handling.

All together, this means that we can get rid of
btrfs_dir_ro_inode_operations and use simple_dir_inode_operations
instead.

1: https://lore.kernel.org/linux-btrfs/20190929052934.GY26530@ZenIV.linux.org.uk/

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fec2a78de037..9dc84a88ef0c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -64,7 +64,6 @@ struct btrfs_dio_data {
 
 static const struct inode_operations btrfs_dir_inode_operations;
 static const struct inode_operations btrfs_symlink_inode_operations;
-static const struct inode_operations btrfs_dir_ro_inode_operations;
 static const struct inode_operations btrfs_special_inode_operations;
 static const struct inode_operations btrfs_file_inode_operations;
 static const struct address_space_operations btrfs_aops;
@@ -5846,7 +5845,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 
 	inode->i_ino = BTRFS_EMPTY_SUBVOL_DIR_OBJECTID;
-	inode->i_op = &btrfs_dir_ro_inode_operations;
+	inode->i_op = &simple_dir_inode_operations;
 	inode->i_opflags &= ~IOP_XATTR;
 	inode->i_fop = &simple_dir_operations;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
@@ -11001,11 +11000,6 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 	.update_time	= btrfs_update_time,
 	.tmpfile        = btrfs_tmpfile,
 };
-static const struct inode_operations btrfs_dir_ro_inode_operations = {
-	.lookup		= btrfs_lookup,
-	.permission	= btrfs_permission,
-	.update_time	= btrfs_update_time,
-};
 
 static const struct file_operations btrfs_dir_file_operations = {
 	.llseek		= generic_file_llseek,
-- 
2.24.0


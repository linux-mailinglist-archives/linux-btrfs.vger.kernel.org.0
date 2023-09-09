Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005037997D9
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 14:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjIIMIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Sep 2023 08:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbjIIMIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Sep 2023 08:08:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1E9E57
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 05:08:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C971C433CA;
        Sat,  9 Sep 2023 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694261326;
        bh=hsZtPCJ+rX/mWq0JlGLmAleKgG1TdwFskNinE5jZx/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8Q8AScpdN8BFNIgsQeorbhYxzlBqWGt4BJk86dmYD8VkDls2qQv6uewGyfXSekM2
         GsH9TQB/6p2LE1z/RSTFU3h+oCbABrq1R4NoWU/r5EFyJlzExJV7cCQPYFJKnncLhK
         /eC0/Jry6xu65f6/jHSDt2TaGYaBUPk6cmjkCYLAehtdIPPlvC96yTHgXXMk0LKcnC
         Lz5PRark6MsO5wGAHRK5E3160A+D36Oq9toTac7H+EZeQVIekz0HrUL9pIMFf13VWi
         FiNIAiyubjjtkgkVTh9xX93EGw/Hw4lMriTXB2L7BXWSotcW1wG8VZysuniwNFylNs
         5a+SwgsMHot+w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ian@ianjohnson.dev, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs: refresh dir last index during a rewinddir(3) call
Date:   Sat,  9 Sep 2023 13:08:32 +0100
Message-Id: <f2ce20268ec99d4d4e1392a200d75309a0b41acc.1694260751.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694260751.git.fdmanana@suse.com>
References: <cover.1694260751.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When opening a directory we find what's the index of its last entry and
then store it in the directory's file handle private data (struct
btrfs_file_private::last_index), so that in the case new directory entries
are added to a directory after an opendir(3) call we don't end up in an
infinite loop (see commit 9b378f6ad48c ("btrfs: fix infinite directory
reads")) when calling readdir(3).

However once rewinddir(3) is called, POSIX states [1] that any new
directory entries added after the previous opendir(3) call, must be
returned by subsequent calls to readdir(3):

  "The rewinddir() function shall reset the position of the directory
   stream to which dirp refers to the beginning of the directory.
   It shall also cause the directory stream to refer to the current
   state of the corresponding directory, as a call to opendir() would
   have done."

We currently don't refresh the last_index field of the struct
btrfs_file_private associated to the directory, so after a rewinddir(3)
we are not returning any new entries added after the opendir(3) call.

Fix this by finding the current last index of the directory when llseek
is called agains the directory.

This can be reproduced by the following C program provided by Ian Johnson:

   #include <dirent.h>
   #include <stdio.h>

   int main(void) {
     DIR *dir = opendir("test");

     FILE *file;
     file = fopen("test/1", "w");
     fwrite("1", 1, 1, file);
     fclose(file);

     file = fopen("test/2", "w");
     fwrite("2", 1, 1, file);
     fclose(file);

     rewinddir(dir);

     struct dirent *entry;
     while ((entry = readdir(dir))) {
        printf("%s\n", entry->d_name);
     }
     closedir(dir);
     return 0;
   }

Reported-by: Ian Johnson <ian@ianjohnson.dev>
Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnson.dev/
Fixes: 9b378f6ad48c ("btrfs: fix infinite directory reads")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df035211bdf0..006ca4cb4788 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5820,6 +5820,19 @@ static int btrfs_opendir(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static loff_t btrfs_dir_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct btrfs_file_private *private = file->private_data;
+	int ret;
+
+	ret = btrfs_get_dir_last_index(BTRFS_I(file_inode(file)),
+				       &private->last_index);
+	if (ret)
+		return ret;
+
+	return generic_file_llseek(file, offset, whence);
+}
+
 struct dir_entry {
 	u64 ino;
 	u64 offset;
@@ -10893,7 +10906,7 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
-	.llseek		= generic_file_llseek,
+	.llseek		= btrfs_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= btrfs_real_readdir,
 	.open		= btrfs_opendir,
-- 
2.40.1


Return-Path: <linux-btrfs+bounces-1846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D583EF4F
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 18:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A31F22159
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A40F2E635;
	Sat, 27 Jan 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CopMizgS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391B2E414;
	Sat, 27 Jan 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706378207; cv=none; b=Wvfozsons3jWbNtJv/g1mep1uGUhtFwYMkK/KUmxkKdsDJ1H683CpAIYRjxKTG/2DJJha5JU5ZU/Bp9WYrkC+3NGO3JQfBajSwZJaPzku06Qh2CaqPNGd3DFfkd+MRHqUVE4dlMOlgdpsNZU2kJ63M2ksTupSSXJEmFHQXppoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706378207; c=relaxed/simple;
	bh=pEnNZrXen7VnxSjfx0NojxEko5L+OzfrIM99xt+zBOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKtjBD8W8V591jRc1PY7ifR2Y2LX+O6EuuuG8e6831loinXsQbP96WirSF3POxrNOiH5Z9RWyV1ItAv8TFBEza3Zv5aQJAw+c2yZun2dui9ljiqB+hTWt75uvxPa5ncxHS/97N50LF8eNgJM0sHh0rrcm+aXhSsPzFteqKp9kQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CopMizgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660C9C43394;
	Sat, 27 Jan 2024 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706378207;
	bh=pEnNZrXen7VnxSjfx0NojxEko5L+OzfrIM99xt+zBOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CopMizgSrSMLM+mWKdUrnkb+ODSVdIxFTuMgTGl54VcP83jzv0iQpxEM7cTyU/wRj
	 1WjU+cAg96oQxqhn/G6WsIE6i3NBiUVn0waCz1BHeeVbal8eRj5lN+mwjrwINtyopQ
	 rNJB0xMsATWTmVTDmHS2JADqzySdWcpynm5uQI2PX3xra8iq+I7OFQRz7r7JoPpnMn
	 raZoYI3gBaCWrT7SUL1AuhQZNKqXGSXhJYzjoN43LIoZ9mlMRC9gVxmgBP81lt1Xxs
	 5xYJ44IlwajfyDLqyrWYQc/Fz0tBnrzEqOgRa0Sk4a3ejXj76olreyJHiZEHvuShBT
	 luQVK1SsMubMA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Ian Johnson <ian@ianjohnson.dev>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4 for 6.1 stable] btrfs: refresh dir last index during a rewinddir(3) call
Date: Sat, 27 Jan 2024 17:56:33 +0000
Message-Id: <9f532a81d33cfd2e241403fc2c861b85bada1b62.1706377319.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706377319.git.fdmanana@suse.com>
References: <cover.1706377319.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit e60aa5da14d01fed8411202dbe4adf6c44bd2a57 upstream.

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
is called against the directory.

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
CC: stable@vger.kernel.org # 6.5+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6f388fee0eee..aeae04b5cef4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6049,6 +6049,19 @@ static int btrfs_opendir(struct inode *inode, struct file *file)
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
@@ -11429,7 +11442,7 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
-	.llseek		= generic_file_llseek,
+	.llseek		= btrfs_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= btrfs_real_readdir,
 	.open		= btrfs_opendir,
-- 
2.40.1



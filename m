Return-Path: <linux-btrfs+bounces-1790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C5C83C187
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 13:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB59289980
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA045028;
	Thu, 25 Jan 2024 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYW6Kice"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C932182;
	Thu, 25 Jan 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184014; cv=none; b=V4hWDqF3E879tUX/H8I0Qx8OW4wDWKoNPTZ9NM0Cm5l9uvu2cL/Ghq2pnDis54VGwD5U+PXRLHV+gIypzrPN4EKf+TKQmU0hovBgBuC+aZWYHppC8tl/Lyo1y1Lw30oszFUsNOW/AT2sYn22Kk8bgMJb6UNeu+13UZhSTuvZ6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184014; c=relaxed/simple;
	bh=kRJsEQgQi3lL12yg1eN4B68tTZ85NhZPTmvEuKCcOFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCV2H/HRjIILn2GMbu2xs7UubppqRoBVwjIGBLn3qNH1PtgAWBRaW5sAO4bW/IK9yF28j1+yXHHNiy5tyRPXZ4rBswcCgGCCIGBRxpiwLM+IQ1n6X2Ev0tD4WmZTv/KOkymiy1JY+h5a8om4vs7jLljZz1POedCQ4BAWw5tuudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYW6Kice; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10072C433F1;
	Thu, 25 Jan 2024 12:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706184014;
	bh=kRJsEQgQi3lL12yg1eN4B68tTZ85NhZPTmvEuKCcOFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYW6KiceeEoOHLi+Ma+xG81Y/S7B6AwEql+LDqb8K9m8t+f3G3YjfjoYJWS61TWTZ
	 tWuI/14VTDJ80/0D8shRqPFq/JoDe3/PRxHTzwa0TLAEq5ValBxSKStCgHwo1tlHfv
	 Tg1duCY2RiuNunWglau7RMLPWpiW8iemXd2lGNjafiRwoIb5VOgNmibDOV/7Sq8v/U
	 wRLWnMswiodbgLMH2BLoDdUz+XRA/jkhNGkBrgH81BXXJHftesPXQHGM1umBGhguTG
	 v4TA/xLJFBHG6GI2068F1cpTbXwkr7IHNj6vveTku93iyC00gnklUtW5zDPx4x+of+
	 1NUHEHoHBs6Nw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: erosca@de.adit-jv.com,
	Maksim.Paimushkin@se.bosch.com,
	Matthias.Thomae@de.bosch.com,
	Sebastian.Unger@bosch.com,
	Dirk.Behme@de.bosch.com,
	Eugeniu.Rosca@bosch.com,
	wqu@suse.com,
	dsterba@suse.com,
	stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Ian Johnson <ian@ianjohnson.dev>
Subject: [PATCH 3/4 for 5.15 stable] btrfs: refresh dir last index during a rewinddir(3) call
Date: Thu, 25 Jan 2024 11:59:37 +0000
Message-Id: <acbd885da4e8e7076c11bbcc31e0f6090cc10201.1706183427.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706183427.git.fdmanana@suse.com>
References: <cover.1706183427.git.fdmanana@suse.com>
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
index b144e346f24c..b7047604d255 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6222,6 +6222,19 @@ static int btrfs_opendir(struct inode *inode, struct file *file)
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
@@ -11087,7 +11100,7 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
-	.llseek		= generic_file_llseek,
+	.llseek		= btrfs_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= btrfs_real_readdir,
 	.open		= btrfs_opendir,
-- 
2.40.1



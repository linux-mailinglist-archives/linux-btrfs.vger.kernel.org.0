Return-Path: <linux-btrfs+bounces-2611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2785DA6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 14:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21205285FD7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB237D41B;
	Wed, 21 Feb 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FTe8C0uK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62F69D2E;
	Wed, 21 Feb 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522081; cv=none; b=ZyxMsaQLnXIW4lk9QEvXqXV7c+9xMiNo/VGYSBzP68T7ExQ7sgd80YfDcg1HNotYwt1C/lb0Jx/fuYL6JyC/6yS8vXeTet30e8+bEldoZXGw0efvU+TT3gl2Za0LyCnYHjtFyqNZVbgNttiUL/8xEnbEvi82WK+pvAUod2sZJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522081; c=relaxed/simple;
	bh=XN+YSLiyxzttMMnZFmMfSgdr0IpfNAjmGBUyFFF6ZS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJB7TlRWgbw9VYlm8ylvQP9kX5dZjey7sGEPhPrNlTBYl6LC/MxImnn5M+CJI8nVwiHScpAhmYyWWdwt6jRST/L+Dyl6Na+ewBAxupqCzW5CFNbKReN48+KFcKkVgBspn0jPYYB8meKFRScmZ2Fajd4PJ1ZHe75Gz+hDAoDNlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FTe8C0uK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A69C433C7;
	Wed, 21 Feb 2024 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708522080;
	bh=XN+YSLiyxzttMMnZFmMfSgdr0IpfNAjmGBUyFFF6ZS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTe8C0uKO0yAbgNHV2pGlY9MR82BYjGq9LX8yWbgLbCgxBdPJBvMs4p18NzzHMQ4l
	 NiyUxJ8F0wPidXjZPIIxpPAStUtIXtMxuVWsuEIJQEJ6h+tCDcqaf5PtlvwoxnZsZD
	 fgPKqfMUjR8M6KsFZC50Dd0i9TaJlkAIZa214pko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Johnson <ian@ianjohnson.dev>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Eugeniu Rosca <eugeniu.rosca@bosch.com>
Subject: [PATCH 5.15 074/476] btrfs: refresh dir last index during a rewinddir(3) call
Date: Wed, 21 Feb 2024 14:02:05 +0100
Message-ID: <20240221130010.695342401@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6222,6 +6222,19 @@ static int btrfs_opendir(struct inode *i
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
@@ -11087,7 +11100,7 @@ static const struct inode_operations btr
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
-	.llseek		= generic_file_llseek,
+	.llseek		= btrfs_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= btrfs_real_readdir,
 	.open		= btrfs_opendir,




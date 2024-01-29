Return-Path: <linux-btrfs+bounces-1908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C1840EC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C051F29853
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B388160890;
	Mon, 29 Jan 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="imjblAkd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9715703F;
	Mon, 29 Jan 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548340; cv=none; b=aTbrtXHfVIHyUSI1pRmuE4vq7Wd0Enlmo9+99PhHsJlhIFHtnq2IUyucFt/mv0mRqAGQPmLWaHDkgRHCg1DaNC8TZutiViYgOSyR9Bp5oed6L0tKQoCYmhk6nddnTfcqYSP8tgw1+QJFwoc5L+mOHurFRY+pQ9+z7oyzQ1AXOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548340; c=relaxed/simple;
	bh=GXVsOpJzz0+W8UwQZXnp4cGpAyisnLpLNo7eCSIhyzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QprA8kjtYY8dCP2o5CCcvPsXcyN0PMe7sYtyDnJZRxKFHlYfnGGnIdgPwACDKW0JM6qgG0U7nRmKHuRLvi6OsL0n248fOKlr3gdbvXYcB1mcrH00NadXQCOyS2G9+S/f/BPcJalLJhMkg8aMgIL07A4aSNrrKcSbqSEFkjfRksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=imjblAkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC50C433C7;
	Mon, 29 Jan 2024 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548340;
	bh=GXVsOpJzz0+W8UwQZXnp4cGpAyisnLpLNo7eCSIhyzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imjblAkdcMq1BcwLeIaNgHWqpA+Q8V5Iq42L2zeZXHRqTj+4MpbDk8/WC4vfGl/kC
	 LT1KnhPKBNIedYgdxRdRK6O0ZNwqpWPKExgYhsh3Rn2NwvdKAzoHdFCNJESHNF/fXw
	 PLfLw7zWkbcyFodwsB7A6B4ZZB9P+v9LoC65Fy80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Johnson <ian@ianjohnson.dev>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 105/185] btrfs: refresh dir last index during a rewinddir(3) call
Date: Mon, 29 Jan 2024 09:05:05 -0800
Message-ID: <20240129170001.966469178@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
References: <20240129165958.589924174@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6049,6 +6049,19 @@ static int btrfs_opendir(struct inode *i
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
@@ -11429,7 +11442,7 @@ static const struct inode_operations btr
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
-	.llseek		= generic_file_llseek,
+	.llseek		= btrfs_dir_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= btrfs_real_readdir,
 	.open		= btrfs_opendir,




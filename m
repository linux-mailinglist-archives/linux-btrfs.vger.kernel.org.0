Return-Path: <linux-btrfs+bounces-1907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D20C840EBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6032E1C2364E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446F160883;
	Mon, 29 Jan 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M5mEIV3I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728115703F;
	Mon, 29 Jan 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548339; cv=none; b=Dib6YpJKI8hUcNYgAxOBM8PiPJ+zWKJyxxjbV4LtgLl6hlIgd0GXlGeNmHHvqk22MNpFGbRE+nsVUaSNyoQguyAX2nzQjRUgduAUFxWY1OfuIE2LMdNV8qgB5MLj85QWgbT8c01f/uBfSjBbVF2TX8Ptq1bN30rra/Y2s3AZUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548339; c=relaxed/simple;
	bh=EDZzqiUwWxx9kAeKt5Ob0yqoj6SyPBOyVlBIgbX+nus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiHovT4OIPKRR/Hk3NjlSSdMKk5ym7HBVFbwRwvkzD8cF556jyMxSf3yaepBFVQFHGotlua3nW5WeqUuuqlGkfvZ03mQ8vHja9bnQjpIO2l3mzVQVU8gPVCBMefj48SHfuK6roWtbcHpMBPwo5A6FooL1GkBitoqnduAEJl8ju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M5mEIV3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECBEC433C7;
	Mon, 29 Jan 2024 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548338;
	bh=EDZzqiUwWxx9kAeKt5Ob0yqoj6SyPBOyVlBIgbX+nus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5mEIV3IG8QWRF0KaRr8qGd5iolqKD78HE7SKobQBaEXSiaBtVy9mwL420f0ue0Lg
	 +Q2uolYKMZARhtVhz7ZtQzth7VIoTbHbHpe/Pmbb50cEg36CrHE12wWUsEXUFe5XWp
	 6J91Di7h77MeOb3LZsG1ZBAIFSYZ3YvziXc2iMU8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 104/185] btrfs: set last dir index to the current last index when opening dir
Date: Mon, 29 Jan 2024 09:05:04 -0800
Message-ID: <20240129170001.933489913@linuxfoundation.org>
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

commit 357950361cbc6d54fb68ed878265c647384684ae upstream.

When opening a directory for reading it, we set the last index where we
stop iteration to the value in struct btrfs_inode::index_cnt. That value
does not match the index of the most recently added directory entry but
it's instead the index number that will be assigned the next directory
entry.

This means that if after the call to opendir(3) new directory entries are
added, a readdir(3) call will return the first new directory entry. This
is fine because POSIX says the following [1]:

  "If a file is removed from or added to the directory after the most
   recent call to opendir() or rewinddir(), whether a subsequent call to
   readdir() returns an entry for that file is unspecified."

For example for the test script from commit 9b378f6ad48c ("btrfs: fix
infinite directory reads"), where we have 2000 files in a directory, ext4
doesn't return any new directory entry after opendir(3), while xfs returns
the first 13 new directory entries added after the opendir(3) call.

If we move to a shorter example with an empty directory when opendir(3) is
called, and 2 files added to the directory after the opendir(3) call, then
readdir(3) on btrfs will return the first file, ext4 and xfs return the 2
files (but in a different order). A test program for this, reported by
Ian Johnson, is the following:

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

     struct dirent *entry;
     while ((entry = readdir(dir))) {
        printf("%s\n", entry->d_name);
     }
     closedir(dir);
     return 0;
   }

To make this less odd, change the behaviour to never return new entries
that were added after the opendir(3) call. This is done by setting the
last_index field of the struct btrfs_file_private attached to the
directory's file handle with a value matching btrfs_inode::index_cnt
minus 1, since that value always matches the index of the next new
directory entry and not the index of the most recently added entry.

[1] https://pubs.opengroup.org/onlinepubs/007904875/functions/readdir_r.html

Link: https://lore.kernel.org/linux-btrfs/YR1P0S.NGASEG570GJ8@ianjohnson.dev/
CC: stable@vger.kernel.org # 6.5+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6011,7 +6011,8 @@ static int btrfs_get_dir_last_index(stru
 		}
 	}
 
-	*index = dir->index_cnt;
+	/* index_cnt is the index number of next new entry, so decrement it. */
+	*index = dir->index_cnt - 1;
 
 	return 0;
 }




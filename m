Return-Path: <linux-btrfs+bounces-1852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1183EF68
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 19:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AA01F23143
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CEB2E644;
	Sat, 27 Jan 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGppRVT/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CE2D638;
	Sat, 27 Jan 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706379353; cv=none; b=WIDUjLbLY5V/k1nMFfSoZm+0bBruL/69njWZnn1BbPFdpUHnt0vRp5elC9On7TyJBNWjWoDvXch1vl00zRNy6QJBG82IBGmM1PcjMMVxlXM1PwQRyz8/3O6s87FDvt9Dzvf/ZKm9lCtXlkQx2OuG8LxzzRCaVtLGp8GC5KhnDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706379353; c=relaxed/simple;
	bh=fJ5Vz/CLlUPwcKzrWVl+NJkVcs0WitnIAZT2qmKuta4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APtYA4DatY3g6jvExW/OMarugp9LhX4yXByY11I1qYlDpb8taNwpsudfTNooEREhng9H49IM6Yq7i/FOOlT8+kg3eM2WSMNxZfsSKyqrc6WCykRn5vzUeV7tfcZXuS8SsicfDrTHeiDoOw9zcWcHxZ9e10aLeAc0Xkl/a6swlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGppRVT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31F4C433F1;
	Sat, 27 Jan 2024 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706379353;
	bh=fJ5Vz/CLlUPwcKzrWVl+NJkVcs0WitnIAZT2qmKuta4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YGppRVT/WVXahr2lEzv0dAFk2MfPFKe8YqKwXN5aTPuU7mATC1Vw2EFqmCaucUQNv
	 Qoy8QmT8PKRdNCFXzfG69vYtIBXBIqdMC62IthRjhgg7/bTYUOcj7fQYEmdtYW+V8/
	 bo0xIvdifxbRmaXUu1/TtxxBC8s4bUnvepyV9HFV9IC/gimH+8u8y061wuruHNYoTL
	 xSitsQzvrgiLHV/wIBpCWzvGSR4TV1Lr5mbO2VSsfABv7TOsC1jEFGlxv+arub9bfc
	 axQTv0YJGRJx4Hgj8KhclQlZY4xM6zmAVZOv97hMyVC/QamiBxr/IfMI5GBhLo4IRC
	 iUn+MBXXAQV5A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/4 for stable 6.1] btrfs: set last dir index to the current last index when opening dir
Date: Sat, 27 Jan 2024 18:15:40 +0000
Message-Id: <756f4eeb62e16d3eefd3c7d40a5b9b372dca45a2.1706379057.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706379057.git.fdmanana@suse.com>
References: <cover.1706379057.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a406f0ac5f74..6f388fee0eee 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6011,7 +6011,8 @@ static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
 		}
 	}
 
-	*index = dir->index_cnt;
+	/* index_cnt is the index number of next new entry, so decrement it. */
+	*index = dir->index_cnt - 1;
 
 	return 0;
 }
-- 
2.40.1



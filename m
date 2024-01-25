Return-Path: <linux-btrfs+bounces-1789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC583C18B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 13:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E75B2955F
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B945036;
	Thu, 25 Jan 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvUZ//7D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669B41742;
	Thu, 25 Jan 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184012; cv=none; b=Gd4FX3gwGKUDvSElddhdGZ1C1wmIJfBAhladHAXlyWeNezCwmYZzy8pyYZf8IfAAgP0zbrlBLG+KSnCyMjtYneghKCOCPFlz/+adQ+01tnMXHoE5F0r/L+4itMK3b6lgzteBeGweeYNVsGIg+U+rvGbO8bcNflOcsOivqjbJuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184012; c=relaxed/simple;
	bh=2y68cXdxGyYR00VS2EWrdnrmZgkelcA9Pf8uW0aHs5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZaoE3nOYSwFcKvyzL7xClyyBACUVYxdjbkAhsFjqnvAgRMllFDgFac1YTr7nLjs0G073MT4a36D3BhRk/Ei2C2TRg2iv9czCMMmHc4MGUJAI8ZiUnLEDKxt/zvohMVGLJmmW+HLEN2e+jTD8BkEQiM52erybM2TpXxEKry4QucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvUZ//7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE32C43390;
	Thu, 25 Jan 2024 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706184011;
	bh=2y68cXdxGyYR00VS2EWrdnrmZgkelcA9Pf8uW0aHs5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvUZ//7D/c/WF3nACqyRZNrgJkqqm1i4mWztll4AwhFJjPOUbKmlJhIQcdMyJHA/X
	 IoOCpfZDNKg89zQsgjTvnam3LZWyGPSHUvuT0o0RCyWYJNb6MiNgFBovOgXFVjZRoG
	 1ziGabsd4cov/Qbb2LtGYH0Q18dRAMER46PSsx8XpdB6WTh8UZa4yOnXJCxDJ03m6b
	 bSror8OS86Tf8PPgcA1YSZweAdT12VYWCaeFN6w0nyhSXLAyraxMT1qgqITEYCLInR
	 HY6H7LMEyIeOs0xXVh1kQ6c2tEeTguBE4tHqaM0TBTJhhGJWnhQtW+IfECNkK/ajht
	 a7gl25N9N0Gqw==
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
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/4 for 5.15 stable] btrfs: set last dir index to the current last index when opening dir
Date: Thu, 25 Jan 2024 11:59:36 +0000
Message-Id: <b433c98aae18577662767e98d4119450913dc516.1706183427.git.fdmanana@suse.com>
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
index 1df374ce829b..b144e346f24c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6184,7 +6184,8 @@ static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
 		}
 	}
 
-	*index = dir->index_cnt;
+	/* index_cnt is the index number of next new entry, so decrement it. */
+	*index = dir->index_cnt - 1;
 
 	return 0;
 }
-- 
2.40.1



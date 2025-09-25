Return-Path: <linux-btrfs+bounces-17198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBDDBA1E89
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 01:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA161C83A73
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61042EC094;
	Thu, 25 Sep 2025 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyz9KbF7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F02EA754;
	Thu, 25 Sep 2025 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841401; cv=none; b=uchRFma3WZr+bcBD8YYW6tvOTNjhvg7ZHRj7my/CIaINNglSsFZE2Ev24Vg4g0w4oGY7jY++sswjXIqm4/3ZCmP3m9jCTQLxvmfwY6TEYNJXTOgtmnSdAEjD1CqQGbKrDaoi51LG9J7dLex0tTlnKwf2Sozdna8Pq2pygA8NVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841401; c=relaxed/simple;
	bh=zkqIIa2xV06FUQdGkqXJ02AOCm50ZPKMdRML6Bevq4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cUv4csNFYDLTTI6tbZgMLOxrjNUImUdKbWLNFgY8rnG4FIn8dPHY7xWyEVFUDaCFy6kZiOs2SvnhYcQXIcqgsFJjojd3i+ArAqN+oXy+0ITOtaoMVkbsyJ6ZvxQwL9ZuErYfbsizGnRUtmp/Gj1iroBNEWFUsicGwAcTRFwFfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyz9KbF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FD6C4CEF0;
	Thu, 25 Sep 2025 23:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758841399;
	bh=zkqIIa2xV06FUQdGkqXJ02AOCm50ZPKMdRML6Bevq4I=;
	h=From:Date:Subject:To:Cc:From;
	b=cyz9KbF7wH2Bx9PSOK+EvWdJXpi/H+KCq+ENfhk9Z9p/EgWXEHAwBfMkOYjBSxZin
	 c+wDecUpYC70N02y9jOwmI7kb3o+bvJ7DkYcG2JcaBWfUlK1RY4kAfIF/Da27/TEEl
	 TYmyLwDWElEGB6RhXF691v0MQMaVkKOPw8oSWe8gQPR15b4ORq03fvohbi2xIaRqlV
	 IYm8qdjOsXh5e1fdkMzNpS+KUspL6eL3krghq7RsRedD5Ag4F5MFlrilhWeBAwMI0C
	 yJcDqZ6AbYn6h1/3bnssqF8mVT4k+g80V0hsX4hP9GLJ7DMQSDlJTtDwbqJ5QHILEd
	 udE0EQNyCxa8Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Sep 2025 19:03:04 -0400
Subject: [PATCH] btrfs: Fix PAGE_SIZE format specifier in open_ctree()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-btrfs-fix-page_size-format-specifier-v1-1-8f98d300a909@kernel.org>
X-B4-Tracking: v=1; b=H4sIACfK1WgC/x2NwQqDMBAFf0X23AUNRIi/UkrZpi+6h2rYlVIq/
 ntDj3OYmYMcpnCauoMMb3Xd1gbDpaO8yDqD9dmYQh9in0Lkx27FueiHq8y4u37BZbOX7OwVWYv
 COAySJI9xTAXUUtXQjP/mejvPH+vMrj92AAAA
X-Change-ID: 20250925-btrfs-fix-page_size-format-specifier-21a9ac6569fe
To: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=nathan@kernel.org;
 h=from:subject:message-id; bh=zkqIIa2xV06FUQdGkqXJ02AOCm50ZPKMdRML6Bevq4I=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBlXT5kmmcps8ud87Glv4qF+4/n0uyujzPdlBpeEtQlF5
 C3pepDTUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACaytYPhf1au3CypuFmxyuv3
 s++9qczn8mjfhN83iq6XMl/Na7E718zIMH2eZGvhnU/bfwgeVHdfP+ffLQPn50JLs9wy8rMu31y
 SyQsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

There is an instance of -Wformat when targeting 32-bit architectures due
to using a 'size_t' specifier (which is 'unsigned int' for 32-bit
platforms) to print PAGE_SIZE:

  In file included from fs/btrfs/compression.h:17,
                   from fs/btrfs/extent_io.h:15,
                   from fs/btrfs/locking.h:13,
                   from fs/btrfs/ctree.h:19,
                   from fs/btrfs/disk-io.c:22:
  fs/btrfs/disk-io.c: In function 'open_ctree':
  include/linux/kern_levels.h:5:25: error: format '%zu' expects argument of type 'size_t', but argument 4 has type 'long unsigned int' [-Werror=format=]
  ...
  fs/btrfs/disk-io.c:3398:17: note: in expansion of macro 'btrfs_warn'
   3398 |                 btrfs_warn(fs_info,
        |                 ^~~~~~~~~~

PAGE_SIZE is consistently defined as an 'unsigned long' in
include/vsdo/page.h so use '%lu' to clear up the warning.

Fixes: 98077f7f2180 ("btrfs: enable experimental bs > ps support")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 21c2a19d690f..f475fb2272ac 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3396,7 +3396,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	if (fs_info->sectorsize > PAGE_SIZE)
 		btrfs_warn(fs_info,
-			   "support for block size %u with page size %zu is experimental, some features may be missing",
+			   "support for block size %u with page size %lu is experimental, some features may be missing",
 			   fs_info->sectorsize, PAGE_SIZE);
 	/*
 	 * Handle the space caching options appropriately now that we have the

---
base-commit: d54be55d7a5eb9ee0a758580079adb2808d71a25
change-id: 20250925-btrfs-fix-page_size-format-specifier-21a9ac6569fe

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>



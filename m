Return-Path: <linux-btrfs+bounces-18514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC022C28AC0
	for <lists+linux-btrfs@lfdr.de>; Sun, 02 Nov 2025 08:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A823A4635
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Nov 2025 07:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2D25A2CF;
	Sun,  2 Nov 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="JKibTKdR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="uJ2IYfGQ";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="lkl5+76r";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="POdbh/k2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender6.mail.selcloud.ru (sender6.mail.selcloud.ru [5.8.75.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4743136658;
	Sun,  2 Nov 2025 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762069188; cv=none; b=DTUwGEEYxCQUYCaLvxd5L78NuCHea5Q9k7lRlT1E4Bl+VzbWHa+OAt2JFVb5GN7oWL04GtFYiDdqqLaHYa2FR6GqkCiN2kHckdI0FEHdf5Gxm4UH5Qxxx/4X+E9RgxrJomwZmqo5eCDnyG7Qo45w10EjvXnTccCzsnDZRmRFSP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762069188; c=relaxed/simple;
	bh=eLYKpA2M2bNBddBLyNndMvM8FJM1mDsigEhFCCBvXzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnbJPEJVW/nx1gDeXlF4m4p1DcA3Frhy4fjfaRKfqNpFrvg23ACRMcgOaDG22m6PgkSq5JVTCrRbXXcOotaPu/42D/SBjdfCr5iExIU2s2Fl3DCqaloryTIQXgr/GzlbC3BdpUs4dAwvm2sTBLvYfHnBhid3BjSdovqj5Eg8fLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=JKibTKdR; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=uJ2IYfGQ; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=lkl5+76r; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=POdbh/k2; arc=none smtp.client-ip=5.8.75.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xyX37y0QHKkl6URbf2G3KEuVSSvC55xkAI8knVnPPW0=; t=1762069184; x=1762241984;
	 b=JKibTKdRki2uuoPv4FzqKbgfRPCLgsylQ8t6UreQwpNbp/KaRO7Cw32S6JXmfUbPAp9AdUmvxK
	z8HyWA71ReHTgbVDvVNJW/VoiQ16gNE15I+7PX5xfm1tziNNfkkQwJX/sdNw5GMvsjWsGLGUGn6SL
	5SiVkQZCyVky0903EeRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Help:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=xyX37y0QHKkl6URbf2G3KEuVSSvC55xkAI8knVnPPW0=;
	t=1762069184; x=1762241984; b=uJ2IYfGQ3WSxeO3pyDOwqTwuV9tVDOkdMK2PJBUa3EAZaFr
	oxsXCB7VYEoLlVFyinN6VeLKcybk67v8GEYjwDMk7KJimvsSHl+vhYywX7Xqm9+e+Xi7ZTc4nArRk
	iuhQqDmqYeMr913Z5gRI/6Rr0cq8uIC2sq79UR5qC3natXI=;
Precedence: bulk
X-Issuen: 1402959
X-User: 149890965
X-Postmaster-Msgtype: 3849
Feedback-ID: 1402959:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251029.201254
X-SMTPUID: mlgnr60
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762069174; bh=xyX37y0QHKkl6URbf2G3KEu
	VSSvC55xkAI8knVnPPW0=; b=lkl5+76rn8jhNBcJsG3ROCixwYDlV+ShD8oFSPzCagXQNxlNWK
	7BYAI2t52Ye3FKusKmpROiHq6B9BJ1rnvtEFWzK1Col2goxpTGrZtHHCFht6EchCp4irB/652iy
	fy3zWkJKm+HP7TFcHji3UKsjQjO0Qc1848HKF/YQtKGoOjL5HpTFDGJ+2DS6zYA3t/Y7vEjLpyq
	gflW+DJRYFC4PMjUN5hmal/VVf/jNlOc51f3roSmFPIawELW6kkAPjwiMRvyyc0NYyJ6Fh8eJbK
	g/jAYQsZeiPJkGx/JG7CL9QzWMt8wAZCgJhhNTSPMz9zzDfjx3Z3ItbvwNkthoaW/Vw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762069174; bh=xyX37y0QHKkl6URbf2G3KEu
	VSSvC55xkAI8knVnPPW0=; b=POdbh/k2luigw82WnO9sAWv9IWUPaTkCFW+EDUQfZOGVg8ClKb
	0feJ8JwD1OusEfcGzzI7td2dCS36jlgu1BAw==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: make ASSERT no-op in release builds
Date: Sun,  2 Nov 2025 10:38:52 +0300
Message-ID: <20251102073904.2149103-1-foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current definition of `ASSERT(cond)` as `(void)(cond)` is redundant,
since these checks have no side effects and don't affect code logic.

However, some checks contain READ_ONCE or other compiler-unfriendly
constructs. For example, ASSERT(list_empty) in btrfs_add_dealloc_inode
was compiled to a redundant mov instruction due to this issue.

This patch defines ASSERT as BUILD_BUG_ON_INVALID for !CONFIG_BTRFS_ASSERT
builds. It also marks `full_page_sectors_uptodate` as __maybe_unused to
suppress "unneeded declaration" warning (it's needed in compile time)

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
Changes from v1:
- Annotate full_page_sectors_uptodate as __maybe_unused to avoid
  compiler warning

Link to v1: https://lore.kernel.org/linux-btrfs/20251030182322.4085697-1-foxido@foxido.dev/
---
 fs/btrfs/messages.h | 2 +-
 fs/btrfs/raid56.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 4416c165644f..f80fe40a2c2b 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -168,7 +168,7 @@ do {										\
 #endif
 
 #else
-#define ASSERT(cond, args...)			(void)(cond)
+#define ASSERT(cond, args...)			BUILD_BUG_ON_INVALID(cond)
 #endif
 
 #ifdef CONFIG_BTRFS_DEBUG
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0135dceb7baa..302f20d8c335 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -299,8 +299,8 @@ static int rbio_bucket(struct btrfs_raid_bio *rbio)
 	return hash_64(num >> 16, BTRFS_STRIPE_HASH_TABLE_BITS);
 }
 
-static bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
-				       unsigned int page_nr)
+static __maybe_unused bool full_page_sectors_uptodate(struct btrfs_raid_bio *rbio,
+						      unsigned int page_nr)
 {
 	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	const u32 sectors_per_page = PAGE_SIZE / sectorsize;

base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
-- 
2.51.1.dirty



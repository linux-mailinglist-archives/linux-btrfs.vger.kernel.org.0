Return-Path: <linux-btrfs+bounces-12032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC166A506B0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E335D1891389
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A92512E8;
	Wed,  5 Mar 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAgA6LWM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA832512D9
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196760; cv=none; b=er1qneHdNZwkWGTI3Tk9qTJwtPrzLTSRyBCTiWkd9+QLEIBdmfwg2TF/77qPWDIucc3qg3wkOmVtXtFjalR3HmsMH+rKMbhcNnZnaOsUEPgjUyXRV43F81cSn6TzyDBCRcyqOd5p83vqlWb+z/IA82NTI+gLUFQN72MII3ynqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196760; c=relaxed/simple;
	bh=UWVLiD4f7nvJaf4OdEkWZ/tDZYdLBqAGx4ZsEmp01co=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfumyld/SZpvv8KER4yJFnxwR0PalIZTSwnvegTZxXnrcMFFHgpidqmbjv9GPRXaeuchyUrOoJBUVMJvEh6vJph6JAI1eDvScupjjfqeZlzHovHIU0wpXkkOrUNLpOddBKRLAbyqRzV8OSJVxq9Bv7LwXB07yHp74TFwLBy+V74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAgA6LWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AB5C4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196759;
	bh=UWVLiD4f7nvJaf4OdEkWZ/tDZYdLBqAGx4ZsEmp01co=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gAgA6LWMxkeBeBuLkO/6rum5gpdCquoSl86bD2Xj+iYwobOJRUxwurwgSrHLAbakj
	 5lvPstVy7Thm4TudCek7ykU4HHfPzEBUBHnwcXrIxwfWJSjeaphdeH68BgzeoBYjMu
	 Lr+oVvdbp06/9uatkVrpdkJVhJB7gghQLrdfwTzmUB6Jt+KF1BwueNT0cl6iCW51Z6
	 qsCjvVgg5VTVTyadY7YAd281r4WTRM04rGTpGhuEj881j9B/K9qJaIFxhqejroQagW
	 WmskwZh+jdtK0zXcd5WwCeBBoQ0CzPzS3+T4SuBorQ9Ee557QsOt886guJimy/4OUl
	 SWcntKedVRMEQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: move btrfs_cleanup_bio() code into its single caller
Date: Wed,  5 Mar 2025 17:45:50 +0000
Message-Id: <6b96e8cc67e95a3d1bac6f0974e2b5ee3824dd43.1741196484.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741196484.git.fdmanana@suse.com>
References: <cover.1741196484.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The btrfs_cleanup_bio() helper is trivial and has a single caller, there's
no point in having a dedicated helper function. So get rid of it and move
its code into the caller (btrfs_bio_end_io()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/bio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 07bbb0da2812..e9840954bf4a 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -97,21 +97,17 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 	return bbio;
 }
 
-/* Free a bio that was never submitted to the underlying device. */
-static void btrfs_cleanup_bio(struct btrfs_bio *bbio)
-{
-	if (bbio_has_ordered_extent(bbio))
-		btrfs_put_ordered_extent(bbio->ordered);
-	bio_put(&bbio->bio);
-}
-
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
 	bbio->bio.bi_status = status;
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
 		struct btrfs_bio *orig_bbio = bbio->private;
 
-		btrfs_cleanup_bio(bbio);
+		/* Free bio that was never submitted to the underlying device. */
+		if (bbio_has_ordered_extent(bbio))
+			btrfs_put_ordered_extent(bbio->ordered);
+		bio_put(&bbio->bio);
+
 		bbio = orig_bbio;
 	}
 
-- 
2.45.2



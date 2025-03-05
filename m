Return-Path: <linux-btrfs+bounces-12036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11F7A50988
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 19:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56A3168E05
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199525486B;
	Wed,  5 Mar 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ2Ii9CX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04425487E
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198677; cv=none; b=BkfI7fpoQe6n+pPzqQOTUXF/3yk543m53YBIQQLJkJAiNjS3ytD232eFdUS9jhlpLJcBcLPKcvIVkKbAuPMkP737tatXL6u9+uLBtkXRDfx3hLyEnX3kp5PSv9EbkEW+s4oZsNWMYg9saVqZ1tWOyrV1KjRnSVYs6mEjMrYSCJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198677; c=relaxed/simple;
	bh=MgWOsgZqI5T8K169gZV9TDzeg88d/7NeM/BpQfmy4nw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtjC7F45UxBACdPGIWX2kJ0hgnE78hduEGGycRzVo6nV4MffP+/ZvZyXjSe5aFLRSiOzkHCNfckMnCjDJaxIi4DhXN8oVfcI+MdhrnW0pDFlRkH0d3AT7rm8lbIBF6CTZpLeqzQ/Mw4APFALXGW2060+jVePEW5hPwM3JW/xRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ2Ii9CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0098C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198677;
	bh=MgWOsgZqI5T8K169gZV9TDzeg88d/7NeM/BpQfmy4nw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KJ2Ii9CXvZJS12EFKKsdHjyc5vyCn47nepdXefTsfNRgsEKf5MAqu4AFn4ABKDXFS
	 6VjkIba//7LQUkOnotJGvBUSf5760IDy/AV35Kj/FHU7V4lPO0tdrTo96eHmubPNHW
	 IYpBjfpv64SJukJWPH5irK/m3ZmEpJSpUwR8iHq5Gh82dFLJBhJDeGx+YTfPUrlBE5
	 s9E+XsLMQdSc6UwHSKNwaKxpPhViRYvrqbPYItRKlUqGuuThus6VTfsuNcnVX47j+V
	 77e2/PSmK9MKB8wQ41xUM2QTkwBQjUQxHluU52StqHWHiQVRwRp1jZ8TZMCn/rQmGX
	 4QdHADNhpC2gg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: move __btrfs_bio_end_io() code into its single caller
Date: Wed,  5 Mar 2025 18:17:49 +0000
Message-Id: <ae393f17bac40dae2b27f13403825c4a7a29d77e.1741198394.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741198394.git.fdmanana@suse.com>
References: <cover.1741198394.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The __btrfs_bio_end_io() helper is trivial and has a single caller, so
there's no point in having a dedicated helper function. Further the double
underscore prefix in the name is discouraged. So get rid of it and move
its code into the caller (btrfs_bio_end_io()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/bio.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2f32ee215c3f..07bbb0da2812 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -105,18 +105,6 @@ static void btrfs_cleanup_bio(struct btrfs_bio *bbio)
 	bio_put(&bbio->bio);
 }
 
-static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
-{
-	if (bbio_has_ordered_extent(bbio)) {
-		struct btrfs_ordered_extent *ordered = bbio->ordered;
-
-		bbio->end_io(bbio);
-		btrfs_put_ordered_extent(ordered);
-	} else {
-		bbio->end_io(bbio);
-	}
-}
-
 void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
 	bbio->bio.bi_status = status;
@@ -138,7 +126,15 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 		/* Load split bio's error which might be set above. */
 		if (status == BLK_STS_OK)
 			bbio->bio.bi_status = READ_ONCE(bbio->status);
-		__btrfs_bio_end_io(bbio);
+
+		if (bbio_has_ordered_extent(bbio)) {
+			struct btrfs_ordered_extent *ordered = bbio->ordered;
+
+			bbio->end_io(bbio);
+			btrfs_put_ordered_extent(ordered);
+		} else {
+			bbio->end_io(bbio);
+		}
 	}
 }
 
-- 
2.45.2



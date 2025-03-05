Return-Path: <linux-btrfs+bounces-12037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C9A509AE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 19:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F87E7A9987
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE53254B08;
	Wed,  5 Mar 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/49ksyr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA25254AFF
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198678; cv=none; b=ESgi9u+35vs+MCCxLoVE3qBdNSCyrEsxb4IbpE4x01mMfrq5kfy7QRgbUKHGj/BD4UTvyik97iDbxO2Ke/RAGYgaCPYdeF1Q3QmxzNw86F5zvRIay2d90A7o4Nr1rchzba2Ogj5jcszyqKjU6LVMHRGYoeSc90cuyj5U2hX7+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198678; c=relaxed/simple;
	bh=UWVLiD4f7nvJaf4OdEkWZ/tDZYdLBqAGx4ZsEmp01co=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGKZZEDLppJoxATgdZ2qc2QXRUsREiHN9NcWJvor8psfyRP0Ii9PEuXFLoKUQx8jOH018u8GtQ/twdpO+2W6gZGnoAE+hcgtCViKlkjwwlzl5DN4pFrdd9KQwgjXDfFg4+pKvWlCTglySCHpDnLW3aothAaPaQhP2wFeCV6H9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/49ksyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91EFC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198678;
	bh=UWVLiD4f7nvJaf4OdEkWZ/tDZYdLBqAGx4ZsEmp01co=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c/49ksyrOxrFpvSh/8xN20CfBSK4j6gw4w9TExoMxD7dPIQHU+XGwLQSvjh7B+26G
	 1LWbpHVVqXkhmrwqIaWSPlj2v6qCdMzh5Zx0AfisKi072b7jabwod27MCeig8fJ2WQ
	 Xb6rnNLXYz4ozuEe30yJP7b1ZM++CAQkfQ4mm2CyXb53WsZZPNXzLumX0AXMOZY7Rz
	 j/UjxeSz9fEaGteWY6r0M3ZKkBBAf6BJyJjHAwk1av2niSbF3t/gpVwmY3e94pMc1e
	 8PhZ5dx9pzVzMoDSpXRgJymOtQe6mh3p/XFcN25xYi1JCSY4UtgbDGedY/RFXVU5fx
	 TWI/k/3zy0Fzg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: move btrfs_cleanup_bio() code into its single caller
Date: Wed,  5 Mar 2025 18:17:50 +0000
Message-Id: <b318f8381cf31b55938406bbdf5ad8b58ea53573.1741198394.git.fdmanana@suse.com>
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



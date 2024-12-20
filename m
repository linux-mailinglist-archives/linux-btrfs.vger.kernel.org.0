Return-Path: <linux-btrfs+bounces-10622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944B9F9794
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 18:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B607A14CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2024 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2954222069C;
	Fri, 20 Dec 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPxY/iSf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468DB220694;
	Fri, 20 Dec 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714712; cv=none; b=PJf/Bh+YOf5qIOXfdA/3nE6v34eEGcfnEZrwa4jH+6x0QlTnk98kmEMTJ6yuflP9IdOGvWqPj8k2mdhveXRlYM6UmWktDmAeey5ntgOFYnJmbtVWKpWd2tOKdRUxPSYsOAPqUjn0gYv29GCA7Iv173oFndG5P/NqZ+TfJe2mxkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714712; c=relaxed/simple;
	bh=B+6wyjP4qJFxuzpZwAWnn8bi9PXTtuJwnew0vufBTcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwRckXDPVTMAwkI8rRiVzT//jmR/IHOmGIxMLVjouhSnaJKE+FEFD04J2k/SRvFluZAUHmLZhFL6ZtsRW7CX2ViLlCw7O44wCgihKy18Ade78ccTn+LBmCnK6wLIkW3bN4sggROvcdJpgd1PJYwwtkWAKqOmf03us8U89dUL140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPxY/iSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB57C4CED7;
	Fri, 20 Dec 2024 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714712;
	bh=B+6wyjP4qJFxuzpZwAWnn8bi9PXTtuJwnew0vufBTcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPxY/iSfETeJnq2UPwLn6pHHzrjjuJqmM2DObLuT6Yy4rst5FapO5YNs+q5BSnAEB
	 hdeQENbo7SmR12ilzHDlXsWSRsjf1+F/FTYkDKvYvvC2yP9/Mkfzw+PWyceoPQD8HQ
	 dTnwsuhRDKVXvDG0PWKNuxRhvxTHinrK+GFJkXXiAzkz5eSuFgQblt/hXfh1IrA70i
	 UWS3NNpBb2Kq03/kVdQOEhPFUorKO/uVLQALV55O39fPx+73piRnkXFEv7oliz5tKr
	 +EspJzF6B9ARXbk1PRMosK7xTwYEgZfIwe1P0087mccM8btwrbwX51H0cll3yaOiAs
	 gAcuZPrnUI2iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 09/29] btrfs: handle bio_split() errors
Date: Fri, 20 Dec 2024 12:11:10 -0500
Message-Id: <20241220171130.511389-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit c7c97ceff98cc459bf5e358e5cbd06fcb651d501 ]

Commit e546fe1da9bd ("block: Rework bio_split() return value") changed
bio_split() so that it can return errors.

Add error handling for it in btrfs_split_bio() and ultimately
btrfs_submit_chunk(). As the bio is not submitted, the bio counter must
be decremented to pair btrfs_bio_counter_inc_blocked().

Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/bio.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 7e0f9600b80c..2c8c7d9a6fcb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 
 	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
 			&btrfs_clone_bioset);
+	if (IS_ERR(bio))
+		return ERR_CAST(bio);
+
 	bbio = btrfs_bio(bio);
 	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
 	bbio->inode = orig_bbio->inode;
@@ -678,7 +681,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 				&bioc, &smap, &mirror_num);
 	if (error) {
 		ret = errno_to_blk_status(error);
-		goto fail;
+		btrfs_bio_counter_dec(fs_info);
+		goto end_bbio;
 	}
 
 	map_length = min(map_length, length);
@@ -686,7 +690,15 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		map_length = btrfs_append_map_length(bbio, map_length);
 
 	if (map_length < length) {
-		bbio = btrfs_split_bio(fs_info, bbio, map_length);
+		struct btrfs_bio *split;
+
+		split = btrfs_split_bio(fs_info, bbio, map_length);
+		if (IS_ERR(split)) {
+			ret = errno_to_blk_status(PTR_ERR(split));
+			btrfs_bio_counter_dec(fs_info);
+			goto end_bbio;
+		}
+		bbio = split;
 		bio = &bbio->bio;
 	}
 
@@ -760,6 +772,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 		btrfs_bio_end_io(remaining, ret);
 	}
+end_bbio:
 	btrfs_bio_end_io(bbio, ret);
 	/* Do not submit another chunk */
 	return true;
-- 
2.39.5



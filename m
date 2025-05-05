Return-Path: <linux-btrfs+bounces-13686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6BBAAA911
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 03:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA77C1B6796F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 01:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA06298CD7;
	Mon,  5 May 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRnjqzyy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED02989B1;
	Mon,  5 May 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484920; cv=none; b=ZC7ywJrK9+nH6eRF56ocNOzsqW811bL2J8kIYdK4xMjZ/WG6dUl8aXkcidDC5B84yyMNitnke1d7l6/R09UOkd0XEpsLcJxIbtVhJhcPpuZLxFv+kEqXd5y1JWtmh3Oynij8gihSS36gkKoOhSXg939SDqCtq2FACdi6y88vaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484920; c=relaxed/simple;
	bh=M0oI3I3DwFGvDJA4AGHL1f/DEmF7TFgyH2YpOnvFnjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iyfOD2qtBEcI9C7AqdlamuOTeHSnro27o9MpsZ/GDDGdfjFUfRh097+GwBFg8DHh49TK0l6P4AGbitUMl0HYpz/rc0AuOT57nqnGIPkOLYOwBsezAxQJ4y3EN836kQNMcz24NsVx221qpj7uMLHLObOcu4A4OjNV/wrGNSpdwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRnjqzyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000FDC4CEEE;
	Mon,  5 May 2025 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484919;
	bh=M0oI3I3DwFGvDJA4AGHL1f/DEmF7TFgyH2YpOnvFnjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRnjqzyy8x2wXOM1U97SH1ZDTUjbza5fPGuSikmoipOKTcjYbuKGZCJpnTiTEjwT1
	 vI4Lhzk993IyNVTTt3fMD71O5A4QyjHaiy6xtGmBdjAXGAEBxoqOrnXiFMPrhZZhOe
	 Hz1eX/b0hJqeCFvsFGWoaqUYJy7owPZnKwguTAw/v58obIvIN31fsdbBdqJ8xWvW6A
	 O5W1JR2GpzASUDyHSuqMaR9C9bEvQeqRcK1zT2OjMg7fZav35kYr8GePoGiSFPBJai
	 g5sJPW1YECqxorT7WZ9EGNPsnzeKbStFIOp87o++UOuZ5ZPotNSJ+28mUPi9SMqSDw
	 aIKK0tp5gEq9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 076/486] btrfs: properly limit inline data extent according to block size
Date: Mon,  5 May 2025 18:32:32 -0400
Message-Id: <20250505223922.2682012-76-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 23019d3e6617a8ec99a8d2f5947aa3dd8a74a1b8 ]

Btrfs utilizes inline data extent for the following cases:

- Regular small files
- Symlinks

And "btrfs check" detects any file extents that are too large as an
error.

It's not a problem for 4K block size, but for the incoming smaller
block sizes (2K), it can cause problems due to bad limits:

- Non-compressed inline data extents
  We do not allow a non-compressed inline data extent to be as large as
  block size.

- Symlinks
  Currently the only real limit on symlinks are 4K, which can be larger
  than 2K block size.

These will result btrfs-check to report too large file extents.

Fix it by adding proper size checks for the above cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b842276573e8..3dee0565ad21a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -623,6 +623,10 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
 	if (size > fs_info->sectorsize)
 		return false;
 
+	/* We do not allow a non-compressed extent to be as large as block size. */
+	if (data_len >= fs_info->sectorsize)
+		return false;
+
 	/* We cannot exceed the maximum inline data size. */
 	if (data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
 		return false;
@@ -8683,7 +8687,12 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct extent_buffer *leaf;
 
 	name_len = strlen(symname);
-	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info))
+	/*
+	 * Symlinks utilize uncompressed inline extent data, which should not
+	 * reach block size.
+	 */
+	if (name_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
+	    name_len >= fs_info->sectorsize)
 		return -ENAMETOOLONG;
 
 	inode = new_inode(dir->i_sb);
-- 
2.39.5



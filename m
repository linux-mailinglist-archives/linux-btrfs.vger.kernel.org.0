Return-Path: <linux-btrfs+bounces-11539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393CA3A94C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 21:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7114A177F20
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 20:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0B1FDE38;
	Tue, 18 Feb 2025 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEnyFUQQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21E1FDA85;
	Tue, 18 Feb 2025 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910409; cv=none; b=uBaCQSbJ474gD86MlgxkQvkUTiVp5ju46uGrEvOh7BIH+WxzCiSfWQdnyalA+LmsXcK3GbPlz1KMy85zewmgGwiguEeuLi9HhiiLSNesrqPaeUFsIFuVs7cEhFLax9aG7rYrSnex+FZYqsSvroBOwaRyBITRWMTDZJUPpqxS5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910409; c=relaxed/simple;
	bh=OishFRVt1TzOKpDATJz9wcVUGZvqBcFcoFGVrn4aBXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQTAUTdbBI3u/tmqk979lduPooRQdi3y1id9531My8NGQdYhchzI+li/+4J7jfV7zXfu+/g5LXyTAlKBnd0Za0IqBFLdO4F0EbxscIWsqYzJWNDsRHci3cVPCqR7Ux7uor7pgMErOUwrAXNejqcDOSwGMbYvcozmgAlclhOcjIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEnyFUQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E2CC4CEED;
	Tue, 18 Feb 2025 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910409;
	bh=OishFRVt1TzOKpDATJz9wcVUGZvqBcFcoFGVrn4aBXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEnyFUQQW2uOmUWhga6mXa6OKvTTCnTE87yP4eDh9dFZOehcG5Iss4fU8LhBRmHop
	 +Pb8HvtidsKIa5L8OvU9owQZZoQlMqiP8Ua77xLTLpxv9TIyJFAOn8aafJnVkPF91c
	 gNtN7jDbGJa56re5vldcj0E0NASgpyFwfw/UdXGHXqnaMcF6dvOe0FlxL541IU8+pZ
	 cnRdcgT1fbQIiJ0XTMFxeXd+PFLnYXIbXy6bZB9AM/coDCgdjafCSdWCmIq1NCfSPX
	 Z87KJzBR99rn0a7vAKIkxLJf6/arPhNprlp/QZxls/0X++Bl4CdBpFk62nL4AMsheM
	 fU38FerLF0EIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/31] btrfs: fix two misuses of folio_shift()
Date: Tue, 18 Feb 2025 15:25:58 -0500
Message-Id: <20250218202619.3592630-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 01af106a076352182b2916b143fc50272600bd81 ]

It is meaningless to shift a byte count by folio_shift().  The folio index
is in units of PAGE_SIZE, not folio_size().  We can use folio_contains()
to make this work for arbitrary-order folios, so remove the assertion
that the folios are of order 0.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 42c9899d9241c..aa13a3bca715c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -526,8 +526,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 		u64 end;
 		u32 len;
 
-		/* For now only order 0 folios are supported for data. */
-		ASSERT(folio_order(folio) == 0);
 		btrfs_debug(fs_info,
 			"%s: bi_sector=%llu, err=%d, mirror=%u",
 			__func__, bio->bi_iter.bi_sector, bio->bi_status,
@@ -555,7 +553,6 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
-			pgoff_t end_index = i_size >> folio_shift(folio);
 
 			/*
 			 * Zero out the remaining part if this range straddles
@@ -564,9 +561,11 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 			 * Here we should only zero the range inside the folio,
 			 * not touch anything else.
 			 *
-			 * NOTE: i_size is exclusive while end is inclusive.
+			 * NOTE: i_size is exclusive while end is inclusive and
+			 * folio_contains() takes PAGE_SIZE units.
 			 */
-			if (folio_index(folio) == end_index && i_size <= end) {
+			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&
+			    i_size <= end) {
 				u32 zero_start = max(offset_in_folio(folio, i_size),
 						     offset_in_folio(folio, start));
 				u32 zero_len = offset_in_folio(folio, end) + 1 -
@@ -963,7 +962,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		return ret;
 	}
 
-	if (folio->index == last_byte >> folio_shift(folio)) {
+	if (folio_contains(folio, last_byte >> PAGE_SHIFT)) {
 		size_t zero_offset = offset_in_folio(folio, last_byte);
 
 		if (zero_offset) {
-- 
2.39.5



Return-Path: <linux-btrfs+bounces-11291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15476A2895F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B28162EB1
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517521519BB;
	Wed,  5 Feb 2025 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCs3Y7Cd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568722A7EF
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738755402; cv=none; b=qb55noyh/r09j6GLNZ83qH5sVSXeVzdXns9Q4ZzE3tVZmh2526KDyFVh8NT2CANMnYCp4tOTqiOD8AVB0qKbs7NRI8GVeNJ3+2b7Ko07O3LpVQSBXw+cFOTVqqAqAauTq3J94TgApe7etN+mnmjk/ie37hwTEfD7cCLuyW0PEuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738755402; c=relaxed/simple;
	bh=QvvZ8aK02sHE+ICpjA3pUq2NgGmgYhwugZV0C9pMECg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CDm8e+S8JTKq80r/HuQNjzh4aUx0SLOUEiVenAiJJRuaKi2gl+9Y11a3hyM0oQzuJJfFHlyOXQfyFzIcTtFp7EgPF+J97kvO20i+UOHKAKL+f2OFnVPjCn5wwItxm0pYSpfN0gaonWihDcT85Obl/QhyipuQh8H6iAOy84TaXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCs3Y7Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ED0C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738755401;
	bh=QvvZ8aK02sHE+ICpjA3pUq2NgGmgYhwugZV0C9pMECg=;
	h=From:To:Subject:Date:From;
	b=aCs3Y7Cdjjhg5lwmt9dkLgdyE9m0cliHQBhzkq/KXVku4rc4aW9on4iUfg0jw2id7
	 wUIZ3kJ63wJvGgnC1Ut+mReL+7UwoGJqbHnTxRMhCyDJVkgFit/b35ax5xKCmIntGa
	 h8M4Ft6ge97Zv5DlM+b5nbKM1JKEZ7qruktqBbcLnXnE9UtijZ6Imo4SUO9oCctfCE
	 fbfjoyaFqniO4bmg5HnyzDkHasLHBzApOfEBPH4B/7B/QhhNj+Ghlg9uwALsov2nJU
	 AojOyz2lte4qbDghLCz4EbyX+ioCCplYpmlPHMtwm8uMxGNDgExuideSsVAn+HaVhC
	 1Tz/DycImD48A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid assigning twice to block_start at btrfs_do_readpage()
Date: Wed,  5 Feb 2025 11:36:38 +0000
Message-Id: <87182120501efa8c878a65196fd6225481cab7c1.1738755264.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_do_readpage() if we get an extent map for a prealloc extent we
end up assigning twice to the 'block_start' variable, first the value
returned by extent_map_block_start() and then EXTENT_MAP_HOLE. This is
pointless so make it more clear by using an if-else statement and doing
only one assignment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bdb9816bf125..9e70d43e19cb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -991,9 +991,11 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			disk_bytenr = em->disk_bytenr;
 		else
 			disk_bytenr = extent_map_block_start(em) + extent_offset;
-		block_start = extent_map_block_start(em);
+
 		if (em->flags & EXTENT_FLAG_PREALLOC)
 			block_start = EXTENT_MAP_HOLE;
+		else
+			block_start = extent_map_block_start(em);
 
 		/*
 		 * If we have a file range that points to a compressed extent
-- 
2.45.2



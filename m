Return-Path: <linux-btrfs+bounces-14434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D4ACCEDE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 23:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D5D3A233D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 21:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14F226D09;
	Tue,  3 Jun 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSgRJyi0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858B2224AF2
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985610; cv=none; b=nXQY8bXQk6LBtkfmoIWYPxdHf0iJ8BsuvIVDH4VP2GvsC2BvSnCivKqafh2lYlypaUvNs2m1dEf2IaYAjGyuiCD3jaVR1okabHV9I1lg3kG0/2B7hByqESNBEbtBaiP3dH+xH7i7tO6Z0GWIbvswY7jJsIuSXcuEya0+n51ihmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985610; c=relaxed/simple;
	bh=H0iYDwoydeE+OhJh6B7+Bg0Muqw+eXTUidnxQAh80rg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ivp9ZU5zgOW+714FAYavIV8PzKfW1YCcA6yFoeYTw2NBSZFoDTER+At+mCc8RyvR70KucmoLdmTJf/Fos2OAhvqrnMeSdkeoSAYM0VOBzii/YFSScodUmNKZuZZv0z5sPDbFzgJn0cvXPvYXbkBXKm0eFTjRjrLnqm2l223yjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSgRJyi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8ACC4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748985609;
	bh=H0iYDwoydeE+OhJh6B7+Bg0Muqw+eXTUidnxQAh80rg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qSgRJyi08G2Ke6EcimtBfFuPFmwxKFhyMX1dXFXQirrw9YPWOqLGK99msWKcmmqYn
	 z5AQuGvpC3QBh6bsKSW0bXdVlrvKhYzSmWeAxrPRW54x8DSFDUkCpeMfOkL60g7TLV
	 wzvxvuV9LMiG5DmNbwrO0GcqRoPzAB37ChMACfHZjqHkIjsq/LJ9gnI29JpqUaJBPB
	 NEsvTok1DaGf+3s7+F99SNbT/b89ZojmytYwbgh8bJxp68Ad4nhAp+ix6W1okjrWkn
	 hBRXh2QZ6ihSZG4U1FcQdOOrTFnRLvmMNzcAf3zjUIxZEvbQh14vdkprjcRFnyz2su
	 /qOfpl6hqTqlA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: don't silently ignore unexpected extent type when replaying log
Date: Tue,  3 Jun 2025 22:19:58 +0100
Message-ID: <7a4820f91854e3e0e52ec39a4dd89ce9878193d6.1748985387.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748985387.git.fdmanana@suse.com>
References: <cover.1748985387.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If there's an unexpected (invalid) extent type, we just silently ignore
it. This means a corruption or some bug somewhere, so instead return
-EUCLEAN to the caller, making log replay fail, and print an error message
with relevant information.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c8dcc7d3f4b0..3f5593fe1215 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -668,7 +668,10 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		extent_end = ALIGN(start + size,
 				   fs_info->sectorsize);
 	} else {
-		return 0;
+		btrfs_err(fs_info,
+		  "unexpected extent type=%d root=%llu inode=%llu offset=%llu",
+			  found_type, btrfs_root_id(root), key->objectid, key->offset);
+		return -EUCLEAN;
 	}
 
 	inode = read_one_inode(root, key->objectid);
-- 
2.47.2



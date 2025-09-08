Return-Path: <linux-btrfs+bounces-16714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D8B48935
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358187A8830
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4DC2FB08E;
	Mon,  8 Sep 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6yJcIlW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912EE2FAC0A
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325228; cv=none; b=dtaTwe8EkpteUNIqwQiCEFAiQjU6RrU0gMPASTetWtbT70pPyY/JW3D2fqSuZUDVm4UAJJFOskb+5oQnSpMwg9z0CUTsRlSbYXE710afNdSdm8lCtslDwtSAILAZW5b2/Ux6adgDsX4Aad2GSrSDhLWfzQHR/RY9hK/6uNDw1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325228; c=relaxed/simple;
	bh=sYpvCKrKoxGNpjk258JD7pDCRDxYRfo/svgu1+OJIm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Znbz2u6kg2Z1VILnd7Mp1JukYE2hRcynztxNC1r5KDuK+MDusULMTeUEEUNTs5ezDEOZloy371uayRmfOoPbkjYKrODCTa6qgOo/02wKZXocp2jN4aGUo8t0RtBF8cSfWxd7VNxtLrZ9bGarFz83rnf9n1+4We+pHQ259jkGsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6yJcIlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16E0C4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325228;
	bh=sYpvCKrKoxGNpjk258JD7pDCRDxYRfo/svgu1+OJIm8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U6yJcIlWrcRPxO/gHe+TUdbnVErTWJ1u9MKoSNndsLrNJcep3qhAtAv76kCVhQvl9
	 7IDoHT31k+Wm3s1ge0q3et14dzt4hr3ZoJ4PZiHParVEybqS27SRAjTg/qUEmDx9c/
	 6v/BhIyB7K13csU/X0E5iL1y9HYpcTcdocgVi4ZTnJCpvY+FyxPbbe/8dHeh+DMCSD
	 //p1YE0LWb/XIEyN2ESJD2/e9x3FNQ1p+ynERWZvFxiP2di/48YCXSdH1aGJRRLbkR
	 eD/laHB4ZN7tXebVON3Ci84RzGUimtHm5s63IPPc4xQ2akK00aRAN9A6cPhglDDZsw
	 ipfxXqJ5Js+MQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 19/33] btrfs: use level argument in log tree walk callback process_one_buffer()
Date: Mon,  8 Sep 2025 10:53:13 +0100
Message-ID: <c04ab99dc1a2365db6942c41d496ffcdeacc6949.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We already have the extent buffer's level in an argument, there's no need
to call btrfs_header_level(). So use the level argument and make the code
shorter.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2060f0d99f6e..166ceb003a1e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -386,8 +386,7 @@ static int process_one_buffer(struct extent_buffer *eb,
 			return ret;
 		}
 
-		if (btrfs_buffer_uptodate(eb, gen, false) &&
-		    btrfs_header_level(eb) == 0) {
+		if (btrfs_buffer_uptodate(eb, gen, false) && level == 0) {
 			ret = btrfs_exclude_logged_extents(eb);
 			if (ret)
 				btrfs_abort_transaction(trans, ret);
-- 
2.47.2



Return-Path: <linux-btrfs+bounces-9324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7259BB932
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 16:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40106282E6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0061C07CC;
	Mon,  4 Nov 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc8H9b6M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76B1BFE03
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734903; cv=none; b=FpnGAHHO6akhYzoUtQqcBpS+aDOKhaVhAjHMSFopSWiEeS24IZC1JourjkFwRgVLuqiua/esWmO8csZVo32HlrKBnN1cvjmr2kGLx8SxBNyj1IoJWc0ajEkVPRzj1XG8R4j+sYSomQGP1CZ72BAmBKbMQJauPEwmw3B097G+Fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734903; c=relaxed/simple;
	bh=836PXA2lrc0cwE9u8GxFHonz3UEP/UoHnsHbpAwF5KI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=c2tceUiGpApKaKqF32rsRF6AmbzOkNYCYTC9M7vZy0n/BlL0vphaSffmwMbwFUCwgUndEXXegucJ3d6qFRRcev4K043HJCwWrGJSNE85kzCA/n72UXBrSfFc/nFRtoYNAwQaFvNKI2fMOLQDc3Vdk9tGARU3d2nvRDpEBImMvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc8H9b6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FC0C4CECE
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Nov 2024 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730734903;
	bh=836PXA2lrc0cwE9u8GxFHonz3UEP/UoHnsHbpAwF5KI=;
	h=From:To:Subject:Date:From;
	b=dc8H9b6My+17UtSAwWDMd5yC9W5svIx+yoM4/MLXa4gWcNwG38cwa04YK1YbUVk6j
	 I2MkAuTAnkk5zTCsawQ6b+OAwCe40AXxaaBEsjSmkzu8IBOcxVIQuisGemmJbuwhGX
	 t7W2ZfOz3E6TUjZlbCNXE2wkFZzho8yflPvS3f6pP7FZSuWPR0NtsrU8NfJelJdAkP
	 X+vyjxzs9znImR3OFIjBFS8Umd/5Fx8U+PDiHKnEVhI5mHXhhRWvgFmwShrNRVseDG
	 6+Enzd6lpk0p19ZBM0U77DKKsz5odTF/NBTCYZLhpi64ABSMuDKdjqMxP2mrCpIZiu
	 ZpDTbSJ5CSZzA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update stale comment for struct btrfs_delayed_ref_node::add_list
Date: Mon,  4 Nov 2024 15:41:39 +0000
Message-Id: <5fbc6e1d2a3ab67f1304f1115fdbc831c1e4557a.1730734691.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The comment refers to a list in the respective delayed ref head that no
longer exists (ref_list), it was replaced with a rbtree (ref_tree) in
commit 0e0adbcfdc90 ("btrfs: track refs in a rb_tree instead of a list").

So update the stale comment to refer to the rbtree instead of the old
list.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 4cb7d4475808..611fb3388f82 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -61,7 +61,8 @@ struct btrfs_delayed_ref_node {
 	/*
 	 * If action is BTRFS_ADD_DELAYED_REF, also link this node to
 	 * ref_head->ref_add_list, then we do not need to iterate the
-	 * whole ref_head->ref_list to find BTRFS_ADD_DELAYED_REF nodes.
+	 * refs rbtree in the corresponding delayed ref head
+	 * (struct btrfs_delayed_ref_head::ref_tree).
 	 */
 	struct list_head add_list;
 
-- 
2.45.2



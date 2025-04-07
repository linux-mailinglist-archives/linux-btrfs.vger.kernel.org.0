Return-Path: <linux-btrfs+bounces-12840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0BA7E8B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A85189E729
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF6C22A80D;
	Mon,  7 Apr 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ7NdgsM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092122A4D6
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047389; cv=none; b=m4p2os5BUv1KoIUAOJpfyHTrxSw3o97B7MTcpSywuja8mzjtgrJiPdqWjWBtCMP/OgFKpGAlz0AUb06ojK+4VUyi1CcRDI1f8RinPef7T36ns0CdQO3wPlIrRC1ay+zxY0LcHH03BfySWT0imRsCzYoyyFOmsP4GpWwPtdJ7zkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047389; c=relaxed/simple;
	bh=9EXKZFvLEBGVetCSx3GPmLboE9SWZDIwB+H/Ro7dLys=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lm8KuzbZZuYDR+mTuj8L9MCheFBgFS4DBnsG+3JSyszLwkanva9QPvsMwmygWLgPAY/ZJ+dqKl9vzeJ/emplWyGuTRn8aKNjXRtxyKPMeihmIq4KalODZS9gNr8NEJEUggYC0L9aP3+AGIAv4KPTQ5i3pWpBZIOUQFr9xwME9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ7NdgsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4E5C4CEEF
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047388;
	bh=9EXKZFvLEBGVetCSx3GPmLboE9SWZDIwB+H/Ro7dLys=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YQ7NdgsMLxDy/ocQbzTG5vJ0MtMqhnMRR5ZNAsCTGrx8edccuX/myegR/RpoDelJC
	 7oLRdW64dr/mfuVbfFMoDbLi22amwSscj/fNh3p6NYvhIlSwJX6wP6X+n2P65L4VtZ
	 G/OpstLtb9SJyuCPwFkX5WJPjD2mO3ONmfXgJSKSfS1dZtiQDGEIaudCMqz4+luy4E
	 yYZcyoZOsyvwd5bXAgPrBthDv6fUA5BBIyioT8WCq361zWb4hJzkCfONOQqvMlGIa1
	 eT064GEOUUDrHkWiDHNrfWady+qz6GNdSlqCGs4I3KO/ay7MzgDhVSJ20e0SHQFMNz
	 ORg8fmDiLhcqQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/16] btrfs: add btrfs prefix to trace events for extent state alloc and free
Date: Mon,  7 Apr 2025 18:36:09 +0100
Message-Id: <5538e7180b37ec69a864938901d7375b61cd0376.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These trace events don't have the 'btrfs_' prefix in their name, unlike
the other trace events from extent-io-tree.c. So add the prefix to make
them consistent and follow coding style conventions too.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c    | 4 ++--
 include/trace/events/btrfs.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 40da61cf3f0e..59448d3028d3 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -159,7 +159,7 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
 	btrfs_leak_debug_add_state(state);
 	refcount_set(&state->refs, 1);
 	init_waitqueue_head(&state->wq);
-	trace_alloc_extent_state(state, mask, _RET_IP_);
+	trace_btrfs_alloc_extent_state(state, mask, _RET_IP_);
 	return state;
 }
 
@@ -178,7 +178,7 @@ void free_extent_state(struct extent_state *state)
 	if (refcount_dec_and_test(&state->refs)) {
 		WARN_ON(extent_state_in_tree(state));
 		btrfs_leak_debug_del_state(state);
-		trace_free_extent_state(state, _RET_IP_);
+		trace_btrfs_free_extent_state(state, _RET_IP_);
 		kmem_cache_free(extent_state_cache, state);
 	}
 }
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index f3481a362483..efc06599bc53 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1476,7 +1476,7 @@ TRACE_EVENT(btrfs_setup_cluster,
 );
 
 struct extent_state;
-TRACE_EVENT(alloc_extent_state,
+TRACE_EVENT(btrfs_alloc_extent_state,
 
 	TP_PROTO(const struct extent_state *state,
 		 gfp_t mask, unsigned long IP),
@@ -1499,7 +1499,7 @@ TRACE_EVENT(alloc_extent_state,
 		  show_gfp_flags(__entry->mask), __entry->ip)
 );
 
-TRACE_EVENT(free_extent_state,
+TRACE_EVENT(btrfs_free_extent_state,
 
 	TP_PROTO(const struct extent_state *state, unsigned long IP),
 
-- 
2.45.2



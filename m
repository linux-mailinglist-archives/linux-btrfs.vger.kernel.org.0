Return-Path: <linux-btrfs+bounces-16719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885EBB4892A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E44E174E9C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0FF2FC026;
	Mon,  8 Sep 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X76fBV81"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0E2FB99D
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325233; cv=none; b=s6fY4eHRwRdmv7o4q8PyISf9lASHLxD6CZzWK61PjCVcG/G8OvVfyA3ZUCjsc06q0p21tztyVspVTk4f76n9AtXZnmEQzn283MdtxL4R5r8AHoTaDTw2Y8uwu2oH5Hp2BxKa1zR92pO+Vgp28pBPTxzKC7DhsxgD8QW23WKt7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325233; c=relaxed/simple;
	bh=IALC/6q8CAqIN66MazCuZsnR3lrM28OnEoajgIWJ1Xw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk6e9gbrItCsIpZn1hlcCYwQUDdkURGH7m4ks/O9TiIA7dqhdDp8dVQHPdt++vSY3vNSrPSQkNaczn39EXmNZ253ykra4IbHubmBUCd2eMQDtAvzXa3c8ulZZxJXgOuGNe1F4jM0H3sp8CHprTUsgvAjHZE8XpYtNF3i8RNnSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X76fBV81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6A3C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325233;
	bh=IALC/6q8CAqIN66MazCuZsnR3lrM28OnEoajgIWJ1Xw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X76fBV81atC4klPkRFm8dMvAkYftkNy75petGi8Rt1GOb/AdZsmk1pN7MGm1qzAe3
	 sRLb3cgB65Wid0aZZtc4lACZQlK2kHzjpjEvnsjWxBNkQV116LwfBG0Bvj3X2WdRjB
	 5EVSli4gOTSelFg5dByosFdF+dghdwDPpHQN5kak8oLZJErSNNPIydkx0mEmgETuIE
	 SRV5J+5mr9QR98c1FN4VHFE8w52Gdnj409qzeHpi0LCQEjT+xgcJ1a1IsNNefShnh4
	 laqNQADWxNaFHH7+d5HX/ppBl9+0RSqd+XiI+sU7QC08j/3MD2bN0GuBUtSMsDNleW
	 k/KT1hdJeAlkg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 24/33] btrfs: avoid path allocations when dropping extents during log replay
Date: Mon,  8 Sep 2025 10:53:18 +0100
Message-ID: <982da29bb898986e5102c3c4b7fed3bff1c2145c.1757271913.git.fdmanana@suse.com>
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

We can avoid a path allocation in the btrfs_drop_extents() calls we have
at replay_one_extent() and replay_one_buffer() by passing the path we
already have in those contextes as it's unused by the time they call
btrfs_drop_extents().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5754333ae732..a912ccdf1485 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -738,6 +738,7 @@ static noinline int replay_one_extent(struct walk_control *wc, struct btrfs_path
 	drop_args.start = start;
 	drop_args.end = extent_end;
 	drop_args.drop_cache = true;
+	drop_args.path = path;
 	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -2676,6 +2677,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				drop_args.start = from;
 				drop_args.end = (u64)-1;
 				drop_args.drop_cache = true;
+				drop_args.path = path;
 				ret = btrfs_drop_extents(trans, root, inode,  &drop_args);
 				if (ret) {
 					btrfs_abort_transaction(trans, ret);
-- 
2.47.2



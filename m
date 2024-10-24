Return-Path: <linux-btrfs+bounces-9134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6A9AEBDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB0C1F236FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688F41F81A1;
	Thu, 24 Oct 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc/eYWFa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C81F8195
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787075; cv=none; b=J17AYFjp0bC60/DsxiQY+4nMw1MqE/dIxV5S16UjXOWKuuTLyTtQVo1KAB5vuwvA90tPL2Z9sCo8jZB/PTTbOeBF2FvaNQ61hzpBADp5TLlI1M9cbbSeJLQMvaVseEH/I381Gwga2RTYAX7RaZ+XUu8NpNs+Hvob4oMIE8tQqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787075; c=relaxed/simple;
	bh=7FhUZGBS3cxrPyhLKLic3Z/qwesUuDY5Z8WoFC4sbwo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rUrRbqdTkg2weli7fnOr2irYCWBE3kNCBHjns8e9013EciZlhYLunAPKSyeJ3wX9ZwyFWK9Vt0zgrg99nusj22f5braUa/CKSRRyb+ICB/8TXWlsUO2GVxez/Z4lghdqQdoTweNQFyzbG8onR5aaj5y2zodSgN71V8h6zArzXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc/eYWFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DC2C4CEE5
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787075;
	bh=7FhUZGBS3cxrPyhLKLic3Z/qwesUuDY5Z8WoFC4sbwo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oc/eYWFaEDTmG5t3kL1i9Ne9e3FWf9wtcWYvQAEDwy7geopByovwuHLVceS8kTXsR
	 QQl55QQtInYQW1wVmRrG8bAUX8ZW/F2kPi+ZzsdiFNPQ8i8N/XR9Ak4zlyCM3aHOUw
	 ZYkJwYIFLaZJ2tav/pgWpIS6vr7QG4X1x0QNGesEnPObaUAS0iPxAYPb5ySYZU23w7
	 DReNo0NvTyDjTekYJWXimaPmV+pEe8R3T8d3oTo2uGZ6yiMAJ1w5wxkE+8nvLkJfuU
	 6WrPAKvcJGEz7uD+1s8nuRlQKWqR77BhxS1BKUlhdG5PLhZsFRcy/v+YgGZ5zswddt
	 5EDQyx+syB8UA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/18] btrfs: remove duplicated code to drop delayed ref during transaction abort
Date: Thu, 24 Oct 2024 17:24:13 +0100
Message-Id: <5718d90d0fff1bc39531d71f590c9dd21e04f5c6.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When destroying delayed refs during a transaction abort, we have open
coded the removal of a delayed ref, which is also done by the static
helper function drop_delayed_ref(). So remove that duplicated code and
use drop_delayed_ref() instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 4dfb7e44507f..db834268faef 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1261,13 +1261,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 			struct btrfs_delayed_ref_node *ref;
 
 			ref = rb_entry(n, struct btrfs_delayed_ref_node, ref_node);
-			rb_erase_cached(&ref->ref_node, &head->ref_tree);
-			RB_CLEAR_NODE(&ref->ref_node);
-			if (!list_empty(&ref->add_list))
-				list_del(&ref->add_list);
-			atomic_dec(&delayed_refs->num_entries);
-			btrfs_put_delayed_ref(ref);
-			btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
+			drop_delayed_ref(fs_info, delayed_refs, head, ref);
 		}
 		if (head->must_insert_reserved)
 			pin_bytes = true;
-- 
2.43.0



Return-Path: <linux-btrfs+bounces-8904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B699D490
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59C61C23278
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435E41B4F04;
	Mon, 14 Oct 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMrwh4x1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266E1ADFEB
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923069; cv=none; b=Pszg3BvzFOewS90uyEt2IX/zT3MDglbr2jNSJC8jsIh9U45MXU9FI+LmTJr+yauJ0Z3wYkzSQ7QqJccRN8ZWVdlA6P/hlxvqguajhYZE8Oz9jbOFftNOXQt6qElGOjTTiWPgrBmpaRkOKH/4oFuzrEEjZx9aC5Fx9eD0VOWv5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923069; c=relaxed/simple;
	bh=HaVFtoyjrTKRDfc0937u94RKZr1mr6pzWSQuUa3eVaM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=jGx2SWL0QV4rgr1izhr2xVNqmkxboFyyefDH5GCJCraGcp5r6eFaFR197cCwqbDXAMr7VKK0IiQjPkvvvC8poeVoWpcfBpyf2/YLeiVarpqSpidZGC0syH+MluMXugIJbGShofDi98JpAVDbjAb4sqGEXe4dZn6X5bQZ+jPHUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMrwh4x1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14FFC4CEC3
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728923069;
	bh=HaVFtoyjrTKRDfc0937u94RKZr1mr6pzWSQuUa3eVaM=;
	h=From:To:Subject:Date:From;
	b=BMrwh4x1D7szRFAZsJxCvU8vC9IEWnccWMuCfM5l+7UayZ94onwEEhYEB38+klnwq
	 43jBxspRlb0RoaK8IpMC1D+AqO4Qnu+xdbdyJC04/WfKgdsFipJGcp6/zHjfVC+OuD
	 Rt63PBGNkugceS2iPgKkXBTJUIrg9XfdnLves+qnAMrR217QNvioRd/Fud6jiD2ZUJ
	 bUZ8qJyo0SRscF9oVPIuAVJKiCML2IWSPCY16KSskiDx8plXqXNIVEuEOhC1uOePcg
	 bnLhnKq9skqXIlMs7xh156xzXhWcKXQxiP7uTsfm9WUuSEvayQ7b3ErUFwxIPTP6B2
	 Tm+C9rVO5//eA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix use-after-free on head ref when adding delayed ref
Date: Mon, 14 Oct 2024 17:24:26 +0100
Message-Id: <02fc507b62b19be2348fc08de8b13bd7af1a440e.1728922973.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At add_delayed_ref(), if we added a qgroup record, we can trigger a
use-after-free on the head reference when calling
btrfs_qgroup_trace_extent_post() since we are not holding the delayed refs
spinlock anymore at that point and in the meanwhile other task may have
removed the head reference after running delayed refs.

So fix this by extracting the bytenr from the generic reference instead
of the head reference.

Reported-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/670d3f2c.050a0220.3e960.0066.GAE@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

This is meant to be squashed into the following patch that is in for-next
but not in Linus' tree:

  "btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record"

 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 13c2e00d1270..04586aa11917 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1074,7 +1074,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
 	if (qrecord_inserted)
-		return btrfs_qgroup_trace_extent_post(trans, record, head_ref->bytenr);
+		return btrfs_qgroup_trace_extent_post(trans, record, generic_ref->bytenr);
 	return 0;
 
 free_record:
-- 
2.43.0



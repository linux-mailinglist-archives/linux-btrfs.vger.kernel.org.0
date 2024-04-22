Return-Path: <linux-btrfs+bounces-4483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8DA8ADAB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193B41C2141D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D5158D82;
	Mon, 22 Apr 2024 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+5hmL1N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F51A38E6;
	Mon, 22 Apr 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830322; cv=none; b=I1pP+cRnZtFKxwi0j25eVOtIiWPbjj8cJlyXmYJa/BVw/4sTpX7OKMC3GgihtKytlKj4whIN/69jbWlzJPUkuh1UHLGnnzpFGm6ZVgZjhtUng0aqG2KGSjek5Ivyx8VVhYYudYHQruszFbE/Iucf0UIOUS0AuUPz41qBsMVPv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830322; c=relaxed/simple;
	bh=HZlsMepAe7cgqhaYCoUfHmUSLyjCHeRnV1bb3aXFMqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+tT5mrdeeAXZU/Noh32EsXN3Aqmq6exr3tpdsAzBa4OHrnbu/OIYVL+aCe1NOSPvkEicE2HniEyLCl25dlx8fV1dptN8b6RtwxZe0fQrgipUcbEI7sis0GF2j2i4S7LsHhypQzFOGIxKf/A0ft7QiZG7Q6/Qw4m0EeK19GR3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+5hmL1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD91C2BD11;
	Mon, 22 Apr 2024 23:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830322;
	bh=HZlsMepAe7cgqhaYCoUfHmUSLyjCHeRnV1bb3aXFMqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+5hmL1NdrezOHaAZ1Nx7tQv3k3g28AemByZkRDQ0z7O6xy30g+am2UY1MNEk3eIG
	 d0dzBd5kASoipSqyBsf9gHVlyoCuPbnJj9L4+zoNBr5nnPRiVfEU9UnjqT5MKK+FrL
	 H+NUxJdNsiFUZy8th+J8TP8eduImNmyH60Azs1dXz5vYn9Os5c1qiu5W7WnR4cjm6T
	 ayCfDNDVRxjpuAsQB+K7SKeXuxCSdtTTkBvIDgbc8WVD4atBxb9YxAa4WziZm0lSqA
	 Jo41hBzdlflydF5BkFo7wYsFmk39lsRjE/pBdWomzaBLNrcyVRwYC1kcliDB8diSeS
	 ABPtftdU5RzfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/9] btrfs: always clear PERTRANS metadata during commit
Date: Mon, 22 Apr 2024 19:19:45 -0400
Message-ID: <20240422231955.1613650-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231955.1613650-1-sashal@kernel.org>
References: <20240422231955.1613650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 6e68de0bb0ed59e0554a0c15ede7308c47351e2d ]

It is possible to clear a root's IN_TRANS tag from the radix tree, but
not clear its PERTRANS, if there is some error in between. Eliminate
that possibility by moving the free up to where we clear the tag.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d23047b23005c..8cefe11c57dbc 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1343,6 +1343,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1367,7 +1368,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-- 
2.43.0



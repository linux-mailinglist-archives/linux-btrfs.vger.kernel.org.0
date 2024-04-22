Return-Path: <linux-btrfs+bounces-4485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEC8ADAD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6641C21B18
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7A1C6609;
	Mon, 22 Apr 2024 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ7+ZdJq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5831C65EE;
	Mon, 22 Apr 2024 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830347; cv=none; b=iOuQbx4tFzPNeBsde4XWhYCBNlkQA06Q2owRR0GGzRJkc010lZdxIkr89LKuG0ij5xkctnY9xBzRd2lWOw4DBnuvBaXV51UXAynC8O92NHxfk9aohELbB5/RaYpGaVtCHrceeJIFeBnA1kf4qdqGeyyV/yxwSNhqetcYa6epC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830347; c=relaxed/simple;
	bh=h30kKFH62G6DEMeMOAHw7ig+j5I/udilBJVWhRVG2Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC1bxOlaKjJOQiPt7Wos9TGXCJPP1Ojy2pt9stCsb3IXbQq9gK3A7mTZ5uGagSgQAsTBpHa/TdrQ4k4z8XZ85tzOkCIeKqlLFTjCIjpjk8r7tQ28ycv/LQqRGJSDEcpjpiKUXD2rT3X3tXCHlUluyAV9F+CGJaxOiSl/Q3L4Rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ7+ZdJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DA5C3277B;
	Mon, 22 Apr 2024 23:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830347;
	bh=h30kKFH62G6DEMeMOAHw7ig+j5I/udilBJVWhRVG2Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZ7+ZdJqAtgiABijc4sGps5UsMEeo4LSp2Y/S80+IktlepxQ7IZfDDWzy80vBKUoI
	 vdpO6DOj1TB7vl6z0/IZr2WfW0jCIrzfcnIFtrIL2rdi+sg+OUyJTpZ6KoyJct9VhU
	 v68HqJfStTsKBr/q5riYwnwalhuaJR5Or1bExD4vXRxF/EZibibQnKx23+XblcCVk4
	 sEEBMJBrrmOlZv1CBRK0Jvy30ZwI5UP16qKhT6Ypq53HkUnPBhB8QGTSUCSlW8O2sB
	 hEJmvJSgfwjMzi2fzkmrEtK4sB1Uw1xoYiKm8ZMmPUdBmrd+gJTg2hnD4mPDObf2um
	 CXOjJ5NjQiFzQ==
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
Subject: [PATCH AUTOSEL 5.4 4/9] btrfs: always clear PERTRANS metadata during commit
Date: Mon, 22 Apr 2024 19:20:09 -0400
Message-ID: <20240422232020.1615476-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422232020.1615476-1-sashal@kernel.org>
References: <20240422232020.1615476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index 89ffc02554069..1d25bf0c55ccf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1226,6 +1226,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1250,7 +1251,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-- 
2.43.0



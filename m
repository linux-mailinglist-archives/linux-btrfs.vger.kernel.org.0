Return-Path: <linux-btrfs+bounces-4475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A38AD998
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D725B2080E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 23:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A315697C;
	Mon, 22 Apr 2024 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujKCPM4w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9015667F;
	Mon, 22 Apr 2024 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830055; cv=none; b=S85u6BiU0O29C/QOq17ynnMoVR8MiYv77lMibnfzN0KE982TCZzqKX1EYlQIIhmcpHy1n3/DOcmhSbcP5ET5xEZmD4QUjGkakQWQA4dfAR5yfdw2rJl+BoIb1VkqYNDvk+/i6VTzh3JexNEECkQei7XK3PdRw59TTGyTB4F9efQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830055; c=relaxed/simple;
	bh=WWfuv1tupr6zwcaOE5m5WSm4mQ0yiIoOU0JCcSN56wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkwZv+40wNN0SjKIQ4jb+AsK9qdEjeDUopBUXPJ4VqMK+YX2q0UyiA1CFs6OL3H0b+xsiJ/MZXibgFA7L6ZZu4N6a826vCZwvi9xWglraBcogypBiJQ+Dy5LUxr/6F5OVYbPe48mhZdafL/6Qt/BlBhjt96m8zh+v7pTrnDaYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujKCPM4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03C7C2BD11;
	Mon, 22 Apr 2024 23:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830054;
	bh=WWfuv1tupr6zwcaOE5m5WSm4mQ0yiIoOU0JCcSN56wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujKCPM4wfNl4C/EyTQc58e1nI4DlJtktmFk1B+eq2ZYF6jiRqKIbdnyqZjIHgnfFu
	 0pZSwIqmqu0lZrX0Q2mm7eE0eQtN2ZptbBzcdeNZv0QmbuTRI5KMGAZv3CvHGcNevF
	 UjGqA/7Jv7EIH5VCtYvPYTUEbtdzrDrH1TE+EExUqi/5TSFyg0OpG+muz4LYhghVRx
	 56PymtiwOP2RlfiqGpI/B5tmDP1U0g+TouKYH1I/J76fidMu2f456KhHHLeO/3foa5
	 6h2h11Db7qbLwKmwSnjdxjxdmrt5zsT+U4DNeyA6K0XCXcoNwCIzKbT1vBQBzfqeHE
	 vTeWZslYyj18w==
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
Subject: [PATCH AUTOSEL 6.8 09/43] btrfs: always clear PERTRANS metadata during commit
Date: Mon, 22 Apr 2024 19:13:55 -0400
Message-ID: <20240422231521.1592991-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index f1705ae59e4a9..b93cdf5f179cf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1496,6 +1496,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1520,7 +1521,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-- 
2.43.0



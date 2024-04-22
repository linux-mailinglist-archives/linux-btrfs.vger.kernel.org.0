Return-Path: <linux-btrfs+bounces-4479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2088ADA68
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 02:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B359D287AD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 00:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A317A933;
	Mon, 22 Apr 2024 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pljnFPzr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1978179949;
	Mon, 22 Apr 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830253; cv=none; b=ZFn5v8bQBrVOpgFGBWuvRjHQkz+NMlCERRoDJC3kHce4Ir1EDCpFNPmmiFLd3PLGExILyybCb0w9o64KjmDfFwUoPpZACrTzPL93RQ8fNrDwHL624qlHRM3WHf43+Wt/7mQrccZ+r/SvXnXrwm6eT2b/SNSISwft479B0Tqj2R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830253; c=relaxed/simple;
	bh=ErU6J01NlqqOHk2A1Cn8LQqGbYG5+wXsvVM7pMkTHbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5qKzL8STiVZzpSg8aeMk/UnMidlMYqolQUlx23LRF4qZ7K041zXQsyfO9NJhWXcuRC/6mx1k4XPWZ7fVYULAcRHrSacSe09yek2BL7lVjx+eiqVRirclqopB6UXlsqhSPTLMLZIrWnC/t+tyun60+XVOYAcTzXuAzRMHVxfH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pljnFPzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A25C3277B;
	Mon, 22 Apr 2024 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830253;
	bh=ErU6J01NlqqOHk2A1Cn8LQqGbYG5+wXsvVM7pMkTHbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pljnFPzrrC9f312kl13XZ4FGlnJVgIIthzi98DXcRfkGXRL7vbByWQBTILMSQU4EA
	 t4uHj+W1N+eknTMXqSJBkKAULfB4vG/DZphJI4SUfewOaY3reksMSM8swzZSNJlsnX
	 EV5qcoPKOOxntpWbdg86SI2+mZGS7iDmej37de+Mw/AjWWt1NBGP6er7rS9fQtWZID
	 pN5Qq7D2kAARRH7MfXE8hZixRo88s6cR+zDkyP8EPAhxs2c0D7+VgUR0we8UvbbEdu
	 pxiwuUEOnVW2m0M7Wo8eniHoQYvPp6FHZLUuySObM018H6L8CbpPidTyfVUQYSyXN/
	 PGiJUy3SqcMIQ==
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
Subject: [PATCH AUTOSEL 6.1 05/19] btrfs: always clear PERTRANS metadata during commit
Date: Mon, 22 Apr 2024 19:18:19 -0400
Message-ID: <20240422231845.1607921-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231845.1607921-1-sashal@kernel.org>
References: <20240422231845.1607921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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
index 5549c843f0d3f..a7853a3a57190 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1440,6 +1440,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1464,7 +1465,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-- 
2.43.0



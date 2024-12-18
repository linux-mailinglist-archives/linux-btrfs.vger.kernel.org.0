Return-Path: <linux-btrfs+bounces-10557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADF69F6BE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CC016D8B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED41F8AE6;
	Wed, 18 Dec 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPqLLlwR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2711F8918
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541612; cv=none; b=kt2rmVdHtwNby1wI4ifb65RTT0Z8qt0nZvGCvRQigIfQTPvJuuEb98EKPPTAWbpZCBYIYCON5rZ2zyCef81AWLNNPvjNkSRQ9+bxMmwNvvPJxW0BzVH2HwRzMjLq9hp7/tem3AnkPF+Ud9i+gCU4KtD6Uy0nUQDPdcoXkMBuckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541612; c=relaxed/simple;
	bh=pLEY2zhDOE2z8aq9wzl+/YcRQyIznjqVH+rfhB1bEOc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHIE8Lh+8vuq14EjwTTkIbmQ4pg7TTI9WcDHLNKUdFMT71I8ehwGHY+yxxnfPm+rAHyCjzqiXAmebCmZbiR0Gzpq+zSIBBT3EVnoyMcOpfniUpPiH6qbtujVzppUsx7PwOpRJ7uxY0NAGdTlg6O7Q/74GtR9nrJro07m2gNdy30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPqLLlwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18521C4CED7
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541612;
	bh=pLEY2zhDOE2z8aq9wzl+/YcRQyIznjqVH+rfhB1bEOc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QPqLLlwRZbj0Bg+KYQXJKWM1orkfx0KYE5DFVHDsBeJSuxE2y4K0LK8kRYGTpg6vq
	 JSLMtsO4Sf7AS9a9TBHhxBJR2DaMKX6IA2bHJ2YwjYhkyvMpvW03jfBnpr67xaWTR0
	 +Kl9huA9glOGtSFPQk5ULkn8gs8eGkySCpvPbMzgEWz2WKbpB/RBFDXOCKFnDCDQ7Q
	 JVAExJv/+vtncM6ZOZMa40D66UilKsc7kNdxUxNZrsfNhtymrtmJwZodTIlldyuxUI
	 0EGoIGjX0WYw7y3YtS52g4QFa47IFN8XghiixXhUPrPLNavOVVdRcaMjMjh74qqeM6
	 7bAEuU1pkILIw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/20] btrfs: tree-log: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:28 +0000
Message-Id: <e798a14b8c173645d84c07286ff6abe21893a60d.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have several places explicitly calling btrfs_mark_buffer_dirty() but
that is not necessarily since the target leaf came from a path that was
obtained for a btree search function that modifies the btree, something
like btrfs_insert_empty_item() or anything else that ends up calling
btrfs_search_slot() with a value of 1 for its 'cow' argument.

These just make the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c8d6587688b3..955d1677e865 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -590,7 +590,6 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 		}
 	}
 no_copy:
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_release_path(path);
 	return 0;
 }
@@ -3588,7 +3587,6 @@ static noinline int insert_dir_log_key(struct btrfs_trans_handle *trans,
 		last_offset = max(last_offset, curr_end);
 	}
 	btrfs_set_dir_log_end(path->nodes[0], item, last_offset);
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	btrfs_release_path(path);
 	return 0;
 }
@@ -4566,7 +4564,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		dst_index++;
 	}
 
-	btrfs_mark_buffer_dirty(trans, dst_path->nodes[0]);
 	btrfs_release_path(dst_path);
 out:
 	kfree(ins_data);
@@ -4776,7 +4773,6 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	write_extent_buffer(leaf, &fi,
 			    btrfs_item_ptr_offset(leaf, path->slots[0]),
 			    sizeof(fi));
-	btrfs_mark_buffer_dirty(trans, leaf);
 
 	btrfs_release_path(path);
 
-- 
2.45.2



Return-Path: <linux-btrfs+bounces-10560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A13A9F6BE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A53E16D061
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8D51FA148;
	Wed, 18 Dec 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0Ex0yKr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224F1F9A81
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541616; cv=none; b=inWrQZNbAdVzDIyaiCzsjcQ1Eyc9PKxgNDi3/CU9LT0vA7xPJC+N1yypaWYcOMiES6T/ZxyySnfoEYp23PW3W0ewbfsoqvTVFFLbCKMun7uDhYYxKAM6JZMqUyHEI8AwTsRDHzLldtXLBWlzu9k/zhoOq0vJQjmCjA6fWEQlMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541616; c=relaxed/simple;
	bh=wTIXOAz/PmF8IOV+o/w1YajjrFqWLNaFZjO2r1ZAm/w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVktkzUXcQptcwrqS6COjkJgFxSH8JmiQ8ucibKJp/++Xomy92yWL2hdA5N1qOIc4nMQKQlOTELBEtc5TLgapVQlUR9n0O+v8MUo4TsqQsekWoHzO46+I86OQfz1yuDcG9GI/it/elTyI1GBLA5DDf4VqZodRyfcxb+jhoNQTH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0Ex0yKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE3CC4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541615;
	bh=wTIXOAz/PmF8IOV+o/w1YajjrFqWLNaFZjO2r1ZAm/w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M0Ex0yKrJxWf5b7JU7litZMVprIv18yWxkLoNizSRhxAZyNlGTHCfFrLHyNt+iTP9
	 uZXcUqQ/cnJ/z6IC7QZpkundUTBQg/a3P2tKuCQd0ncsqXmc7k8vTDjIOjqfDjV6pz
	 P/R7DpSiCMsog3mN5dIFh6p6IKCTkh92Tloz+7x7Nrk6n3u9HCfsY2qGSgWvhOMP1w
	 j4ySBpRkl7+m8sPXXG7Q4ZOPETziI1MQxn58I/2I5ky/xhGt+4JiP+x0AeephuwS25
	 38FE3qU7ZrbOtxBQRecL2jDIxlQYhK2ESAgYRCdr0BP0dtOP3/d1CsiYmCZnG2Indv
	 y6PaMcl+CdPcA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/20] btrfs: block-group: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:31 +0000
Message-Id: <0bdee9a4eb6960c61544334ffe292cb544a0bfa3.1734527445.git.fdmanana@suse.com>
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
 fs/btrfs/block-group.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5be029734cfa..8f91aa431074 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2670,7 +2670,6 @@ static int insert_dev_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_dev_extent_chunk_offset(leaf, extent, chunk_offset);
 
 	btrfs_set_dev_extent_length(leaf, extent, num_bytes);
-	btrfs_mark_buffer_dirty(trans, leaf);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -3120,7 +3119,6 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 						   cache->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
-	btrfs_mark_buffer_dirty(trans, leaf);
 fail:
 	btrfs_release_path(path);
 	/*
-- 
2.45.2



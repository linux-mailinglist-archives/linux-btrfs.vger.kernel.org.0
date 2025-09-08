Return-Path: <linux-btrfs+bounces-16722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D1B4892E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71634174D5C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224802FDC30;
	Mon,  8 Sep 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDO40OHV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923C2FD1B6
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325236; cv=none; b=qoJeRlBU7ivHZfS9yJ9a9AiLG/+dldn3jZREX2ItKIbDQKeUmVN2dokkvxfrxo8mn+D7IN50CAeKC4TfprcugyDwgeNmVJ6NEwknFb83v+AxGie8cTb53r1JE2Z8OcSjAFi99SlkOh/4xMuse5+T7oWYw0pE3BtWO3Ua0S0hBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325236; c=relaxed/simple;
	bh=g+O8TQWXRj0C58ob/TJ3X+CRc1XHxIy9S3W801FCqtk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1JReBr95mtwgtjWWsuWCeCQAldauKsef6kjJV5i+VksX8M6cjm3Dc1Qn38JsqJefKEgrbLShOyI052/ac5ApUmYxo5a5ZS/ocf+ZFFG0RWXMZJ46FYwvGzzGWXB0CizwszUk5YaSpCLl2262AmoiGELrBvVqkOtIgFQ0WB/gQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDO40OHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D006C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325236;
	bh=g+O8TQWXRj0C58ob/TJ3X+CRc1XHxIy9S3W801FCqtk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aDO40OHVXf87Q4cfmoW89YIuF9LsvmaYG4vQf8K9vsN5CVS11SdIBB/xoUOrWACME
	 x5+R83fB/DSixegG6VoPhunyDv1dz/54q+M3mUOcHJTHRDd3N/h8hliERiFZYr2HBX
	 k7sykPiwYfvWGjOj6G0cEwBc+AAz9A+CwP3yTDdXKD8dR2kANlDcfRJFZB89r/F5ik
	 mfoORC3emCXfMvsm0R+pgjqCDgHoyMPPuBBxVzaNz2kfx7UVmbbORXvN2QeMS6xQ5C
	 I6KvpMbr7W4NAX0VurH9bUC9jIZCQDnfSa+XvQ09vR6WHreyclbGG1OqIqDMSzssem
	 UtGRfh+tBTWoQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 27/33] btrfs: remove redundant path release when overwriting item during log replay
Date: Mon,  8 Sep 2025 10:53:21 +0100
Message-ID: <ac9759810360f40748e4a92a94ad20e50b97dfbf.1757271913.git.fdmanana@suse.com>
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

At overwrite_item() we have a redundant btrfs_release_path() just before
failing with -ENOMEM, as the caller who passed in the path will free it
and therefore also release any refcounts and locks on the extent buffers
of the path. So remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 65b8858e82d1..66500ebdd35c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -471,7 +471,6 @@ static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
 		}
 		src_copy = kmalloc(item_size, GFP_NOFS);
 		if (!src_copy) {
-			btrfs_release_path(path);
 			btrfs_abort_transaction(trans, -ENOMEM);
 			return -ENOMEM;
 		}
-- 
2.47.2



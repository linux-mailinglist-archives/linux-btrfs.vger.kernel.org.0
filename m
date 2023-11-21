Return-Path: <linux-btrfs+bounces-244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB107F2E80
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AA1281788
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EAE524C0;
	Tue, 21 Nov 2023 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+MqKLtD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A647524A8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223CDC433C9
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573929;
	bh=PUYVlSxOBYGqVYk4s1rhMlrO5hOBjdKLim9fGaYKC0Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F+MqKLtD8yvxjkVKBiw6eY8TI0W92Lokha4NJ51aSfcfJ/n3rwt8OYFX4lZgOnsa6
	 ZH16f4a4vm7w5WlDjwnI/fz9vLWaYE2lPgghUKUzhWJ3BHdkrlqZAIHAseg7/IfC0Y
	 zetDWCT4u6r3eBhoy0NjCmZkgoIpcJ/uBIIjH0XIDnuhdgseFZJpp2atBVi13gyH0M
	 Ry6qjIyul/WPnUMYIHigeCg1eJnTV93u/POt2BnjSNkao9bixzYgJ3ITh3KG3sza/n
	 e0YXIwUwV8fafOEroQO7ji+lHQk2KxUyJKsJpndyt7rbgOZ+/h6NDcizGbmdvvPmpc
	 DCGdumijq3Brw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: use btrfs_next_item() at scrub.c:find_first_extent_item()
Date: Tue, 21 Nov 2023 13:38:37 +0000
Message-Id: <c0e14c7d6dd2bad6889e6f5226febb84dca90ce9.1700573314.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1700573313.git.fdmanana@suse.com>
References: <cover.1700573313.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no reason to open code what btrfs_next_item() does when searching
for extent items at scrub.c:scrub.c:find_first_extent_item(), so remove
the logic to find the next item and use btrfs_next_item() instead, making
the code shorter and less nested code blocks. While at it also fix the
comment to the plural "items" instead of "item" and end it with proper
punctuation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/scrub.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9ce5be21b036..63ac78006f1c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1409,14 +1409,11 @@ static int find_first_extent_item(struct btrfs_root *extent_root,
 		if (ret > 0)
 			break;
 next:
-		path->slots[0]++;
-		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(extent_root, path);
-			if (ret) {
-				/* Either no more item or fatal error */
-				btrfs_release_path(path);
-				return ret;
-			}
+		ret = btrfs_next_item(extent_root, path);
+		if (ret) {
+			/* Either no more items or a fatal error. */
+			btrfs_release_path(path);
+			return ret;
 		}
 	}
 	btrfs_release_path(path);
-- 
2.40.1



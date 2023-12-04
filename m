Return-Path: <linux-btrfs+bounces-576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EB803A06
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99345280F37
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F602E40E;
	Mon,  4 Dec 2023 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUXZv6N4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E62DF93
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B95C433C8
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706839;
	bh=NXqMZyiS7s4zkRrQKgontCU/DLZbOdejvSKapBOWvsQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MUXZv6N4LI3+QgrCgZFAC9YL9cWxnIXfZ1/O+v0BZi157L6nbl94QQsQGc9gCEH2S
	 fL81jHQ/upn6IcNBDHXTceLyIAPZ49wO9tOD7/y1BCxtiq2NhTO9GM8ZMh5Kb0AK5Q
	 Kg558HIuGTtbud8zIZX+PUsGtwAhafuTR0wxGpcjM112dl33eUtOjK47GAoUtqNn3E
	 KzG0b7KgZf1639t76w2rtXtsdRWmG5wvFLC8cvxw2roo+6XIUVgg/8QVBQuDAX6MV7
	 a9LyAxt3mqgukKvyskXqZmD+IEsRcFNnFjKRSQoTLiN0a/QOQFhcB6tD4Rqs5cvjVH
	 OobV4yBe40Pug==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/11] btrfs: tests: fix error messages for test case 4 of extent map tests
Date: Mon,  4 Dec 2023 16:20:24 +0000
Message-Id: <10f2b8f765981fd5d5e24a210d85ec2d2250c700.1701706418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701706418.git.fdmanana@suse.com>
References: <cover.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In test case 4 for extent maps, if we error out we are supposed to print
in interval but instead of printing a non-inclusive end offset, we are
printing the length of the interval, which makes it confusing. So fix
that to print the exclusive end offset instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/extent-map-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 8602f94cc29d..ac64eafad703 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -388,13 +388,13 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case4 [0x%llx 0x%llx): ret %d",
-			 start, len, ret);
+			 start, start + len, ret);
 		goto out;
 	}
 	if (em && (start < em->start || start + len > extent_map_end(em))) {
 		test_err(
 "case4 [0x%llx 0x%llx): ret %d, added wrong em (start 0x%llx len 0x%llx block_start 0x%llx block_len 0x%llx)",
-			 start, len, ret, em->start, em->len, em->block_start,
+			 start, start + len, ret, em->start, em->len, em->block_start,
 			 em->block_len);
 		ret = -EINVAL;
 	}
-- 
2.40.1



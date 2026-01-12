Return-Path: <linux-btrfs+bounces-20400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C48D12DFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 14:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA2A301FC1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C42359F8F;
	Mon, 12 Jan 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+APAdb7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586E330339;
	Mon, 12 Jan 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225456; cv=none; b=Y6Q3gz5yGsA4OkwcBoHLgZTC/Fxma4I440eo7VGc8j8DafJ4+INXrmaUeL/kiLgL0YWHR6oqu5GHvJC55d/dEgNYUQQYIQgBvMHmE8sxu/4sZ106+e7nNkhzNU6cfDuReVa+tvOPxT3DPUte8OGEewMHWy5U/vMiYsMkiA91aQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225456; c=relaxed/simple;
	bh=fmwIlMbdtLz/erEbIxpMcWSvLpOC9hkYVlKBKlxgI78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMxspjisIuFJruy7Q5hl2mHd6W55XJEJLm+Drw1BwN2uhv2Is1AbBUpXA9y3B3kltgCQF9O1CuY4Qrfg2y5AiIVRdhBtfQUnBlLh+YR/IFVFegSkrShshUm96XW2cojNWZM9VOp5XuayIaDUg3Rfu3GO205cXmAJraxI/5ptrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+APAdb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6538C16AAE;
	Mon, 12 Jan 2026 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768225455;
	bh=fmwIlMbdtLz/erEbIxpMcWSvLpOC9hkYVlKBKlxgI78=;
	h=From:To:Cc:Subject:Date:From;
	b=t+APAdb7tvLfkPcMboWWzhDMytrrFnJjsyMrnXC/ZOLZmuV6qhCLWLJpgFZWnU4gE
	 at9uSG/Q6ytliV5q7Enrq0qvgy5ecGFUy9x2cDrG7Oy/XFI0V7iLUeCz3RBoKfiKkq
	 CvvsvHXHRg1Rzropeo40pErSErQ2WHfLtDUJrGFruuolfiKEXdoLGAx6MJx6jiY8gV
	 OKqLdQeqyJ9Ktmz6W4Kqa7Ov/41OUI4cmEKVD4LS7c31epoaHQOlFn/L+Tm8EtIN/2
	 s1Hn/x/iL4czKEZsQw4fBE1g7q6oFi6AMsOTZ2xqSAM5VhF7cZiVm82TCUR3WjqLwW
	 8Ma+FnXT2bzgA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fsx: add missing -T option to getopt_long()
Date: Mon, 12 Jan 2026 13:44:09 +0000
Message-ID: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently fsx fails with an invalid argument error when we pass the -T
option (do not use dontcache IO) to it because it's not listed in the
gepopt_long() call.

Fix this and add T to the getopt_long() call.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 ltp/fsx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 626976dd..8626662b 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -3160,7 +3160,7 @@ main(int argc, char **argv)
 	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
 
 	while ((ch = getopt_long(argc, argv,
-				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
+				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:TOP:RS:UWXZ",
 				 longopts, NULL)) != EOF)
 		switch (ch) {
 		case 'a':
-- 
2.47.2



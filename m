Return-Path: <linux-btrfs+bounces-8588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CCB992B00
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B537284D59
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2173E1D26EE;
	Mon,  7 Oct 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMerIUZj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495D0A2D;
	Mon,  7 Oct 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302544; cv=none; b=bWtguUAeerSuXaH58CUdklQIPyoCTTqE2YrQ5sVh5EfYoiqKwwRDXI2EhKhu+MjjnQKJsWXN4TI13OZX+fYWzt0X8IiKjTnWOXCLELvidhl+knOyHUwfy6rctvrSVHoxJA3J5uStmWibyLTTbU8Ltp4WqvBXxwWYeDjT+34wrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302544; c=relaxed/simple;
	bh=IjRoJ5ttRI+wbnPVrZUlxvrNKwtP+vicBzmCuD2r/8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSmHQEqYgYcb2FCo19pdd/B7TdgmTyLLKkaZMb7W2fQzpJqwyf1LmtXNjHt/OJ0Jd+r7vGlqMd2/rzkQzU8fc6dZ046APlD+URwpKBHw33iUprDhqnRCCrSOMMbDgmZ9W0T0WxsZsTnKOO22ejNGWsfhNeZm9lvoHO5zh9NpGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMerIUZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C4CC4CEC6;
	Mon,  7 Oct 2024 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728302543;
	bh=IjRoJ5ttRI+wbnPVrZUlxvrNKwtP+vicBzmCuD2r/8M=;
	h=From:To:Cc:Subject:Date:From;
	b=cMerIUZjXYSzi3uibf5+cnW31D3wdGmYSGZAXPAOx8kpBVHuQLkqTt2UUJOh/dixp
	 hgFEKVTTC+3hsW/d6bZ/if+UrbnjRM9cOelV/nadja++VCPa7LqqgYlN3KIbN/7uUm
	 WNJiJVU1tCFYtFJqd3GXlz3/7ND/jlJ26LD/+Kif5Qcf47UNn7GNb9JAR8Xg1zht0w
	 KoK7ObOV/zI41dV/YaJJtJq4+kTkqYozep5UyuSubacOUuffS1zTb4l0EBQGf8YOcq
	 sVuHqucKkci+n2JRoP18vhSQXQoBYHJmF+UF9EY0WpE7o8vFSsBKWOf/A3Mq9Gknqm
	 zbv+KA+ADgYpA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/322: add git commit ID
Date: Mon,  7 Oct 2024 13:02:16 +0100
Message-ID: <2126c43fff7fc7b421c3ed692f1eabbf10d8e534.1728302503.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The corresponding btrfs kernel patch was merged into Linus' tree and
included in kernel 6.12-rc2, so update the test with the commit ID.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/322 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/322 b/tests/btrfs/322
index 06a62bb5..12aaad71 100755
--- a/tests/btrfs/322
+++ b/tests/btrfs/322
@@ -28,7 +28,7 @@ _require_xfs_io_command "fiemap"
 _require_xfs_io_command "reflink"
 _require_odirect
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit fa630df665aa \
 	"btrfs: send: fix invalid clone operation for file that got its size decreased"
 
 check_all_extents_shared()
-- 
2.43.0



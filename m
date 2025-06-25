Return-Path: <linux-btrfs+bounces-14958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB6AE892A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 18:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B78F3A48D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B875826C3A5;
	Wed, 25 Jun 2025 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpJjKU/c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830C17C224
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867557; cv=none; b=Vnp3KLPnKUrkSoEYwCiCDr4TQok9V1espCpLpqwCCUfcL4CJKbEQxWOfotUJkvOjhryL2/Sr6lAnKcvJ4ZmgU9Ju74ynprdweB5kwERCNMhiT+RzYvjO/LyFBhVkoRKkCYfa8wjx+d7hGIYHKT1qQZ959cWhVC+Mn8OfXEuL000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867557; c=relaxed/simple;
	bh=GOerHk4EhmEo5omK5isEN6TJxhjCVDc/a2a+aR1PI2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s7vmUJVNvs9l1P2tLcDRhxuDAM/v0Jq7neDuY/rT4p1KClOX5Jo5RwOe99JeJSH8KBGemgsG9D8tybyw+ra/86XfV00y2H/6f//F/MThKFZh8Jf4Hn3Sc3AK2GEuYXxZsESQOyjk/wU0MC6R0LaqQprNMBKNkYkD74BZN+kHaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpJjKU/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F219FC4CEEA
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750867556;
	bh=GOerHk4EhmEo5omK5isEN6TJxhjCVDc/a2a+aR1PI2I=;
	h=From:To:Subject:Date:From;
	b=hpJjKU/c8MEvXNrdK7xTzp6voeijzq8xRQS32e0Zur8bvjEpMw+yOApou6MWOe2kB
	 IB1udYVrPC98H3uSdr20jktVl1SD+zMjuNxunJR7++0o/h5EInc4p5Y0FPdgonxWNe
	 nYIGtK+5p9KkETl8NVvdvscYXA27MDM/rPqpUdUHY6X+0PN+EPnMJ7TTHyGdHeUm9w
	 hN5dpnTEJqNfslU2v3PnjZ2MyUBdE6Fop1cUK+KdjTMUOmtXKQMLkQUIsiZ6iPBELZ
	 6JGLUfZ610sXC1q+z8GD7ZX4xOUddRvi3him89Jfn+iwrCFTSUaScOKkrqLg7OIEIU
	 WJoA75ZtRB3KQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: remove redundant check for add_qgroup_rb() call
Date: Wed, 25 Jun 2025 17:05:52 +0100
Message-ID: <4017a6e8b1a7b5a839f0552916cc2c281286210a.1750867517.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The add_qgroup_rb() function never returns an error pointer anymore since
commit 8d54518b5e52 ("btrfs: qgroup: pre-allocate btrfs_qgroup to reduce
GFP_ATOMIC usage"), so checking for an error pointer result at
btrfs_quota_enable() is redundant.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index e38272ac808d..afc9a2707129 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1161,11 +1161,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 
 			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
 			prealloc = NULL;
-			if (IS_ERR(qgroup)) {
-				ret = PTR_ERR(qgroup);
-				btrfs_abort_transaction(trans, ret);
-				goto out_free_path;
-			}
 			ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 			if (ret < 0) {
 				btrfs_abort_transaction(trans, ret);
-- 
2.47.2



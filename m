Return-Path: <linux-btrfs+bounces-11317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC0A2A87A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22608165F27
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA922DF93;
	Thu,  6 Feb 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+UZaI4+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01A2253F0;
	Thu,  6 Feb 2025 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844806; cv=none; b=ZcQ/BzU1kwjPzO/JK+lqvMr3IkrkgtJl9XYy1TRqxO4RZiwZcq2rhuFYcpizXbHmcANIS7rncm8yti4dWMj1wA2C9u2+S6+e+wP7BmxsQZ5urgG5DmhJAjjbJK0qfeT92l3I/42F5EUuyQHf0tkC3LHzpQVlQCJEatdkdZ61Cfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844806; c=relaxed/simple;
	bh=Gs/ZjYJcfesuQ4HVpxGoEjVLbO1JCoIjU1sMEjUWPDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgKq8nriPU83WdYJmUzm1Ofj33FoMI91F4uaINRDW49pwW6w0Mh+ks42bicN+oLtxEBM4UTvLQz/UdSt4sqsQ9qp0UfCZzPc5svd+cqNOM3WI6J6m5WoFC+U7iOyQUT5W/kuYqtcdf2UQenpG0vY2w7QAGGJl8HewiZ9/HBC6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+UZaI4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634EBC4CEDD;
	Thu,  6 Feb 2025 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738844805;
	bh=Gs/ZjYJcfesuQ4HVpxGoEjVLbO1JCoIjU1sMEjUWPDg=;
	h=From:To:Cc:Subject:Date:From;
	b=S+UZaI4+vOBHExacTzLtgW0KnGIqrdfOsxoRcTeI+SYGj0cDRXYLM6lbP3RF64EfF
	 Wwfm8fNolzsBDQp3nhoyJoUCvmvKjf6syShWVh6eS/d10JDmxXBJAMO0YYupVJjK8U
	 QBk6Yqe5TYKq5GQzf5i42J8OhuFAc5DDd5AnZXwF3vAGdJNXQTkPRv/cgph/3yTzDA
	 CJ0TFrSD/72vkD/7zR1gI/9xhcVGks9a+ihiA16BLLybctuI2uFFdv9tQfsd/5fFsC
	 kWH5jU+zMCc8HiP6WUKXsMHxjeiMEu/wE7MtQF0Tqm2sjS8YGPxeXBYU0ikCMDfp4D
	 2KdGriYy1OZnA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/631: suggest xfs fix only if the tested filesystem is xfs
Date: Thu,  6 Feb 2025 12:26:33 +0000
Message-ID: <9e38c9daf9d330ad2c3a180df13c4bcc0f115416.1738844738.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's odd when a test fails on a filesystem that is not xfs and it suggests
that a xfs specific fix may be missing, which obviously is irrelevant.
So suggest the fix only if we are running on xfs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/631 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/631 b/tests/generic/631
index 8e2cf9c6..c38ab771 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -41,7 +41,7 @@ _require_attrs trusted
 _exclude_fs overlay
 _require_extra_fs overlay
 
-_fixed_by_kernel_commit 6da1b4b1ab36 \
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 6da1b4b1ab36 \
 	"xfs: fix an ABBA deadlock in xfs_rename"
 
 _scratch_mkfs >> $seqres.full
-- 
2.45.2



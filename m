Return-Path: <linux-btrfs+bounces-3657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D353A88EC31
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721141F284F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719B14E2C9;
	Wed, 27 Mar 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgHrDJ7z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46C12F583;
	Wed, 27 Mar 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559516; cv=none; b=fdE0+BUVs2nJiYb0z9YNl34prLxWnJlRzuk+3SEQ41DCPrtU4jZLI0OgEvQK8K6MOoxkopiRsD4pASyoRLow3wEpe+Qm6nf0b+e1dY3oPQZTN3+742b+aZGkgW8o+cDk65P4IJgkvPR/HmWy0ykKkqVdfawo6G6q5bE3oIKER3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559516; c=relaxed/simple;
	bh=PejVCeyImKVb9tF6Ui/cbZM3A2MJUS8mmfB5DA0lsws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwG6nOJ5KM9ldV5qkDrKfAkVOoncaJL0HZsHMNEeg3PW/z1Nt3K+AeS2wRlN0/QVZmbZVHH4kfTzi8NubOjbZeRXZovYomfIrXZnYfWq93kMeWiWRa3c4r3m4FGZoRRDgcn92PhKbADQvjeBvik+nPg/DhZkSrMYuXvzxpImslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgHrDJ7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4703DC43394;
	Wed, 27 Mar 2024 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559516;
	bh=PejVCeyImKVb9tF6Ui/cbZM3A2MJUS8mmfB5DA0lsws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgHrDJ7zwGmuCxnzlnA+1MQ86YwmCAwEpIK4RS7kUEx5pu24JGq20JrM+pXkCLO6r
	 VJBaIn5jpf3ZJRxBQEgKUowfP+HeA4GCPuMhxkrHjYbQsTO2zhm8lHoTGd+wkqDYvc
	 dMCadNdaWovUFiqqRAwdTqqFFiTjgFimPqLp4R9T1hDOCSfGg/4mBVYBce0y5g1yBF
	 iJGFW48u79YDhHp0jN9RDlWecrliVYVcbQbLFs1iF7a9R1bsulIEm8JTR4ZXZWCAQ0
	 boHXwrSU2BY4Umakw94J2Pvh/A2u6DJIfOuFpiQFJZCKfm9anIoG5X3j4Ufcc5QhY6
	 OMwiCYHwAHhng==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 02/10] btrfs/028: use the helper _btrfs_kill_stress_balance_pid
Date: Wed, 27 Mar 2024 17:11:36 +0000
Message-ID: <375e94a8cc448c369d4346cba2f6ef6f65b34df6.1711558345.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711558345.git.fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Now that there's a helper to kill a background process that is running
_btrfs_stress_balance(), use it in btrfs/028. It's equivalent to the
existing code in btrfs/028.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/028 | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/028 b/tests/btrfs/028
index d860974e..8fbe8887 100755
--- a/tests/btrfs/028
+++ b/tests/btrfs/028
@@ -44,12 +44,9 @@ balance_pid=$!
 
 # 30s is enough to trigger bug
 sleep $((30*$TIME_FACTOR))
-kill $fsstress_pid $balance_pid &> /dev/null
-wait
-
-# kill _btrfs_stress_balance can't end balance, so call btrfs balance cancel
-# to cancel running or paused balance.
-$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
+kill $fsstress_pid &> /dev/null
+wait $fsstress_pid &> /dev/null
+_btrfs_kill_stress_balance_pid $balance_pid
 
 _run_btrfs_util_prog filesystem sync $SCRATCH_MNT
 
-- 
2.43.0



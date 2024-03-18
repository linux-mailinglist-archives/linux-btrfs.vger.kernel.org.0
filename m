Return-Path: <linux-btrfs+bounces-3347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD04C87E84F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 12:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0BDB22B3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 11:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B8381DF;
	Mon, 18 Mar 2024 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCo+s4G2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8D381CF
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760321; cv=none; b=PnXTHmDxxsIqPEiE9ELsly1/Xpd/0DyQSiRdIli2/B4U6fibNFC3T/ZJv8GU7czHawa62iUoFwH36zr6AI3wdTPi8dtpvduHyoEuCyQsTGqfVpUXpVh/ttaw3vTVmQpaUmynKdqkDXQ3hQkcARlvB0BOKTgjK8BD3ovtJqgfsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760321; c=relaxed/simple;
	bh=DaF8gqt4iqVeZXtnEXv7mHZ+BRmjnfOStBdTuy7mSS4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iwIk1pXe4Q1BqQnuHa6mzziOis3eYaFTdMpzyH4yA3swUilfB+8NIopen7YhLjo9zdtnv5XGMPuiGmFpiO1GksKUnPVs5DC5iMMsTAMzADe873zYxyNlXfMRFqHuGZi0fMQNBOAlxg1ehLaMyL/nI3FP9mhMXQSwV/nEGH9UiJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCo+s4G2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2573DC433C7
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710760320;
	bh=DaF8gqt4iqVeZXtnEXv7mHZ+BRmjnfOStBdTuy7mSS4=;
	h=From:To:Subject:Date:From;
	b=pCo+s4G2bG67ypfm/FMUTRRX1/57S7jZFgb+tlllH+5a96mUDMAu2rLeVEyXSXd8i
	 3x0I/LDD76YgrhxGX9GAOJL08QnLus1kPk1HUupOb7nxqdVHQSdgg8bqQfOGJHCGXl
	 K8OYcqZp0mmSW1KmxQJ18sFH64SigmH4sh5jtLxqpFquVtPuR/bVtRTxEXxdDSQhqU
	 g2WGL3w/h9Rh+0QKeLHPFWkuQVHjdWpLM4EjgDk6CjSlZcqLDf5cD4xJ4eYpk7Xh+Y
	 SEPBT7bSoayXD+VWTR5aM0Sq9ZGHqChYKRxfYHc5PTG2CFpHio+/aVdWFJJ8phldip
	 7ICgjBlRo7TJw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid pointless wake ups of drew lock readers
Date: Mon, 18 Mar 2024 11:11:56 +0000
Message-Id: <ed6897d89e53696370450d72a366f96ad954edbd.1710760179.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When unlocking a write lock on a drew lock, at btrfs_drew_write_unlock(),
it's pointless to wake up tasks waiting to acquire a read lock if we
didn't decrement the 'writers' counter down to 0, since a read lock can
only be acquired when the counter reaches a value of 0. Doing so is
harmless from a functional point of view, but it's not efficient due to
unnecessarily waking up tasks just for them to sleep again on the
waitqueue.

So change this to wake up readers only if we decremented the 'writers'
counter to 0.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/locking.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 508a3fdfcd58..72992e74c479 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -364,8 +364,12 @@ void btrfs_drew_write_lock(struct btrfs_drew_lock *lock)
 
 void btrfs_drew_write_unlock(struct btrfs_drew_lock *lock)
 {
-	atomic_dec(&lock->writers);
-	cond_wake_up(&lock->pending_readers);
+	/*
+	 * atomic_dec_and_test() implies a full barrier, so woken up readers are
+	 * guaranteed to see the decrement.
+	 */
+	if (atomic_dec_and_test(&lock->writers))
+		wake_up(&lock->pending_readers);
 }
 
 void btrfs_drew_read_lock(struct btrfs_drew_lock *lock)
-- 
2.43.0



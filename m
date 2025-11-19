Return-Path: <linux-btrfs+bounces-19147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FCC6ED38
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id C6F5329552
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 13:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCD235E55A;
	Wed, 19 Nov 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+efuUeS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354E33CEA5
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558372; cv=none; b=E3AU0I5Y4t1NttXmJ/0ImzC5uasiVrXDt4MLwUvNdnLBMYecDZXfmlI1gGU0VZgPHoLk2PoxlvzeRyG3BV2N6L5IUjKzyTf4tWMhhTselrgEt0C4j+P1dB3wfjvQzirLRjxvhvRa4D40+r+JYMJ7R9nX7lX1cPX8zkLH1XAsaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558372; c=relaxed/simple;
	bh=/8ZGtV521cw3qYY2CGvjXCHAGtu/Eh341Zvh5LYI+C0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ELkB5xBT7T5k1QiicNtgGPet6nIN+JLQUo7QmGTM74rWXYI4MQvLXFqYpCqLsu2241cd0ibbqe6AY6UN6hwUSj12HeFPJHEAjwWJDpVmIUifdOaBlYfkJ0iNM7VDGbfbLLKa3nUUQHFRwLe+Z0fszwZ1bMXWtks1HcjmETC497c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+efuUeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A29BC19421
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763558371;
	bh=/8ZGtV521cw3qYY2CGvjXCHAGtu/Eh341Zvh5LYI+C0=;
	h=From:To:Subject:Date:From;
	b=N+efuUeS4FVF+v/bilfDbDnL4jKOQxs75IVkZmMIctmIgPHQSOqpUVVjaitVQS1V6
	 d4tFwnsxWai/AiZE4AAKJr7HOQNV4FJDt7xb1GK5yO3sIkklQ3GBSh5JCTlJWg1NY1
	 mC207F04Cq5Ymu/g1tSgfjWj3+ObkEKRczr65YKJ4iUkVgngl9d+7BK8nWCV22QpTl
	 CTavpUNYCeWXx7YovUCSHYhhuk+jR+XM4b5kOhfbGOl4c5StHz79E3pSECijswpdoz
	 NStKpV8q8rNs4q1YhJcIYUW2Umw1BhoJ5KvkG6nVqu1OapeXRbG+yFZOIlr6PnvytR
	 d5WqDdMxeZdOw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: cleanups for a couple log tree functions
Date: Wed, 19 Nov 2025 13:19:06 +0000
Message-ID: <cover.1763557872.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A couple of trivial cleanups for the argument list of two log tree
functions.

Filipe Manana (2):
  btrfs: remove root argument from btrfs_del_dir_entries_in_log()
  btrfs: reduce arguments to btrfs_del_inode_ref_in_log()

 fs/btrfs/inode.c    |  4 ++--
 fs/btrfs/tree-log.c | 12 ++++++------
 fs/btrfs/tree-log.h |  5 ++---
 3 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.47.2



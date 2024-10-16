Return-Path: <linux-btrfs+bounces-8958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB79A0C74
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E16B28B6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613DC1CB53F;
	Wed, 16 Oct 2024 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0bfATCj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67713E40F
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088427; cv=none; b=YB09QWA8L8PqXGJ8d2NQCm8+V/++Veh5gmNQEOtxobZWn8xZfI8LgS1zX8cUzR55ONJw6eO6KhyQxYNGm9UNERueS5nzFuXscmhK70VJUzNQbb8E7jSSvgaBFDHuS9lsDLc8Z2wpXTWFl1RcLs3ghJIH8aEtj7t2abwHN4S9B54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088427; c=relaxed/simple;
	bh=LTiPFr08tRlewQ4/xGAjUSW1PNlLmVPb7ToIeXUlMyE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=h4CxIv1LDNaXF6ZjbWiQXzZIXOUzNJuvOuxZJVLkrjzEmrfsS6FNB4jgEc3pkvySN+dpH/prwompTA+3M5Jo7mxmYAmlotMIh4uP6R2tC9D/NP0ZXwakWRcOSsIjFy5DDQYpvW4znc50RJknUJfYSlJLsLN9+ODtHx6ivgQZOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0bfATCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B65C4CEC7
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088427;
	bh=LTiPFr08tRlewQ4/xGAjUSW1PNlLmVPb7ToIeXUlMyE=;
	h=From:To:Subject:Date:From;
	b=l0bfATCjPag2vc8c9waWt4O95FeNqr2CckXziQ0Lnea392Jpb+K4rG/i5svCvwy1v
	 WhibhCroar6r3n6xVhziDv0DbH8fgluQKnD6blGE9ebEKET5xV48/auO6UEDpwYWFF
	 Y7bAkAVbQRkATe54vZibb0GYOhybi1O8Vn1lxqqpSzL3z/I8rZvTNhNiy5XtG90J+o
	 XjT0XW5G4YFbQKcdt9XHydyJtIlZ+0CTs+wrUlnzR4atXrWjCsbhg/8j4EWqIbT6Rs
	 dPkaUwfAiRnVhFC8LIu6rYCo25uA2qGQ3yFlRAjwzoOSTSs7jcNmU9u62FVeGFLRQa
	 NfZjAszsvopzA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: some cleanups around read_block_for_search()
Date: Wed, 16 Oct 2024 15:20:19 +0100
Message-Id: <cover.1729075703.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A set of cleanups around read_block_for_search() and btrfs_verify_level_key(),
mostly simplify arguments and remove redundant arguments and variables.

Filipe Manana (4):
  btrfs: remove redundant level argument from read_block_for_search()
  btrfs: simplify arguments for btrfs_verify_level_key()
  btrfs: remove redundant initialization from btrfs_readahead_tree_block()
  btrfs: remove local generation variable from read_block_for_search()

 fs/btrfs/ctree.c        | 29 ++++++++++++-----------------
 fs/btrfs/extent_io.c    |  1 -
 fs/btrfs/tree-checker.c | 16 ++++++++--------
 fs/btrfs/tree-checker.h |  4 ++--
 4 files changed, 22 insertions(+), 28 deletions(-)

-- 
2.43.0



Return-Path: <linux-btrfs+bounces-17698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D421BD2E6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E903734B74C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F6426CE2C;
	Mon, 13 Oct 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx6Ba08x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636C1D63F5
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357136; cv=none; b=JIkvefsW66Hy0Bns+x9eWtQLxDhyIVvMOfEvR20F0mRDagdXPTxgTKu6owxti1bo71Ju/gsGoG07Mo5tTm+0aa9z+/BoVpSadsspsb87O4YscXaKJ2CDLb72mpEGu5thdTTbmPikVC+5TnYTp6uPQMh9mrzzagaWby/oZf4h4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357136; c=relaxed/simple;
	bh=+WhY7xizl9ULWFNOA8szfIdIhDIdXTkOjaitqdwXAVg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k22RAhWJCBsYRCDwXp2w9yE/1C6kcXqHgmWuM3bsAjzfzDg/ILtPF/+3tCQbJKdr6Z4MrJMw/Uc5jY6ylf5Yekcv7f2aBVc+AC/OtgUL4HW8ay6Z+or4x1zNN84iG4e2vBvseSsy3AW/GMXtFeQ5yXP0JyYXKBk/qjaUJ5eHXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx6Ba08x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA4EC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357136;
	bh=+WhY7xizl9ULWFNOA8szfIdIhDIdXTkOjaitqdwXAVg=;
	h=From:To:Subject:Date:From;
	b=Gx6Ba08x1Ia5S3whSzFqi6/kwyurDsih2GwrPJZjjq/DlNhmGaKpWX5KIb569CGpk
	 9hbgRpDhFg9giegkGgTjeaNxPC39bMpDyKYZBj0a5NPEBwK/uYvO8CBfQV4Wk/+cpu
	 egoNyUH10LcAKF8EmuD6+mvpa/ZkoqztRZVwI6MQGCMx2ozKGe9a414DLlk2OUFiTs
	 +shbkqCUqmdoo70Vly7Rn0CcqcTm3c6oakOf8swMIkRErAiz0UsC8NJLAE6dQx4mo/
	 QWlE9glJr7oodDDuZP2Js0FEp2274nXXhhvqnGjGP/AqHGxH48/WP5r56vWHlO2SgX
	 +KLqA2YKUBhCg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: fix a bug with truncation and writeback and cleanups
Date: Mon, 13 Oct 2025 13:05:25 +0100
Message-ID: <cover.1760356778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The first patch fixes a bug where we can up persisting a file extent item
that crosses the i_size boundary, making btrfs check complain because it
won't find checksum items beyond the i_size boundary. Details in the change
log. The rest are several cleanups in related code that popped up while
debugging the issue.

Filipe Manana (7):
  btrfs: truncate ordered extent when skipping writeback past i_size
  btrfs: use variable for end offset in extent_writepage_io()
  btrfs: split assertion into two in extent_writepage_io()
  btrfs: add unlikely to unexpected error case in extent_writepages()
  btrfs: consistently round up or down i_size in btrfs_truncate()
  btrfs: avoid multiple i_size rounding in btrfs_truncate()
  btrfs: avoid repeated computations in btrfs_mark_ordered_io_finished()

 fs/btrfs/extent_io.c    | 33 ++++++++++++++++++++++++++-------
 fs/btrfs/inode.c        | 18 ++++++++----------
 fs/btrfs/ordered-data.c | 23 +++++++++++------------
 3 files changed, 45 insertions(+), 29 deletions(-)

-- 
2.47.2



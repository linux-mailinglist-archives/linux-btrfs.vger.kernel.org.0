Return-Path: <linux-btrfs+bounces-12269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E66A5FEA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 18:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A414D19C1941
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9521E9907;
	Thu, 13 Mar 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNuu9BUr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E111E573B
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888541; cv=none; b=IGE/rHJU7NrC57IRpKbHius1hy1EHJL3LGkKTGopXILEHIAHfXzhjySLMDT2O48X9KMomRMdteKez6Q1aTSkMbmq/Rm0M9bjTSMtCMzvq1XZ+NMeDKtBbV1NK7JdigsJik+JJdlGjKeoD4oUyrn/h+hq6aALCgG/OBOsnLKphV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888541; c=relaxed/simple;
	bh=Cb+mVLaT9PQrLQjPNtLVOhfOfMf5HhIUMkzZZnRnf/E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=eAw28QwXqox7Q8mmw50TlfHg8zNlk3dqbXBxjytMT0fcRxoGYyYhygpMw0NtEf2/NKwP1jDBp4kbSONcJoL3RDDDNAAaJ4vUuV623AubT7Fk64nhompMmenB90UCOnTayaCwP24wa8pq6tUvWf4eqYilqz1VZX2erMlPBJKrhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNuu9BUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20668C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741888540;
	bh=Cb+mVLaT9PQrLQjPNtLVOhfOfMf5HhIUMkzZZnRnf/E=;
	h=From:To:Subject:Date:From;
	b=PNuu9BUrgb8w6uWxrkRZfuQqgERcyXWstw4ZKcsm9kLf+KSLL9Y1gp3Gchwgqha4M
	 kLWNaO4Ht2GXs/vYQKWMWS/EDJHYCvbjdNhXVPTsVkbhwyYEjFAfxkxf1+Xy8gsVzL
	 u5PSm/GBlun4z1iObXtQ8Yt+5cAZsODKmOU5tD8mfJ/eibO3+kqjUs0qdipO8VCUWr
	 7VKOpHt+Jy3YJaaO42jGRIkFLnBAXPjQPQ0fzfpUpTGiECV/ZJYkD0HcyLbquww4O8
	 d9nFUUpg5oX7yM1ovdLZ42TVdYjXJ5oiId6ETmf6Zp90xu+xAA/HFrBfIeKu7i8e+c
	 1MmT7rclBOGBA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: some cleanups and minor optimization for log trees
Date: Thu, 13 Mar 2025 17:55:30 +0000
Message-Id: <cover.1741887949.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A series of cleanups, simplifications and a minor optimization related to
log replay and inode logging. Details in the change logs.

Filipe Manana (7):
  btrfs: avoid unnecessary memory allocation and copy at overwrite_item()
  btrfs: use variables to store extent buffer and slot at overwrite_item()
  btrfs: update outdated comment for overwrite_item()
  btrfs: use memcmp_extent_buffer() at replay_one_extent()
  btrfs: remove redundant else statement from btrfs_log_inode_parent()
  btrfs: simplify condition for logging new dentries at btrfs_log_inode_parent()
  btrfs: remove end_no_trans label from btrfs_log_inode_parent()

 fs/btrfs/tree-log.c | 125 +++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 72 deletions(-)

-- 
2.45.2



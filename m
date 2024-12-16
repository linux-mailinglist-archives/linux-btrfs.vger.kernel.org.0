Return-Path: <linux-btrfs+bounces-10411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C475C9F374B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89739169F82
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45012066C0;
	Mon, 16 Dec 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSidscor"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E16205E25
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369448; cv=none; b=qvo5MngOlatYqHigEXaCyJkC7yS3nv+/VoFl/xmo4VJq/Cyqi1qOBHpsaCFxIuf6vZRYqsFEmOH5d+2hsw2WTjUkjWFzDsLpywf0JMzd5cJu6vgSh5uosAO1/ABkVsK1U7qSjQN3Z9s2KS6fX95xMQwwDWvZuUPlumN+Q1+lSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369448; c=relaxed/simple;
	bh=Zo2RnFZ1vJtIn0xU9d9WpSxnD9L2YrN/dgZIRKp85dQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=b4HlsgDkLU93ql3XZUKR6/rAJzKaCey/c+r+rjgj+TZTHre6XYPk/4KPd/rVMub/YDwKV45cKixbjzbROGFbOXjqtHjKZZ6DqQ7gXoWg3dH3mi8JCAhXXuj2OCKBlRj7mlORM5CoDZL3Jg42q2X/+oGp4cMwfogmg76StZsq0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSidscor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19072C4CED4
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369447;
	bh=Zo2RnFZ1vJtIn0xU9d9WpSxnD9L2YrN/dgZIRKp85dQ=;
	h=From:To:Subject:Date:From;
	b=qSidscorddjNh+gqADtt4GtpeaF+FuLrsGUbugn+n7iSRL67uTa9aLn4LJR38ojnP
	 TEn6jWs+89wmgDfeSWuZJh+5IWEYA/oc4ec6YKZm7GySpKjEiMf8iQ32UitJVhGZr1
	 33SaEGOnR/WUnAF6F/ZcaoN7vA64VEr0DrxV01yNvDJipYuVWXhxRJ1Mtmsl2w16An
	 0w9Ssl+1lTONRnNKx0y1toS/lfahCCaTsYJGvB6dRdp7S/jN+LkMQ/spN/h2Q41sMK
	 iJvLXY0k1MyWKVdhpLMh7nAs2xdfutarPRU9NSmdfFbubwgO/pkYMBScNaIvmxv6yR
	 Uuld99m9W63hg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9] btrfs: some header cleanups and move things around
Date: Mon, 16 Dec 2024 17:17:15 +0000
Message-Id: <cover.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Move some misplaced prototypes, macros and functions around and some
header cleanups. Trivial changes, details in the change logs.

Filipe Manana (9):
  btrfs: move abort_should_print_stack() to transaction.h
  btrfs: move csum related functions from ctree.c into fs.c
  btrfs: move the exclusive operation functions into fs.c
  btrfs: move btrfs_is_empty_uuid() from ioctl.c into fs.c
  btrfs: move the folio ordered helpers from ctree.h into fs.h
  btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
  btrfs: move btrfs_alloc_write_mask() into fs.h
  btrfs: move extent-tree function declarations out of ctree.h
  btrfs: remove pointless comment from ctree.h

 fs/btrfs/ctree.c            |  67 -----------------
 fs/btrfs/ctree.h            |  29 --------
 fs/btrfs/extent-tree.h      |   4 ++
 fs/btrfs/free-space-cache.c |   2 +-
 fs/btrfs/fs.c               | 139 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/fs.h               |  24 +++++++
 fs/btrfs/ioctl.c            |  91 -----------------------
 fs/btrfs/ioctl.h            |   1 -
 fs/btrfs/transaction.h      |  18 ++++-
 fs/btrfs/volumes.c          |   2 +-
 10 files changed, 185 insertions(+), 192 deletions(-)

-- 
2.45.2



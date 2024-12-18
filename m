Return-Path: <linux-btrfs+bounces-10556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD679F6BE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC30B16D2FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70031F8926;
	Wed, 18 Dec 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW6pEL7R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE614AD38
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541612; cv=none; b=qQnk+MApqueI43WuCSijxYbLefTcuaV4SpgoGdM2/yqg68yFz36TNepcutXO2Do31Lx17D4z+uH3mrQzhARy09CcCIeQGo8IYkty9SAeHuK8N7c6V3U9W5Zwa9swyn9jboEay0AWVk2FXMMdPYwjvowA9a+GMDme+TMuDMTWDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541612; c=relaxed/simple;
	bh=QQp0Qzq98aa9lg2Qk1csbtXmZEMXcBbDgb/leOSH1fg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Sebr2M1yDh3Ta0CrK+p6LoQ8dj5fiQY4drpxlfmQS2KUtt1IRpBEImo7D9sEhFuw89mWQNjIaIMHSINtplD7Lfi/hExzSLg4otIuEP45wmT1rwkJXSUKQlj+tYnVGS0z+5k2pPSmZQhQYYLUTjUtDEgBm1ikthq30VpuFwlsVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW6pEL7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CC9C4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541611;
	bh=QQp0Qzq98aa9lg2Qk1csbtXmZEMXcBbDgb/leOSH1fg=;
	h=From:To:Subject:Date:From;
	b=OW6pEL7RRx3+MdpynQ48qsS2U+zIU5Q7amrWXZLpzDqWvMyhlZLEE8mK8frAkzJVo
	 Z9YJpZ57ck/6j5qVIzQxoUoQ0P1eJntv790BprefsH5TU93/duXb/2VkKToqYM1jYp
	 loCVkEVGj9YF9iNNJLpf+sEjahZYgVLSuE+2p7nOxdJ/tehTbXN9HInqPIHp8jynO+
	 JekO1oEkgl06IW5nynPdF56KuI6Phj6wQfVPtK14OwFgFMrBQuF+d/7WawsurDOvAk
	 vCrHfudfGBM12X0a/RTg88IuW9vrEwy7W8Hoa3Z5pGuq6IwOMF1Uo+5PqXK5sOizru
	 c/+mb6XlT9VPg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/20] btrfs: remove plenty of redundant btrfs_mark_buffer_dirty() calls
Date: Wed, 18 Dec 2024 17:06:27 +0000
Message-Id: <cover.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's quite a lot of places calling btrfs_mark_buffer_dirty() when it
is not necessary because we already have a path setup for writing, due
to calls to btrfs_search_slot() with a 'cow' argument having a value of 1
or anything that calls btrfs_search_slot() that way (and it's obvious
from the context). These make the code more verbose, add some overhead
and increase the module's text size unnecessarily. This patchset removes
such unnecessary calls. Often people keep adding them because they copy
the approach done from such places.

The changes are made on a per file basis to make it easier to review or
bisect.

Module size before this patchset:

  $ size fs/btrfs/btrfs.ko 
     text	   data	    bss	    dec	    hex	filename
  1781992	 161029	  16920	1959941	 1de805	fs/btrfs/btrfs.ko

After this patchet:

  $ size fs/btrfs/btrfs.ko 
     text	   data	    bss	    dec	    hex	filename
  1780646	 161021	  16920	1958587	 1de2bb	fs/btrfs/btrfs.ko

Filipe Manana (20):
  btrfs: tree-log: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: free-space-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: extent-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: block-group: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: delayed-inode: remove unnecessary call to btrfs_mark_buffer_dirty()
  btrfs: dev-replace: remove unnecessary call to btrfs_mark_buffer_dirty()
  btrfs: dir-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: file: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: file-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: free-space-cache: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: inode: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: inode-item: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: ioctl: remove unnecessary call to btrfs_mark_buffer_dirty()
  btrfs: qgroup: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: raid-stripe-tree: remove unnecessary call to btrfs_mark_buffer_dirty()
  btrfs: relocation: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: root-tree: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: uuid-tree: remove unnecessary call to btrfs_mark_buffer_dirty()
  btrfs: volumes: remove unnecessary calls to btrfs_mark_buffer_dirty()
  btrfs: xattr: remove unnecessary call to btrfs_mark_buffer_dirty()

 fs/btrfs/block-group.c      |  2 --
 fs/btrfs/delayed-inode.c    |  1 -
 fs/btrfs/dev-replace.c      |  3 ---
 fs/btrfs/dir-item.c         |  2 --
 fs/btrfs/extent-tree.c      | 10 ----------
 fs/btrfs/file-item.c        |  3 ---
 fs/btrfs/file.c             | 11 -----------
 fs/btrfs/free-space-cache.c |  3 ---
 fs/btrfs/free-space-tree.c  |  5 -----
 fs/btrfs/inode-item.c       |  5 -----
 fs/btrfs/inode.c            |  5 -----
 fs/btrfs/ioctl.c            |  1 -
 fs/btrfs/qgroup.c           | 18 ------------------
 fs/btrfs/raid-stripe-tree.c |  1 -
 fs/btrfs/relocation.c       |  7 -------
 fs/btrfs/root-tree.c        |  2 --
 fs/btrfs/tree-log.c         |  4 ----
 fs/btrfs/uuid-tree.c        |  2 --
 fs/btrfs/volumes.c          | 12 +-----------
 fs/btrfs/xattr.c            |  1 -
 20 files changed, 1 insertion(+), 97 deletions(-)

-- 
2.45.2



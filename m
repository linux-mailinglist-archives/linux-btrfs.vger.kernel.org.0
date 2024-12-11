Return-Path: <linux-btrfs+bounces-10227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA39ECF0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8999168295
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98D199E89;
	Wed, 11 Dec 2024 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1sMtgy5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370418A6D3
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928812; cv=none; b=ISDK+cbVRYuCNehH3/2UtYrCQwyGpC2lCanrda9uTh/4lPmgHPDFMD6/1XnNwxWu1iNf4wr5IC0AEpfzp1qqGfBlK4Xu/lv1T72YVjbnIDOZj+50a5qX1QwyB1l3wqlTFYLK6vf09io0ut4dgcVXAH84wQA8rnHVX4kn6ZQwf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928812; c=relaxed/simple;
	bh=TsBs4omSws75hCh4lXxo7zo2Sc+vDbNtNrUbtqPNcsk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=rineDQnxmvKrbMKJjQsVlpfF6JRnKf9nUwq+tDS/GLiWeX+y/d6RITEuU/k8Q6NZrh9oEQ1u3l0al6bqBj+iCmgMkg3EmfXsb1wtmVjDKcxfBSp89cFR6N24McdHe0Ef9IJT2vsXrcr+YtLGHOCm5T3gl2ZCBBv7V72MjhS3pes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1sMtgy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D74C4CED4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928811;
	bh=TsBs4omSws75hCh4lXxo7zo2Sc+vDbNtNrUbtqPNcsk=;
	h=From:To:Subject:Date:From;
	b=C1sMtgy5JXT/MKwZxWS6Yxpg/X/npSdoAZ3D8tAY4KvIIx3a36iRa5oCLn8dJN1sl
	 lsEWbgc0Ly44ljMouiuiSlAY1a+urmaeBoj6dptxO35oMIyuqOlYytRw0UM6ySf8qF
	 BYr1DPOOwv3at8d5zS2OnSNQZ6ZopMBjPj+vPM7O/9tsUwGm4KYHdj2ePZ6BTFgHMh
	 iQtfJ0MzXlESCRhIs5GgUTm7ljxdaIpAdSSq8FXhzPihI1OPXeUAiU4d9LQhsBpa7P
	 MHlCoBDl5+fgXFnczQSzcQ69VgEgVC3OBajJ5SXjTzQYIYmP/rRIEzOpjp9kAeHZjb
	 y7bvlQZH8KCyw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] btrfs: fixes around swap file activation and cleanups
Date: Wed, 11 Dec 2024 14:53:17 +0000
Message-Id: <cover.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are a couple issues with swap file activation, one being races with
memory mapped writes, while the other one is a failure due to buggy
detection of extent sharedness - we can often consider an extent as shared
when it is not but it used to be. The rest are just some cleanups or
enhancements.

Filipe Manana (11):
  btrfs: fix race with memory mapped writes when activating swap file
  btrfs: fix swap file activation failure due to extents that used to be shared
  btrfs: allow swap activation to be interruptible
  btrfs: avoid monopolizing a core when activating a swap file
  btrfs: remove no longer needed strict argument from can_nocow_extent()
  btrfs: remove the snapshot check from check_committed_ref()
  btrfs: avoid redundant call to get inline ref type at check_committed_ref()
  btrfs: simplify return logic at check_committed_ref()
  btrfs: simplify arguments for btrfs_cross_ref_exist()
  btrfs: add function comment for check_committed_ref()
  btrfs: add assertions and comment about path expectations to btrfs_cross_ref_exist()

 fs/btrfs/btrfs_inode.h |   2 +-
 fs/btrfs/direct-io.c   |   3 +-
 fs/btrfs/extent-tree.c | 127 ++++++++++++++++++++++++-----------
 fs/btrfs/extent-tree.h |   3 +-
 fs/btrfs/file.c        |   2 +-
 fs/btrfs/inode.c       | 146 +++++++++++++++++++++++++++++------------
 fs/btrfs/locking.h     |   5 ++
 7 files changed, 202 insertions(+), 86 deletions(-)

-- 
2.45.2



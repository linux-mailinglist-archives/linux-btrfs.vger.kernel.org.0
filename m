Return-Path: <linux-btrfs+bounces-4328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C466C8A8190
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805F2283D37
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CA713CF85;
	Wed, 17 Apr 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqh2YbP/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815F13C918
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351827; cv=none; b=kVw+oCY5v3IXRRnyep/Y7CJgQ5H1H8hxkj2HdFeeIWc0x5SbEdziauXDdLEsV0SML+MYK5AEqZhQfCao88DjFXhrS83TeSvENEjaiMG/6Qpgcl/DesyajaeMuCUDujV5ZeWI13J21lL1GIrGiWoUbKv8B8hfpqj0xSmzUzoibQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351827; c=relaxed/simple;
	bh=y3Y5b5T3ucYBmYHJsu8k/jufOOAWZDfLN7T4pSfgUJQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MDi+GIb/CTIGf9C6g4oC/HtovSEZtaFnyX8OJfIOWIdbQSzXjSBJyuDxEKQipZm7BS0+S6b4oe+eHOiF7XsKTaQVUt4sdEdRTio8/sVFEg/dtYMahIc2U662DJ/rTVrBmskwHrB8RA9NJxD9JFZ0MITfccDkHkvd81OFjK9RlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqh2YbP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9FCC4AF0A
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351827;
	bh=y3Y5b5T3ucYBmYHJsu8k/jufOOAWZDfLN7T4pSfgUJQ=;
	h=From:To:Subject:Date:From;
	b=Kqh2YbP/Ij+zrN7Obu5IvrXhmjdRAaXcp6Bv+sdg7v2tUVfu7laRchM+QfMfajnbA
	 3hcwoS+0+OScFrMdQqCP5KtY83HTBoOU56Y2U67bQf5hBAu6iDCBCqgNvRDaZn90n4
	 nIZIf5XK5kKIa7ABzpUEnXGPtnTnbISU4uvPUNMnxGgPw2GgFcEr0uKuVd8xTeS9L8
	 SFL31SIEJ+a8U3VWcyRNOLZytu1/ASGCiHmhBZCQEkAEpErNY/D7yvDctf1q/9rkZI
	 hOrSft3+HJSZ/6IJl092ksg5IgaU7SVsCyFAmgqGEcRKQEFicAO6iPTj+QMYsb0zbl
	 /tVTRhOSslyIg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: cleanups and improvements around extent map release
Date: Wed, 17 Apr 2024 12:03:30 +0100
Message-Id: <cover.1713302470.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These make the folio release path release extent maps more often when they
are not needed, as well as some cleanups. More details in the change logs.

Filipe Manana (5):
  btrfs: rename some variables at try_release_extent_mapping()
  btrfs: use btrfs_get_fs_generation() at try_release_extent_mapping()
  btrfs: remove i_size restriction at try_release_extent_mapping()
  btrfs: be better releasing extent maps at try_release_extent_mapping()
  btrfs: make try_release_extent_mapping() return a bool

 fs/btrfs/extent_io.c | 149 +++++++++++++++++++++----------------------
 fs/btrfs/extent_io.h |   2 +-
 fs/btrfs/inode.c     |   7 +-
 3 files changed, 77 insertions(+), 81 deletions(-)

-- 
2.43.0



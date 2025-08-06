Return-Path: <linux-btrfs+bounces-15892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD3B1C4A3
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D768560C21
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35228AB11;
	Wed,  6 Aug 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDGdin7J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DD21ABBB
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478697; cv=none; b=scA0S4mnCRg8KkhiT51NTcxNpewrN+2Nj3T7IxCiE1yLnq0FctwozfNdGiB0vEEqDZIfkqVCVJrPT/EhwitcHOQVx3eSHTv6O0GOInTXd9VkaOOladY6dt8Vp/u7s3zRhCz9bjYyeTIvGRVd7GY23nv5w3deLLa681+IDmX7Hpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478697; c=relaxed/simple;
	bh=Jq03UDugzQ1/d2sj9gOK0ruzEFUMoGlpGOA4D+owxQo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bBdkqVQ+gckpAPTEfMICTrw+TsDa3YScT9LKVEefA3QS1dafWnsya5NaVFe/siBaMESU+iGnCl14U8I22US3HbJTWwr74pTtr6ibURTTDeRAD17hH4PiiCNin60k7Z+bw0xqoCkFD9hACkNtwR3KZGvUc4Kzg5AVoG6kioitxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDGdin7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA01C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754478697;
	bh=Jq03UDugzQ1/d2sj9gOK0ruzEFUMoGlpGOA4D+owxQo=;
	h=From:To:Subject:Date:From;
	b=FDGdin7JgkpFZcVTh2ycObK/pWM3sLK0cnIP1mOg7rkIQN5U/TUAmyR8/yQNafUoC
	 IVyZ3Eojv2v8K8vDhlg7Rmg2jiY4OOC8gRVaX21a+IdQq8/Zbp5pLA516h+h4Y56re
	 c6LF038VewAE10YCucGZcSesth5KdN5gfGnBOZpCNbbuO7eL3tXzkEH+f4UbEsa5xr
	 d6idupNdZFkI2yf/6y3y0rHHfACPYHuDu0AQkCdeODJnBcdiDd+BSgYE5Oj/w9R+MF
	 CWg5QU3Fr5jyzEPM237JYWFsxR6tQRcz/p+775zmmALteLM0munl4BPP0BPyUoHVSg
	 ABjyIuvsY5P1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fixes for races when checking if an inode was logged before
Date: Wed,  6 Aug 2025 12:11:29 +0100
Message-ID: <cover.1754432805.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The first patch is actually a new version of a patch sent out before [1],
because holding the inode's log_mutex at inode_logged() can make lockdep
unhappy in situations like when logging conflicting inodes, where we are
already holding the log_mutex of some other inode and could potentially
result in a ABBA deadlock.

The second patch splits part of what the initial version of patch 1 fixed,
but with a different solution that makes the management of an inode's
last_dir_index_offset field simpler.

Patch 3 is completely new.

Details in the change logs.

[1] - https://lore.kernel.org/linux-btrfs/7585d15c0e9c163d5cdf32307014a4e792e62541.1753807163.git.fdmanana@suse.com/

Filipe Manana (3):
  btrfs: fix race between logging inode and checking if it was logged before
  btrfs: fix race between setting last_dir_index_offset and inode logging
  btrfs: avoid load/store tearing races when checking if an inode was logged

 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/tree-log.c    | 78 ++++++++++++++++++++++++++++--------------
 3 files changed, 55 insertions(+), 26 deletions(-)

-- 
2.47.2



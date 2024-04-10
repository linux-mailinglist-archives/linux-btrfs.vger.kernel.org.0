Return-Path: <linux-btrfs+bounces-4098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE589F0D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B41528BCE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82AE15DBDD;
	Wed, 10 Apr 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi/PR0N8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061EB15AABA
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748528; cv=none; b=iyPW0Ix/x6xZo4dI8KJDfjGeJbkYlhDCA7zamCD1y7DClA+GBwCbF3dDTmqvIbmTS76kIKtqcol/dcGqm2sTJu9Ba8o80DAAMu4MQrJAMyF03ihTXAArXCIuPOk3iCm7VHJ+cx57ZQz08eW50Us97DnTgx724tCXcapVdhAEQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748528; c=relaxed/simple;
	bh=GFRPvGOrRT8ovHTL2ScyB/Xd3JdPSHFbRXkRJ7ZWSmg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Kz3fyoeCdxYJQsBfReJOaNa3tzg7+/TqD7kx65WJSkiWnazXIFv0q+Wt577mtCTPWnp2mSSp7kCVM46f1XK5o/5YAu/Xy87Tf30iyMnnYT9Ql/Scz1rDCxvwyuuQISjMn6XJmbCDWgW/nLi2cz48fXdcPSDobbr1yfHNOsoVbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi/PR0N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57127C433F1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748527;
	bh=GFRPvGOrRT8ovHTL2ScyB/Xd3JdPSHFbRXkRJ7ZWSmg=;
	h=From:To:Subject:Date:From;
	b=Bi/PR0N8roqUT33+1xRdsM6NN/GEwGCc20pIFV95B7TGPUz2btabmg+IXW5x+uj1+
	 pGWSjn7tCp37d1er/+qFQjkCVkvrmascaFPunVVdKUMEUn6LbDAqJJGJ1YioqJxY5h
	 x0gz6GZWm/Y9KzeO+/Zw9k8VUkhJkI9QNjlTjUtv9T+LUMNbzCwS2sHRFWnJwpnjk6
	 LchRO0IdXQ8MissMdKqUSafv6K2wFvvRGYXbK738X4dAcNWUZDVHSWxj31KZJfK7Tf
	 ExDEmNMa1z2vJId90vnwPVVVeRcnVZjY81ziOjdmzhymrU9mbg4sRGlkhF98PGlCxS
	 4axbwIdLvlqMg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] btrfs: add a shrinker for extent maps
Date: Wed, 10 Apr 2024 12:28:32 +0100
Message-Id: <cover.1712748143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we don't limit the amount of extent maps we can have for inodes
from a subvolume tree, which can result in excessive use of memory and in
some cases in running into OOM situations. This was reported some time ago
by a user and it's specially easier to trigger with direct IO.

The shrinker itself is patch 9/11, what comes before is simple preparatory
work and the rest just trace events. More details in the change logs.

Filipe Manana (11):
  btrfs: pass an inode to btrfs_add_extent_mapping()
  btrfs: tests: error out on unexpected extent map reference count
  btrfs: simplify add_extent_mapping() by removing pointless label
  btrfs: pass the extent map tree's inode to add_extent_mapping()
  btrfs: pass the extent map tree's inode to clear_em_logging()
  btrfs: pass the extent map tree's inode to remove_extent_mapping()
  btrfs: pass the extent map tree's inode to replace_extent_mapping()
  btrfs: add a global per cpu counter to track number of used extent maps
  btrfs: add a shrinker for extent maps
  btrfs: update comment for btrfs_set_inode_full_sync() about locking
  btrfs: add tracepoints for extent map shrinker events

 fs/btrfs/btrfs_inode.h            |   8 +-
 fs/btrfs/disk-io.c                |   5 +
 fs/btrfs/extent_io.c              |   2 +-
 fs/btrfs/extent_map.c             | 340 +++++++++++++++++++++++++-----
 fs/btrfs/extent_map.h             |   9 +-
 fs/btrfs/fs.h                     |   4 +
 fs/btrfs/inode.c                  |   2 +-
 fs/btrfs/tests/extent-map-tests.c | 216 ++++++++++---------
 fs/btrfs/tree-log.c               |   4 +-
 include/trace/events/btrfs.h      |  92 ++++++++
 10 files changed, 524 insertions(+), 158 deletions(-)

-- 
2.43.0



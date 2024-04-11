Return-Path: <linux-btrfs+bounces-4143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68958A1C58
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B221C227D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD016F26E;
	Thu, 11 Apr 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kngkLmh+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4717A93E
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852356; cv=none; b=JYq1Ua68sY2dr+MxPBxOS9E+cbQdwk8Klsd93KH4C8aDzlW/Q2Y2nAOq83b2kKYDIwdpI86L/V12+ajwT1A1fxJvDthwgx+by9MnjWI+OaDs7pO3XQAUqBxfw8gyCF0FMnX+XrKBn5pH5KlZ/n4J0r6zZ8V4JxKz+eofNcSxFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852356; c=relaxed/simple;
	bh=uZ+hsoz/TGihi64+feSoU/J6J2d8LXqX451llsdR3Gk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ns4zEgiu5HgE5A5Zy7ILa8iA6Hvdg99IdgUaa+OSfwJ1ZTB7txQ3qpASyUgoWru+jY0YBrc7n2BeLs1SZzd9Wvpa7rGoMI6PzrnDRFgghBr3BefLlqnjrWWAn7Ywt10E1pxn+uFix1/+9EIJDq+o+k0nCEaAGbWKRjJEun7w1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kngkLmh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB1FC072AA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852355;
	bh=uZ+hsoz/TGihi64+feSoU/J6J2d8LXqX451llsdR3Gk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kngkLmh+6aDsDLLH0Ia+cVf/H13EJUNQMijgolOdx3881lPeP7nRiuStD8NtJuO/9
	 8nJlYCa6HEP8cAVckItKJ/LHcKbt49lfZbUWB/IR449GHjIp4t77dMdqfogSaFohh2
	 vKmXCitgVms664pO0z22cAcQfJZpIGTsV4g8VeJPfhs11NwTvdYkmS7TzTEd9duzjC
	 NlB1GAjR8mPdE19l8afwoYlAjQx9rAK58MWG2o08CR5/GHntozTIhDUsjiAOXqnodb
	 AXnNn+8GK8OifEdtPIajceMHquY3l3Y19so+VLoVfP4uEHlp9NkV1dwIej9Da+CqLx
	 W9ZFRhiwK8yAQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/15] btrfs: add a shrinker for extent maps
Date: Thu, 11 Apr 2024 17:18:54 +0100
Message-Id: <cover.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
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

The shrinker itself is patch 13/15, what comes before is simple preparatory
work and the rest just trace events. More details in the change logs.

V2: Split patch 09/11 into 3.
    Added two patches to export and use helper to find inode in a root.
    Updated patch 13/15 to use the helper for finding next inode and
    removed the #ifdef for 32 bits case which is irrelevant as on 32 bits
    systems we can't ever have more than ULONG_MAX extent maps allocated.

Filipe Manana (15):
  btrfs: pass an inode to btrfs_add_extent_mapping()
  btrfs: tests: error out on unexpected extent map reference count
  btrfs: simplify add_extent_mapping() by removing pointless label
  btrfs: pass the extent map tree's inode to add_extent_mapping()
  btrfs: pass the extent map tree's inode to clear_em_logging()
  btrfs: pass the extent map tree's inode to remove_extent_mapping()
  btrfs: pass the extent map tree's inode to replace_extent_mapping()
  btrfs: pass the extent map tree's inode to setup_extent_mapping()
  btrfs: pass the extent map tree's inode to try_merge_map()
  btrfs: add a global per cpu counter to track number of used extent maps
  btrfs: export find_next_inode() as btrfs_find_first_inode()
  btrfs: use btrfs_find_first_inode() at btrfs_prune_dentries()
  btrfs: add a shrinker for extent maps
  btrfs: update comment for btrfs_set_inode_full_sync() about locking
  btrfs: add tracepoints for extent map shrinker events

 fs/btrfs/btrfs_inode.h            |   9 +-
 fs/btrfs/disk-io.c                |   5 +
 fs/btrfs/extent_io.c              |   2 +-
 fs/btrfs/extent_map.c             | 297 ++++++++++++++++++++++++------
 fs/btrfs/extent_map.h             |   9 +-
 fs/btrfs/fs.h                     |   4 +
 fs/btrfs/inode.c                  | 126 +++++++------
 fs/btrfs/relocation.c             | 105 +++--------
 fs/btrfs/tests/extent-map-tests.c | 216 ++++++++++++----------
 fs/btrfs/tree-log.c               |   4 +-
 include/trace/events/btrfs.h      |  92 +++++++++
 11 files changed, 579 insertions(+), 290 deletions(-)

-- 
2.43.0



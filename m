Return-Path: <linux-btrfs+bounces-8192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A39843F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3934B22E89
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 10:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3B1A2C2B;
	Tue, 24 Sep 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9lcqybb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834621A2C1F
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174749; cv=none; b=lG5Lo0Roqz+vdxVX7BULP/OfhiV+KiMkKUQRWI7FCeEGaqDjAhxJYpMiH1JsyIWai+gMA62y5aH8q33tr7KqkYMgV7yChCKIwiQ7mJezk2qy7WB1CEId0qS9++12BxoM844Fr5arG1nGNW3BcMcLoijZCZOlUNnKciXyN6AkrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174749; c=relaxed/simple;
	bh=PGl+COYxw+nFwncABtIIB18dyBdMInCoqvIFmv7jqZI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fbu+uqXevCadHo8IhHRb9nJA3X5fGScXgOkWD5v2Jv8qhOTSvI9Wum5b1girpD1yHLgj1ruMULpnJIyj1HeqxI0wyCfNK8vyjfmXx9yurApXxId1rlVVAau51To0YHFpplz45AJ/Z1JhaeGhJeLy4xZS+4k/OhSOjG0rddyQouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9lcqybb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ED0C4CEC4
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727174749;
	bh=PGl+COYxw+nFwncABtIIB18dyBdMInCoqvIFmv7jqZI=;
	h=From:To:Subject:Date:From;
	b=W9lcqybbrJmMi3hHoGSwm6zYoafdFsAai8HJ3a3vqvvZ/mfJ6UB9ardAZwOQFx0BL
	 G++GRu7g8wM95v9ZSatZCEABE7sxVcMLSVNx/a4fGwvPMdZQpKyhwZYv2iOTLJylEb
	 EV5IzIVaA89UI03/1Q6Qf1e+9R1wyd+VRY7cW9QYY6IZsGMoU4xSpaHVkI6CLRw8KN
	 BHpdfj0WRSLeJvIT5KVTBceo4cdcclwhnEKDu+GfNNKasK8Jn6vNApVEtcmjIyCL0e
	 sawaNsOEjz+7n6fs/d96wOHNIqfHLmuuRStBSi+xunWr1CE0rJ6awVHFcw4lMElxqK
	 i9bubnaQAGc7Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: make extent map shrinker more efficient and re-enable it
Date: Tue, 24 Sep 2024 11:45:40 +0100
Message-Id: <cover.1727174151.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This makes the extent map shrinker run by a single task and asynchronously
in a work queue, re-enables it by default and some cleanups. More details
in the changelogs of each patch.

Filipe Manana (5):
  btrfs: add and use helper to remove extent map from its inode's tree
  btrfs: make the extent map shrinker run asynchronously as a work queue job
  btrfs: simplify tracking progress for the extent map shrinker
  btrfs: rename extent map shrinker members from struct btrfs_fs_info
  btrfs: re-enable the extent map shrinker

 fs/btrfs/disk-io.c           |   4 +-
 fs/btrfs/extent_map.c        | 122 +++++++++++++++++------------------
 fs/btrfs/extent_map.h        |   3 +-
 fs/btrfs/fs.h                |   7 +-
 fs/btrfs/super.c             |  21 ++----
 include/trace/events/btrfs.h |  21 +++---
 6 files changed, 83 insertions(+), 95 deletions(-)

-- 
2.43.0



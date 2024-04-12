Return-Path: <linux-btrfs+bounces-4190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851568A31C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F1D1F22A1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746A11482F0;
	Fri, 12 Apr 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqIB9/nT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99716147C9C
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934205; cv=none; b=mrjMZ8uKC6eQvdsr7DjR2F0NmEneOJzuCYLeHWd4RSNU0HnkJn8tEb+FAwLePbME8lY/wREBXc+nv6hobVrJ3W6CBu5D8x2RhX0Qc9yn9//A2Qpedz3/vcqOvumCoMs9njf75GLf4znGTI857HZCj2ytO/X3ZJZ3EOLmwe173SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934205; c=relaxed/simple;
	bh=8JMwHMtzPsadXtsGK9RJ5s3QR2Cn+s9nyeGwIxiuXtE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZeJWaG9zKzps4t12PiV9cveroLnR6F75T5wImssh3boqercDBPibnJXotsX+kJaZUg5wOkLc6luyDZUv27zX2lHurngh0JktAVCBmGF3uHpM+axbsUVb8USozhI/PACNvsMVyXIiRBtgxjKw/vGgDFpGiXVYFwApcgTkM8c7IEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqIB9/nT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA06C3277B
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934205;
	bh=8JMwHMtzPsadXtsGK9RJ5s3QR2Cn+s9nyeGwIxiuXtE=;
	h=From:To:Subject:Date:From;
	b=lqIB9/nTkvOYUJyARoBUU9BYLquwwDAkRSKp8i8/s6KSaufLhUW7I9QsSInshSYG9
	 ODrU14L09LlQ77DN/EhcsFnql/42lpPzK5kn/SgfT8+m2S03aArmwFZPxQE/qUT3re
	 J3/o9CsV36vuf+UyB8KyVC1wiqebIaPsbdahPNwB1kNrq7OU9FQVxco4mbvrm3uQGc
	 WqLbARzDbJrJG14TGs1d3el6+vvzOerG9LSscfobwqw5thici5yNFbN1aUXc/x5imd
	 AH1lfGKyCuFLWkBpJuCWBt2DFDKS908bpd+++1HGM6DTB0W3QWiR235OYbcMIDyj34
	 GDeHd77Qj++TQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: some speedup for NOCOW write path and cleanups
Date: Fri, 12 Apr 2024 16:03:14 +0100
Message-Id: <cover.1712933003.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These are some cleanups in the NOCOW write path and making the check for
the existence of checksums in a range more efficient. More details in the
changelogs.

Filipe Manana (6):
  btrfs: add function comment to btrfs_lookup_csums_list()
  btrfs: remove search_commit parameter from btrfs_lookup_csums_list()
  btrfs: remove use of a temporary list at btrfs_lookup_csums_list()
  btrfs: simplify error path for btrfs_lookup_csums_list()
  btrfs: make NOCOW checks for existence of checksums in a range more efficient
  btrfs: open code csum_exist_in_range()

 fs/btrfs/file-item.c  | 57 +++++++++++++++++++++++++++----------------
 fs/btrfs/file-item.h  |  3 +--
 fs/btrfs/inode.c      | 33 ++++++-------------------
 fs/btrfs/relocation.c |  4 +--
 fs/btrfs/tree-log.c   | 15 +++++++-----
 5 files changed, 55 insertions(+), 57 deletions(-)

-- 
2.43.0



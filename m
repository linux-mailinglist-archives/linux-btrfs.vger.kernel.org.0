Return-Path: <linux-btrfs+bounces-6286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4FE92A4EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 16:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BF31F220F1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77A13D8BC;
	Mon,  8 Jul 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfcTUBtd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89F51C06
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449768; cv=none; b=UZb3OpgRqm2lpAmv1OtEc7ruxg0hkqmsEgfFnQzrGrMa/cCCvIhkJx7yZNgud519dyJzS5fIfBEOMx2qSoDlSFvqtLeck4aoO1uHbZRKoD2tUiSXlv/v8OtdqO4q+C9c6RjR02Gr13NoYdteDjMk4boD8ft62N6c9KGiI8vUUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449768; c=relaxed/simple;
	bh=GXb9GYxVpyVIOQFz26P64oKtzTJwCtWqLPPSkFs7Rcc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=V/mK5tBimpiqtxvBFfloTiRl3wHYPt7pOP8BmAouRJY23Tf143o40+1J8BwTzHFZCL52VOkOmaAEVzTcFILJepeRwjkstylwS6A72C768GXPWfB3jWzs8RyjnZBPuHSSHn8uowcI3Jbyv/mS4EofM0bgAkw2xvFkjc/yaE74SN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfcTUBtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4315EC32786
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720449768;
	bh=GXb9GYxVpyVIOQFz26P64oKtzTJwCtWqLPPSkFs7Rcc=;
	h=From:To:Subject:Date:From;
	b=IfcTUBtdja9QCBXlEJP5jA2leltmJEbAPfoNSGsFOZbmkHzSkdwwUC2n50hjHIhIX
	 SH0275qYVghyipaHNjV2xTKIlz7VMEpx/5Z6P4eIAMTHyfrC1Ou5M5pcRx8CEigxZO
	 luZHXCDhDFFHJH8aJidW2O+A+gET/2b/gw/3t6GdOR6B962aahzN7exQNwkXhfF+G5
	 EJNtzUUFhVwoOAhmd6OYIuUZgmiCFJI9MfymAZQDtd7niSZhtHIWvpPgdCVyH1mLp/
	 uDlJQexxDpINCG9+1nlQ8/bP6DV583EYbXpK26Im/TobFiCc9n2ofnIR4UnFgfnc+z
	 OX2wDQGKTsYgQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6.10 0/3] btrfs: some fixes/updates for the extent map shrinker
Date: Mon,  8 Jul 2024 15:42:42 +0100
Message-Id: <cover.1720448663.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A few fixes for the extent map shrinker that fix some reports from users
where their desktops became very unresponsive.

Several notes here:

1) The first patch was already sent before to the list and it's in
   for-next already. It's unrelated to the reports from those users but
   it's related to a report from syzbot for a deadlock in case the
   shrinker does an iput on an inode with 0 links that needs to be
   deleted, and when the inode still has links but it's dirty, it can
   make the iput wait for writeback to complete, slowing down the
   shrinker. I've included it here just to group things in a logical
   way;

2) These patches apply to 6.10-rc;

3) At least the first 2 patches should go to 6.10 final IMO;

4) In case they land in 6.10-rc, then for-next needs to be rebased since
   there are minor and trivial conflicts to solve due to the last patch in
   for-next that reduces the size of struct btrfs_inode down to 1024 bytes.

   Also the following patch which landed on for-next should be dropped
   because it's made obsolete by the second patch in this patchset:

   https://lore.kernel.org/linux-btrfs/cb12212b9c599817507f3978c9102767267625b2.1719825714.git.fdmanana@suse.com/

5) There will be further improvements to the shrinker, namely to
   reduce the latency of finding open inodes in a root, but those
   will come later and may be too much for 6.10 final. It would also
   require different patch versions for 6.10 and 6.11 (for-next) since
   in the former we use a rbtree while in the later we have a xarray
   now.

Thanks.

Filipe Manana (3):
  btrfs: use delayed iput during extent map shrinking
  btrfs: stop extent map shrinker if reschedule is needed
  btrfs: avoid races when tracking progress for extent map shrinking

 fs/btrfs/disk-io.c           |   2 +
 fs/btrfs/extent_map.c        | 123 ++++++++++++++++++++++++++---------
 fs/btrfs/fs.h                |   1 +
 include/trace/events/btrfs.h |  18 ++---
 4 files changed, 107 insertions(+), 37 deletions(-)

-- 
2.43.0



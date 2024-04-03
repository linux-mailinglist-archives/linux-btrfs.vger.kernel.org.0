Return-Path: <linux-btrfs+bounces-3872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47311896EA5
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786DA1C25BA9
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A6145B3F;
	Wed,  3 Apr 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApShwrAY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854F1386A8
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145952; cv=none; b=NpG2Ey29xMpvNLA8Mnjeyob687YeDp9+S4ZwWP0D1h896D0Ud43/OrOH+nlEdSb28Ybt77yIvUafi0zymCQ0LFTge73+tunbK3AGQPWkmoIcSFXLBaULkwO2KqrokQAFvzTmyj+QaFZUoUs6JYjxre2a8MH9ZfUdh7chtL3ebVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145952; c=relaxed/simple;
	bh=DEY44Jmn+oFmodhn3Mdbo25EFre7KwxxKONGRSVRIKE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=S1mEW9OOymHGeBoGARUZZ5UQGZIs5CacnWRb+eMbdPLJCbZTsTQ3j1ll/FSDS2zNxoaob5Z+PJnbf+ML2ylvNpZ4R2Dfbu+hlhqngM0j7TGCtoOyBdADTTYnRdcRs3HoWKCeiZFb2in+cIQTh2AqfsSFJ9nfVNgOnmOc/ZGYzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApShwrAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3CBC43390
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712145952;
	bh=DEY44Jmn+oFmodhn3Mdbo25EFre7KwxxKONGRSVRIKE=;
	h=From:To:Subject:Date:From;
	b=ApShwrAYFAluKVuXLB/WyNlMyUG3zO2F3SyyXQhVq5Qd3UC7CiBMZw9MuFpWSnePR
	 Ian/1efwgvQ+vOXUpo6NWAFhTXQFcBOm0xyEKZSayksmJYwHMeV1lliny29Z4qgpvI
	 qQsecq9MgShHA23Lnkfr2pfsMtOahHeJhMQ+tfAXpDI4j1VH8FBBCgeIbGq23d9pWt
	 pBuUXz5EBcL+BPRHnex2kGb0tAXaW3cfXNOx32hRIR+54wqcRWZUEthsxykH22pP4x
	 ZsCWqmvgiFALeQfN/9RTO3ug+V2boX5Jq0xvvclVB6FcmpHzmeQolBkHPLNWkSFU8v
	 p/jFs2RROA8gg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: remove some unused and pointless code
Date: Wed,  3 Apr 2024 13:05:45 +0100
Message-Id: <cover.1712145320.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Details in the change logs. Trivial changes.

Filipe Manana (3):
  btrfs: remove pointless return value assignment at btrfs_finish_one_ordered()
  btrfs: remove list emptyness check at warn_about_uncommitted_trans()
  btrfs: remove no longer used btrfs_clone_chunk_map()

 fs/btrfs/disk-io.c |  3 ---
 fs/btrfs/inode.c   |  1 -
 fs/btrfs/volumes.c | 15 ---------------
 fs/btrfs/volumes.h |  1 -
 4 files changed, 20 deletions(-)

-- 
2.43.0



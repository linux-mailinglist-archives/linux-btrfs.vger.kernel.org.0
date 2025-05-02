Return-Path: <linux-btrfs+bounces-13611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB80FAA6FA2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77034A8167
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36923C4F4;
	Fri,  2 May 2025 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB0iPQf/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2814AD2D
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181832; cv=none; b=sZtK7fbCtWbdI3ZxGFN+0MRK6ZR9Y58LSSZHZRzDJ7yRJMSI/xBV2NiO8KDXKqSnfxB0ioz6lxV/cr9ZKb37Sh87emA6dCLaFg6x5p05asfUqqLxizzKutwVny2Er2UB+XfGeqwsCENf3h0nhRadJ0WD5c/7154OpHd+LdhpBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181832; c=relaxed/simple;
	bh=SQLoMO+Q1pLTyMb74pTS9y85lps4zf2KYxSrr3eIDS0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=uLonghljSw/LEpTzNH/4hZFBkI4xDQ/o7GrJql1aQc1CPMb9Etu+rXfMsjEdWh63s6Y4siyqmz00F59Q6Rb1TUOe2iKIZBX4lhJ8X5IAwlLTs4QrpDmTWJX/SESzsrZ27HW2/4mcQBQRNtNPE+V5X4IjLma6TnZH7jmBGlsbqsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB0iPQf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EE1C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746181832;
	bh=SQLoMO+Q1pLTyMb74pTS9y85lps4zf2KYxSrr3eIDS0=;
	h=From:To:Subject:Date:From;
	b=HB0iPQf/iLlVTXFPGn4dNEH2g9kH/SkVp/DLSjOWipcRIhxTb2eKbCllO0+9SEFGM
	 Z2TSS0Ixcv//oKffoQZ22nCVKx/kuqq5QcgbrxmGMV0bql91REWPi3M2MnK3uw3zHN
	 ATkkkC3o4HMZ8855XMGSvdvIi8Hcy5L9Y/J3DxjH0lMrX59O9ET2xbEN0BIJo1zNDA
	 l9tCZAgUZNjU3/h5S5iRvp3/gGeMHfeiybfjTSeWp3DxRvliFak3h+4U49Dz+Gp6yP
	 Uff5uIiefuYiDRvCSrBQf/kcKVFRWcRofbqyKJRlxbZ67cyKknIZ88JRRDuOf1f4Mm
	 zQUHN0L02K5eA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: some list extraction and disposal cleanups
Date: Fri,  2 May 2025 11:30:20 +0100
Message-Id: <cover.1746181528.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Simplify some list element extractions and list disposals. More details in
the changelogs.

Filipe Manana (8):
  btrfs: simplify getting and extracting previous transaction during commit
  btrfs: simplify getting and extracting previous transaction at clean_pinned_extents()
  btrfs: simplify cow only root list extraction during transaction commit
  btrfs: raid56: use list_last_entry() at cache_rbio()
  btrfs: simplify extracting delayed node at btrfs_first_delayed_node()
  btrfs: simplify extracting delayed node at btrfs_first_prepared_delayed_node()
  btrfs: simplify csum list release at btrfs_put_ordered_extent()
  btrfs: defrag: use list_last_entry() at defrag_collect_targets()

 fs/btrfs/block-group.c   |  5 ++---
 fs/btrfs/defrag.c        |  8 ++++----
 fs/btrfs/delayed-inode.c | 31 ++++++++++++-------------------
 fs/btrfs/ordered-data.c  | 12 ++++--------
 fs/btrfs/raid56.c        |  6 +++---
 fs/btrfs/transaction.c   | 16 +++++++---------
 6 files changed, 32 insertions(+), 46 deletions(-)

-- 
2.47.2



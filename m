Return-Path: <linux-btrfs+bounces-13798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199D2AAE7BF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FC67BE7D1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4028C851;
	Wed,  7 May 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOGcz4ut"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378D28C5BF
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638602; cv=none; b=tF90lQoHPSUrIfhyV4jk7Zmjzmi/Zpnj6S0f0qM0t+V1boblxgZF46UEtGeePqSKypkQl7lvZxgmr6lB/UMvF19n20df5GC1IbnWbTUMPx2446LvGjKOHk6c1g+3XM1err3XVu/XZzRX6qp5aL+Um45uf+OuAJ8Q1oZtSFMU5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638602; c=relaxed/simple;
	bh=jkRtKzIxDidVH5bKEk8YFnzJh6lgk69UGMdcQne46U0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BTRia4FOJa0hjOL5N0CJuUnAOUUMOPh115jJhrD0R2CrerlSf4iXR8W1mVEpN/cj4S0nlpBuBiNLCohUsMHtsnj6TFX0JR416rJyQH1EIMsS0CXia4eUZDndwLZwsQZ6fml+FNc/dmtz1n/JO4crtwZljiDvA1kVb1XQ7C+2SUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOGcz4ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9039C4CEE2
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746638601;
	bh=jkRtKzIxDidVH5bKEk8YFnzJh6lgk69UGMdcQne46U0=;
	h=From:To:Subject:Date:From;
	b=lOGcz4utcjCcH/3wTkUFr+sIK6SfUB9muPeOVQvLYZuGdyEBfpTYPDl1RSZyaG23U
	 /BGIN9m4n77me+I/ThUB4X8Q4V/ZkkOWg2wTyJZpEo8uLJl1DkjBm8BtY8a1MCKmCB
	 5aS080duRpPYH/1K0UNwehv97HllEfRviX8A6iqFrxhoxPy1T0GxGGTokeinxTQMMs
	 draqnCvpu9uSS0N3l+TsUDrUbL62Ds4pQBYCuYqvNdOHj/EBvN5IN5vws6ebATCu7+
	 jLmuPTjDpya8pNb48zLTpEUFTmZzylJpavPRC91VlIJDS1ZqFV+QmX/AsqV6KRXGp5
	 loeVZp/Ch2gYw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs: fixes and cleanups for ordered extent allocation
Date: Wed,  7 May 2025 18:23:12 +0100
Message-Id: <cover.1746638347.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some fixes and cleanups around ordered extent allocation. Details in the
change logs.

Filipe Manana (5):
  btrfs: fix qgroup reservation leak on failure to allocate ordered extent
  btrfs: check we grabbed inode reference when allocating an ordered extent
  btrfs: fold error checks when allocating ordered extent and update comments
  btrfs: use boolean for delalloc argument to btrfs_free_reserved_bytes()
  btrfs: use boolean for delalloc argument to btrfs_free_reserved_extent()

 fs/btrfs/block-group.c  | 10 ++++----
 fs/btrfs/block-group.h  |  2 +-
 fs/btrfs/direct-io.c    |  3 +--
 fs/btrfs/extent-tree.c  |  8 +++----
 fs/btrfs/extent-tree.h  |  2 +-
 fs/btrfs/inode.c        | 10 ++++----
 fs/btrfs/ordered-data.c | 51 ++++++++++++++++++++++++++---------------
 7 files changed, 50 insertions(+), 36 deletions(-)

-- 
2.47.2



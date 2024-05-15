Return-Path: <linux-btrfs+bounces-5025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DAE8C6C73
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FB21C2144E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50BF158DD6;
	Wed, 15 May 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQgw0L7S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFF158DD1
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799113; cv=none; b=EKhkh0svdKB7JaL+NamiUKiNiYPX2V1iSgIi775jnqmhlqUe9ysmsMHWyJ6mob9FQd55KIrsbT4tk2n7tDF3VEpZIq+EumxQENt7VW23yKfPrANqGBa9/f5mM98U7Il6TzcMsjrcuV9Q9GNjWtmMJiUYYbH8gEjz0DSeFWUjISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799113; c=relaxed/simple;
	bh=FOHywHTOhbLZgbIzDUZ8puWBeZRD39PG92VFjm4h8T0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqOWWnxzFuDZpRX/P2bOXQhpjuQ+bI99kzuWgFXVzCN01zCVWeO6NHmkepW5PtKiN/GqC2B1gZRLBKwPs+BJadUwLRgPiufIf3Cmh1pq5gORR0gdm9nDh+BWIUZIrX7IXYX7souX8vdJhcd7BmWtQKaXFawwuXsAA9EZCqXm7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQgw0L7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111AFC2BD11
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715799112;
	bh=FOHywHTOhbLZgbIzDUZ8puWBeZRD39PG92VFjm4h8T0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AQgw0L7S7aoGyNaC6YW3UVzHOUUBrn52xw6JNJinlaBwsc7GqhGbAFmnUeYoCD1Bb
	 PL3KbuFDCrhyF6KK10iOMK/0mSpzyvBL3unZekYPgyHhmjFoBTN+PTQ75iMRqpXayZ
	 AtnhqEA4nYkCbz77nKmGrGIICE9gyOBkFTHJD46hFwZu23f3K5T3ANAIRw1vlXeL1k
	 zGzepM6DSNb8CrjF0zcavBCCPXoMefdpwc0gVsuHDGM6A0yw++1VbKwdKY/doK9TGP
	 x8lztg8yKPa3PNanI/KKMJ+FZXk/2K1gmvUrhhGMElsRY1w2D2awMDJmG+/Vkz7iER
	 32SrsXDq+85Zg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fix a bug in the direct IO write path for COW writes
Date: Wed, 15 May 2024 19:51:45 +0100
Message-Id: <cover.1715798440.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715688057.git.fdmanana@suse.com>
References: <cover.1715688057.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a bug in an error path for direct IO writes in COW mode, which can make
a subsequent fsync log invalid extent items (pointing to unwritten data).
The second patch is just a cleanup. Details in the change logs.

V2: Rework solution since other error paths caused the same problem, make
    it more generic.
    Added more details to change log and comment about what's going on,
    and why reads aren't affected.

Filipe Manana (2):
  btrfs: immediately drop extent maps after failed COW write
  btrfs: make btrfs_finish_ordered_extent() return void

 fs/btrfs/ordered-data.c | 30 ++++++++++++++++++++++++++++--
 fs/btrfs/ordered-data.h |  2 +-
 2 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.43.0



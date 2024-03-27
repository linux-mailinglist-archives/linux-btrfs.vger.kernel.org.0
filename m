Return-Path: <linux-btrfs+bounces-3655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F20FE88EC2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968F71F25446
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFA14D701;
	Wed, 27 Mar 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMz5SbBw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB72412F583;
	Wed, 27 Mar 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559514; cv=none; b=n5RuaJJOEYbG6XHitZ8Nc+xAiVUwEoFn99ROzEvy3evc0cfHxMxx1oNmzsyS2+SMXr5BIfbP6dkabWXIVEASJd1A+pxKZtx1HYylmQXBhUTzyh3mM5GuUiPpkfnJMrfl0jK2qyMPA8lHFVNpnEHYNRYVwwl9jU8qTBytKhbbPLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559514; c=relaxed/simple;
	bh=bwlRyWsDgXzAgSTyO2AomIDtKj1wB/EFyth8YNriTOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k06YC4//Wte5ZZeNoOdNUTKME7rNc1UZUwWHnLmJmv3WFRTFrgFHPcwbVDz4CK4kkVJazr1evz+mXoYUPu1y1/r+5HulX5Y36yaZuBrieoq3iMi3jHLljGiiFXrqsJlH2IAWF2nR2NPBDSkN1V3fjXSmA0O5es7WrleWjkvXDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMz5SbBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DD0C433C7;
	Wed, 27 Mar 2024 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559513;
	bh=bwlRyWsDgXzAgSTyO2AomIDtKj1wB/EFyth8YNriTOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fMz5SbBwD87kgSUWbgZbNqeHwu1EnYdK4AUxyccENYunXj5hhoYHgtBeUjBYwB/bV
	 ZW4o9DUxPl8U6vblJo9qHmDQfXWRcONZ+efxzdaczDF0HHgMFvrI0zMPBVK8qkW1U1
	 p9hZptyAHeItKuFIL8O5dMxAHUqeM8Jxt5ZAZaVxe1UoutmmK0GVZEtsVgtYFyp0rv
	 2SGUHawtWV+8Oooue1FBXn/0HVk+yQrcfh0k6vBAIh9TGvVl4Z4DK6rzPeHWO88CJF
	 rktJNs0KrAJ0yTECziahpEK6tQbXfG6/v/WSuG5qE5T6xE4S0C5HN9P/5zOMuw1fy8
	 kwud2ST4S4njw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 00/10] fstests/btrfs: fixes for tests btrfs/06[0-9] and btrfs/07[0-4]
Date: Wed, 27 Mar 2024 17:11:34 +0000
Message-ID: <cover.1711558345.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Killing any of the tests cases btrfs/06[0-9] and btrfs/07[0-4] often leaves
some background processes running around that prevent unmounting the
scratch filesystems or running fstests again. When that happens it requires
manually finding which processes are still using the scratch filesystem
and then kill them. These patches address that issue. Details in the change
logs.

Filipe Manana (10):
  btrfs: add helper to kill background process running _btrfs_stress_balance
  btrfs/028: use the helper _btrfs_kill_stress_balance_pid
  btrfs/028: removed redundant sync and scratch filesystem unmount
  btrfs: add helper to kill background process running _btrfs_stress_scrub
  btrfs: add helper to kill background process running _btrfs_stress_defrag
  btrfs: add helper to kill background process running _btrfs_stress_remount_compress
  btrfs: add helper to kill background process running _btrfs_stress_replace
  btrfs: add helper to stop background process running _btrfs_stress_subvolume
  btrfs: remove stop file early at _btrfs_stress_subvolume
  btrfs/06[0-9]..07[0-4]: kill all background tasks when test is killed/interrupted

 common/btrfs    | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/028 | 16 +++-------
 tests/btrfs/060 | 33 +++++++++++++------
 tests/btrfs/061 | 30 ++++++++++++------
 tests/btrfs/062 | 30 ++++++++++++------
 tests/btrfs/063 | 30 ++++++++++++------
 tests/btrfs/064 | 30 ++++++++++++------
 tests/btrfs/065 | 33 +++++++++++++------
 tests/btrfs/066 | 33 +++++++++++++------
 tests/btrfs/067 | 33 +++++++++++++------
 tests/btrfs/068 | 33 +++++++++++++------
 tests/btrfs/069 | 31 ++++++++++++------
 tests/btrfs/070 | 31 ++++++++++++------
 tests/btrfs/071 | 31 ++++++++++++------
 tests/btrfs/072 | 31 ++++++++++++------
 tests/btrfs/073 | 30 ++++++++++++------
 tests/btrfs/074 | 30 ++++++++++++------
 tests/btrfs/255 |  8 ++---
 18 files changed, 417 insertions(+), 160 deletions(-)

-- 
2.43.0



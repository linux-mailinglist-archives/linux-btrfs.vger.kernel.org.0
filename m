Return-Path: <linux-btrfs+bounces-11635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9F6A3D7AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97935189C3A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC51DE2D8;
	Thu, 20 Feb 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBUlWoBd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F12862BD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049488; cv=none; b=eVUEcZZVWbtE1qorjgRYUNuflrusZxxK6n1P9Kw4gzcG0+MHrStCh3qZwKp4WvNeUb8bln3pfoRm8s5V6Daub80Jy2WgNRVg3R9vh4CRs9s91eG7+QLNfPDku2gnTeTWkmgrST7ou7JJ30DzC8RexMOnhEI6Qkcp7hh1D5or9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049488; c=relaxed/simple;
	bh=EbILuY7/MPyKeGDNSYltVgJNwQFrFc9FY37c7pThSLE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cY8Iez8bZCxu1gKjod9JCxiuAoISmmQ/S8MMW14S5Tu5oTXhktsKA6W+epq/ptFWWFy5A4Dy/3kgC+n84rAMOO1q4q+8/z7GfLQ5pGkJbpwDtYUpTKGkgW7xNmTnM36cV0Ey3wKX0Sg0w0fHVoxk4fpMV2VJmNxMMG/pvjif+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBUlWoBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063D1C4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049487;
	bh=EbILuY7/MPyKeGDNSYltVgJNwQFrFc9FY37c7pThSLE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gBUlWoBdyYQMyoNAW/du/cDnZwJtkgBH4uaOeiMUchCpf4VOFCkTyu3EkVydpM+sL
	 Y2aF5/OIwsQ+zgf9EFyf2xciBw75OzjXiq7Dd2MvJS72EkR7umI43u5NPCsLPyG1sR
	 9AL5nguzyudhMW8ZN+fEmT11RH6wOgSdTltuT9c+crzbE2cCcLD//vhwyrjmibetSV
	 yuoShZFEvGh23fyp1M2Uc6PIbj8WheA2HdF18BMf54+71dUMaoBtwPUKeMC024Lijm
	 xtBTd2HxDvM4KCWcNved6aD6yKL1hDxPbE89hMzfQ6U5ztSFlF9hvql9hwFODJUDQn
	 pto/hUZgw4QxA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/30] btrfs: avoid repeated path computations and allocations for send
Date: Thu, 20 Feb 2025 11:04:13 +0000
Message-Id: <cover.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This eleminates repeated path allocations and computations for send when
processing the current inode. The bulk of this is done in patches 28/30
and 29/30, while the remainder are cleanups and simplifications, some of
them to simplify the actual work related to avoiding the repeated path
allocations and computations.

A test, and its result, is described in the change log of patch 29/30.

V2: Add 4 missing patches (cleanups).

Filipe Manana (30):
  btrfs: send: remove duplicated logic from fs_path_reset()
  btrfs: send: make fs_path_len() inline and constify its argument
  btrfs: send: always use fs_path_len() to determine a path's length
  btrfs: send: simplify return logic from fs_path_prepare_for_add()
  btrfs: send: simplify return logic from fs_path_add()
  btrfs: send: implement fs_path_add_path() using fs_path_add()
  btrfs: send: simplify return logic from fs_path_add_from_extent_buffer()
  btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
  btrfs: send: simplify return logic from __get_cur_name_and_parent()
  btrfs: send: simplify return logic from is_inode_existent()
  btrfs: send: simplify return logic from get_cur_inode_state()
  btrfs: send: factor out common logic when sending xattrs
  btrfs: send: only use booleans variables at process_recorded_refs()
  btrfs: send: add and use helper to rename current inode when processing refs
  btrfs: send: simplify return logic from send_remove_xattr()
  btrfs: send: simplify return logic from record_new_ref_if_needed()
  btrfs: send: simplify return logic from record_deleted_ref_if_needed()
  btrfs: send: simplify return logic from record_new_ref()
  btrfs: send: simplify return logic from record_deleted_ref()
  btrfs: send: simplify return logic from record_changed_ref()
  btrfs: send: remove unnecessary return variable from process_new_xattr()
  btrfs: send: simplify return logic from process_changed_xattr()
  btrfs: send: simplify return logic from send_verity()
  btrfs: send: simplify return logic from send_rename()
  btrfs: send: simplify return logic from send_link()
  btrfs: send: simplify return logic from send_unlink()
  btrfs: send: simplify return logic from send_rmdir()
  btrfs: send: keep the current inode's path cached
  btrfs: send: avoid path allocation for the current inode when issuing commands
  btrfs: send: simplify return logic from send_set_xattr()

 fs/btrfs/send.c | 497 +++++++++++++++++++++++-------------------------
 1 file changed, 236 insertions(+), 261 deletions(-)

-- 
2.45.2



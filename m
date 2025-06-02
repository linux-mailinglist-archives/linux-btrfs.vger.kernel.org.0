Return-Path: <linux-btrfs+bounces-14362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB477ACAC80
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA92419604A2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BFB1FBCAA;
	Mon,  2 Jun 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnCyqaxu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7D7E0FF
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860396; cv=none; b=P9bKZFpYM5DiLb1DJCeBuQCjDzwpuaqEMfReZgaitOn1ArJ8LcZlnc0vQFdpVNrv4enP+d8ps4uPB6Vkn1yZg9lX5QUAT18ghMe673kOs/TZ8d/TJGbu6CB1gR2rlUgNghCwhB6ks4b+5UtntNW9NhYu5jM6BSQXYp27Ldz/9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860396; c=relaxed/simple;
	bh=1vepuFqC4LBk98xk4tz7TfzHT76tH95SrLzUXVjuUjk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PsKI1+c/sGZGOFxuuiWBYEqQ9BApPLDGVnkBOn3netiZQZraZ+rD6bCG/ueao5Auz1m4I/QARdvehcYHeZZLlK7c59ZhHA+YscDa7DLlUulyLXdN/grM+qy3E+W/xs+h3Ge7oqpf4nT/kYFa6A20Wj0BFsMSnV22ON5qK2LbjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnCyqaxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E091C4CEEB
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860394;
	bh=1vepuFqC4LBk98xk4tz7TfzHT76tH95SrLzUXVjuUjk=;
	h=From:To:Subject:Date:From;
	b=fnCyqaxuezRE8mjpO8NM+57//XlyarLg8ymlBsnfsqmmG+dZ2+elMDNDeOMpc5XKa
	 lQnNzbUH2+AaO8Qrb/UgFZiTmmW0m48M31Kxq1Wx2tWSMzF1kg0bWbg9lH1Y6j38V6
	 5XpTixMqe9anbbW5eb25oQonY6oyi5QslEruhz3b+UOI8mxneNzBIWQFxUV4AlRBOo
	 HqdxU5xxYD3PBI7LS0lPeCIurPJ0JIacmu7wFXN9GQM7hj+M2ADrkLGPRgmjS+w1Fm
	 Ogl+rX1UqVMn3SPOrqAyK5t1FOSr9CW9GSlfOepqLHLuWOoVDJPmI90iCPzjEtXiDb
	 HHat4rTAeaIUg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/14] btrfs: directory logging bug fix and several updates
Date: Mon,  2 Jun 2025 11:32:53 +0100
Message-ID: <cover.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These fix a race between renames and directory logging and several cleanups
and small optimizations. Details in the change logs.

Filipe Manana (14):
  btrfs: fix a race between renames and directory logging
  btrfs: assert we join log transaction at btrfs_del_inode_ref_in_log()
  btrfs: free path sooner at __btrfs_unlink_inode()
  btrfs: use btrfs_del_item() at del_logged_dentry()
  btrfs: assert we join log transaction at btrfs_del_dir_entries_in_log()
  btrfs: allocate path earlier at btrfs_del_dir_entries_in_log()
  btrfs: allocate path earlier at btrfs_log_new_name()
  btrfs: allocate scratch eb earlier at btrfs_log_new_name()
  btrfs: pass NULL index to btrfs_del_inode_ref() where not needed
  btrfs: switch del_all argument of replay_dir_deletes() from int to bool
  btrfs: make btrfs_delete_delayed_insertion_item() return a boolean
  btrfs: add details to error messages at btrfs_delete_delayed_dir_index()
  btrfs: make btrfs_should_delete_dir_index() return a bool instead
  btrfs: make btrfs_readdir_delayed_dir_index() return a bool instead

 fs/btrfs/delayed-inode.c |  42 +++++++-------
 fs/btrfs/delayed-inode.h |   7 +--
 fs/btrfs/inode.c         | 119 ++++++++++++++++++++++++++-------------
 fs/btrfs/tree-log.c      |  72 ++++++++++++-----------
 4 files changed, 144 insertions(+), 96 deletions(-)

-- 
2.47.2



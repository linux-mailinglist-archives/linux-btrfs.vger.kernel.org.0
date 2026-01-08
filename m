Return-Path: <linux-btrfs+bounces-20228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6B5D033A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 15:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB223314724D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC8F481659;
	Thu,  8 Jan 2026 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH32if7G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB048035F;
	Thu,  8 Jan 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879446; cv=none; b=uGiF3T4DSy/D/rojMZ3BwLk1KGSeBn2Lv7HWJZ8lNpYcbiXvkdD3njAe5Sy67rr+8O45yfOeP15BWuYvN71iGEDbd89hLYPcmmdML07BnQJZrC+yxM88UOHSoq6cmFN5GVK6IvpnnyCJi/pLHWavo9V7SxUPhs5WHKfllwaY5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879446; c=relaxed/simple;
	bh=JPsQleIl1sPS1zwC0xJbTdhPQWkwOV2s3UfQggzItKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8MvoTVkoa7AnFIEkmb7HKSVRQIAIMqxKIOhkca+beIaJ2rXw8dVrhdU/WPNaUVfrKRLuO2e90J/QQdnisO6AOUUe6zd3PGAJ/G6+imLrr4FjZ+3firhp76GOSmkECy/pzE18beOEE2Ls0sFFGQV9wTgU5hAdyC0aXwdir9Thbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH32if7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233D3C16AAE;
	Thu,  8 Jan 2026 13:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767879446;
	bh=JPsQleIl1sPS1zwC0xJbTdhPQWkwOV2s3UfQggzItKg=;
	h=From:To:Cc:Subject:Date:From;
	b=KH32if7G/4yUSegvHTTLtATwAWRpQuG33UUccD76EZR8P+7jXIegytTe7PlXhpkei
	 zlRCsM0jrAI2lOhnmMqd+1elMS6IqgIIOLw1xy+xF8zi0YFzQ/MwdVGraz1fkM524E
	 jK/w3FKyWM/lYlBQXhoZ945KiS9sv36gUxyNI0hzfFn8RT6CwqPlE82hC1AhXxV7CQ
	 3JCqO1BP/tt107B5vZLmhPvUEFobgtHspwb8gXMVWmsN/VEYUrgiOd5SjtFluzMSdf
	 IJaQTgI9dZaSvqsF1CpLLy96jylpca/5rBwWL3isZ+gvUXGPbj6BD2ZgcyUEhux/mS
	 fBAXUtBOW4+GQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/4] btrfs: stop duplicating VFS code for subvolume/snapshot dentry
Date: Thu,  8 Jan 2026 13:35:30 +0000
Message-ID: <cover.1767801889.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs has copies of two unexported functions from fs/namei.c
used in the snapshot/subvolume creation and deletion. This patchset
exports those functions and makes btrfs use them, to avoid duplication
and the burden of keeping the copies up to date.

Filipe Manana (4):
  fs: export may_delete() as may_delete_dentry()
  fs: export may_create() as may_create_dentry()
  btrfs: use may_delete_dentry() in btrfs_ioctl_snap_destroy()
  btrfs: use may_create_dentry() in btrfs_mksubvol()

 fs/btrfs/ioctl.c   | 73 ++--------------------------------------------
 fs/namei.c         | 36 ++++++++++++-----------
 include/linux/fs.h |  5 ++++
 3 files changed, 26 insertions(+), 88 deletions(-)

-- 
2.47.2



Return-Path: <linux-btrfs+bounces-3321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C1A87CD7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 13:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FE4283BFD
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB71024B59;
	Fri, 15 Mar 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr3b8Nan"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D924A13
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507358; cv=none; b=l+aycbd8al5pwPD/4rNgwUVV+RaynVM9Ta8bNDeDQ82wDHGpjwYoyeXcXAnjW4vBd2c2Ndvst29jlTyttVwjeaPn3xbZ57qz2KXP+ftnERTyDx/uEFJq1vCRXr0NLvQNQM9SOlA1o2pHi86dG+wzwDck2ju1CPrzO+gMcaqgqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507358; c=relaxed/simple;
	bh=nnNPgNIiNELb38o9VE/PATPwdwzqMO9v8C8zuWgM0r4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=K7oVfUYeUZusm77m5NkZ8tyV6xFFbotgMD/dnkDw5NU9TX24FJ/hPIWnhXXHpMCWm2t6/TOpNUz8yAf9jn1BGYo/a9C9lPrz4v1FsTVZGQH9x6xw9XK8WMJDEMGnZ+LNQjoFztjonQoYFyIE0kopz+3qWM0n3UBm4+aBDpor02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr3b8Nan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273E0C433C7
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710507357;
	bh=nnNPgNIiNELb38o9VE/PATPwdwzqMO9v8C8zuWgM0r4=;
	h=From:To:Subject:Date:From;
	b=cr3b8NanZKsHdsjT4zJdlhWaWwBp8pz0ui7Hd3P4eN+I/pR0kuOdU7Sj9jJuKLF1r
	 mUNP1pR4ebY7aJgXUyBKx2cG/4v5YYJZB+Aygqd9e9n5s2KeCi+ZsnwGtWJ/pF1jje
	 7Ai7YWKn4MOhuLEeK/TgXHu2m5sP2Ot88FNW3KMpKRGxteyDZ7O9PNIFrMfeC/kUuR
	 sjlLrVk0eltEuBbMwNgTsZX8z+5axRKYGeCy2dpajXm/cbQYnSK5amH00ZsFBl3zeN
	 2W/fa7GuGBOt2BAjpeKx8mKiB8bpoQ831ORgESHFLVW33AnPunmiXkeqKn/B4TkJiP
	 86tBeczUrPbDQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: trivial changes to btree lock functions
Date: Fri, 15 Mar 2024 12:55:51 +0000
Message-Id: <cover.1710506834.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some trivial changes to btree lock functions. Details in the change logs.

Filipe Manana (2):
  btrfs: inline btrfs_tree_lock() and btrfs_tree_read_lock()
  btrfs: rename __btrfs_tree_lock() and __btrfs_tree_read_lock()

 fs/btrfs/ctree.c       | 12 ++++++------
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/locking.c     | 16 +++-------------
 fs/btrfs/locking.h     | 18 ++++++++++++++----
 4 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.43.0



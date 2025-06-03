Return-Path: <linux-btrfs+bounces-14411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7BACC99C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD2B1895282
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6423A99E;
	Tue,  3 Jun 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj2NHmGl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3515624B
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962232; cv=none; b=CrAZSK4goNJqwwxBV00wA6bBcZGfylStLHiWQtkAUKpUpkUCYwB4kFGyETnXgB8Ca7oegYN5P5xFjBIuTUwN04eAHfFm1PMLqFV72hrCjTfEbnnfK/8i08PKgYm2N6VmT2d1i2WYpKT1C9x3akzMqAgYLQgMxbP6QNn87AUkIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962232; c=relaxed/simple;
	bh=f8DSqpeRrldOvkqCR75klSqnmxsyWUazoAcHn4tifgA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y6B7XusrYnSeJNJvLmiX+ueu6TcVVBzF/YUwZdGuJdaMQdn7QQOf6t+UlKO+8/Bs+58mDx1lrkmZXPRORPsp+dGqWqRc74ajpPXJT89H/GYpbSUALvDQtWpjwbQRVmT7PH6eVzNMD36Qrl9F7v3n/M53VN5ueSeNTO+syRae9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj2NHmGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499F9C4CEEE
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748962231;
	bh=f8DSqpeRrldOvkqCR75klSqnmxsyWUazoAcHn4tifgA=;
	h=From:To:Subject:Date:From;
	b=qj2NHmGlLYHJXPBqFs2UUYjT6xEdnAN71YtR8CFkxj4iIHy7J6vrajhUY7QafZu8R
	 vzOQILdsuzyDGHh+25mPEvH11QAH3nf2nCghWkTERU2JrJsXdmnbG+zdz9KsHDETZI
	 I04EFcTO2UCJ0h1SdhdkDd8J7VUAgW7zFJ7hIUr6JnfZX5umYDlWNJKwPQ0+CRV/EX
	 OLfvvutHIJoYBu78xldpt+BUL7hveow4b6V625hdQm+TXO0va5NmU/M6VBqDvPkE6M
	 zax+chF8d4L0oMvYdzEWbS9Q5XWwb+4No1aEP0SHT407umwiy6AJJxJHGtYwdn8Qqd
	 Rap8N6ZV7tOmg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: use refcount_t type for extent buffers and cleanups
Date: Tue,  3 Jun 2025 15:50:24 +0100
Message-ID: <cover.1748962110.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Switch from a bare atomic to refcount_t type to track extent buffer
reference count and a couple cleanups. Details in the change logs.

Filipe Manana (3):
  btrfs: reorganize logic at free_extent_buffer() for better readability
  btrfs: add comment for optimization in free_extent_buffer()
  btrfs: use refcount_t type for the extent buffer reference counter

 fs/btrfs/ctree.c             | 14 ++++-----
 fs/btrfs/extent-tree.c       |  2 +-
 fs/btrfs/extent_io.c         | 55 +++++++++++++++++++-----------------
 fs/btrfs/extent_io.h         |  2 +-
 fs/btrfs/fiemap.c            |  2 +-
 fs/btrfs/print-tree.c        |  2 +-
 fs/btrfs/qgroup.c            |  6 ++--
 fs/btrfs/relocation.c        |  4 +--
 fs/btrfs/tree-log.c          |  4 +--
 fs/btrfs/zoned.c             |  2 +-
 include/trace/events/btrfs.h |  2 +-
 11 files changed, 49 insertions(+), 46 deletions(-)

-- 
2.47.2



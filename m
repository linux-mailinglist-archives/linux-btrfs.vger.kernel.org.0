Return-Path: <linux-btrfs+bounces-12879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DDA813B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668DB1BA7DEA
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB8C23C8B7;
	Tue,  8 Apr 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGsgZ3+t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDE256D
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133582; cv=none; b=pK8XP3pGzmtBRz/BWW0WAtcTB04/4m4d4nCoojmF8iQ2/wXtRWG2aC0NDolDGoctzXp7m4b8gay7h4RrqoArn0Th4NkkEOOh7197sV9SHFo7C0JFIhYB6qy9J0j/wMadJXIEBVDSeT//TldPJFo+g8hxuQdZ8DFXDysHaWTIzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133582; c=relaxed/simple;
	bh=RXzQ2UEKR0vzk2YKt6wiO4Av+EcACDuwSp7fc4LhbHA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OzlEpmUYqp72BSC48qwa2a+j6wKjplbITmZ9/13fDNsdzkW9jOXBXmmoxFfaUGOwWZYl8TFS6tIbSXF4RbM7ESv/TEW7xh0O+IauzdSiLyj5BvIH4Q6IIuZsA0doMaDYh5Jf0ZXJogj5e5is3Q9mKQMXtU4On/M5eIbQAAHAWE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGsgZ3+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE49FC4CEE5
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744133582;
	bh=RXzQ2UEKR0vzk2YKt6wiO4Av+EcACDuwSp7fc4LhbHA=;
	h=From:To:Subject:Date:From;
	b=SGsgZ3+tsS0w4AxK+v+8ZfAXpn/M2xxogF/nHgbd4JD1JNLsXcYwXEOn48RLNBrwi
	 gita+XqU/rnMcwpJZSYKQyhJe7E/IzINS+SJXxcqO2cy1ckrc7nRyRKtjFgZsVxVue
	 uIXiTYwpR/WVPCBJJFmwBf+MLo4fKaShTUKSctQY4Atib429WRHNo6pH3qhudzwLPE
	 /vC92e/jyOztJ7g3hnvCqw0417mH8cqT2nxLsjZXMdfhTbmEl2hsKGArJtR5QUEVLd
	 Cdpm6ZsPVcdVuHh2SXFiNcHfFd3732nuHcfgkJedg/2ZI3PR1Rs95QYboPPwwkxIbx
	 P46YVSvYWzaDw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs: rename exported functions from extent_map.h
Date: Tue,  8 Apr 2025 18:32:53 +0100
Message-Id: <cover.1744130413.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Many of the exported functions from extent_map.h don't have a 'btrfs_'
prefix, but some have, making it inconsistent and also against the coding
style conventions. I've added myself some of them recently, to get and set
compression on an extent map, and ended up not adding the prefix since the
other functions in the file didn't have the prefix, just to make things
consistent. So rename the ones without the prefix to have it.

I've split this into more reasonably sized patches to avoid having a huge
patch and make things easier to review.

Filipe Manana (6):
  btrfs: rename exported extent map compression functions
  btrfs: rename extent map functions to get block start, end and check if in tree
  btrfs: rename functions to allocate and free extent maps
  btrfs: rename remaining exported extent map functions
  btrfs: rename __lookup_extent_mapping() to remove double underscore prefix
  btrfs: rename __tree_search() to remove double underscore prefix

 fs/btrfs/compression.c            |  18 ++--
 fs/btrfs/defrag.c                 |  22 ++--
 fs/btrfs/direct-io.c              |  26 ++---
 fs/btrfs/disk-io.c                |   2 +-
 fs/btrfs/extent_io.c              |  45 +++++----
 fs/btrfs/extent_map.c             | 163 +++++++++++++++---------------
 fs/btrfs/extent_map.h             |  47 ++++-----
 fs/btrfs/file-item.c              |   4 +-
 fs/btrfs/file.c                   |  30 +++---
 fs/btrfs/inode.c                  |  80 +++++++--------
 fs/btrfs/relocation.c             |   4 +-
 fs/btrfs/super.c                  |   4 +-
 fs/btrfs/tests/extent-map-tests.c | 102 +++++++++----------
 fs/btrfs/tests/inode-tests.c      |  79 ++++++++-------
 fs/btrfs/tree-log.c               |  16 +--
 fs/btrfs/zoned.c                  |  10 +-
 16 files changed, 327 insertions(+), 325 deletions(-)

-- 
2.45.2



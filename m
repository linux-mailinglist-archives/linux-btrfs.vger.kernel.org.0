Return-Path: <linux-btrfs+bounces-1843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529883EF49
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 18:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FAD1C21739
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210D2D610;
	Sat, 27 Jan 2024 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIMdEoZX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A025777;
	Sat, 27 Jan 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706378203; cv=none; b=lAk0vhmZMWQvZDYNExgI8UODREJ/T0xIuV6Jy+r3TqM+GCnH4sja25X/My0dLzxxY2SXg0VFpQp+Q7qIAMTPP1ed0YKgKovTcPK/kQXsaDejT1zTibfWKkrxGK7m8w0FDLZGHd5VhJ92r487c9YkpQqgHjHxN5hBO5ilUUxfMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706378203; c=relaxed/simple;
	bh=Mi6FZsJ7oJzO3j0KuyqojMy6sRZJZhWvGhDRKOSX3hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LGSWGd7VP1OYN6SSqnto6rTibp1aH3mwigDa3JjQIihgBJ5nEKfCzDLr0BupM6D8PvMRy1o5gcqKDpsH+oWuNhcvEAqdkSes4JVFV2+YSFhSji4lQnX1kAbHJ3pWtTxsQeCagB8avZzmXwrVAzXlFf56NZn/z5YTHFsBquxaZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIMdEoZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85A3C433F1;
	Sat, 27 Jan 2024 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706378202;
	bh=Mi6FZsJ7oJzO3j0KuyqojMy6sRZJZhWvGhDRKOSX3hQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iIMdEoZXpC/fajwchqaJbw1eGXkK434rb7QZ74hbrOsANUGE8zwk0hBnXiNcuOz8y
	 v3JGClKDd8dBLYYrttEkdRKWb09TLaL+XYMN6yR88MdOMI1sRfj4ushYeKGh1xOq3a
	 ory0EuBY2jBbrmNddOvlQpz0nfOpdnj5bCft/h7oXaraNC6m8WK5SMdxYCoNGPfTPi
	 NQdrg8UEF4MWpnY31DTfZZJ3TENI/yslf7MNS4gd5fwsegVkl9+XS4x+p0Tp44R/r5
	 1w/wE/2c6YPmDDs8bz83bzAKVD5KeCYwhWOofTWVxC0Fe8ERhnNfm4ZLqQkLchs1Yf
	 3usiW/kVXdtNg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 0/4 for 6.1 stable]
Date: Sat, 27 Jan 2024 17:56:30 +0000
Message-Id: <cover.1706377319.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Here follows the backport of some directory related fixes for the stable
6.1 tree. I tested these on top of 6.1.75.

These were recently requested by a user for 5.15 stable:

   https://lore.kernel.org/linux-btrfs/20240124225522.GA2614102@lxhi-087/

This request is to backport the same patches to 6.1, while the request
for 5.15 stabe is at:

   https://lore.kernel.org/linux-btrfs/cover.1706183427.git.fdmanana@suse.com/

Filipe Manana (4):
  btrfs: fix infinite directory reads
  btrfs: set last dir index to the current last index when opening dir
  btrfs: refresh dir last index during a rewinddir(3) call
  btrfs: fix race between reading a directory and adding entries to it

 fs/btrfs/ctree.h         |   1 +
 fs/btrfs/delayed-inode.c |   5 +-
 fs/btrfs/delayed-inode.h |   1 +
 fs/btrfs/inode.c         | 150 +++++++++++++++++++++++++--------------
 4 files changed, 102 insertions(+), 55 deletions(-)

-- 
2.40.1



Return-Path: <linux-btrfs+bounces-12033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C51A50985
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 19:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92401168896
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 18:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F28253F3F;
	Wed,  5 Mar 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXRXpYVE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B83251798
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198674; cv=none; b=im+goKXEjLzBMzJBQQSZH6eRsXsISVD6HYZ4k0LGW+nXvvwAOlJ2XIqlik5MX6GjidKCua5cej8YCX5KsNhMT9f8coXsHEYJwNbiGWa9z8K+uZjqYW3pNZkcDx3DySed1oFvT3qeHT9Z8R+kdEztgpyaxxfzwLNXA1A5umkcLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198674; c=relaxed/simple;
	bh=4yUYyjtMFFv8i5L5lrd/+MeXYumd48imf6bm7ZdCors=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNdQ0fbB5LOwimr7VA8yuGIeVm1LV593d4Vq/i+qEpJVZ6iXnAFoR4aLKccQNxxzAGl6nGcceiG9tC/a6LNh9+7eNRjnnzegvwtC3u3idSg3/rjEmxYw1WE47m+gzpFhpUaZCzMPBRz5Gi54hiyEeJMi5TShyYEwhiRAgW5U5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXRXpYVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EDCC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 18:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198674;
	bh=4yUYyjtMFFv8i5L5lrd/+MeXYumd48imf6bm7ZdCors=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WXRXpYVEbJrMhs5me/3kH0C90tPJn+MVcyDIli/LToPMchG55tVH98qUVPVec9LQW
	 lWX3HVXatSQGyMS6slSUgZc/k4bhcf6UUZ+kKRMunTVvSWczfNpGA6q4+TRYU6buY0
	 f2DxmfSgN32bWawYMWjyxFJRW/ij+w/4pPBAe9TI44yrL1iVoWUKjgw4SJYA7WqxCN
	 Dh7CHSHOZ11VKaZlLiHZSDiqcquPrScYa8R6/tEwHMNQsaDHLeeuHZefltwdWVGFsb
	 gK6QK3Y+Tfisp3JYnkqim2uo1+KDflNHVfWpMcf7Fqm7J6FKIN6wCZM3rvCu6sbwf+
	 V9X4JdQb3+K7Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: fix unexpected delayed iputs at umount time and cleanups
Date: Wed,  5 Mar 2025 18:17:46 +0000
Message-Id: <cover.1741198394.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741196484.git.fdmanana@suse.com>
References: <cover.1741196484.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Fix a couple races that can result in adding delayed iputs during umount after
we no longer expect to find any, triggering an assertion failure. Plus a couple
cleanups. Details in the change logs.

V2: Removed the NULL checks for the workqueues in patches 1 and 2, as they
    can never be NULL while at close_ctree() (they can only be NULL in error
    paths from open_ctree()).

Filipe Manana (4):
  btrfs: fix non-empty delayed iputs list on unmount due to endio workers
  btrfs: fix non-empty delayed iputs list on unmount due to compressed write workers
  btrfs: move __btrfs_bio_end_io() code into its single caller
  btrfs: move btrfs_cleanup_bio() code into its single caller

 fs/btrfs/bio.c     | 36 ++++++++++++++----------------------
 fs/btrfs/disk-io.c | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+), 22 deletions(-)

-- 
2.45.2



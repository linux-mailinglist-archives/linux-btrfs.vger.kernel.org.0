Return-Path: <linux-btrfs+bounces-13996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8EAB68CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 12:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4A37A62DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46262270EA6;
	Wed, 14 May 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao+Y5XBs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4426FD9B
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218567; cv=none; b=IoQEopSfFxRYeajCFlPmQHpAe4ggstnuH+4RU5ahGbytV6v3y3Fo+Bj/46rmt+ajGgH5oU/2ULIoIDQk3kBMxyUTgbPkGrzIUxbNDj5hXPg4PPXUZQnwFAZYPalokAI3NyIIvk+kdFWEBFwuzLPdLOm7xJHntJdfQb4TdRMoEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218567; c=relaxed/simple;
	bh=dKbAAq88RvkV8Mkl1Wz4K3D4lKhKHgg+p1x2ZU6P9SM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZTkE+aX4SM8kLxi5JP7yDmGWCLci4pda5W4gLaZAY7ixEnr9Hg9iNfxyJlGX7BOYsootIS703jb3muC2W2yVomI1taoc/4bvM2l3lEZPg7B3e0SzxPdus3RRrRP6FqULGGvHh9L8cx2jDdr8GA8AKxc8+m6okKWnopgFdGHKKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao+Y5XBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB44C4CEF0
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747218567;
	bh=dKbAAq88RvkV8Mkl1Wz4K3D4lKhKHgg+p1x2ZU6P9SM=;
	h=From:To:Subject:Date:From;
	b=ao+Y5XBsmBawdUeGzpymufL3KzkWhouk3YoRjj8EJ8j+vQRQo8JNcdWmP4Mf9ewRh
	 F5mg37InBRJxQcnAjBJRjiexfkZKNYLuJnznPbHgd5UkD+rFqLBPOdYOBsa1oZb/mG
	 DNRrdZpKHvfCL9IJRKM/is61QHqR+sSdqXD4PtJaxYHEv6yo2AOBJ+9PkJq0UhpIHN
	 l74t+zlmepmUyzoLywYORU+mwnI7Fg/pPjIgnkvUf8fFlIsyeO1kS3Ypk0MoyCkzcM
	 E7P+I1SliGL5P9JgIfmHHLNDNPtS5koer+tClJmz+tnBHorCOs7YbJ/8OPEuY2KR1g
	 ukIkPdAwWOazg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: fix a bug and cleanups in btrfs_page_mkwrite()
Date: Wed, 14 May 2025 11:29:19 +0100
Message-Id: <cover.1747217722.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A bug fix for mmap writes and a couple cleanups. Details in the change logs.

Filipe Manana (3):
  btrfs: fix wrong start offset for delalloc space release during mmap write
  btrfs: pass true to btrfs_delalloc_release_space() at btrfs_page_mkwrite()
  btrfs: simplify early error checking in btrfs_page_mkwrite()

 fs/btrfs/file.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.47.2



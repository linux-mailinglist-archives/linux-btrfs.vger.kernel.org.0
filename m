Return-Path: <linux-btrfs+bounces-14006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE43AB6A51
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC064C0FE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086592749E0;
	Wed, 14 May 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhmQ0nDo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21620F091
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222720; cv=none; b=U3GmI3rJ+6PpN+JhQF4Dq9/IkTbKm4ywQ8OZzaSjj05XWMcwgGER6HLo2YO2WLIi5YcYh2wsFBJJppBkNtVkV/d/Ir/x7uFxeS6ym5j/CCD529SkHHSNihf1Y+lP4hTdVhTIoPINvVVmsN+34cSpL1dwZiNCqCArUBDHDIbwejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222720; c=relaxed/simple;
	bh=DGB32W8oBiq3Te+vW4b3RH3obbYxuu2XztIwJp6Tok0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d1eW068kHAlb3N1aDzgxImZKndVX3CY70icz6OQ7AH0Z7FuZ2H4I0lHjnThXxTjP3kkEaeHcvXcTI50B3I6stpHaPyrRx/bNjh+7RTvium0zesTh+IbYVlR+d54aYKkx5sydrT/FSf4kRz/g6sbVv/T6zAotnXS+3aqGM4b75tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhmQ0nDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0C8C4CEE9
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222720;
	bh=DGB32W8oBiq3Te+vW4b3RH3obbYxuu2XztIwJp6Tok0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rhmQ0nDoHtpz5pdQUfszjx/CyzsCBzXz8lKXAN0yPEJLAirJNjAKLD+SYQ5P2c95n
	 FT1f1FG8mR++cxXbnjl+ThOqNkYWUkQ6ER259PdZbGMO5Ne5zJm9f+lk00neH4XuS9
	 1uj3o7oQf4juEsv3/Gu5+MGJcB0magvRKSyxuj2LDD2C82fkpcxlRm/CATk04AZtTI
	 osN0WOtTOmZ+tfavzxe0BqJi7SbC28TTkrb3ydExaSfO2RUqtrqoTw2WSxyj1yeAC6
	 UxA8IMPpcFvj2UKVV1szABLxtwOKvelFwQyb75Re7n5r5+sMQA9luRUw0h8hF1+1FK
	 cQLpV1c38oPtQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: fix a bug and cleanups in btrfs_page_mkwrite()
Date: Wed, 14 May 2025 12:38:32 +0100
Message-Id: <cover.1747222631.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747217722.git.fdmanana@suse.com>
References: <cover.1747217722.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A bug fix for mmap writes and a couple cleanups. Details in the change logs.

V2: Added two more patches (4/5 and 5/5).

Filipe Manana (5):
  btrfs: fix wrong start offset for delalloc space release during mmap write
  btrfs: pass true to btrfs_delalloc_release_space() at btrfs_page_mkwrite()
  btrfs: simplify early error checking in btrfs_page_mkwrite()
  btrfs: don't return VM_FAULT_SIGBUS on failure to set delalloc for mmap write
  btrfs: use a single variable to track return value at btrfs_page_mkwrite()

 fs/btrfs/file.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

-- 
2.47.2



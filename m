Return-Path: <linux-btrfs+bounces-15383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E867AFE76A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E6D1C47E08
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7332951CB;
	Wed,  9 Jul 2025 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uodgZV7e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841629117A
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059638; cv=none; b=dqIUXeWaWDzAjA0IHfIWDMCtx4x6kzxaptiadrNCK5zON0yH9ywzQUrPL2ZBQeWn4uSR8zL0WSH6JZdX9rUEtwxP0DymkJI5a57yf0KeRiOF3izSkhCewW1w1TopUmlYAPXhxeefM67LWieJ/fR2dPHhOVx9xABArsmN5ecTj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059638; c=relaxed/simple;
	bh=MlwyzG1ABC/p2FH+ZBvcX2rWyPLuLp+F25zNYgwciIc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtoMyJn1q7mtKwQdwFN7uxr0gFeE95Nv2PY05U2ENdyjDd/SIr+PgOXc7FrHSV4DOtRcGNwK5z2mT+VYtcP5UCReAoAtaA3CJx+7RGB7qHVt3S0iOkgv8OLdTVm6l/rn0ZQ0o+u1D1u42rMY0rHYCUqrCbLgGLASD5InJYIn3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uodgZV7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD070C4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752059637;
	bh=MlwyzG1ABC/p2FH+ZBvcX2rWyPLuLp+F25zNYgwciIc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uodgZV7emjXOaEtYeRxb+nY0k6TxQNMX6NVD3XcboTtgl8FVCU2rpQOf3lBGPIhBh
	 f4QkcY/Tz13kvYh5isgAHBZc3RdDb1bs4NIOsGIOghP7D4ViuqFX1DniZVrSWmV1li
	 GjL58+Hvx5opia/uIpuYaxPmvF+cJKHY9EcBlXf1nfZ094k10hW0mRidDmOxe7RSGu
	 DNfRbBbkekb3IDr0aj/4iTTyw6N/LaCcj1NN+MtbbPKJL9+suMbklxCWJAL8DlO/49
	 IrUx41aiOK5r3N+cYKF24HzuvmhMKFY3/lSNfcMNCO/73CgM+QeB79kbQJ/8tXVyou
	 gEsYUZDRUeTmA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: fix mmap writes for NOCOW files/extents
Date: Wed,  9 Jul 2025 12:13:50 +0100
Message-ID: <cover.1752058855.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1752050704.git.fdmanana@suse.com>
References: <cover.1752050704.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A bug fix and a couple cleanups. Details in the individual change logs.

V2: Fix a bug in patch 1/3 where if write_bytes < reserved_space we would
    exit without unlocking the cow lock, so set only_release_metadata to
    true before bailing out in that case.
    Added Qu's review tags.

Filipe Manana (3):
  btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
  btrfs: use variable for io_tree when clearing range in btrfs_page_mkwrite()
  btrfs: use btrfs_inode local variable at btrfs_page_mkwrite()

 fs/btrfs/file.c | 91 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 27 deletions(-)

-- 
2.47.2



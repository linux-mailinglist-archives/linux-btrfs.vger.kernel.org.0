Return-Path: <linux-btrfs+bounces-6841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564D93F8B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01631C216BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EB154444;
	Mon, 29 Jul 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhgm3MPX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B71DFFC
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264687; cv=none; b=odseYnxjcW8LpBxYy6In3a6zrhAjRooJrsEJWeqFKkOqwdfS/H0icSk3RReUJHH19VVbhkGW+4tqKSdjx/aweHYFqmdkuiEF+E3CmNAWc6s1SbcWDMEn7H6sEdlKCRGW0ACB31qXnTWUsNK9GUmQgr10OjMqeavonum0nQjJvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264687; c=relaxed/simple;
	bh=O25H1FKBny+nu2EDNBpDrzbSiQWlR+g/PE1sf1FCj/Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bOKK77IuBwgd7L8wvwxB09jOIz5M5IXSBSJzL/jy2tX250aaRHKqRVwW/72MrJ6mY3D90g4agx+vFKHySOrq4tl/JpbLeVsX91p1afyNb0KlKmyR/+7a+nJDPAvmU5ojP3BxTlLaKSZAWKv4ZbC2WNCSH5wa1OwKLvuHkEBYl0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhgm3MPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D46C4AF09
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722264687;
	bh=O25H1FKBny+nu2EDNBpDrzbSiQWlR+g/PE1sf1FCj/Q=;
	h=From:To:Subject:Date:From;
	b=mhgm3MPXcweSNuQWLrqRLBA66sJ3RGF+4UvTxUz4M4TiaVmrFmZdTyH4ig63meeYv
	 LR6rywl/a6jlB0cQ2gOk8Me5eNHWTtSPGdNG9sxA25uG4i9KEpUx6uRsxhI5vpVHzM
	 S2UXMD4DHOD2Fl0Wm0jntqCUAEv+V/XBv9bAk3OiCgoZhcIluoeild0sVQZ+sz0TMu
	 mexkb5xRKcAqnqWfG9wlWZ8mRUb+8aQ4BNip+LjEklXkQ6MxAKOYaXfAYD+f0tBSeV
	 wI60jt1M2HdHFoYM0NBo2u/eyh2O984hPNt9oUZvFm+OjEZyb4OCNB9BMP+xl2fHUh
	 At9kYXfBOmwBw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some updates to the dev replace finishing parting
Date: Mon, 29 Jul 2024 15:51:21 +0100
Message-Id: <cover.1722264391.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Trivial changes, details in the change logs.

Filipe Manana (2):
  btrfs: reschedule when updating chunk maps at the end of a device replace
  btrfs: more efficient chunk map iteration when device replace finishes

 fs/btrfs/dev-replace.c | 43 ++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.43.0



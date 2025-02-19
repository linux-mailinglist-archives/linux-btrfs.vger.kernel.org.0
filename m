Return-Path: <linux-btrfs+bounces-11571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A025AA3BD40
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8125173CFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A41E0B70;
	Wed, 19 Feb 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgiQ2W4f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CB1E8323
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965417; cv=none; b=P8jhjs16XEodewVNBZPnSFjNo0shLGCqVbgayRRU/1qLwGGAF4k8PrXBk+XtHNkyD28UdpiJ/VAiHVkXeVDnKJHPNLHLSCBXcFTh/2dbibEDqils8ypJH95A9bWl742ziCXCf3zqs19bWp/00g5fWIrmXiuDp+SR9Zi5Tbjt0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965417; c=relaxed/simple;
	bh=XxZo2AnDSw5lV1zznAhDaeSUgPufzogr8jT0/2qq8Mo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kt84agZQDMGw9r2ATxiEu6Cd0qElY78SmWXLd19u3BO9THq23KM3/X0V5/MxnJsPz0gTNo8CdLnkdGx1U3Xtl26oHS+JA7Cji6lcYJtepgWlTCl4SQlV+nQmHMQTkoF0D3QtT12D94R5biNOw17kqbcVlPqlwJ2/W75ud9/cGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgiQ2W4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8129C4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965416;
	bh=XxZo2AnDSw5lV1zznAhDaeSUgPufzogr8jT0/2qq8Mo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XgiQ2W4fYXJuhN3dJ1yX/3meI1M0S/M0fmWFLFqzUYEabd4JyWr5T53tvXvU9aXYr
	 CVBl+oLlHI0y8BTpOLDd7Yqd/CbBS3Ri9WbtVlYFDEV+HBCAcL9Fp9Z9o+Dx3S99GJ
	 DIC8ADPRQysbMfDnZADWQfn4a1/+B+YjOnoqN5MSzV1NzEcMsv3AzNgVBwpRZOo6Cb
	 neppYwVmedsMLaMZkWgq18CnhlKD4lWD66rhRgiErwXLy7z20i/h+oBxcteNeqHK3/
	 zZAZWBWqP0kHq5Sg6K70RKOOsW420vz1/I1kS7D6D/RCiOWXHega41Ng9dEGpvPLgt
	 HWY3HIZ+flEwg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/26] btrfs: send: implement fs_path_add_path() using fs_path_add()
Date: Wed, 19 Feb 2025 11:43:06 +0000
Message-Id: <984cf0ba391d6e7de70b7c8057cdaaecffd961a1.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The helper fs_path_add_path() is basically a copy of fs_path_add() and it
can be made a wrapper around fs_path_add(). So do that and also make it
inline and constify its second argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2203745569e0..7a75f1d963f9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -566,19 +566,9 @@ static int fs_path_add(struct fs_path *p, const char *name, int name_len)
 	return 0;
 }
 
-static int fs_path_add_path(struct fs_path *p, struct fs_path *p2)
+static inline int fs_path_add_path(struct fs_path *p, const struct fs_path *p2)
 {
-	int ret;
-	const int p2_len = fs_path_len(p2);
-	char *prepared;
-
-	ret = fs_path_prepare_for_add(p, p2_len, &prepared);
-	if (ret < 0)
-		goto out;
-	memcpy(prepared, p2->start, p2_len);
-
-out:
-	return ret;
+	return fs_path_add(p, p2->start, fs_path_len(p2));
 }
 
 static int fs_path_add_from_extent_buffer(struct fs_path *p,
-- 
2.45.2



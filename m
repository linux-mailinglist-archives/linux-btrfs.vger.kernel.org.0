Return-Path: <linux-btrfs+bounces-13680-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3FCAAA0EA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 00:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F2A4618ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1724297A69;
	Mon,  5 May 2025 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceohF3Ra"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C7297A4D;
	Mon,  5 May 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483531; cv=none; b=oWfwyCtyvBxv3ZvSlPxwM31FKZXQHqvRHPT54JnkjsvkdL3YMcNVQZtDMpKJrmIKcM+9ecNHo+FpcpEv6hXNKyqehfB3M/cAsfGc/c8BuQoqsTkGbu61L/sz99WnOD3gya47ai5Y0jxzZYa/TuepcNq4XV+UhaVvwv5hr2+Lobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483531; c=relaxed/simple;
	bh=n+e33YGpGIKk7k+5QYVL3izqIDyJ9RU6m/SPwc0tmZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcYKZBDzfSGlfjJ4NMTAP2zrxEFzhbAEHBKjAy1ZcXwoz/lDJ9omdj/gBIpDnwsEgTP+YP/JVw8focEhDDLmIwEhHypdMDjWKL6uVMqup2pumRBeKQEwNglTCmVf8v+IDeaDv7+bY2VOfm46ewxtSTeK437RmMGIJyBcPIq5KJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceohF3Ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A9EC4CEEF;
	Mon,  5 May 2025 22:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483530;
	bh=n+e33YGpGIKk7k+5QYVL3izqIDyJ9RU6m/SPwc0tmZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceohF3Ra8dWz4vvpiYR8xgPOxNllRkLVpPE0KHGqH9CvFw/UwwOdwiIXM9xvCsafo
	 ZtcrQaDVsOG+1X6iCEsQhYp3cRMZqxZdeLn1m0MCQ4GBniga8P+dR1WsTXIzAvrV9i
	 PGovd6rYmWc9Vw0BNCIP63HRiBuVPQ/jFemSiJ5ioIoNSNvhKViQZeM+qFNtyfQdLm
	 s2xjMbu8SeV/cVaPCdbascPMbksbeXykc3eIs1pyKMegsKy7SgwVtPrekxz3fASXHq
	 pPA1RGz6CLDXd0TJwxmZjcnQijslyJ5DlzYjVPzTDg/yicw003BskokfWeE7C3nHO3
	 1Rjm8yW+jHx/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 102/642] btrfs: zoned: exit btrfs_can_activate_zone if BTRFS_FS_NEED_ZONE_FINISH is set
Date: Mon,  5 May 2025 18:05:18 -0400
Message-Id: <20250505221419.2672473-102-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 26b38e28162ef4ceb1e0482299820fbbd7dbcd92 ]

If BTRFS_FS_NEED_ZONE_FINISH is already set for the whole filesystem, exit
early in btrfs_can_activate_zone(). There's no need to check if
BTRFS_FS_NEED_ZONE_FINISH needs to be set if it is already set.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 978a57da8b4f5..7c502192cd6be 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2330,6 +2330,9 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	if (!btrfs_is_zoned(fs_info))
 		return true;
 
+	if (test_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags))
+		return false;
+
 	/* Check if there is a device with active zones left */
 	mutex_lock(&fs_info->chunk_mutex);
 	spin_lock(&fs_info->zone_active_bgs_lock);
-- 
2.39.5



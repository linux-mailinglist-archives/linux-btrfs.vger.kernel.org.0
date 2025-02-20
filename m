Return-Path: <linux-btrfs+bounces-11637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987EA3D7B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C2717CB88
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF12C1F12E9;
	Thu, 20 Feb 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmFOeHlY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333431F0E2D
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049490; cv=none; b=Y5NjElTq5ZqKr3Mf3haTf/5zGL/s+BfuO0pEHu0sWf8rQfuvLe9SIdtM/xlb2GnvEXskYxaBjLdczA1a1SYPlU30ns5wlXM1Ea/vhrmy+KhM0uY3lIyxkd0yqbNsaNMEs+olTD2UkmyqRoEB44CPHC0zUXavCnceR3gC/OWrHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049490; c=relaxed/simple;
	bh=VElW5lz5SNietu+keLp8sG3SfJrkP00ZTihTb1ozIFI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRxZ1Vr+aczmmuLZr1Xaxi8g5UYk0KsikkF5MPgMDWbCLfl/DWt0xvaKaWE7rENqngRNEUZHqFpD5OnF6mKaJ1SK3SvPyTyCCXKrd7G7pzfZHgFdlbh/8ZZZeoLvHLABL3ct1fHvGrVsdPYdm1CuH1tLYbzj17gkcNXsqPpuoho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmFOeHlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C63C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049489;
	bh=VElW5lz5SNietu+keLp8sG3SfJrkP00ZTihTb1ozIFI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fmFOeHlYWIanQJ3xlTdYbgPMInjp3aJwX5oUh51UXGYPF2gQ5/ayZibeCHSXpE1kn
	 mSAAmRIt2xydjMW70qmGocB42c5EyvHRMXmqq7PNqxkFMve45bmsnSjhjD3RRGtpaD
	 jARM8UYngX7o4jV8VZr95Fmi5kEK9ZPXbnuy2sWi7woUVWqCkHnFED5hEcqFK2Ot0Z
	 rLJKVg0kXA+WOmdtmGLOx38+cF52Onz3zmaxNVwGpsWPS5vVfJ2RKgJzR6xwiXJU0A
	 UZrWuGqV5GQxFBd7YvXvJnu8BTXMEUhNjR8lBcq3zL7zJixIpUI8mXLbSjPo5jJrih
	 wU/vE3LgJF8tg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/30] btrfs: send: make fs_path_len() inline and constify its argument
Date: Thu, 20 Feb 2025 11:04:15 +0000
Message-Id: <b468495ebf47e5d75be130af11ada116552ed4e0.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The helper function fs_path_len() is trivial and doesn't need to change
its path argument, so make it inline and constify the argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 8de561fb1390..4e998bf8d379 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -468,7 +468,7 @@ static void fs_path_free(struct fs_path *p)
 	kfree(p);
 }
 
-static int fs_path_len(struct fs_path *p)
+static inline int fs_path_len(const struct fs_path *p)
 {
 	return p->end - p->start;
 }
-- 
2.45.2



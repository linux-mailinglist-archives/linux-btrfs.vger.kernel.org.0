Return-Path: <linux-btrfs+bounces-11570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AD7A3BD45
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEF0189BC76
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73101E8321;
	Wed, 19 Feb 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHnP0COl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC21E5B7E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965416; cv=none; b=m3BgXLhBaKgBWynY0ue11HJaS8KTPdgGRVi/++b7RYJXW+byynpPFk4SbsRN4CewWdPPBAW9azNGSQihCZyinCqmXkQAH17K/wmQhONgXcosh8EVdTso6JA7uSrYLEcry1Jz/ahLXnN29m6hNyH1iNR2PF0dDb6igG7fOKn8gCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965416; c=relaxed/simple;
	bh=rdrI5QR7o7YSMAs7It4zSI9Pc91EI1TQvoSr4/qmDNk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fj7udIpS6iiaPFSGV59aHKOPhmBfqEO/zwIJnjfKwOZt19xD4h31xZ+RrPY0M/ZGes/rfCRsJPc71/Pos9dZjv3vT1mt+4FKU9CFDWkSGC+7MzMdzeKAb9Xs/oDkqTD7T2UImuxo98+Pi4SFctkx4ztI6aBeGGb2ICx7to1v7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHnP0COl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE104C4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965414;
	bh=rdrI5QR7o7YSMAs7It4zSI9Pc91EI1TQvoSr4/qmDNk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QHnP0COlmt/j/Fk+xZ8vB7RhNfE/QMF2M3KVH6SdGsvE9jrQ1Cs4N6J+2a9IMOXGl
	 uyCtT82itNWHzvTHwR2O40RjUj03GCEbcP6sKIBZ84q3QQMV1qq7OL1oItaSBxVPGD
	 2kxOd+QhszeoVnA7prZC1qm9uVwu3OJ4bz/Xpka2lYbFajvaA7ht56STYYPQp48ANk
	 WaD8zZkeiITHXihauztXmJO2gGLjDFGK65XgrCR7j5xKQL2qSw1owon75Ur2K8chmF
	 hmj8058WGT1v4a2BVH+t8BW9FwRspDDryFI7dzzr5gG4LIs3XUBYG9urr1GoIgygjW
	 VHxYyEcMwxwug==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/26] btrfs: send: simplify return logic from fs_path_prepare_for_add()
Date: Wed, 19 Feb 2025 11:43:04 +0000
Message-Id: <b329b46a563fe8fbefe327b8f9d26a757066a836.1739965104.git.fdmanana@suse.com>
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

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9f9885dc1e10..535384028cb8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -535,7 +535,7 @@ static int fs_path_prepare_for_add(struct fs_path *p, int name_len,
 		new_len++;
 	ret = fs_path_ensure_buf(p, new_len);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (p->reversed) {
 		if (p->start != p->end)
@@ -550,8 +550,7 @@ static int fs_path_prepare_for_add(struct fs_path *p, int name_len,
 		*p->end = 0;
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int fs_path_add(struct fs_path *p, const char *name, int name_len)
-- 
2.45.2



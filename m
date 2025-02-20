Return-Path: <linux-btrfs+bounces-11641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569BAA3D7B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C84D17D686
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E051DE3A7;
	Thu, 20 Feb 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbLYiSfr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5E1F2369
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049494; cv=none; b=YTItT1SWLyMHCgTWdLBt+6wx5Zn0aPbtKWLMV3jbVeLEQAEKNEeqeEwa6O+BXQbXWJ+ZoNN7Iozq9aaTUYwcKY6zFS0ocxG5U+5GVSevwVkb+aH7KjsOLe1xXbQVRLsflhp0hr4ALdtg1E1vsAxuav0XzfqQrwC3jfVmDT2icoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049494; c=relaxed/simple;
	bh=XxZo2AnDSw5lV1zznAhDaeSUgPufzogr8jT0/2qq8Mo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnuZ/Of9uYWCBuFY2BBso4LslMsLQWIbGz7/PSynUmzWpdcghuQ/BpDVR43CXGyU2IPRlpVbfENUiA6fKLe25Dco4iEZdsCaWc7u9v6sJmU+K/OdI7gcEOI1kCNSjmvMwqO52o2zIMBtRy/S/aQJyxqDpYgabINafjnvAsQCM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbLYiSfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37781C4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049493;
	bh=XxZo2AnDSw5lV1zznAhDaeSUgPufzogr8jT0/2qq8Mo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QbLYiSfr2qfZnmpmT9ooMQrrNbrbDCBeWFra1H06DAltLuGy4O7Qn35c62FWQY4lP
	 Alr5yOEavKDfQmLk8BnHfQBJzRavHMclDqIRDYwkiIqTOvdZB0MM66YXbTXa7GMXF3
	 /PbBsqa4UmVwcB2Pdtsp1reJXK+2AQbFtlfe+elMy8z0HQNp7wXl+0DEdZhUP389pq
	 jVtMvasjdnfdwi50KUDH9bjN4VmkxR1UrHNIs0bQvfhA95n4XrEMgT04QNkhRQVFJF
	 bb/GerPz7p71I/B4A6OpA1YQHNIv2XyJ3pd3g8/1Ji1fcTvY25kxRiq/8x4NUWce/h
	 8B+0YltISCj1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/30] btrfs: send: implement fs_path_add_path() using fs_path_add()
Date: Thu, 20 Feb 2025 11:04:19 +0000
Message-Id: <ff39cbb59348ce36b4fe6fe32d3696f17f0e0920.1740049233.git.fdmanana@suse.com>
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



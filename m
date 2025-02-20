Return-Path: <linux-btrfs+bounces-11640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F403DA3D7AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F90B189EE6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46221F193C;
	Thu, 20 Feb 2025 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTnMJn81"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF51D2F53
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049493; cv=none; b=mBPncU5S14FjczLmhmNjlEpTJXKyKEfOiNHgHpl1cVeqY91u+7+e9HOAxuzE4ha89qGTiGO4OfmoVxh+0rdrvhcrHspqXQio9SSzhUB7d4ltr7W4XB2fxVPS3irxtO2R4NgpeCwTQHAuF7+Ce3wk/N/s4ZTWDxoDBz6pEWAxieU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049493; c=relaxed/simple;
	bh=nLZMehNoN9F5I0XHcpAhnK5JTMMzu8dFugV0exoQdf0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/s9Ol88JhcTjnHT1rj4OLeJ1+NsGZHbamEk/ju7/NH+ei2IlyO6+1AtAnTrjA7suSjIwkrWiEbcvPU+wkZaSNgUmxDYynLTNnYfkGtgtsXnGAjgLM+HuR8gxB12r/QOa3RgTBw3ii3eyU9NX67S8kMh/wIcMUM8miAoiSDueVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTnMJn81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E18C4CED1
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049492;
	bh=nLZMehNoN9F5I0XHcpAhnK5JTMMzu8dFugV0exoQdf0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tTnMJn81DzZJcXXLkpEprckPJiH/7580Fz+QcbUpSzYtZHx2vRehIvBUx7L9NYqOe
	 WiBzOPCKjkqAwusNLg/98ptp6kJ9VOei0iT9Nkz8JG54oXnaSiNDQbi/q5zXea+hiJ
	 IZIdB3VlRprchkrLtbmIFSoboVXuRI1yNj0xvQJ9/mVz6Qdt+0jsMJmnBKZpQe5CXM
	 LpuUQARSNsDKjCgCtDPYQHx7ECwvD4Hc89CRlgK4ekwibd0m5WNaTMTIm7kJeC614O
	 hZyBjgFVpX9rX/7O8PNBlN69sJZapWW4dtCTwCQPh57GzGNgacFf8YuufmguyqBn/O
	 eiTj0/Y46KlNg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/30] btrfs: send: simplify return logic from fs_path_add()
Date: Thu, 20 Feb 2025 11:04:18 +0000
Message-Id: <301aafddc69b21853a1b95038cafcb37f9b11588.1740049233.git.fdmanana@suse.com>
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

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 535384028cb8..2203745569e0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -560,11 +560,10 @@ static int fs_path_add(struct fs_path *p, const char *name, int name_len)
 
 	ret = fs_path_prepare_for_add(p, name_len, &prepared);
 	if (ret < 0)
-		goto out;
+		return ret;
 	memcpy(prepared, name, name_len);
 
-out:
-	return ret;
+	return 0;
 }
 
 static int fs_path_add_path(struct fs_path *p, struct fs_path *p2)
-- 
2.45.2



Return-Path: <linux-btrfs+bounces-11591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFA5A3BD53
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B899F1735BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BE1EF082;
	Wed, 19 Feb 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT8w3d5I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A861E0E14
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965438; cv=none; b=cAbARD+sM1XH4+oz82t/uDVn6eo6F4QWHpCxdlRj050IdOIV2XdYwSkEdK3m116dQirT4NEuUyfc4xoUYmvkJ3Mv+UtFq4wrFeiG2QIITh//CjvXv2k+jho/75mp1G/AOwB/SmvH+ld/ZkzexsHlldopso28uDslGa37dcVxqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965438; c=relaxed/simple;
	bh=K8Ukr01cAjFbIg5qr8bYihKjLwaKbXAP5/76TP5tZCE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arlTenW1rW92Xhpso1ZuVwzjeOEEmwN+iUQ2kRjSrTJB9zAjtlt8kWwCd9lcUmJ2eiZxQpuN7jM4t6g/6UG8uXgdN9okrmUMsgkKUdHkp/tbnRI7mERTVtBPniuhgbusE1F7FlHwfhW11/cKmkZwDJaB7XzN8Zz8+YMGIEZ7Bdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT8w3d5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB9CC4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965436;
	bh=K8Ukr01cAjFbIg5qr8bYihKjLwaKbXAP5/76TP5tZCE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OT8w3d5I6SqtgsWF0uh2vxBrxwqgnQyDxhtgXj3NiYRnryz4T1kx4NdzA5lZdFcuM
	 BhpKDd55GXZ/dH5oE4EWDbrhJ+K0XlZk39zWxNGF/jINx3bTmHA79NK8JNVQqbWdNP
	 UBNXhWlJ/d8CKEUJQU5CblSM9KM1OeYmOZV+qcS7vmwz2QBseM97xqLOUmQYdAmCFg
	 KdcVKpJzCJp3JSYHu0H7qTYi6IDv/WWDq8ziJGbQ3RSqFYdN2s9MibRbkqvC1kHxzP
	 80sIRibpDKcZsBzFza8nN8DRl6D6wSY+ZcHzJ8KHIXZZia4T8b5frYmtnwUR5w+wgr
	 Ya9aWfXgBL1TA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 26/26] btrfs: send: simplify return logic from send_set_xattr()
Date: Wed, 19 Feb 2025 11:43:26 +0000
Message-Id: <4638c8874946aca59742d03715284a3358656b77.1739965104.git.fdmanana@suse.com>
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

There's no longer any need for the 'out' label as there are no resources
to cleanup anymore in case of an error and we can directly return if
begin_cmd() fails.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 77cedde3b57b..644172f1cdb0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4921,7 +4921,7 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_SET_XATTR);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
 	TLV_PUT_STRING(sctx, BTRFS_SEND_A_XATTR_NAME, name, name_len);
@@ -4930,7 +4930,6 @@ static int send_set_xattr(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2



Return-Path: <linux-btrfs+bounces-11665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32302A3D7CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95DF19C1485
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9211F560E;
	Thu, 20 Feb 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iah3g9ne"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C81F55F5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049518; cv=none; b=jswWJI3DnefWDILzwE9+YnJrS8lutHVtTjRHQhATpTorKsmNb22HhVwU5iBs8EstHTsIwudvOFgHQxB6v3TWtF4DkJ12UvcBkQsdcNzDkqiCBJpuE2dv5BM0Bc3u2e9bt6njBO6iLHa9HRQsMnq0IDcZ7WpmFLyvCQa1meICqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049518; c=relaxed/simple;
	bh=sND5AadJivekOGKz9y//4pBxSPGXLqgKjxggF0TcMLE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TVnKSabfaXElEFCadMkxZjlDWzDH9XqExpygS6U3Ii0RO/O0e+9/W2buA2APwwefmX2FUZX72m/BrsonWPbStFv9d4dV8bT7qsFayjU6YJjtTTv79v7M2Y7uzi12tncCXOgbINA78GwUI+YZbDQ7gWUvMFjFl5iT8l48h9hB9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iah3g9ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61A3C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049518;
	bh=sND5AadJivekOGKz9y//4pBxSPGXLqgKjxggF0TcMLE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Iah3g9ne3osEBScFQR+tWLT355UiFHRVM3qo2s5HzQqAbYw/xtFHbrRXEi8RuFjEi
	 cd4VC5Nlq4S8rIYkEX6jBGro4lwtgYvrO894xHrOgiBPR+Nej14bo48ZwJDWte/w+D
	 3CnYPyCCJTKEajUe2OC1Ho2/sy8qJu3UAo2mcAlRJn/I9cKL6ugYsfrku2NRF5RshH
	 4/qF81WSugGUIkTHmmNWKDoeAL3CoQMY5LorGpy8NlncyUzbzq7kkZIYPPVCUsOIwi
	 UDqbAjSgJh9FPW5yCls3VS48iFXpP1qPJn9Ln82i2cjgT/36HufTE0jqzVILjhuxZy
	 UrSqS+MlmAhcQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 30/30] btrfs: send: simplify return logic from send_set_xattr()
Date: Thu, 20 Feb 2025 11:04:43 +0000
Message-Id: <65f564543c176d884b248646b64cfaf08fb0ca0f.1740049233.git.fdmanana@suse.com>
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

There's no longer any need for the 'out' label as there are no resources
to cleanup anymore in case of an error and we can directly return if
begin_cmd() fails.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2c1259068b76..878b32331bc2 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4917,7 +4917,7 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_SET_XATTR);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
 	TLV_PUT_STRING(sctx, BTRFS_SEND_A_XATTR_NAME, name, name_len);
@@ -4926,7 +4926,6 @@ static int send_set_xattr(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2



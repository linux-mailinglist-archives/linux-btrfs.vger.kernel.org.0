Return-Path: <linux-btrfs+bounces-13873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF4AB30C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F99D3A4341
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5029C2566E8;
	Mon, 12 May 2025 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eElxAcpe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270F42A9D
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036118; cv=none; b=IpEfBhLlKGhkM5GZLXwEMtysaNqLwdehW7bfZ0ahfnlD/i1aOJoI5everehydUY09Y+ClZ0kzC6nKbg/GbiGpXMZWtknkz5/Y3ty3Gg5c2P+LByEwaWLbL7LhIqhSsXjPJgFGcViXCVb6AwEW5oYFaLNJxiTrbUo0Zq1n8sr9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036118; c=relaxed/simple;
	bh=+qA3sMLuyaldYnM6JoY4SJOUNNExQJ964eiwbeR6ePw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Fv3gBRJAlfeRMtZflCm79q+5ToSrl1R+1rADyQMLgYev0Qo+JjOoosjSB4Fq4uSAjvOuh2DpIRBfXF9qPVZbIAleDusds4hJWmqAnJCosArHv04aluFUStnPgR2jNpOz4LoXKcEg4pcJPbTHzlmARza0KrchCR15RSStN5KCQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eElxAcpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86133C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747036118;
	bh=+qA3sMLuyaldYnM6JoY4SJOUNNExQJ964eiwbeR6ePw=;
	h=From:To:Subject:Date:From;
	b=eElxAcpep1ibY8pxjXK2n4QeRP0ebCzAgQ7nys5d3UR/2dqQImX51k0Fs/WQ/GP9t
	 42PJuBaNSGWcEe7u+wSczZEYtGRzejrt8HlRQ8h0+VpvyIXjzoq9JAPfujlxKUB6nc
	 BvlMEvmgX47qJBlAI6MS7bf6sirPUhm6e0A1/XrlD8ow3efthI2Hx+YsaokTYzXryQ
	 TnsVtajlAazD9ZZMjDFLElZWE+kjMPZbHOKevXgWqTTBwGmBxAxb4sjjsta9zojBIG
	 kqkS+W8QIVYuv3VYpM7Y99ID9tOJfNsEXGUgMeX/P6MT0peoQ7YXtuwwuxLoKVdFLV
	 059wqcBVSJWbg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: log error codes during failures when writing super blocks
Date: Mon, 12 May 2025 08:48:35 +0100
Message-Id: <bb1c6b0212c4e60ef4a6b08be741f1c50ace6afb.1747035917.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When writing super blocks, at write_dev_supers(), we log an error message
when we get some error but we don't show which error we got and we have
that information. So enchance the error messages with the error codes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5bcf11246ba6..1beb9458f622 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3752,8 +3752,8 @@ static int write_dev_supers(struct btrfs_device *device,
 			continue;
 		} else if (ret < 0) {
 			btrfs_err(device->fs_info,
-				"couldn't get super block location for mirror %d",
-				i);
+			  "couldn't get super block location for mirror %d error %d",
+			  i, ret);
 			atomic_inc(&device->sb_write_errors);
 			continue;
 		}
@@ -3772,8 +3772,8 @@ static int write_dev_supers(struct btrfs_device *device,
 					    GFP_NOFS);
 		if (IS_ERR(folio)) {
 			btrfs_err(device->fs_info,
-			    "couldn't get super block page for bytenr %llu",
-			    bytenr);
+			  "couldn't get super block page for bytenr %llu error %ld",
+			  bytenr, PTR_ERR(folio));
 			atomic_inc(&device->sb_write_errors);
 			continue;
 		}
-- 
2.47.2



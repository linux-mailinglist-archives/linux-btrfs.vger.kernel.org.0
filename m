Return-Path: <linux-btrfs+bounces-11588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34356A3BD56
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B6C189C464
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172961E0E16;
	Wed, 19 Feb 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2yTnNZT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9C1E0E0A
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965434; cv=none; b=oHc4AvxudOfFJ6mTdXSRadVZGTczN7dcvzkrSCN8dJcLp2vkvIJCL7vGIZZf88MaqZsdjBalxni4gNX7ht6dMpAq4ZBN20XIBpG6d6eT1kCpAB9Q1s8kmct8S++dUO6p3qY85pDRA7uAHtKRO3gEQKvdpmAK3V5EOsGos/0kD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965434; c=relaxed/simple;
	bh=Z0gnj+j7I6tesK3fs5Y4sZ2G4+laz1ers4iiF43Kdgs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBaxfpE/ZBoNeNHOyigwnox21Q2WWFZi4YEUn0p+K7OstWBwLXLvEV6jrh+T26GKiaCOTD79RJPxKVcxcjVvhABM5PH2IiEAjlwB+E5Yg6kF9knt1S/YH86crGzWu6NOKh7d3B9jws+NrZUgS2kkHPYogRO5NL+b0ZDMpmnpUtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2yTnNZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE82C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965433;
	bh=Z0gnj+j7I6tesK3fs5Y4sZ2G4+laz1ers4iiF43Kdgs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=m2yTnNZTJFfqb1Dt0oplMg8xMU2A0qeir++lEfN2Z8NKp4xCubfOyZPAvQr3gbzqy
	 KNmCnbaiRUA6L+8Wmzofuy+E3BaTht79gqZCg5nyHIwA/9MXHe+4xthBBLAyvujrtj
	 8XcvtcfiyD4eGt3eiFlu7u1+hURmItA3pPBGDZ5XcLfFgMMCxZk0WMkzzGRUEa9byr
	 gom/gAFy9YOzE73zTdc06DzNNpuIJcN1aDoLdnuf78lODkHA805gRh8tSiuAa2IyDG
	 isft0r1Fflg1nKc44G/qVaWlhMn9e1CAvrWvCoUt4IXF7oWIcI3MI46kKho12YVfS9
	 fRIyWt/quE4dg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 23/26] btrfs: send: simplify return logic from send_verity()
Date: Wed, 19 Feb 2025 11:43:23 +0000
Message-Id: <231e2cd5b7ff30e91c66cc72efd4d4564ed0deff.1739965104.git.fdmanana@suse.com>
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

There's no need for the 'out' label as there are no resources to cleanup
in case of an error and we can directly return if begin_cmd() fails.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0cbc8b5b6fab..f161e6a695bd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5122,7 +5122,7 @@ static int send_verity(struct send_ctx *sctx, struct fs_path *path,
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_ENABLE_VERITY);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
 	TLV_PUT_U8(sctx, BTRFS_SEND_A_VERITY_ALGORITHM,
@@ -5137,7 +5137,6 @@ static int send_verity(struct send_ctx *sctx, struct fs_path *path,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2



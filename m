Return-Path: <linux-btrfs+bounces-16670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF580B45D9F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20321C8002B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B611B313293;
	Fri,  5 Sep 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx4lgSo2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669231328F
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088664; cv=none; b=fIPYG2FtjHPM6jboxB1qztG1IEH1sEttIB8VXM+2KxIgsgZW/z/EEF3GcseVFEtjKr1+yAu/WF6p2oaMmaYE6bIH8CQI5tfpjvparqKGsbtpRRmdBDodejtdeJM4/EyKfihmf4qITJsU4URkPsiaP5EVXTDGt3/k0cnsCycrmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088664; c=relaxed/simple;
	bh=tnYCp+jRLMPNsndbM/JcbUGZozD0jPRW0HhKEJL7f98=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIWq131jSmaR9EWAVblXpNvwU90kPSmeX2mluB8Iao6fnJ6mvNovU7G6eEQKXysqkNruFDK3LVfYybrhnyHzoPnFIsRbKuwMF3I9B224zpZTkwbMellh+MY0/JGjROguhzvlP8q3fGu8uGJGxoV9jgDCaY0yUv4y3jT0OUGUqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx4lgSo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628EFC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088663;
	bh=tnYCp+jRLMPNsndbM/JcbUGZozD0jPRW0HhKEJL7f98=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Gx4lgSo2G7YlwsItKHOz2K4pcqJpLTVUzWgYRKQ2Cg9c1dCfrZNGDEqG153jeISNM
	 z3VuBRZMnvEpzRZcg/cjZPMQ6ZZY3VLOmv2DWcr4GAZG1mPtYMGRktgHA6Yx/TH8TU
	 /8Na3s9/5KMM86xhd0/CLUuiQsXURAq57MW4XXNdmvwx+jDPUx9aoqZSFNo3epDH49
	 4hY8rbH10+MxFXrmoWoaZqHdd/sgGkCuT7oRyJK1nU1ivPRDTgCVvpssthl+ujrcIM
	 E2TAkENyA6XdClguxH+47g6+WCU+K9XZRyyfgKxOW20vL7aAgqbgDM90z0kU6IHAP3
	 v8oyJykhEgZNQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 26/33] btrfs: remove redundant path release when processing dentry during log replay
Date: Fri,  5 Sep 2025 17:10:14 +0100
Message-ID: <4eab0109fbde5be726e571f9244adc2b9f21b31f.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At replay_one_one() we have a redundant btrfs_release_path() just before
calling insert_one_name(), as some lines above we have already released
the path with another btrfs_release_path() call. So remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index de1f1c024dc0..65b8858e82d1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2079,7 +2079,6 @@ static noinline int replay_one_name(struct walk_control *wc,
 		update_size = false;
 		goto out;
 	}
-	btrfs_release_path(path);
 	ret = insert_one_name(trans, root, wc->log_key.objectid, wc->log_key.offset,
 			      &name, &log_key);
 	if (ret && ret != -ENOENT && ret != -EEXIST) {
-- 
2.47.2



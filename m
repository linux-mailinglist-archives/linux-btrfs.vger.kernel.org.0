Return-Path: <linux-btrfs+bounces-16721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1D7B4892D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F4E17446A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A52FCC1A;
	Mon,  8 Sep 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7r/SahT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9E2FCBE1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325235; cv=none; b=sEf4TjXXCqaU0AxSCHTrFOz+kKApCT+kLaNy9aQ3Aan38iMV6uOEPL2Ho2FOlSqM26Lbq6E/k3cx7q5F7lDgOX6bcOr2kWhznYyTXHyC0m50lqNhBJcLziTA2mosfEMYDJBMa1LO2Iwbef2cUCemtqg/brHJfKV+YkZixWH9PYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325235; c=relaxed/simple;
	bh=tnYCp+jRLMPNsndbM/JcbUGZozD0jPRW0HhKEJL7f98=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH09LrDPWAzNt4Arpa9r1Zcx6JPcLOKSvVdTkmA1GjR7MIf/OPQtn3C6Qq8B+eQJwVODVNpMNhhkE1HOieOCet4AdCSeUSP7EKQGuYkqcjWo4mBmxHwOtBlz5mx4jdLiIKMZLYknAgE/BISS/XqCy3XLBTqLvpFwV8KuLDD5ARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7r/SahT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F63C4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325235;
	bh=tnYCp+jRLMPNsndbM/JcbUGZozD0jPRW0HhKEJL7f98=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X7r/SahTTMcMUChHYq3O2i22aNiChFLFO9tKUK2gY68A1DHY+JDounUzLRqhKpW8F
	 F+v8soHQOqmh7FytrC9N6SQGLz38wZppYTUOzkw/jWcgDbkkqP5SydiFCVLHDfuoGC
	 9sKrW/d3cCpVb3IQ01r9jZywAUOxm4G2jrec8Rt2afJeElqShPOGtmt+EPnKmAM6eI
	 n9YA1Umbvx4KBduYVI+pAh/HBppqWLysrdxh7sD3JIGwJ7MTb0jUun7UzZjCDkB4c7
	 D9c+682V67dXx5lQMinoiWIer1ZcIulQCDh2RGdSDqIqiOtHl8vDHDpQZ7S1GiWqQz
	 Yj0Im6V/63DHQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 26/33] btrfs: remove redundant path release when processing dentry during log replay
Date: Mon,  8 Sep 2025 10:53:20 +0100
Message-ID: <fc8841712e23318acf2ac910a9d62011f6795a4c.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
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



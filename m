Return-Path: <linux-btrfs+bounces-16663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34127B45D99
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A4517B2C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E230B53B;
	Fri,  5 Sep 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS400kVQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968C30B53C
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088656; cv=none; b=Dg5tnSOMpc356AAkHCgIK2QeZ8aBccTiNgenApeYb+j3U3ecx7w5KVK6koRKsUDrbVPbhNu6aPOkRt1IFSS1AHFLQnq/t7Fx6u4A2f3i9hzBAwomQYvmpPVHHgnM4LfsqJBHRlvYeZFkiJa4PJwMFR+7d1FkjpVqgv0m8bjw6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088656; c=relaxed/simple;
	bh=sYpvCKrKoxGNpjk258JD7pDCRDxYRfo/svgu1+OJIm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FymxQbZREJtyluDRIZpTTBgCEK+wlZxcUyX8XvKuDtfsADq/U6Lo6ZnqrGCdHJJOO6TXgsVS9g9/76XH9P+DGk716BP60sT/hV8rTfId/oQI4FfZPsg2RoA5f5TJ73Xnwoz4Ea84REFBl4Bm3oeCMLNgMxLAGe3jLL6j9lygO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS400kVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ED3C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088656;
	bh=sYpvCKrKoxGNpjk258JD7pDCRDxYRfo/svgu1+OJIm8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eS400kVQmPwkszwk15NfdnTOJ0fnqgtPQMAnxa6nyg7Bk079Eiqrjc1Fj8BqKIKdj
	 4cKcQBOiKxb9i+yT4Tyi3+7bvSTJumeb2Yaqm3KhQuvbcDcEukSzlkmMtV8qlx8Og3
	 Wlo8b4N+UB3OGTGz1khC98IYOpX7L6fqxUWffS9lqro1bZ7Hko/HFerm6A4HnzjI7Y
	 F2IEMcY5+BOhy0hg9ZwqChEDYq0oTT9VUDbyYs1ylvIS9z+1VbLuuUJ5qSXuPd5Sml
	 qGTuVD+WS+ik08dxuiVEeiR8vufeFfWr/HCQUlsb5AJpNMONZs3XAMzAs4JdBFi0cW
	 woxI066mWY8tg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 19/33] btrfs: use level argument in log tree walk callback process_one_buffer()
Date: Fri,  5 Sep 2025 17:10:07 +0100
Message-ID: <c395543772dcd0060350cc1c40eb56b6c3269eba.1757075118.git.fdmanana@suse.com>
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

We already have the extent buffer's level in an argument, there's no need
to call btrfs_header_level(). So use the level argument and make the code
shorter.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2060f0d99f6e..166ceb003a1e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -386,8 +386,7 @@ static int process_one_buffer(struct extent_buffer *eb,
 			return ret;
 		}
 
-		if (btrfs_buffer_uptodate(eb, gen, false) &&
-		    btrfs_header_level(eb) == 0) {
+		if (btrfs_buffer_uptodate(eb, gen, false) && level == 0) {
 			ret = btrfs_exclude_logged_extents(eb);
 			if (ret)
 				btrfs_abort_transaction(trans, ret);
-- 
2.47.2



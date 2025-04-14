Return-Path: <linux-btrfs+bounces-12982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8252BA8797B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7F2188E5D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 07:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381FF2580F9;
	Mon, 14 Apr 2025 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="FyTQ36Wy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD531684AE
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744617242; cv=none; b=fNQvcEgRsZ77yVaLTV1F8z/ZuHth4qwSsVqs0M18IEdTJlpQLDCo/NenfAIi91WNfwVUOcQrC7WWXUrlEj1rvUzuJtVLfsgTxllpck5PnBzfMq9MT/mPm7rQsS5arW3NsdpNLRJaIAJwNDw9/HGraDxlmru3IqmlsXbmbGCALW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744617242; c=relaxed/simple;
	bh=gI03sqIqT7+VvfK4eW3qNLvontYhbWQFU1+hGu8cek4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lU3X3cqXDG2WqP3OJRUjExRxd2q0iqg+G0wotpSsAFO+MJdxIyVZBHmhYh2UQCTEcQFgF3Xl4R68UYNfOAcY47+hSHn7Rw5tQCYvDJAREGNNJXCjthfL+Qdsou6R+52vDqCoiNID1Ann6jtOvu+gHHbzWqFAkBJYuEijXVxB9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=FyTQ36Wy; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from 11212-DT-014.. (unknown [10.17.40.185])
	by mail.synology.com (Postfix) with ESMTPA id 4ZbfW26PWQz9lqp8r;
	Mon, 14 Apr 2025 15:46:38 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1744616799; bh=gI03sqIqT7+VvfK4eW3qNLvontYhbWQFU1+hGu8cek4=;
	h=From:To:Cc:Subject:Date;
	b=FyTQ36Wy5/lYD8UErmeNxfUFsSMjoUF3HrzfHyAFLfBfvOr3v+4BpnsIHrGn7BO7w
	 RZ67RzupHheU9lf8MgiG7mWmNWMw4MQNl9CzKrcf6btUy1boSLRbfCiFqiKok3vOGi
	 qNrfIqhi8ljn03MW25SkhkWDR1r4uQjuBHi0yvjM=
From: davechen <davechen@synology.com>
To: linux-btrfs@vger.kernel.org,
	dsterba@suse.com
Cc: cccheng@synology.com,
	robbieko@synology.com,
	davechen@synology.com
Subject: [PATCH] btrfs: fix COW handling in run_delalloc_nocow function
Date: Mon, 14 Apr 2025 15:46:10 +0800
Message-ID: <20250414074610.2475801-1-davechen@synology.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no

In run_delalloc_nocow(), when the found btrfs_key's offset > cur_offset,
it indicates a gap between he current processing region and
the next file extent. The original code would directly jump to
the "must_cow" label, which implicitly increments the slot and
forces a fallback to COW. This behavior might skip an extent item and
result in an overestimated COW fallback range.

This patch modifies the logic so that when a gap is detected:
  - If no COW range is already being recorded (cow_start is unset),
    cow_start is set to cur_offset.
  - cur_offset is then advanced to the beginning of the next
    extent (extent_end).
  - Instead of jumping to "must_cow", control flows directly to
    "next_slot" so that the same extent item can be reexamined properly.

The change ensures that we accurately account for the extent gap and
avoid accidentally extending the range that needs to fallback to COW.

Signed-off-by: Dave Chen <davechen@synology.com>
---
 fs/btrfs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b842276573e..58457bdf984d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2160,7 +2160,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (found_key.offset > cur_offset) {
 			extent_end = found_key.offset;
 			extent_type = 0;
-			goto must_cow;
+			if (cow_start == (u64)-1)
+				cow_start = cur_offset;
+			cur_offset = extent_end;
+			goto next_slot;
 		}
 
 		/*
-- 
2.43.0



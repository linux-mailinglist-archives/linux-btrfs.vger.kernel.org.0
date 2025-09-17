Return-Path: <linux-btrfs+bounces-16882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94054B7E08F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47B2582AA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 07:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FB305943;
	Wed, 17 Sep 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amYjLbhw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181DB2F261F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095569; cv=none; b=nWvVRXcA7w93wnBOZFIIJLYnezHHY/7ZgrqbifY2uUqHOPgrb0fx6dXVz+kcdBfgELpU3wpHT9cMdKU/kM4a6UHGjZKFCemW+SA2DRehoyg+rpKBhxXBpv/5R4cH1CbQkxU30ignot/upzqX7hjsBihiulVyIw3G8e8KkjGst1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095569; c=relaxed/simple;
	bh=W9issCwWO/yKal49xYMUylYAqXFhiNzQbBRXKvcajbA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IClq1F/NryM72hQtdHmmaA04FAGqOIxrX4lv9EJhs6jOSZWNBOppZ14tOi0Wdh0u5dp8HnhO8xXGJCL6kD2pqUb7bpmQHYq/BDEC9cCnLMaZDNeN6kSGa6Xy6n/KzRjDaD+Oj/PFSHbKTfL25EHKpste3OTZHT0LztEHdnS9nqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amYjLbhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87CC4CEF0
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095568;
	bh=W9issCwWO/yKal49xYMUylYAqXFhiNzQbBRXKvcajbA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=amYjLbhwldJFryeyhyJNkeyvSoQfGKOcM+cEJCvGJkvklcKturIotOJHymSQ9Aezp
	 JonsWfHQVaMsdN/hYqqOLtjPxMhfEOvuPrrsoD/5QnOhpQcgTjw0+Qdx03Vks28hT8
	 4RzOMF0W/orJaTQyigI0c8/jG7n2fYnVcpgtlM3CO+iuZdVmokT0wmvzP2IMro6V7x
	 awSIhtvgwfZli+VpZvwFGli+k/S2avXU5wSmPoBg6gi26dEabGjwJq1E8NZYY+IeBG
	 Jg5a7PhfeRbfoYYoz+el1ey/wKBdWjll8sLYxduvjHqqS0f8o48xiQTonRa1+WarEq
	 jQpuZ2rmP4QnA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: mark as unlikely not uptodate check in read_extent_buffer_pages()
Date: Wed, 17 Sep 2025 08:52:40 +0100
Message-ID: <dca869284d4c4b988dae707b2003c6f3c48d6343.1758095164.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758095164.git.fdmanana@suse.com>
References: <cover.1758095164.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After we waited for the bios that read an extent buffer's extent from
disk, we expect to have the extent buffer up to date (no errors happened),
so mark the check for not being up to date as unlikely and allow the
compiler to potentially generate better code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f0cce1bb7c6..704fd922c18b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3868,7 +3868,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 		return ret;
 
 	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_READING, TASK_UNINTERRUPTIBLE);
-	if (!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
+	if (unlikely(!test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags)))
 		return -EIO;
 	return 0;
 }
-- 
2.47.2



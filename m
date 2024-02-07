Return-Path: <linux-btrfs+bounces-2192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F884C2CF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 03:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C6B2BB45
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7715E88;
	Wed,  7 Feb 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pDiUiKyH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3210957
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274602; cv=none; b=MD7kp3cNSYfCzLTAX3f/c5s9Lws2k4h1y6DP5lg9+gPNCCvZw78gZbfjht1cBZDn0LRQeGg2dJXRNrGwz8IYlvaXEm8hpCqywIR+Q6oDy7IweKuS1aYYLTQaKYvfjmFlOikm2PKU5ATZLKqInx14W8JpM+dOUj0QWnhz/jjsSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274602; c=relaxed/simple;
	bh=BmbZGsFxwakjn0IikUsjUWm3IXpJHfHD1/as7Xt9Pcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=makL9wQGplNLi+/vmnvTZ7fJhcnWhmJEbCKKMYZMDZbr7yxnIshFVVvd4Kn7XC7zQenC6p14iHj8VSpMzs7KxYejneh+84CZcSXq3Mq0w0GLnaHxjnHm8VF2tX5wbIBTwBsWZv80sJXjOlvHPYprV7NLOJ1XViEyH2lm+TTu/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pDiUiKyH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707274599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORZ3NxtyAsFtX+LQqgBHca7yU+LThn04BGVHp9Ql3Xo=;
	b=pDiUiKyH50D8XHO58L3cgo3uvyZLrzm4X70Qti7QUxGR3rQNj/BuHQQlxIxmffy58IbNXt
	wFRIggEdJ7tQCBdrS5+ILsTVeyHHj9ZQgL4TtniPQF2uAYZqbaEisIJfHY8tGKE1L3x0qM
	Zl5AECde5V/jpDG7GPbX1+WKqDmiSjo=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/7] fat: Hook up sb->s_uuid
Date: Tue,  6 Feb 2024 21:56:18 -0500
Message-ID: <20240207025624.1019754-5-kent.overstreet@linux.dev>
In-Reply-To: <20240207025624.1019754-1-kent.overstreet@linux.dev>
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Now that we have a standard ioctl for querying the filesystem UUID,
initialize sb->s_uuid so that it works.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/fat/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 1fac3dabf130..5c813696d1ff 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1762,6 +1762,9 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	else /* fat 16 or 12 */
 		sbi->vol_id = bpb.fat16_vol_id;
 
+	__le32 vol_id_le = cpu_to_le32(sbi->vol_id);
+	super_set_uuid(sb, (void *) &vol_id_le, sizeof(vol_id_le));
+
 	sbi->dir_per_block = sb->s_blocksize / sizeof(struct msdos_dir_entry);
 	sbi->dir_per_block_bits = ffs(sbi->dir_per_block) - 1;
 
-- 
2.43.0



Return-Path: <linux-btrfs+bounces-2119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33B84A7A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 22:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CEB1C278DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDF912B147;
	Mon,  5 Feb 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uob/dDzx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CA129A9E
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163568; cv=none; b=FlG0eSFBZWCHMHHYTWrpGH5e1ok8RM5zftv8NHgn8YoPrVaiVREPgn8ehdngS9WvgUGBGVwjOgUKt6l8DqR3cPZJKHwaFa2XjEXYikbDMOzKpYg/neSZlq1R0AkiS5tLg8pbrnq04mm6dP6jWcGrXN/HKEI4XKOH/tus7P2z1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163568; c=relaxed/simple;
	bh=sT0YhdGMz+E9RZmaN5yZSWMd1g+aYCrhSj7fqmLAo7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iojZrQAi08dpdEkl+Iau1yW5TSwjo7Pp1GOhe//l2BFPdMLj4NrYQE7XXZ7sEfaHQqvLOzp1n8JybIeAmeqFpTPZyBwIIY3AeoxQBUY4wUfm8IjYYFOHqYppIfq2Y+KnG2Xj76VtCVyQSzrfhzi+EpE2P7xtYOjR0a9qSFOWvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uob/dDzx; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707163564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxk7XRZEL0snESkDWwhfb1zBoSWiW2T8Lz3o6KIMn8M=;
	b=uob/dDzxQcIREDsMEM9g/iWBuz0YPHzPTzop+cY2f31oBhFBJpCrXqtQ7KCYfdmuorHek/
	3BdFAyeJ8xmW3cVWSpJ8jwVBKqrGw114zEAqI1kXcx6EbAAY7oyS1MVSqTQRGZeWGiMh3T
	67MIwynAHlE/7CcJzvVvZxLHj5EuROc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/6] fs: super_block->s_uuid_len
Date: Mon,  5 Feb 2024 15:05:12 -0500
Message-ID: <20240205200529.546646-2-kent.overstreet@linux.dev>
In-Reply-To: <20240205200529.546646-1-kent.overstreet@linux.dev>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Some weird old filesytems have UUID-like things that we wish to expose
as UUIDs, but are smaller; add a length field so that the new
FS_IOC_(GET|SET)UUID ioctls can handle them in generic code.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/super.c         | 1 +
 include/linux/fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index d35e85295489..ed688d2a58a7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -375,6 +375,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_gran = 1000000000;
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
+	s->s_uuid_len = sizeof(s->s_uuid);
 
 	s->s_shrink = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
 				     "sb-%s", type->name);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..ff41ea6c3a9c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1257,6 +1257,7 @@ struct super_block {
 
 	char			s_id[32];	/* Informational name */
 	uuid_t			s_uuid;		/* UUID */
+	u8			s_uuid_len;	/* Default 16, possibly smaller for weird filesystems */
 
 	unsigned int		s_max_links;
 
-- 
2.43.0



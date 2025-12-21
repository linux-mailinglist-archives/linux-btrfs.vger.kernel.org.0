Return-Path: <linux-btrfs+bounces-19939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113AFCD3AF2
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 04:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2790F3081098
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2712253B58;
	Sun, 21 Dec 2025 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXqTv8zu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480923EAB7
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285615; cv=none; b=uh43XiNPqOkg7upazqv9QiaDws81RyFAECIZmcEYEtYq3vlKi4x+4/k78szEXdGY6GWaDbBS/d/jAye0DA14/q2DfzF18WQSILtrGEee8NfVGTdCwDXdJWrJ+Su9Z33zHoM9UxK0V3S4xkBoD3DquYB0kDa3JxhyiXu4S+kcmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285615; c=relaxed/simple;
	bh=V7ilqadfBXQOTYr9StUYy6E9eJ9EgwDYxG/6noZg4xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+b4qU3ulGuMqfu0fCeFjqIZ8J/djYYq78hTn8ndmR5l/aUMFVdVvp75bf8UDvvoBLvLkNbyxzA4DI4pJ15gkIU/gyevIQzIWCOY/iz0h6Mj7niekHsMmkg88Z9z8coWXj7YMFzkKgNeqOvaVK51BpdhhF0lZr+MDuezQfiXzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXqTv8zu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1uXTIV/q9QWEKYFCtmTYr1p7eCMWcmzNVFUPfueUQ4=;
	b=JXqTv8zu/Qki4b4C1lFNqdDA3GnN9beFrnuQK4WUNE49WG1J67QpwVRXFpeKiw0HUcUV0A
	DlSy4kgr8YyWrda2b4xpstMtT1F7oo1AO96mT2RZz1PrH9MpR3Q7fS6RInTC+6LeTncG4z
	sQVMiqi6fty18yPhBdtzzXNdYqx5LQ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-lXnjKGRIMTuWIEywNbTQxw-1; Sat,
 20 Dec 2025 21:53:27 -0500
X-MC-Unique: lXnjKGRIMTuWIEywNbTQxw-1
X-Mimecast-MFC-AGG-ID: lXnjKGRIMTuWIEywNbTQxw_1766285606
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A2A41956088;
	Sun, 21 Dec 2025 02:53:26 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F94F180049F;
	Sun, 21 Dec 2025 02:53:22 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Satya Tangirala <satyat@google.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 13/17] xfs: use bio_set_status in xfs_zone_alloc_and_submit
Date: Sun, 21 Dec 2025 03:52:28 +0100
Message-ID: <20251221025233.87087-14-agruenba@redhat.com>
In-Reply-To: <20251221025233.87087-1-agruenba@redhat.com>
References: <20251221025233.87087-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

At label out_split_error in xfs_zone_alloc_and_submit(), IS_ERR(split)
is true, so bio_set_status() compiles down to a simple assignment.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/xfs/xfs_zone_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index bd6f3ef095cb..2b069cffac00 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -896,7 +896,7 @@ xfs_zone_alloc_and_submit(
 	return;
 
 out_split_error:
-	ioend->io_bio.bi_status = errno_to_blk_status(PTR_ERR(split));
+	bio_set_status(&ioend->io_bio, errno_to_blk_status(PTR_ERR(split)));
 	bio_endio(&ioend->io_bio);
 	return;
 
-- 
2.52.0



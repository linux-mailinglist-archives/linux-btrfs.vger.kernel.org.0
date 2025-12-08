Return-Path: <linux-btrfs+bounces-19563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DD9CAD0EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 13:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3034307C197
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 12:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4330102B;
	Mon,  8 Dec 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5DStzKN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AA2EBDE3
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765195840; cv=none; b=JwnCljnXgMMp1HTsFQVxdAuThL1WP/pvW9ZhYRRAhizfzv4S3dVF8HaytyBdOVkLdqag2cNbAgoLXQgm1SqzTum0Qq7yHoX2rKvOLL3zej7nBLdcJ7VKbhDdE4UlFJZ4kve2P/X8Lml4zHbncxDaR70zLrrDJaAXqPLkN1uF9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765195840; c=relaxed/simple;
	bh=9k1l5oP0yXJfVXtLxOCu5RYALmuhZB/zpoPE5QPpVGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8+xcO83llPmxgJCqoiFlNZZAg9vwZOKts8J+0qnWoneWuhjPSgeUWkAYPRU5rjov39exqKj+bDLrAiSpG6t7aYwQkMunVJDlMTAXZkZttjE6L3Ncigef8tcSawwSoDe/1c/0o3AzkZ9+7RsnjF39ik1qRedDex6jQiCn07I1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5DStzKN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765195837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8Q0v07JW9uSTBXNVPvB76vEIqMmpZ+G2A5HsI4ewQk=;
	b=U5DStzKNwL6tAP6caAjIp4hDM32K1dQSmj8beYd1yH26XupizmVAPEeqLcFfawrc207jsq
	5q+EOulk6Q1hkTzgMBE+a4ZosOPxm1ywMlCYtXs7QF6ynWqRldxsOECrCqkAnLKLqJEkSh
	eKaYr+ZDdRMcrfQfNgxBFa7/HqcjGpg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-kCi3znmHORW-rI5eE-cFgw-1; Mon,
 08 Dec 2025 07:10:32 -0500
X-MC-Unique: kCi3znmHORW-rI5eE-cFgw-1
X-Mimecast-MFC-AGG-ID: kCi3znmHORW-rI5eE-cFgw_1765195831
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A81971956080;
	Mon,  8 Dec 2025 12:10:30 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C8141956095;
	Mon,  8 Dec 2025 12:10:27 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC 01/12] bio: rename bio_chain arguments
Date: Mon,  8 Dec 2025 12:10:08 +0000
Message-ID: <20251208121020.1780402-2-agruenba@redhat.com>
In-Reply-To: <20251208121020.1780402-1-agruenba@redhat.com>
References: <20251208121020.1780402-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Use the same argument names in bio_chain() as in bio_chain_and_submit()
to be consistent.  Slightly improve the function description.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/bio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278..3f408e1ba13f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -327,22 +327,22 @@ static void bio_chain_endio(struct bio *bio)
 
 /**
  * bio_chain - chain bio completions
- * @bio: the target bio
- * @parent: the parent bio of @bio
+ * @prev: the bio to chain
+ * @new: the bio to chain to
  *
- * The caller won't have a bi_end_io called when @bio completes - instead,
- * @parent's bi_end_io won't be called until both @parent and @bio have
- * completed; the chained bio will also be freed when it completes.
+ * The caller won't have a bi_end_io called when @prev completes.  Instead,
+ * @new's bi_end_io will be called once both @new and @prev have completed.
+ * Like an unchained bio, @prev will be put when it completes.
  *
- * The caller must not set bi_private or bi_end_io in @bio.
+ * The caller must not set bi_private or bi_end_io in @prev.
  */
-void bio_chain(struct bio *bio, struct bio *parent)
+void bio_chain(struct bio *prev, struct bio *new)
 {
-	BUG_ON(bio->bi_private || bio->bi_end_io);
+	BUG_ON(prev->bi_private || prev->bi_end_io);
 
-	bio->bi_private = parent;
-	bio->bi_end_io	= bio_chain_endio;
-	bio_inc_remaining(parent);
+	prev->bi_private = new;
+	prev->bi_end_io	= bio_chain_endio;
+	bio_inc_remaining(new);
 }
 EXPORT_SYMBOL(bio_chain);
 
-- 
2.51.0



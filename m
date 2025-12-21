Return-Path: <linux-btrfs+bounces-19928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C576CD3A3A
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6134C30443DF
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 02:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F521773D;
	Sun, 21 Dec 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e02bTbYG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547E1F4C96
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285577; cv=none; b=GPQtTJ/VjJGYGR2xCzpNV9mqNtzCyYoQPw0vK+bFzCKnlR90lqAik4b5OhFWrIIpJeYtoI7xSFH09NmyYe2GwiR4TvI8Z9mlfDOfAtHcnFatMaG+FbGBKZZhp5gOTnnAFSJ8toADuxp7AunH3W3nPfHAdwDiVv5SVEwd5rlWfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285577; c=relaxed/simple;
	bh=s2FKoMxZd739dCzhmdB8JVLEUJx/RdFLnNDGdbuTA+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3tw1V47qyO/Tj6NFhM7tCfaa4HJ3O8T+3nshREFLjIEoX+2TP9ARkpHTo6TcGgIlF71XI18ChDfUpRzF4tcv5KYxEQ8xhGjSNZTr/bFUV3GWyWeo1ahoBrf9HssUtY8uN4QDwMP0K/aLD6roesRsmZmNA6/YimScojsI1OIkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e02bTbYG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z84twE+0dmUFQawUihISJPCYSTL4dhggfdILlETnyIY=;
	b=e02bTbYGxn4UQgboeLTOKs4g2kBFniySoJejldH3VvN6T8UQNJkTUBRtjsSGodbm9xrFIy
	Z49hm700SYn3p7hKvoBbBrXT6A/vi3njHHc1YFIis2N/BPBjGyr0/5SJEQ9aW9oFpFsq55
	O+A0KCvaZdKSykt0petML+nasCNOfdk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-iB9QqN7SOFaqUEEFzmQTgg-1; Sat,
 20 Dec 2025 21:52:49 -0500
X-MC-Unique: iB9QqN7SOFaqUEEFzmQTgg-1
X-Mimecast-MFC-AGG-ID: iB9QqN7SOFaqUEEFzmQTgg_1766285567
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 341301956088;
	Sun, 21 Dec 2025 02:52:47 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 863B8180049F;
	Sun, 21 Dec 2025 02:52:43 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [RFC v2 02/17] bio: rename bio_chain arguments
Date: Sun, 21 Dec 2025 03:52:17 +0100
Message-ID: <20251221025233.87087-3-agruenba@redhat.com>
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

Use the same argument names in bio_chain() as in bio_chain_and_submit()
to be consistent.  Slightly improve the function description.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
2.52.0



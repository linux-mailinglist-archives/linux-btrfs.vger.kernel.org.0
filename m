Return-Path: <linux-btrfs+bounces-19936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F4BCD3AB9
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 04:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BD523027D8B
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B99224AE0;
	Sun, 21 Dec 2025 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOe4SPB+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80857238D52
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285605; cv=none; b=CWk/zKEZGUf0DkccjHoHmRc3BTjwO0AUF50Dc8npYkzy/F76Yi6bgMGk+REm55B0nqAnCzgtoiZB1djAJFoJVQ7VibYBch3lWck5CYzNA5HaT9X9Lg7KOq0hcPykIr1g7h8egax/fQj77mXy5Rqmx0bGHnTFyMQ6AIjxM1Tmc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285605; c=relaxed/simple;
	bh=HIqf22Ptud/9ac/5C/HAWxjPJyK8tFALQWxnuDFT/3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRnSwBdz1U2EvaGFuNqLxbT3ydJ1ceKOHIGj5jhkI+WXh5Hcq1scUbVBTZQLfEvXEcPb25w295R1iZ9/Kx1owfEoQZpqvFNF/WmdbQiLZ95diU5HLKzV8j6EW8kUo69ajVYlwdxkPWCHmvTAH92igtT+gsbVAlRXjZRggTW7S6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOe4SPB+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lqEV0d5M/MjlyxOPZzQUlj9JHGomOy6Eck36K06ymo=;
	b=cOe4SPB+8XqLFCqIgc3jYjAbOAm+dduPRlelU/L/zu6FN6zQwqZDdIw+H6/WB4PvgFgvcW
	3ojvTtzJUSqr3MPVzWa9OlcyNI842FVj1oseFNKQOjPGcRlTYyoXikEtXRruAbllcekkaO
	GjCfpa+lOM66saJVA+n6gq/hOaMLXhw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-9DEeJGNpMOmGqmAAYZY70Q-1; Sat,
 20 Dec 2025 21:53:17 -0500
X-MC-Unique: 9DEeJGNpMOmGqmAAYZY70Q-1
X-Mimecast-MFC-AGG-ID: 9DEeJGNpMOmGqmAAYZY70Q_1766285596
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 010051956050;
	Sun, 21 Dec 2025 02:53:16 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEBD6180049F;
	Sun, 21 Dec 2025 02:53:12 +0000 (UTC)
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
Subject: [RFC v2 10/17] block: optimize blk_status <=> errno conversion
Date: Sun, 21 Dec 2025 03:52:25 +0100
Message-ID: <20251221025233.87087-11-agruenba@redhat.com>
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

Handle the errno_to_blk_status(0) case inline so that the compiler can
optimize when it knows that errno is not 0.  Likewise for
blk_status_to_errno(BLK_STATUS_OK).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-core.c       | 11 ++++++-----
 include/linux/blkdev.h | 18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9b3100d171b7..381bdf66045b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -133,7 +133,6 @@ inline const char *blk_op_str(enum req_op op)
 EXPORT_SYMBOL_GPL(blk_op_str);
 
 #define blk_errors(_)									\
-	_(BLK_STS_OK,			0,		"")				\
 	_(BLK_STS_NOTSUPP,		-EOPNOTSUPP,	"operation not supported")	\
 	_(BLK_STS_TIMEOUT,		-ETIMEDOUT,	"timeout")			\
 	_(BLK_STS_NOSPC,		-ENOSPC,	"critical space allocation")	\
@@ -159,7 +158,7 @@ EXPORT_SYMBOL_GPL(blk_op_str);
 											\
 	_(BLK_STS_INVAL,		-EINVAL,	"invalid")
 
-blk_status_t errno_to_blk_status(int errno)
+blk_status_t __errno_to_blk_status(int errno)
 {
 	switch(errno) {
 #define _(_status, _errno, _name)		\
@@ -171,9 +170,9 @@ blk_status_t errno_to_blk_status(int errno)
 		return BLK_STS_IOERR;
 	}
 }
-EXPORT_SYMBOL_GPL(errno_to_blk_status);
+EXPORT_SYMBOL_GPL(__errno_to_blk_status);
 
-int blk_status_to_errno(blk_status_t status)
+int __blk_status_to_errno(blk_status_t status)
 {
 	switch(status) {
 #define _(_status, _errno, _name)		\
@@ -185,11 +184,13 @@ int blk_status_to_errno(blk_status_t status)
 		return -EIO;
 	}
 }
-EXPORT_SYMBOL_GPL(blk_status_to_errno);
+EXPORT_SYMBOL_GPL(__blk_status_to_errno);
 
 const char *blk_status_to_str(blk_status_t status)
 {
 	switch(status) {
+	case BLK_STS_OK:
+		return "";
 #define _(_status, _errno, _name)		\
 	case _status:				\
 		return _name;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 70b671a9a7f7..a2451fbd53a8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1011,8 +1011,22 @@ extern void blk_sync_queue(struct request_queue *q);
 /* Helper to convert REQ_OP_XXX to its string format XXX */
 extern const char *blk_op_str(enum req_op op);
 
-int blk_status_to_errno(blk_status_t status);
-blk_status_t errno_to_blk_status(int errno);
+int __blk_status_to_errno(blk_status_t status);
+static inline int blk_status_to_errno(blk_status_t status)
+{
+	if (status == BLK_STS_OK)
+		return 0;
+	return __blk_status_to_errno(status);
+}
+
+blk_status_t __errno_to_blk_status(int errno);
+static inline blk_status_t errno_to_blk_status(int errno)
+{
+	if (errno == 0)
+		return BLK_STS_OK;
+	return __errno_to_blk_status(errno);
+}
+
 const char *blk_status_to_str(blk_status_t status);
 
 /* only poll the hardware once, don't continue until a completion was found */
-- 
2.52.0



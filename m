Return-Path: <linux-btrfs+bounces-19935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0ACD3AC8
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 04:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 470A0303FA44
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC890202963;
	Sun, 21 Dec 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3mMV4Am"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B622FDEA
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285602; cv=none; b=sr0wjahL5aV4+ReLs0Wao9UVOPUHOMR/0HFCNnWrFbGjVElaMNvMQ4QJD9udK6eWv3nZaG+CrcLQAmBxQG+5fmXXxYOEvYfCVpiIInosWjOZYdNjhDf6HZo7eLeCKpH7mgnCkvB1swmiyC3hhum2TBNul7F6DucXPBq1a9oZkqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285602; c=relaxed/simple;
	bh=2wmg7dBrcbW7RMcYYgZ9zCJ+cTkup82Bel/BMblKyRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mO0d5dzouA/llnGl/kGa05uhbWOTRBrIW5HN0vhxRV5fAWgLkGYv9VDkaPIdGrECAD4vQ829cjysCRdlUOkgdymp0S8NT1StE9K0LTzZQE79xFItl0oUemXo/+3FQg80sXc0fTXFgu03bBy3PrC1KmuV+Wr7hmEn0R4vvBeVn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3mMV4Am; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2avyz2OoJ/++uEdJ9fXNwDS5jcJ/iUxeG+6Kq9GellY=;
	b=f3mMV4AmsrO4NdSzdf4ab33X3X9y06szbzpuhjDSPDe+wqvvWvtodeA1bQ4+vBv69yzAvJ
	tCTohB1TT6kFiTeap3ciOln6bGhdjdYRQEFMgjPlmw/7LS9EdFtvVmV8B8K/sOS+zWRjAh
	my9JrTiszsXY9W/PiI9KxYMgFm2IqEs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-a_U1lg8OMOKwSjfjcbh59A-1; Sat,
 20 Dec 2025 21:53:14 -0500
X-MC-Unique: a_U1lg8OMOKwSjfjcbh59A-1
X-Mimecast-MFC-AGG-ID: a_U1lg8OMOKwSjfjcbh59A_1766285592
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8445819560A5;
	Sun, 21 Dec 2025 02:53:12 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9177D180049F;
	Sun, 21 Dec 2025 02:53:09 +0000 (UTC)
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
Subject: [RFC v2 09/17] block: turn blk_errors array into a macro
Date: Sun, 21 Dec 2025 03:52:24 +0100
Message-ID: <20251221025233.87087-10-agruenba@redhat.com>
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

Get rid of the static blk_errors array and replace it with a macro for
generating the appropriate switch statements in errno_to_blk_status(),
blk_status_to_errno(), and blk_status_to_str().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 block/blk-core.c | 97 ++++++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 47ce458b4f34..9b3100d171b7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -132,70 +132,77 @@ inline const char *blk_op_str(enum req_op op)
 }
 EXPORT_SYMBOL_GPL(blk_op_str);
 
-static const struct {
-	int		errno;
-	const char	*name;
-} blk_errors[] = {
-	[BLK_STS_OK]		= { 0,		"" },
-	[BLK_STS_NOTSUPP]	= { -EOPNOTSUPP, "operation not supported" },
-	[BLK_STS_TIMEOUT]	= { -ETIMEDOUT,	"timeout" },
-	[BLK_STS_NOSPC]		= { -ENOSPC,	"critical space allocation" },
-	[BLK_STS_TRANSPORT]	= { -ENOLINK,	"recoverable transport" },
-	[BLK_STS_TARGET]	= { -EREMOTEIO,	"critical target" },
-	[BLK_STS_RESV_CONFLICT]	= { -EBADE,	"reservation conflict" },
-	[BLK_STS_MEDIUM]	= { -ENODATA,	"critical medium" },
-	[BLK_STS_PROTECTION]	= { -EILSEQ,	"protection" },
-	[BLK_STS_RESOURCE]	= { -ENOMEM,	"kernel resource" },
-	[BLK_STS_DEV_RESOURCE]	= { -EBUSY,	"device resource" },
-	[BLK_STS_AGAIN]		= { -EAGAIN,	"nonblocking retry" },
-	[BLK_STS_OFFLINE]	= { -ENODEV,	"device offline" },
-
-	/* device mapper special case, should not leak out: */
-	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
-
-	/* zone device specific errors */
-	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
-	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
-
-	/* Command duration limit device-side timeout */
-	[BLK_STS_DURATION_LIMIT]	= { -ETIME, "duration limit exceeded" },
-
-	[BLK_STS_INVAL]		= { -EINVAL,	"invalid" },
-};
+#define blk_errors(_)									\
+	_(BLK_STS_OK,			0,		"")				\
+	_(BLK_STS_NOTSUPP,		-EOPNOTSUPP,	"operation not supported")	\
+	_(BLK_STS_TIMEOUT,		-ETIMEDOUT,	"timeout")			\
+	_(BLK_STS_NOSPC,		-ENOSPC,	"critical space allocation")	\
+	_(BLK_STS_TRANSPORT,		-ENOLINK,	"recoverable transport")	\
+	_(BLK_STS_TARGET,		-EREMOTEIO,	"critical target")		\
+	_(BLK_STS_RESV_CONFLICT,	-EBADE,		"reservation conflict")	\
+	_(BLK_STS_MEDIUM,		-ENODATA,	"critical medium")		\
+	_(BLK_STS_PROTECTION,		-EILSEQ,	"protection")			\
+	_(BLK_STS_RESOURCE,		-ENOMEM,	"kernel resource")		\
+	_(BLK_STS_DEV_RESOURCE,		-EBUSY,		"device resource")		\
+	_(BLK_STS_AGAIN,		-EAGAIN,	"nonblocking retry")		\
+	_(BLK_STS_OFFLINE,		-ENODEV,	"device offline")		\
+											\
+	/* device mapper special case, should not leak out: */				\
+	_(BLK_STS_DM_REQUEUE,		-EREMCHG,	"dm internal retry")		\
+											\
+	/* zone device specific errors */						\
+	_(BLK_STS_ZONE_OPEN_RESOURCE,	-ETOOMANYREFS,	"open zones exceeded")		\
+	_(BLK_STS_ZONE_ACTIVE_RESOURCE,	-EOVERFLOW,	"active zones exceeded" )	\
+											\
+	/* Command duration limit device-side timeout */				\
+	_(BLK_STS_DURATION_LIMIT,	-ETIME,		"duration limit exceeded")	\
+											\
+	_(BLK_STS_INVAL,		-EINVAL,	"invalid")
 
 blk_status_t errno_to_blk_status(int errno)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
-		if (blk_errors[i].errno == errno)
-			return (__force blk_status_t)i;
+	switch(errno) {
+#define _(_status, _errno, _name)		\
+	case _errno:				\
+		return _status;
+	blk_errors(_)
+#undef _
+	default:
+		return BLK_STS_IOERR;
 	}
-
-	return BLK_STS_IOERR;
 }
 EXPORT_SYMBOL_GPL(errno_to_blk_status);
 
 int blk_status_to_errno(blk_status_t status)
 {
-	int idx = (__force int)status;
-
-	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
+	switch(status) {
+#define _(_status, _errno, _name)		\
+	case _status:				\
+		return _errno;
+	blk_errors(_)
+#undef _
+	default:
 		return -EIO;
-	return blk_errors[idx].errno;
+	}
 }
 EXPORT_SYMBOL_GPL(blk_status_to_errno);
 
 const char *blk_status_to_str(blk_status_t status)
 {
-	int idx = (__force int)status;
-
-	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
+	switch(status) {
+#define _(_status, _errno, _name)		\
+	case _status:				\
+		return _name;
+	blk_errors(_)
+#undef _
+	default:
 		return "I/O";
-	return blk_errors[idx].name;
+	}
 }
 EXPORT_SYMBOL_GPL(blk_status_to_str);
 
+#undef blk_errors
+
 /**
  * blk_sync_queue - cancel any pending callbacks on a queue
  * @q: the queue
-- 
2.52.0



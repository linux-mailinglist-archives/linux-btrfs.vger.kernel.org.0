Return-Path: <linux-btrfs+bounces-19927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EBBCD39FB
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 03:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E19EE30047C8
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 02:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E121322F;
	Sun, 21 Dec 2025 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKphHjCQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB219992C
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766285571; cv=none; b=QWwteOritokS8hS5yiEFYrXb3hM4K6HJpo0/ijDtHVWsIHPYov4zH7ld7ZYBrT+qtMhlzpA6prDAOiXB/UbZKvC4jrS2IRXUUAIMk/hljabPpRlvDpT56tFXv5UM+IWJ/AXN2MhuEwBLuJsh+4wax20KSmRz+iSNkjIZZjEhMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766285571; c=relaxed/simple;
	bh=4ZBa892y1M1TfmSx5/Ar1yUahL1O7FrFkXQfkieSWPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPgws+xgST7qQC2x/g0mUWffGastPugM/THe396LltZtoFPJj2bK26EBqN1HsOw12yboZW3iyWqySHjDrvIMjJ1r8Pjf1st/uaTDhcxgzngndfkHYaLJiEaRYgTpAq7/3slc1KyXnC6YbEvJMmySkgoFs4aVi2hdMHDeldPRChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKphHjCQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766285568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rFNrTbz3ZImqikct+7ijcbg6dOqTPdKeJOJQAT9nGU=;
	b=TKphHjCQSUPOscWPiGm92sAs30KrLXXE+ptjWSGrrKe9KdMJGRTLztu36l1zOTNeOUJcHR
	WujJv8rwblbXMw5u8XvLs7AgAjDNge2GsNqlW9SdigHVNw9YlIkCIHhoznoGJBBNt7tvqi
	GLVrNz8BAFZQJzBiYFxeqpJ1TUjnl0c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-4BAqgF_mO_m3d2XQMIrwtg-1; Sat,
 20 Dec 2025 21:52:44 -0500
X-MC-Unique: 4BAqgF_mO_m3d2XQMIrwtg-1
X-Mimecast-MFC-AGG-ID: 4BAqgF_mO_m3d2XQMIrwtg_1766285563
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CE4D1956080;
	Sun, 21 Dec 2025 02:52:43 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EF1B180045B;
	Sun, 21 Dec 2025 02:52:39 +0000 (UTC)
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
Subject: [RFC v2 01/17] xfs: don't clobber bi_status in xfs_zone_alloc_and_submit
Date: Sun, 21 Dec 2025 03:52:16 +0100
Message-ID: <20251221025233.87087-2-agruenba@redhat.com>
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

Function xfs_zone_alloc_and_submit() sets bio->bi_status and then it
calls bio_io_error(), which overwrites that value again.  Fix that by
completing the bio separately after setting bio->bi_status.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/xfs/xfs_zone_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index ef7a931ebde5..bd6f3ef095cb 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -897,6 +897,9 @@ xfs_zone_alloc_and_submit(
 
 out_split_error:
 	ioend->io_bio.bi_status = errno_to_blk_status(PTR_ERR(split));
+	bio_endio(&ioend->io_bio);
+	return;
+
 out_error:
 	bio_io_error(&ioend->io_bio);
 }
-- 
2.52.0



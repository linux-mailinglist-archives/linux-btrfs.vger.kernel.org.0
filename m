Return-Path: <linux-btrfs+bounces-9262-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E59B7C4A
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929B71C214E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A208E19EED7;
	Thu, 31 Oct 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cMewq+Vu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D214F121
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383402; cv=none; b=YPTjAHDs1Lb9vxpwLTuCLy+vCHPGBHoztg1YSaobpVazfhwqfoNY1DT/55hDxCzabFFywH9Ibn30yA5s7lf8Doxyu6IZ5VQYne1ZJR+45RMXc7frBLgCqjti10FF3Ri4CUbJAmX+ojZvXSvvplLAgNfVR9pq79329rr+p5uLaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383402; c=relaxed/simple;
	bh=gJyz15ICtVhRDS2blf2RNPgCDCGg19gTM0a6+7hDa3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izL4yOFPLSvNbgpJgWWK0q88LUjn0H7vGanrIbfMgWKmZshzL9A7mxE2a3shkjcSWb7pYT2MtZOVnypy36tmgPtSVJUb7IKeeT43j26kWsaRafTYQM/RxOmcD306HIEyufS1ATpYaONmUjwXhc+AHgBHCv1Es40bp+a3vQ0v4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cMewq+Vu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wsf8VXsex6N6qlfcKD1qtzVUR+z2sgDRryYO/ubMalM=; b=cMewq+VuD1Mhy+Az3pRN4sfaJ9
	qgYRcwGEXUhei2cHN3um3YA9QohX6TGp8W157g5fTaKev8npbcMqXI+w1N4muqdNYQtRO+0btKT0U
	ZwRd4jlMznr/roXU7cWrkjOgCysn7U0WDxZzdekVeU9Ita/CvTVbky5MtZSAb2ZdyazNZqgQWb2It
	GGpJMXW8mjHTW024kmUzKcOEZp1NlOqXQxhAL6reBWBMnR6xpdDccEIotyvlHjFpdokxSh+u/YUXw
	1mR/rjvuAnmSd/fB98UD6BiPZtna0Fdkzl+hpWaxQEbCR+zoFxs0AU0ipzlQL6mBnsJpf7VZp4QnD
	ykW9ZKJA==;
Received: from 2a02-8389-2341-5b80-4107-91b3-66f5-c0ed.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4107:91b3:66f5:c0ed] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Vlf-00000003kZ9-1qrT;
	Thu, 31 Oct 2024 14:03:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix a typo in btrfs_use_zone_append
Date: Thu, 31 Oct 2024 15:03:17 +0100
Message-ID: <20241031140317.177800-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 46b9386957e6..5a81a519d943 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1736,7 +1736,7 @@ bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 		return false;
 
 	/*
-	 * Using REQ_OP_ZONE_APPNED for relocation can break assumptions on the
+	 * Using REQ_OP_ZONE_APPEND for relocation can break assumptions on the
 	 * extent layout the relocation code has.
 	 * Furthermore we have set aside own block-group from which only the
 	 * relocation "process" can allocate and make sure only one process at a
-- 
2.45.2



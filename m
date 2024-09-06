Return-Path: <linux-btrfs+bounces-7871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5AA96E90D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 07:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F581F2475B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 05:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E2212EBDB;
	Fri,  6 Sep 2024 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DixfVBSi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DixfVBSi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75444C86
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599822; cv=none; b=FItK//7LpFcgMqdoZnN/a2KB2ntTP4jnqAk/9B+y6P+6ASrnhc6Vu2a3CtbG8SDaDYkC/ap+NosUM2V29Zm3cg5x9K9qeBPw0Eu7EKJiHniPMlgN5EO0QmYZQwXyXpxwQgicL1oXXAi/0K3wYYoTSZWzm5GYf3QKRIRtRbp7UIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599822; c=relaxed/simple;
	bh=kPZlMEqsIS61aJZWywPWNLrQ/fN4hc2iFU+w189HCew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8kQD7XIm+xXhd/doAzcT1sRnM9wXxmjpjG69adIoZGiog81OZ7A7TRyMds9W34yu/MaAwaTAQG3kpKvWFaaaNHEqvx5fyxy5Fp8XQtJaXzTOF8uhnaJ84LIjEtls2GjfNFS9dd1cPf0VhVXTZuab2VKI5/o6H/7ggSvTWYpOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DixfVBSi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DixfVBSi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD0B91F88F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725599818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApyqJFl2LFyj5mzEZ9mYajo9bMouq5odBHVDvF7iJfU=;
	b=DixfVBSiQrFBdUUvHRyBthMyLPlhXgTaTQv9s0pAFo7lUlKEAVCuSrxbUxeNdAeInm/fGc
	qMWWDIXdpR6AW7bHbcPwLNC0VURn2b6mhY2Wo2JinUyxzuyPASJRzotuOmRh0CEinHwJ9o
	fn6AbwdtIHudmht+h9L8aT1qcXOd2HI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725599818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApyqJFl2LFyj5mzEZ9mYajo9bMouq5odBHVDvF7iJfU=;
	b=DixfVBSiQrFBdUUvHRyBthMyLPlhXgTaTQv9s0pAFo7lUlKEAVCuSrxbUxeNdAeInm/fGc
	qMWWDIXdpR6AW7bHbcPwLNC0VURn2b6mhY2Wo2JinUyxzuyPASJRzotuOmRh0CEinHwJ9o
	fn6AbwdtIHudmht+h9L8aT1qcXOd2HI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E673D1395F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ENp4KUmQ2ma6DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2024 05:16:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: zstd: make the compression path to handle sector size < page size
Date: Fri,  6 Sep 2024 14:46:21 +0930
Message-ID: <764a9c6a8e9e5d88253a65595dba8b2709f8d5f2.1725599171.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725599171.git.wqu@suse.com>
References: <cover.1725599171.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Inside zstd_compress_folios(), after exhausted one input page, we need
to switch to the next page as input.

However when counting the total input bytes (@tot_in), we always increase
it by PAGE_SIZE.

For the following case, it can cause incorrect value:

        0          32K         64K          96K
        |          |///////////||///////////|

After compressing range [32K, 64K), we switch to the next page, and
increasing @tot_in by 64K, while we only read 32K.

This will cause the @total_in to return a value larger than the input
length.

Fix it by only increase @tot_in by the input size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zstd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 866607fd3e58..15f8a83165a3 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -495,7 +495,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 
 		/* Check if we need more input */
 		if (workspace->in_buf.pos == workspace->in_buf.size) {
-			tot_in += PAGE_SIZE;
+			tot_in += workspace->in_buf.size;
 			kunmap_local(workspace->in_buf.src);
 			workspace->in_buf.src = NULL;
 			folio_put(in_folio);
-- 
2.46.0



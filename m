Return-Path: <linux-btrfs+bounces-12250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D04A5EA82
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 05:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658697AC0EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 04:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2AB13D53B;
	Thu, 13 Mar 2025 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iSjOzPnR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iSjOzPnR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902D2CCC5
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839686; cv=none; b=dufiTXnz6vewmPutsNEq2ArFPAfHPUaGpe7kwwLiMDMM6LrBhkWojVO6ZzVNEZy9VLQMK29oLQ1LeKIf3CtnJYujrLNeDiDsqiK5Srx4qvMEFChpkjfFVtgqJHx6RY5qXNe8f/x0kTlPrcUNbrapGG9BVj3MHMnmN2khXfmd7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839686; c=relaxed/simple;
	bh=fV39FIZBHcLoysOcEHA/fNtbn1s1mlpDtFc3Eo+jfyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+QhnAQ10YY5rtFoZiYSqTsEIUir4CWVPSVE4898t7KkQ9YLC5ppDqddOT2fq8Km1dUXPIBE8U24urTjpHTXe9rJv7TNOQQU1esCmkLTuE3Up8XRoJpqgkrHKpeCmS1TOIDG7GfftRgTkNjMscns9ANktv7vmHyQ0qbkCvSR8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iSjOzPnR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iSjOzPnR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 660CF1F394
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC3ZrLumjXEUxKYQAcQV/R5RberFyv50JmwDwX9aZy8=;
	b=iSjOzPnRyl0r+aQ9K8Dg3cw/EjElIDm1imRZYq4weKmjIaUtc+c/lKYHOaLbxZmjWfDC0+
	G4SN/CIAdktyOEvd1D7qoE0HL1GW3zI1UFOrhwJtLf+juzkKvCtpiRwhvMjqHbjKkgVo4H
	tdGl/AQXE/HJJ9DlZbnAgprueU4QEEs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC3ZrLumjXEUxKYQAcQV/R5RberFyv50JmwDwX9aZy8=;
	b=iSjOzPnRyl0r+aQ9K8Dg3cw/EjElIDm1imRZYq4weKmjIaUtc+c/lKYHOaLbxZmjWfDC0+
	G4SN/CIAdktyOEvd1D7qoE0HL1GW3zI1UFOrhwJtLf+juzkKvCtpiRwhvMjqHbjKkgVo4H
	tdGl/AQXE/HJJ9DlZbnAgprueU4QEEs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AAE613797
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +I6PFjpd0mcrYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: subpage: prepare for larger data folios
Date: Thu, 13 Mar 2025 14:50:48 +1030
Message-ID: <aa2de725f7c743b5b6b512006b39fc5e3cf79e16.1741839616.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741839616.git.wqu@suse.com>
References: <cover.1741839616.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The subpage handling code has two locations not supporting larger
folios:

- btrfs_attach_subpage()
  Which is doing a metadata specific ASSERT() check.

  But for the future larger data folios support, that check is too
  generic.
  Since it's metadata specific, only check the ASSERT() for metadata.

- btrfs_subpage_assert()
  Just remove the "ASSERT(folio_order(folio) == 0)" check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 834161f35a00..bf7fd50ab9ec 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -69,7 +69,8 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage;
 
 	/* For metadata we don't support larger folio yet. */
-	ASSERT(!folio_test_large(folio));
+	if (type == BTRFS_SUBPAGE_METADATA)
+		ASSERT(!folio_test_large(folio));
 
 	/*
 	 * We have cases like a dummy extent buffer page, which is not mapped
@@ -181,9 +182,6 @@ void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *
 static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len)
 {
-	/* For subpage support, the folio must be single page. */
-	ASSERT(folio_order(folio) == 0);
-
 	/* Basic checks */
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-- 
2.48.1



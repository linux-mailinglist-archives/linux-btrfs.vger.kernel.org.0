Return-Path: <linux-btrfs+bounces-11419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F9A330AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 21:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22B0167F2D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 20:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D620126B;
	Wed, 12 Feb 2025 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U5j+RzZ4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U5j+RzZ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D77201100
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391729; cv=none; b=Ws9J/xmxRFbU4aOXEwUtXcvM8JynsWRniXnU/50uPy/FezUT2hB6JQVCQcsd1/8rALz035gfX0b1i8KD7e2nMmXSAd2eVRbUBK8suc1SFodkoBUAx4QY4oJIfbXxktd2dwP4+Tie5rOtTG7jhnnnaI/bzK+L8TFjXhEZL3T5xBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391729; c=relaxed/simple;
	bh=SxtSOrrq/kJSXP56L8PlegGEW6b92m0/Brpez3vMOdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+DcboT5ZH2cDxXvQt9ymuOqCFyYcyO6x6f9EaYL8U6Ywx1KIHHleduRWSHXZSBA8RZMicqH44jOBsoQn1vlh/z47a6uwkVPMDD8vYXzroks36lK9Bo0xjBh+BTBKWjZDZccIVm3Q5N0T1CXiNmGEjKAtIxVK6Jr/e/FBISWff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U5j+RzZ4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U5j+RzZ4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B71591F78D;
	Wed, 12 Feb 2025 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1QQFwngYDBgFOFa/EsypWfNtVqTiiAjpwaiFLMO65k=;
	b=U5j+RzZ4Idh777dys+U5AQ/1sbfwBjQLwk3B6TnprOjuUjj2uY8igTolqjyIIOxog4D+HX
	v9QY1uhRPbUJugAIBAdeXZLeJmW3BaRXhv52ggazHgoA0h8Xk3/m+Jl7j16oSXNiK9UkDF
	tGwiBp3IJ62fsCY8GUVnI0J9drkTj4s=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1QQFwngYDBgFOFa/EsypWfNtVqTiiAjpwaiFLMO65k=;
	b=U5j+RzZ4Idh777dys+U5AQ/1sbfwBjQLwk3B6TnprOjuUjj2uY8igTolqjyIIOxog4D+HX
	v9QY1uhRPbUJugAIBAdeXZLeJmW3BaRXhv52ggazHgoA0h8Xk3/m+Jl7j16oSXNiK9UkDF
	tGwiBp3IJ62fsCY8GUVnI0J9drkTj4s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD74C13AEF;
	Wed, 12 Feb 2025 20:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eUtXKu0CrWekJgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Feb 2025 20:22:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/7] btrfs: zstd: remove local variable for storing page offsets
Date: Wed, 12 Feb 2025 21:22:05 +0100
Message-ID: <79bc11279507ecd040dbac436e49117a0017ec53.1739391605.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739391605.git.dsterba@suse.com>
References: <cover.1739391605.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.984];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

When using offset_in_page() it's clear what it means, we don't need to
store it in the local variable just to use it right away. There's no
change in the generated code, but keeps the declarations smaller.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zstd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 5419c47b854f..cd5f38d6fbaa 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -401,7 +401,6 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	const unsigned long nr_dest_folios = *out_folios;
 	const u64 orig_end = start + len;
 	unsigned long max_out = nr_dest_folios * PAGE_SIZE;
-	unsigned int pg_off;
 	unsigned int cur_len;
 
 	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
@@ -427,9 +426,8 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
 	if (ret < 0)
 		goto out;
-	pg_off = offset_in_page(start);
 	cur_len = btrfs_calc_input_length(orig_end, start);
-	workspace->in_buf.src = kmap_local_folio(in_folio, pg_off);
+	workspace->in_buf.src = kmap_local_folio(in_folio, offset_in_page(start));
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = cur_len;
 
@@ -513,9 +511,9 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 			ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
 			if (ret < 0)
 				goto out;
-			pg_off = offset_in_page(start);
 			cur_len = btrfs_calc_input_length(orig_end, start);
-			workspace->in_buf.src = kmap_local_folio(in_folio, pg_off);
+			workspace->in_buf.src = kmap_local_folio(in_folio,
+							 offset_in_page(start));
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = cur_len;
 		}
-- 
2.47.1



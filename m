Return-Path: <linux-btrfs+bounces-12672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1425FA7556B
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7853B13CE
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291A71A9B5D;
	Sat, 29 Mar 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cp76Z15f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cp76Z15f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0342048
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743240014; cv=none; b=tFP575ApVjMzBPhNRBES1mM11be/OImtXDi5mULbu3khwZBQeY9ZHHNfvrMUx+nGRA0S5h1+7JSDowLuzf6oV5DxAeFI3UuOlHpknr92JGkDl8r6l+QU6Sc6BQScADQ2bFBPDQU4ljxX/LkJXoXFL9ofq+0qnSAjaVaGUsMr1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743240014; c=relaxed/simple;
	bh=vaVQSwCMjR7XlNQKbcEiUuXWDCr+8Z/ZOMr8C3iIdio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYlmJdE04kkh321YF2VcBp4cBtQlrbP1AbsFLujONNegDDBXkQiFDTGgBdnrIIjLCFl/URTSS7XZFVOHBOAEIhFIatGtYJSKaKRPoO/cgBS1QUQEhRhxAz10i6DDpHzAA95EF19vDdN3JO9zUl/SpwcWzs5Kjypao1D9InEZ/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cp76Z15f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cp76Z15f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6424A2120A;
	Sat, 29 Mar 2025 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALbRnJemeGp94t1vd3lNB8xgXwe5zX43p5Tj1wbiXZ8=;
	b=cp76Z15fxKsUeY3uOEzw11hPvNAKS4lUEloxuT/YYC1LXLIWEADYmbvnUBydcoEMwaINvS
	DZZu+VDY1TWAMyYpsDdgLotvyUbd7wDoUsC6HySx873RjNaRSkcqiK5ivPs8GxEvgzcTHt
	YE6a2YT0g64IRY+8EtmimVM6W98Yej8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cp76Z15f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALbRnJemeGp94t1vd3lNB8xgXwe5zX43p5Tj1wbiXZ8=;
	b=cp76Z15fxKsUeY3uOEzw11hPvNAKS4lUEloxuT/YYC1LXLIWEADYmbvnUBydcoEMwaINvS
	DZZu+VDY1TWAMyYpsDdgLotvyUbd7wDoUsC6HySx873RjNaRSkcqiK5ivPs8GxEvgzcTHt
	YE6a2YT0g64IRY+8EtmimVM6W98Yej8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 625F813A41;
	Sat, 29 Mar 2025 09:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AClVCUO752cCEQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 29 Mar 2025 09:20:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/5] btrfs: subpage: fix a bug that blocks large folios
Date: Sat, 29 Mar 2025 19:49:36 +1030
Message-ID: <a8e9f1a254b3ebb07f68b445c13ac481dbd0068c.1743239672.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743239672.git.wqu@suse.com>
References: <cover.1743239672.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6424A2120A
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Inside the macro, subpage_calc_start_bit(), we need to calculate the
offset to the beginning of the folio.

But we're using offset_in_page(), on systems with 4K page size and 4K fs
block size, this means we will always return offset 0 for a large folio,
causing all kinds of errors.

Fix it by using offset_in_folio() instead.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 11dbd7be6a3b..bd252c78a261 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -204,7 +204,7 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 			   btrfs_blocks_per_folio(fs_info, folio);	\
 									\
 	btrfs_subpage_assert(fs_info, folio, start, len);		\
-	__start_bit = offset_in_page(start) >> fs_info->sectorsize_bits; \
+	__start_bit = offset_in_folio(folio, start) >> fs_info->sectorsize_bits; \
 	__start_bit += blocks_per_folio * btrfs_bitmap_nr_##name;	\
 	__start_bit;							\
 })
-- 
2.49.0



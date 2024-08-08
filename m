Return-Path: <linux-btrfs+bounces-7044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0171E94B67B
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 08:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750E428343A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 06:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC941862AE;
	Thu,  8 Aug 2024 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dBIwwAvU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dBIwwAvU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FF13DBA2
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097187; cv=none; b=VlUBkv7OLOqf6dFxcW9dLDYBuHb3PJSDEUJ0pksqO3kPLs+/AsQ2PoF3kE+ZAs0OrmhvRnAKt+XIjhaRMa/eLLZpTJ3lOhYYqK18pP5iZ99ZhDY3yvFVMmCNGOKF0+EDGievdtAcsCjKo8SKEtvk//lBy/Yf4UPJ0J9ug7Z4TA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097187; c=relaxed/simple;
	bh=hfeL94SsdFI+XWQEA3LGlRaHn9AtUneHK1pq9mTWFy4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpKnkqnkFEds51N2bcVSOd2zW/bkZ7tSjTXtJO9cYG6fU01f5YaLJbNL36p+kiq7zW1tKhJogRXo3XLizQ8fM8FE1sALRdOG5iQPvshYV83o8BsaCq0jyc7wINs4WFmr8d9YS0K4UCULnVr52qi7CYqDI6ZAFUFm3NIB0Uw1sDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dBIwwAvU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dBIwwAvU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C29B21B07
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723097182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cy2t2BUFAF3w2sV5ZasF8M5GRDgj9gaw3W1ZHsvdD5E=;
	b=dBIwwAvUaN8c7DJ0BGB5OAkPNZHNa5V/uZdH3h0vx5aqrslI0v+Hcn27Ogi+d8B7PG4fwu
	3H6ZtyT+wc4WlbZaPPJLxNv0AZXtx97HOGNuTrZbKC9dzGZ9SKVaHM/VCz5MZertNGyav0
	J69+DPHjkvzL9yHAelWJNalRAzLKeeE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dBIwwAvU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723097182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cy2t2BUFAF3w2sV5ZasF8M5GRDgj9gaw3W1ZHsvdD5E=;
	b=dBIwwAvUaN8c7DJ0BGB5OAkPNZHNa5V/uZdH3h0vx5aqrslI0v+Hcn27Ogi+d8B7PG4fwu
	3H6ZtyT+wc4WlbZaPPJLxNv0AZXtx97HOGNuTrZbKC9dzGZ9SKVaHM/VCz5MZertNGyav0
	J69+DPHjkvzL9yHAelWJNalRAzLKeeE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90BF213946
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 06:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2HPdEl1gtGZIZgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2024 06:06:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: utilize cached extent map for data writeback
Date: Thu,  8 Aug 2024 15:36:00 +0930
Message-ID: <f1232d0ffc8ae7389206d4cc9210afc77cfcacac.1723096922.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723096922.git.wqu@suse.com>
References: <cover.1723096922.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6C29B21B07
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Unlike data read, we never really utilize the cached extent_map for data
write.

This means we will do the costly extent map lookup for each sector we
need to write back.

Change it to utilize the same function, __get_extent_map(), just like
the data read path, to reduce the overhead of extent map lookup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d4ad98488c03..9492cd9d4f04 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1357,7 +1357,8 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	/* @filepos >= i_size case should be handled by the caller. */
 	ASSERT(filepos < i_size);
 
-	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
+	em = __get_extent_map(&inode->vfs_inode, NULL, filepos, sectorsize,
+			      &bio_ctrl->em_cached);
 	if (IS_ERR(em))
 		return PTR_ERR_OR_ZERO(em);
 
@@ -2320,6 +2321,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		cur = cur_end + 1;
 	}
 
+	free_extent_map(bio_ctrl.em_cached);
 	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
 }
 
@@ -2338,6 +2340,7 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 	 */
 	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
 	ret = extent_write_cache_pages(mapping, &bio_ctrl);
+	free_extent_map(bio_ctrl.em_cached);
 	submit_write_bio(&bio_ctrl, ret);
 	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
 	return ret;
-- 
2.45.2



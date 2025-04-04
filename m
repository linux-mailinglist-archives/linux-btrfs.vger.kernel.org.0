Return-Path: <linux-btrfs+bounces-12787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 137B0A7B5A1
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 03:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C9D179016
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065C8339A8;
	Fri,  4 Apr 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XhQZaHt3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XhQZaHt3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D62E62B6
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743731293; cv=none; b=V35YNcZP3hxbsXxHq/H8yvQoXZlBBmRK9IbEbTDRKFDSutmAX4nQLmwnvSjVpR9c1kCycT85i1TeoT2zX4LWyPqP2vkDZvqP5Wd70Z/Mu+A41yS8/pAGjspN6HilZf4dUeoKGJgP50R/sIErxzDnGc0e7SwUHNJA6QRTnloD8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743731293; c=relaxed/simple;
	bh=k9cijWStmcO2oB4fFUjCpZgrBsoZYiG2VlYfkMjBpu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tp2Mb1bW6Nkx5eh8E7TwReiJYDAPNhcCcRMhfMizrVPqApXSm4XEmCXPmNKRtk44n3cTm+aRVKJ50KEhLKfZ/PmOVf7DegjrQhLXqvHfLdJ9/KXArwp5u9dMy6Mi4xKxcs/e7iVtlDmLyygybHA5wp8Ii8t6MdXbfAdIDskHoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XhQZaHt3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XhQZaHt3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7014221190
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743731282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwpnCyumCHU0ZpQzS/a8ZRBmbWyutSoOfbSZ7Y+vCVs=;
	b=XhQZaHt3zzhPXKakob93OL0BWsHZCx28BUX15WwSg2EauLhr2sjn1Ubf44af+B+FK6VG5n
	AqPPes8ZZMuOzyNi4jq1hqI9uer0466h0z+ZUktbAZ1FbyM8kze5embC5H/WlWOkfOZJlu
	pdxJoG8Xn3DqxZplY6PGX/UcviTil6I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743731282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwpnCyumCHU0ZpQzS/a8ZRBmbWyutSoOfbSZ7Y+vCVs=;
	b=XhQZaHt3zzhPXKakob93OL0BWsHZCx28BUX15WwSg2EauLhr2sjn1Ubf44af+B+FK6VG5n
	AqPPes8ZZMuOzyNi4jq1hqI9uer0466h0z+ZUktbAZ1FbyM8kze5embC5H/WlWOkfOZJlu
	pdxJoG8Xn3DqxZplY6PGX/UcviTil6I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A451C134C7
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mGn0GFE672dIDwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 01:48:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: remove unnecessary early exits in delalloc folio lock and unlock
Date: Fri,  4 Apr 2025 12:17:40 +1030
Message-ID: <39d3966f896f04c3003eb9a954ce84ff33d51345.1743731232.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743731232.git.wqu@suse.com>
References: <cover.1743731232.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Inside function unlock_delalloc_folio() and lock_delalloc_folios(), we
have the following early exist:

	if (index == locked_folio->index && end_index == index)
		return;

This allows us to exist early if the range are inside the same locked
folio.

But even without the above early check, the existing code can handle it
well, as both __process_folios_contig() and lock_delalloc_folios() will
skip any folio page lock/unlock if it's on the locked folio.

Just remove those unnecessary early exits.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8b29eeac3884..013268f70621 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -224,12 +224,7 @@ static noinline void unlock_delalloc_folio(const struct inode *inode,
 					   const struct folio *locked_folio,
 					   u64 start, u64 end)
 {
-	unsigned long index = start >> PAGE_SHIFT;
-	unsigned long end_index = end >> PAGE_SHIFT;
-
 	ASSERT(locked_folio);
-	if (index == locked_folio->index && end_index == index)
-		return;
 
 	__process_folios_contig(inode->i_mapping, locked_folio, start, end,
 				PAGE_UNLOCK);
@@ -246,9 +241,6 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 	u64 processed_end = start;
 	struct folio_batch fbatch;
 
-	if (index == locked_folio->index && index == end_index)
-		return 0;
-
 	folio_batch_init(&fbatch);
 	while (index <= end_index) {
 		unsigned int found_folios, i;
-- 
2.49.0



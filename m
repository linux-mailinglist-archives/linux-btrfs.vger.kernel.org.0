Return-Path: <linux-btrfs+bounces-12788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1281BA7B5A2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 03:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7D1178B09
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 01:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A620328;
	Fri,  4 Apr 2025 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pQVvnIs6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pQVvnIs6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC52E62B6
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743731302; cv=none; b=nMHnAjrWP4I/BJSM+GyTvFluh8j1UefEm4zOnCpK5mrq8tnzpzoOzjMdMJm2ngam6hoy9tt1Q0U/oDZZsfmfR85UUVpsqYgB91NU1KRBnuCkidEfd75EDNIdVxF5SK5lMxmU0veoADwNIXyn4C/DpFttzUu+TJjPWLScq4uqXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743731302; c=relaxed/simple;
	bh=BxQG5a0vEHLn5jCrqRS9A0m0wpDHg84fB/zGNRzlIqc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaEGjc6XSkYF5f31dJSRFgGYJ3w+LozDdVjyGdKYp/D/0HUlQgdGFPnNxaP00QTysaefYGNQFcqP6+oP3LevSIEguzAOvemkd3OsN7sgC8/3T+0ofylhX3Pbd0foEQ+iMQqhmHXflXFHy3xRLkQf7BWPhhiCgUQgHpc+V/58iMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pQVvnIs6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pQVvnIs6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0439721196
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743731285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO4LZ2SgGTzJdNEr29CFCZHmD+MCMmLyr4FrDkUT3+I=;
	b=pQVvnIs6d9bl2jE498MxN7Qw2z10LLvxBVeX0BfI4pWMZgHT4qzXD0tDoOnoNyB2zGvAy9
	CG0PADqFIBpdPQob45dHcYIE1QUEEJxdEl8JZrBFxndnOeSjkZgTatPNEYtTiAFIyDDGjH
	1HdPQJaoJUxfAKNkuOxYncKG2WC/HC0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743731285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO4LZ2SgGTzJdNEr29CFCZHmD+MCMmLyr4FrDkUT3+I=;
	b=pQVvnIs6d9bl2jE498MxN7Qw2z10LLvxBVeX0BfI4pWMZgHT4qzXD0tDoOnoNyB2zGvAy9
	CG0PADqFIBpdPQob45dHcYIE1QUEEJxdEl8JZrBFxndnOeSjkZgTatPNEYtTiAFIyDDGjH
	1HdPQJaoJUxfAKNkuOxYncKG2WC/HC0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3779E134C7
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 01:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WIL1OVM672dIDwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 01:48:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: get rid of filemap_get_folios_contig() calls
Date: Fri,  4 Apr 2025 12:17:42 +1030
Message-ID: <577429c985d01407c27141db4015c50d8ba7c746.1743731232.git.wqu@suse.com>
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
X-Spam-Score: -2.80
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
X-Spam-Flag: NO
X-Spam-Level: 

With large folios, filemap_get_folios_contig() can return duplicated
folios, for example:

	704K                     768K	                          1M
        |<-- 64K sized folio --->|<------- 256K sized folio ----->|
	                      |          |
			      764K       800K

If we call lock_delalloc_folios() with range [762K, 800K) on above
layout with locked folio at 704K, we will hit the following sequence:

1. filemap_get_folios_contig() returned 1 for range [764K, 768K)
   As this is a folio boundary.

   The returned folio will be folio at 704K.

   Since the folio is already locked, we will not lock the folio.

2. filemap_get_folios_contig() returned 8 for range [768K, 800K)
   All the entries are the same folio at 768K.

3. We lock folio 768K for the slot 0 of the fbatch

4. We lock folio 768K for the slot 1 of the fbatch
   We deadlock, as we have already locked the same folio at step 3.

The filemap_get_folios_contig() behavior is definitely not ideal, but on
the other hand, we do not really need the filemap_get_folios_contig()
call either.

The current filemap_get_folios() is already good enough, and we require
no strong contiguous requirement either, we only need the returned folios
contiguous at file map level (aka, their folio file offsets are contiguous).

So get rid of the cursed filemap_get_folios_contig() and use regular
filemap_get_folios() instead, this will fix the above deadlock for large
folios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c             | 6 ++----
 fs/btrfs/tests/extent-io-tests.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f0d51f6ed951..986bda2eff1c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -207,8 +207,7 @@ static void __process_folios_contig(struct address_space *mapping,
 	while (index <= end_index) {
 		int found_folios;
 
-		found_folios = filemap_get_folios_contig(mapping, &index,
-				end_index, &fbatch);
+		found_folios = filemap_get_folios(mapping, &index, end_index, &fbatch);
 		for (i = 0; i < found_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
@@ -245,8 +244,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 	while (index <= end_index) {
 		unsigned int found_folios, i;
 
-		found_folios = filemap_get_folios_contig(mapping, &index,
-				end_index, &fbatch);
+		found_folios = filemap_get_folios(mapping, &index, end_index, &fbatch);
 		if (found_folios == 0)
 			goto out;
 
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 74aca7180a5a..e762eca8a99f 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -32,8 +32,7 @@ static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
 	folio_batch_init(&fbatch);
 
 	while (index <= end_index) {
-		ret = filemap_get_folios_contig(inode->i_mapping, &index,
-				end_index, &fbatch);
+		ret = filemap_get_folios(inode->i_mapping, &index, end_index, &fbatch);
 		for (i = 0; i < ret; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-- 
2.49.0



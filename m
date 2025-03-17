Return-Path: <linux-btrfs+bounces-12321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C95A64306
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5845E168684
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF68721ABB8;
	Mon, 17 Mar 2025 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZqsZpDih";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZqsZpDih"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F91C6FF3
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195525; cv=none; b=bkzg6pkExslW03+a/KDWds8FrUq3pg6pn48gU3NIKb9PX7MifNykxSywaTfzm8ApS0CtrTqKfYYGNTkni8j78KtlgyQj3EBi7jMhZiNt82A0ioTZPKbMMnZV2tSl78JAtreRyphXL04xjPi9uK5RutGwZzZwYwMZ4ENKkpAT3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195525; c=relaxed/simple;
	bh=GEN3iJkWeDvE/KSQxPiVSF1LRJQphDfycxGUh2NOZUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQy2g0HrovkKDUs+dQ4Y0knlq3W/GK5bAp3yG5+cempnZ1lPyhGMeREYKpISZWDXITgqMtd34rPr0n+DEwV1dG+KstYxpaiQT6p9fizNzxr9/UEhoAGslIIwo2KOp+liTXYgHVLXWJCNJ5TDeYywqq8cOybYy/Gwzt2Vb4a34/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZqsZpDih; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZqsZpDih; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 900AD2212E
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjRDK+DEmvOJ6nnT06bW82e6DneaDQkEOgvkFEgxBIA=;
	b=ZqsZpDihG905MESX6nIexJViByUTUxSMXOrv9QaP0LFgQL5YiYYe5OKXGowaBLkEdJ5Xm1
	o90uJuXdUcyMJsKTJEhqxVScfiCV+Vi6j3O5R64vl111i5u/q8ZvzZpYOxhjVyLSxsadW0
	kQU6q5RzOTkHsQI3gvXcqwUPkL/RNdM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZqsZpDih
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjRDK+DEmvOJ6nnT06bW82e6DneaDQkEOgvkFEgxBIA=;
	b=ZqsZpDihG905MESX6nIexJViByUTUxSMXOrv9QaP0LFgQL5YiYYe5OKXGowaBLkEdJ5Xm1
	o90uJuXdUcyMJsKTJEhqxVScfiCV+Vi6j3O5R64vl111i5u/q8ZvzZpYOxhjVyLSxsadW0
	kQU6q5RzOTkHsQI3gvXcqwUPkL/RNdM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0D2F139D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0HV7ICDL12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 7/9] btrfs: zlib: prepare copy_data_into_buffer() for larger data folios
Date: Mon, 17 Mar 2025 17:40:52 +1030
Message-ID: <00571e99924d303e96fcef9b914f35489e009ea3.1742195085.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742195085.git.wqu@suse.com>
References: <cover.1742195085.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 900AD2212E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The function itself is already taking larger folios into consideration,
just remove the ASSERT(!folio_test_large()) line.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zlib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 3a7d136f57b4..b32aa05b288e 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -120,8 +120,6 @@ static int copy_data_into_buffer(struct address_space *mapping,
 		ret = btrfs_compress_filemap_get_folio(mapping, cur, &folio);
 		if (ret < 0)
 			return ret;
-		/* No larger folio support yet. */
-		ASSERT(!folio_test_large(folio));
 
 		offset = offset_in_folio(folio, cur);
 		copy_length = min(folio_size(folio) - offset,
-- 
2.48.1



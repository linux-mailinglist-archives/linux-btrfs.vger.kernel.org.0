Return-Path: <linux-btrfs+bounces-12299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB9A62354
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 01:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D993BFB17
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571D69450;
	Sat, 15 Mar 2025 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qbXhHx74";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qbXhHx74"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8A6AA7
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999390; cv=none; b=UQjLn5Q8q600V1/1Sk1heyxz6lE2Wi2EcrbYwQSTmhH52Y6ex7Ad0UF0NsTieZtv7VD5hzZ5o4mT6nbKFU3Q/x1Dx3r4UvJR1WvMVxV7oD9IpqVYEwrR4MrXZ0MOcwDPKhxwy880HKYyxB86ntYtHQTxBtRuOzhJCkRA1kN7duw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999390; c=relaxed/simple;
	bh=GEN3iJkWeDvE/KSQxPiVSF1LRJQphDfycxGUh2NOZUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mc4g/aVDZoSMqCSQEolvTlxMNX+IJVOYXf4ybXI16WWd7msGHprGsItMaRusuGVVh4nZmuxcxYgrniedknA/nRa5pvI8Z0Y5XCRpkNEpdPoc+P6+HxbLCs/9nH/PGXkZF6IXtfqXjcw/kKCysbAEoLXEn4IP8cIx6mMRNamOwLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qbXhHx74; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qbXhHx74; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6027D1F395
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjRDK+DEmvOJ6nnT06bW82e6DneaDQkEOgvkFEgxBIA=;
	b=qbXhHx7458YdHTwNAx+6RcyeeYj4Doc+kofn9DhP6fg+WpCcRLDWqt95uu6iG0WQFbouNF
	Fq1fJDqOroNFM9gwuYJkEQbDHZv0dxrmJp1o4+MzWdU0zMElVuK+PhdcvxlPO5+H4WQOz5
	CAW1jgylr9UR7m8m5nTIp2+N3yhJHk4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjRDK+DEmvOJ6nnT06bW82e6DneaDQkEOgvkFEgxBIA=;
	b=qbXhHx7458YdHTwNAx+6RcyeeYj4Doc+kofn9DhP6fg+WpCcRLDWqt95uu6iG0WQFbouNF
	Fq1fJDqOroNFM9gwuYJkEQbDHZv0dxrmJp1o4+MzWdU0zMElVuK+PhdcvxlPO5+H4WQOz5
	CAW1jgylr9UR7m8m5nTIp2+N3yhJHk4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50B6713797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IE6SOwjN1GegXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/7] btrfs: zlib: prepare copy_data_into_buffer() for larger data folios
Date: Sat, 15 Mar 2025 11:12:18 +1030
Message-ID: <de19482cf1201b07b1c55cd548fd6da625a21748.1741999217.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741999217.git.wqu@suse.com>
References: <cover.1741999217.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
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



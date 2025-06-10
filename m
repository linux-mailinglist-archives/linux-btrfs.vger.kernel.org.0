Return-Path: <linux-btrfs+bounces-14584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1657CAD3620
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 14:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62D61898B03
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF6290089;
	Tue, 10 Jun 2025 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PU6cb8zU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PU6cb8zU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520328F530
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557880; cv=none; b=Gm/hC9ICVhcfODE3lIp/wv7lFfrVahmWew/mrTevM2LuwTtHKValuaj6hAEclXMbCWiZyp5pEK1JhDcFpr8ouyDt5tSxb98iVv0Wsekuwv0aAncUxdLjuW1fPzZfC0Y6zVFrmjfzTWupJcjLkkQnc+7W8IDnu7AWfqyZz23+tpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557880; c=relaxed/simple;
	bh=7S/1hsT4Y7r+xsEgy+CZasolYYKRhYxxV7qVf7SYJcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejhTqvOAhBtC/jXh2/xsx8p3r10KNm07+NfcZ5iNW8fqmv+20ddNcj147VvzSOtdbmqD4JVHezW7Urd7XBfl8sKKx29RWSJ0iAiddbSp1nE7cUUcZevbRuMtfa+ePHnfpI9Y1DdwgS53JzAcdCt+RYPlkSZtOK7wBtCDIcL9K90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PU6cb8zU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PU6cb8zU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 08C501F7D1;
	Tue, 10 Jun 2025 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749557869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruhme/gK2NaNRDEVNMHr0BeDCM6DbRixW9zGnOsucjU=;
	b=PU6cb8zUfw9Ii3jJOkdYzni8fYIKLgVHgoFd4VIhVNRovN8HBJYpCzjZz8uqdKXY0ErFKv
	eEgvU+0MfkvtRyKijm1rg3o3j9p2BSz7LWFQFZQBZBZRCBh0fhfjh8GQKE8pXSN/bwZqqd
	Zky2Rx3fRIWBqKQmHRiqCKLlHRPUz9E=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749557869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruhme/gK2NaNRDEVNMHr0BeDCM6DbRixW9zGnOsucjU=;
	b=PU6cb8zUfw9Ii3jJOkdYzni8fYIKLgVHgoFd4VIhVNRovN8HBJYpCzjZz8uqdKXY0ErFKv
	eEgvU+0MfkvtRyKijm1rg3o3j9p2BSz7LWFQFZQBZBZRCBh0fhfjh8GQKE8pXSN/bwZqqd
	Zky2Rx3fRIWBqKQmHRiqCKLlHRPUz9E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F36B113AD9;
	Tue, 10 Jun 2025 12:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 37trO2wiSGiwcgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 10 Jun 2025 12:17:48 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/4] btrfs: simplify range end calculations in truncate_block_zero_beyond_eof()
Date: Tue, 10 Jun 2025 14:17:48 +0200
Message-ID: <f158a5836e767d722627920c4b3d5c5942e95b35.1749557686.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749557686.git.dsterba@suse.com>
References: <cover.1749557686.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

The way zoned_end is calculated and used does a -1 and +1 that
effectively cancel out, so this can be simplified. This is also
preparatory patch for using a helper for folio_pos + folio_size with the
semantics of exclusive end of the range.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 37626c6816f1..50e99b599275 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4819,9 +4819,9 @@ static int truncate_block_zero_beyond_eof(struct btrfs_inode *inode, u64 start)
 	 */
 
 	zero_start = max_t(u64, folio_pos(folio), start);
-	zero_end = folio_pos(folio) + folio_size(folio) - 1;
+	zero_end = folio_pos(folio) + folio_size(folio);
 	folio_zero_range(folio, zero_start - folio_pos(folio),
-			 zero_end - zero_start + 1);
+			 zero_end - zero_start);
 
 out_unlock:
 	folio_unlock(folio);
-- 
2.47.1



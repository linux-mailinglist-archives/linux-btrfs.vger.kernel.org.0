Return-Path: <linux-btrfs+bounces-7324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2155895752A
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 22:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F621C2369F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 20:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263F1553BC;
	Mon, 19 Aug 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gOtXbYq4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A2/k22fY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gOtXbYq4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A2/k22fY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C3518E0E
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097695; cv=none; b=bM7V7dNW8PRwCO9s/5DoIglp31/18A7uVQFYHuZ2HqKv+iVl8C6gnzIem5UsLPqQ43Shk30V6vwjaIyd0bpYeiQLMnSZ++XSMPEGqb06U9a9N7oYbZsZmz8P2TDCn+Uw3w7AsBvu7AqEHbOG63ZwUCHVgvgP0j+e8XkvU+ezTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097695; c=relaxed/simple;
	bh=/xJaGpRMf21nB/V3flW+Yyz/a6yCNfyVBtljTz5UUS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGSW97RFETGbH2Y6mkovzf23oVGGMARp4J21Jw8CqsHxDNeH7eSgGjP7ZGSOJFpyz2/9VuHqxumUXq0KCEKjzkh1uKMpfXLVJtc1d0ZNk2HqAftZKp6dJMjS+SehPQvKU3epTyyXJoGfSaex705ZZ4WD1whskQ3u5lcjoHTdjtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gOtXbYq4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A2/k22fY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gOtXbYq4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A2/k22fY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDD001FEF6;
	Mon, 19 Aug 2024 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724097691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aryJvOnfRQcs2azCGc+YqnSpYG7VGBB/7ZTmeZLETCY=;
	b=gOtXbYq4hnEnalW6DZaT2ChoEFBPDLc6ZZLx0650Rowf13bXqARH2onj+0sOq1z7++818w
	IvbyHz6f4QSCd0nmL4sXdpD42v3YgQEIIrbSbGJ7UDlD+l1OmlYN6XVtQWT8km/Z1kwRi6
	t3mP5ZYvhAPAhVbYqTdEFzTUyFi+C70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724097691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aryJvOnfRQcs2azCGc+YqnSpYG7VGBB/7ZTmeZLETCY=;
	b=A2/k22fY3O6bQaKhwPPetFvsmWPtTbwOmTwNfgyHLmWB1rdDZVpy5kix9xPtuBlkaoUPxm
	bf683MAWcKTFSFAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724097691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aryJvOnfRQcs2azCGc+YqnSpYG7VGBB/7ZTmeZLETCY=;
	b=gOtXbYq4hnEnalW6DZaT2ChoEFBPDLc6ZZLx0650Rowf13bXqARH2onj+0sOq1z7++818w
	IvbyHz6f4QSCd0nmL4sXdpD42v3YgQEIIrbSbGJ7UDlD+l1OmlYN6XVtQWT8km/Z1kwRi6
	t3mP5ZYvhAPAhVbYqTdEFzTUyFi+C70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724097691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aryJvOnfRQcs2azCGc+YqnSpYG7VGBB/7ZTmeZLETCY=;
	b=A2/k22fY3O6bQaKhwPPetFvsmWPtTbwOmTwNfgyHLmWB1rdDZVpy5kix9xPtuBlkaoUPxm
	bf683MAWcKTFSFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46C0F137C3;
	Mon, 19 Aug 2024 20:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kvAACJukw2a3ZgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Mon, 19 Aug 2024 20:01:31 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/2] btrfs: clear folio writeback after completing ordered range
Date: Mon, 19 Aug 2024 16:00:52 -0400
Message-ID: <9198bf5c9c56df6dc78a45ed2341595cb6307fef.1724095925.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724095925.git.rgoldwyn@suse.com>
References: <cover.1724095925.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -3.80
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Mark the folio as completed writeback only after ordered range has been
marked as finished. This is to make sure that the CRCs are written to
disk before a disk read is performed.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0bc4fa1f15cb..695589f02263 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -470,11 +470,11 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		"incomplete page write with offset %zu and length %zu",
 				   fi.offset, fi.length);
 
-		btrfs_finish_ordered_extent(bbio->ordered, folio, start, len,
-					    !error);
 		if (error)
 			mapping_set_error(folio->mapping, error);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
+		btrfs_finish_ordered_extent(bbio->ordered, folio, start, len,
+					    !error);
 	}
 
 	bio_put(bio);
-- 
2.46.0



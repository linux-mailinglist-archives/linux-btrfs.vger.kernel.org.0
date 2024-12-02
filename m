Return-Path: <linux-btrfs+bounces-10014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B8C9E0E18
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 22:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F91282187
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 21:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277351DF733;
	Mon,  2 Dec 2024 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xr0HCV/h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xr0HCV/h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD53D97A
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176101; cv=none; b=megTAhl7CQjUzdtGvxI/arHjorUN909ilOiBXUbuEx2qFXbx575jHaFf1jmZ7t5HRsTqchhrGn/m7EpbHeZWhn8n9ksSufsYazpQ434vQBH8voyG01eZFtL13OWf5SBwCkT1mluLa22nI0l3Uhsm/oFh+4LR2oDk7IufeCU6PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176101; c=relaxed/simple;
	bh=+KBTiu34U5er1+txZD9GUefXUyGiYmIJCVfagKKY23g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mYGwvQBgGBo/icFSzNxSsXh4wd5VXq9qw4o2qh5s6lW3x783u8azxytI0F1cwUjp7kfDvjuCycDiTrwqPQzMWofqorwywu4TybWMlmIOfh0jxiLlH+1/mMRo+5BDxxW9Vsltzc6JjJ1JWIo79EssGpkFc3QN1Oh5XI+WiZCjpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xr0HCV/h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xr0HCV/h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 705092115F
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 21:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733176092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kn5OTjhwaHH2MfXbaToYrGADONLht5Haky1C2vioLBA=;
	b=Xr0HCV/h135a3kwps7yNpiz7u9XFzWtgfp8Y5i+m1Y8XlHgJy25Al9YhCHj8O4tN2WMJAX
	xgmeM3PcXw7Butvz955O4202yjKlWRa8SBljqqIASVZPcX3H+lgugOGm6MLVIJu+nz4Zci
	TZ7eNYrZ9JavqlBMSTzeSXpzVIZbWx0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Xr0HCV/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733176092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kn5OTjhwaHH2MfXbaToYrGADONLht5Haky1C2vioLBA=;
	b=Xr0HCV/h135a3kwps7yNpiz7u9XFzWtgfp8Y5i+m1Y8XlHgJy25Al9YhCHj8O4tN2WMJAX
	xgmeM3PcXw7Butvz955O4202yjKlWRa8SBljqqIASVZPcX3H+lgugOGm6MLVIJu+nz4Zci
	TZ7eNYrZ9JavqlBMSTzeSXpzVIZbWx0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD8EA13A31
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 21:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9H3tGxsrTmewHAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2024 21:48:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: properly wait for writeback before buffered write
Date: Tue,  3 Dec 2024 08:17:53 +1030
Message-ID: <3fa83d6d472d78beb5fd519d0290b73d02d53d15.1733176045.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 705092115F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Before commit e820dbeb6ad1 ("btrfs: convert btrfs_buffered_write() to
use folios"), function prepare_one_folio() will always wait for folio
writeback to finish before returning the folio.

However commit e820dbeb6ad1 ("btrfs: convert btrfs_buffered_write() to
use folios") changed to use FGP_STABLE to do the writeback wait, but
FGP_STABLE is calling folio_wait_stable(), which only calls
folio_wait_writeback() if the address space has AS_STABLE_WRITES, which
is not set for btrfs inodes.

This means we will not wait for folio writeback at all.

[CAUSE]
The cause is FGP_STABLE is not wait for writeback unconditionally, but
only for address spaces with AS_STABLE_WRITES, normally such flag is set
when the super block has SB_I_STABLE_WRITES flag.

Such super block flag is set when the block device has hardware digest
support or has internal checksum requirement.

I'd argue btrfs should set such super block due to its default data
checksum behavior, but it is not set yet, so this means FGP_STABLE flag
will have no effect at all.

(For NODATACSUM inodes, we can skip the wait in theory but that should
be an optimization in the future)

This can lead to data checksum mismatch, as we can modify the folio
meanwhile it's still under writeback, this will make the contents
differ from the contents at submission and checksum calculation.

[FIX]
Instead of fully rely on FGP_STABLE, manually do the folio writeback
wait, until we set the address space or super flag.

Fixes: e820dbeb6ad1 ("btrfs: convert btrfs_buffered_write() to use folios")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
v2:
- Update the commit message and fixes by tag
  I was too focused on the syzbot report, not noticing it's a different
  commit causing the regression.
  Now removed the syzbot report part.
---
 fs/btrfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fbb753300071..8734f5fc681f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -911,6 +911,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 			ret = PTR_ERR(folio);
 		return ret;
 	}
+	folio_wait_writeback(folio);
 	/* Only support page sized folio yet. */
 	ASSERT(folio_order(folio) == 0);
 	ret = set_folio_extent_mapped(folio);
-- 
2.47.1



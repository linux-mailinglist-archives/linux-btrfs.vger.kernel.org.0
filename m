Return-Path: <linux-btrfs+bounces-13649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D16AAA917D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B30B175D4C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF020127B;
	Mon,  5 May 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lC/wEBWW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lC/wEBWW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801411F873B
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442897; cv=none; b=DuZ/LnyagLBwJgUuq+Oqn8o776GjL7gOjrTDfP6AlBspg/ts+bdUxgul1gSo3SKAJJebKXCn+rBq3q9ujUeD1lhlR2aCMioBp/WUK+GVCNYXFtyU1/v42WRIGAL1B7osttp/kv/wvNgbG11m0EbygnMwcPjSRJPSdwdYM2lnJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442897; c=relaxed/simple;
	bh=hlKQBKtJt5NhUCAozOt4dg2fr980F7R/HCVF3vYPMUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4umRORDF07d2mkVWCNMbJPP7mr32+NHyKsEbsptCocuPDEoiL53y9NeNanK3xIkeOPcUIPPh6ScTkHFK7/gay7UO/GTqLZjq9cf8Bsf3gNfzmuY+lIje0x4cCG4wlYX/DmqwOWtO74KXmflDnIYPUlghwuIspsge5TsfQV3QpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lC/wEBWW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lC/wEBWW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B8FA21249
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746442892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSV9ZTH+CgJcw9BSlzfbUHEAKxTyKXF2ulfFXAAXJ4M=;
	b=lC/wEBWWu+jmDVf1IkHMSNTFbkdoAcH2muLXiuti904/wcPshmHlsI5cvc1+c2PlNhJPEJ
	SWkonQuqwIrm4KHFXGS4SvJRyge8Z3fgYPv5Ebnkw44cnBUjgfdfUgOAPqU76MNs8eeBj5
	8XGmKVSaciarmj3xnuxpn2fTtL39tQ8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="lC/wEBWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746442892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSV9ZTH+CgJcw9BSlzfbUHEAKxTyKXF2ulfFXAAXJ4M=;
	b=lC/wEBWWu+jmDVf1IkHMSNTFbkdoAcH2muLXiuti904/wcPshmHlsI5cvc1+c2PlNhJPEJ
	SWkonQuqwIrm4KHFXGS4SvJRyge8Z3fgYPv5Ebnkw44cnBUjgfdfUgOAPqU76MNs8eeBj5
	8XGmKVSaciarmj3xnuxpn2fTtL39tQ8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A940D1372E
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PrVGouaGGg/CAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 May 2025 11:01:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: scrub: fix a wrong error type when metadata bytenr mismatches
Date: Mon,  5 May 2025 20:31:03 +0930
Message-ID: <63f648e441095d2b1fbc44f8c18110f974107a80.1746442395.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746442395.git.wqu@suse.com>
References: <cover.1746442395.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B8FA21249
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

When the bytenr doesn't match for a metadata tree block, we will report
it as an csum error, which is incorrect and should be reported as a
metadata error instead.

Fixes: a3ddbaebc7c9 ("btrfs: scrub: introduce a helper to verify one metadata block")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0d4818d25d8a..92cb75030729 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -611,7 +611,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
 
 	if (logical != btrfs_stack_header_bytenr(header)) {
-		bitmap_set(&stripe->csum_error_bitmap, sector_nr, sectors_per_tree);
+		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
 		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
-- 
2.49.0



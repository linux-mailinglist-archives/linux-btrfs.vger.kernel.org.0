Return-Path: <linux-btrfs+bounces-20166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88DCF951B
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BEE930563CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937DC313558;
	Tue,  6 Jan 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YmzkBjDc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YmzkBjDc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115927B50F
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716463; cv=none; b=FgFBGJRpOg1NhtfqCx5q3Pcv7bACWDBVPCZd//nhSY0Ha2kifiFssTMsvl9WIkMtfK3HatwHOfKe4l9kLncjfg2HO5Ua6e4wVK9gb17cAB+xTW+jqXMxD6tUKzWJzXwsYwEKD4EBGm4/Bc/p7GR4tgmpyGya+WyOW8u4eh+AU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716463; c=relaxed/simple;
	bh=Cvw0SKU3IBlxaPuAdzlEb9V7zGXPIAYJfJNo7dt7Rhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv+WxUhHlXOi+Rz+ifrmIPYYdZ1MBPSMH00vRwj4q1L/8BqOJeelZXPC3BPq4XzPi79tSVlbhMay99tzwEUUQNKtYnslWibAoCxjaO0CuWoPzSIk1z8dN3RJN32qnOv+Ii9v9c3y0LO7frAz8HtodANiiHMdt+PyG5gVD5xyiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YmzkBjDc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YmzkBjDc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02749336C2;
	Tue,  6 Jan 2026 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTNuk4/nmUXdQe+j965Se9RjmV9DiKbgYbT4fCcj0eQ=;
	b=YmzkBjDcH0k2smIXx/qf5g957w7R45BPDPBxTFV5x1I2hBc0+tkm8ZmeDhb+6f/FDDOD96
	ov86L+OPGQ4bsQpj9f7prpDHSvygWNNFsFRKuabMd9VVKhGRpuAjosYbtnJPu/SboNhiKG
	rBIOI77VnzKvfyt4oF1i3lq+t9/t8Hk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTNuk4/nmUXdQe+j965Se9RjmV9DiKbgYbT4fCcj0eQ=;
	b=YmzkBjDcH0k2smIXx/qf5g957w7R45BPDPBxTFV5x1I2hBc0+tkm8ZmeDhb+6f/FDDOD96
	ov86L+OPGQ4bsQpj9f7prpDHSvygWNNFsFRKuabMd9VVKhGRpuAjosYbtnJPu/SboNhiKG
	rBIOI77VnzKvfyt4oF1i3lq+t9/t8Hk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F04D13EA63;
	Tue,  6 Jan 2026 16:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nvCoOmE2XWmjWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:20:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/12] btrfs: rename local variable for offset in folio
Date: Tue,  6 Jan 2026 17:20:26 +0100
Message-ID: <2b6c0f20ed5022d29336268dce8f951dd78500e2.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.978];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

Use proper abbreviation of the 'offset in folio' in the variable name,
same as we have in accessors.c.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0a7ee47aa8aaab..b959d62f015ef5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -762,7 +762,7 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
 
 	while (low < high) {
 		const int unit_size = eb->folio_size;
-		unsigned long oil;
+		unsigned long oif;
 		unsigned long offset;
 		struct btrfs_disk_key *tmp;
 		struct btrfs_disk_key unaligned;
@@ -770,13 +770,13 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
 
 		mid = (low + high) / 2;
 		offset = p + mid * item_size;
-		oil = get_eb_offset_in_folio(eb, offset);
+		oif = get_eb_offset_in_folio(eb, offset);
 
-		if (oil + key_size <= unit_size) {
+		if (oif + key_size <= unit_size) {
 			const unsigned long idx = get_eb_folio_index(eb, offset);
 			char *kaddr = folio_address(eb->folios[idx]);
 
-			tmp = (struct btrfs_disk_key *)(kaddr + oil);
+			tmp = (struct btrfs_disk_key *)(kaddr + oif);
 		} else {
 			read_extent_buffer(eb, &unaligned, offset, key_size);
 			tmp = &unaligned;
-- 
2.51.1



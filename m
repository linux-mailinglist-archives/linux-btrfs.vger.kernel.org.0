Return-Path: <linux-btrfs+bounces-12710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D289BA77457
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 08:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2627A3698
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 06:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14401DF739;
	Tue,  1 Apr 2025 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Swo7uJyk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Swo7uJyk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DA41D8A10
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487992; cv=none; b=W2wZcSFRRf7XTGPv4o0r4gQVUzZg6MfmfdY/VlWRPv+yjilFi/C9CSb6ap7qpDrjbCzvABNg+tG+6Xw/J4YuVC7q4yfhHlq+KM4NqkDbLm17r3jyIPeKicCSIxnZxS3Fkl501VwK59CAFegL+xanguHI/Az56EDtndDGY7s35RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487992; c=relaxed/simple;
	bh=iU0RzMH4yAsn1Pwq+b6jmbp/jwl7KyKJ80PYbqbQpBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIfceJ5AtG7+iCji8XFWv2A/kGncLUnB1hIm5lCTok7vB6+lEJKX+78j22OgUE0ILulK8WnDyT8dk25mBFa6Gol7qb34lwKfuaaGuPp3IVgUaCUnzrGRiuxB8uHmcgnsmVBh1nXN233ZZHCXxCIcvvxwaikieCLQA+4iwP9AesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Swo7uJyk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Swo7uJyk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 105F0211A3
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743487977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/mv4VwvlfFEwIT4h6eWI7wQ6KqvXatZcf2mDtIInoo=;
	b=Swo7uJykfc2GdxnnjBruARignVxzThYEiDUAL14w+hI7FLsWAowsNZHTaVaTJQWpLyHiLy
	UqbT3VYl8G8Iz7RHzNqBpSVt4h48TPJfFxNwsIq3HZK3HDdFdCzlyacNNGuJxh2fMduBdV
	bkoJnZ31Bij9UG9KR3vtjPV//hicTAM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743487977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/mv4VwvlfFEwIT4h6eWI7wQ6KqvXatZcf2mDtIInoo=;
	b=Swo7uJykfc2GdxnnjBruARignVxzThYEiDUAL14w+hI7FLsWAowsNZHTaVaTJQWpLyHiLy
	UqbT3VYl8G8Iz7RHzNqBpSVt4h48TPJfFxNwsIq3HZK3HDdFdCzlyacNNGuJxh2fMduBdV
	bkoJnZ31Bij9UG9KR3vtjPV//hicTAM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41AF1138A5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 06:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IAFvAeiD62dcPgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 06:12:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix the ASSERT() inside GET_SUBPAGE_BITMAP()
Date: Tue,  1 Apr 2025 16:42:32 +1030
Message-ID: <9d2b4cb00e01eb1f42ebf0590d2367d9bd224b7a.1743487686.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743487685.git.wqu@suse.com>
References: <cover.1743487685.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

After enabling large data folios for tests, I hit the ASSERT() inside
GET_SUBPAGE_BITMAP() where blocks_per_folio matches BITS_PER_LONG.

The ASSERT() itself is only based on the original subpage fs block size,
where we have at most 16 blocks per page, thus
"ASSERT(blocks_per_folio < BITS_PER_LONG)".

However the experimental large data folio support will set the max folio
order according to the BITS_PER_LONG, so we can have a case where a large
folio contains exactly BITS_PER_LONG blocks.

So the ASSERT() is too strict, change to to
"ASSERT(blocks_per_folio <= BITS_PER_LONG)" to avoid the false alert.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 5fbdd977121e..d4f019233493 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -664,7 +664,7 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
 				btrfs_blocks_per_folio(fs_info, folio);	\
 	const struct btrfs_subpage *subpage = folio_get_private(folio);	\
 									\
-	ASSERT(blocks_per_folio < BITS_PER_LONG);			\
+	ASSERT(blocks_per_folio <= BITS_PER_LONG);			\
 	*dst = bitmap_read(subpage->bitmaps,				\
 			   blocks_per_folio * btrfs_bitmap_nr_##name,	\
 			   blocks_per_folio);				\
-- 
2.49.0



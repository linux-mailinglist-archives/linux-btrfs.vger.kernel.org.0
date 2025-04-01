Return-Path: <linux-btrfs+bounces-12713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBFA7759E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 09:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB84188B68E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0341E8320;
	Tue,  1 Apr 2025 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T8RkFDvs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GSI2V7wq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931082D05E
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743493857; cv=none; b=eWeSiDDpqhtBCFBszWV3cFwxRSLg6NpQ4DlHpv8FUVG2G6tiONelCgoopIy6MkUsuwunKhrR0FlPe6XBGjvuOn4SLl1y+qVn6hzIveasO53X7TTFHuhgHAa3Y74+Tcr9/QjGuGSzc7Q0ns3A68jkgByndMvrNVA44d2s0Ceyw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743493857; c=relaxed/simple;
	bh=YexXblRp6Q6Ov/FVbXBwiMkGLITLoyflA3BjkKtwafs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WrD2cTBEVf9zb7i8qYHyJL7JVGoF+eb1qIr5TzMKJBRzzgQ7BqZlXZC7CaKpTBHyOKzLcTBX8EDqMxgoYGkMfgBkI4AHCoRc2CTWTVVmkVpyDirc5htKc8p8uXHAKj32jH+JYOgImaEOJL+mhWElAOb7N+Tw46K3NlxExXCrVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T8RkFDvs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GSI2V7wq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 504E421174
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743493853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lMiYqcezf1ysnX1vDqJ+e/qi9ue9E/lZvH1+UcG8reA=;
	b=T8RkFDvsEvYQFUMDudSuN0zsdfiTuUHROKXpkFV2WKAD3ZM4xQ110ufMYefCRylHBwPh8w
	zdy7+L4Bw+b60TXdIoYwMD8GRWt/MsIUnrpwXrFqiquPyZqR813f3M6wWDOD7jteg6i5vu
	RjAzwypHdMBBnp0QXu7fyok2r2gaXGc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GSI2V7wq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743493852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lMiYqcezf1ysnX1vDqJ+e/qi9ue9E/lZvH1+UcG8reA=;
	b=GSI2V7wqTRKBfGNpTSUKWRSk1JH9MSxX40E8sJSlaSaAjcebBe8DTRWcx01SvV+d/g8Ntr
	ABmmiCcbIvwL7PPNSFifrP6zF93TB4YFhc139a1DdXFJEJY5b7/HuPYfx+AvezBq36/CQY
	UKX7cyVq55Xq+I36LxpalD2f2tAelv4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B1CA138A5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 07:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nwlDE9ua62egXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 01 Apr 2025 07:50:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: two small and safe fixes for large folios
Date: Tue,  1 Apr 2025 18:20:27 +1030
Message-ID: <cover.1743493507.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 504E421174
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGELOG]
v2:
- Fix a bug that page_pgoff() usage lacks left page shift

Two small and simple fixes.

The first one is that with large folios, we can have order 6 folios which
reached our current BITS_PER_LONG limit, triggering a previously
impossible ASSERT(), which is based on the fact that our largest page
size (64K) can not reach BITS_PER_LONG blocks per page.

An easily fix by extending the ASSERT() condition to cover
blocks_per_folio == BITS_PER_LONG cases.

The second one is a little more complex, that with large folios, if we
still go through the single page bio vec iteration, we can not call
page_offset(), as non-head pages of a large folio do not have their
page::index initialized properly.

Fix that by going a helper using page_pgoff() to calculate the file
offset, which handles both head and non-head pages of a large folio.

Qu Wenruo (2):
  btrfs: fix the ASSERT() inside GET_SUBPAGE_BITMAP()
  btrfs: fix the file offset calculation inside
    btrfs_decompress_buf2page()

 fs/btrfs/compression.c | 18 +++++++++++++++++-
 fs/btrfs/subpage.c     |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.49.0



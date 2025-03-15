Return-Path: <linux-btrfs+bounces-12298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27014A62352
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 01:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD09171913
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0346FC3;
	Sat, 15 Mar 2025 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pol32xa/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pol32xa/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A944A06
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999383; cv=none; b=NTmBdrltoBMUzcjUI3h81NoWtYzD9EIo0bAQ7d5t45dHXHdv0qcJTmkXXArRu9KykyX8w813Smjp29xQFsdx7oPtrt937Ikxgjfmxf5UnaReX/gZ7hStq80Yv+yHVV2zjJe17QsH2HKwpPMa1xysWtfllLX73wHKE9Hx21PeMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999383; c=relaxed/simple;
	bh=fV39FIZBHcLoysOcEHA/fNtbn1s1mlpDtFc3Eo+jfyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nars2wTIzZkDmNt0GmoKtzM44Qk+5QqEjg96eR8pttujs2+uFi4kbMp1gUr+o81Ns+jSG/8dBp3omEEP3zTa22nfEmT7+SF0n098cSsOJcCHjoCAAZoHqqyBFTaBkTH3Fss2ovZI9Th+dk0HKBm6QgwZrOhC60n3PCIR2JT1MqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pol32xa/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pol32xa/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B06981F394
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC3ZrLumjXEUxKYQAcQV/R5RberFyv50JmwDwX9aZy8=;
	b=Pol32xa/V5Q2l+jfY2gv9uqw5Ra7DZy6dBWBZrmmU4NqeJEXqRktXGnAd/YnxzA7YKI/4w
	aFnoz+SVRx9qgdp397SYyYk/l7T1XdsVJZRghIk4xWURcRRSDGnEs/6/WwXmICZ3bnUQRC
	g3BwsrfQBopil8echyyolASPqRwQBtQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Pol32xa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JC3ZrLumjXEUxKYQAcQV/R5RberFyv50JmwDwX9aZy8=;
	b=Pol32xa/V5Q2l+jfY2gv9uqw5Ra7DZy6dBWBZrmmU4NqeJEXqRktXGnAd/YnxzA7YKI/4w
	aFnoz+SVRx9qgdp397SYyYk/l7T1XdsVJZRghIk4xWURcRRSDGnEs/6/WwXmICZ3bnUQRC
	g3BwsrfQBopil8echyyolASPqRwQBtQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A32AF13797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iKEXFAfN1GegXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/7] btrfs: subpage: prepare for larger data folios
Date: Sat, 15 Mar 2025 11:12:17 +1030
Message-ID: <94c775a6f4e3c6cbdc01925bef85579eff0e6ee7.1741999217.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: B06981F394
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The subpage handling code has two locations not supporting larger
folios:

- btrfs_attach_subpage()
  Which is doing a metadata specific ASSERT() check.

  But for the future larger data folios support, that check is too
  generic.
  Since it's metadata specific, only check the ASSERT() for metadata.

- btrfs_subpage_assert()
  Just remove the "ASSERT(folio_order(folio) == 0)" check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 834161f35a00..bf7fd50ab9ec 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -69,7 +69,8 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage;
 
 	/* For metadata we don't support larger folio yet. */
-	ASSERT(!folio_test_large(folio));
+	if (type == BTRFS_SUBPAGE_METADATA)
+		ASSERT(!folio_test_large(folio));
 
 	/*
 	 * We have cases like a dummy extent buffer page, which is not mapped
@@ -181,9 +182,6 @@ void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *
 static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len)
 {
-	/* For subpage support, the folio must be single page. */
-	ASSERT(folio_order(folio) == 0);
-
 	/* Basic checks */
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-- 
2.48.1



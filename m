Return-Path: <linux-btrfs+bounces-7900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF469725BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 01:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A2B232A3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2024 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333918DF84;
	Mon,  9 Sep 2024 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="am8kunMd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rcPugo4i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="am8kunMd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rcPugo4i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90980130495
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Sep 2024 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725924433; cv=none; b=AiZNb0TOnHiCcuS9SPIxhwwOw62khPgKhsVZND1wJsW/3b9odNonK5W+gU6b3R9d+J1SSQlGBH31ctKwbg3gq7vfzdca4U2ltaMBfUXhwAXahkiKCGnMrULCrGNkMIMxeg+d08zm/JJt9BEDl/O6VKjfcV3lOzyjXYnEe9S5fTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725924433; c=relaxed/simple;
	bh=TGDlVYp9skuQdcav4jyEqavdJUDWjAR5NMRmRlmIBZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NqXGKb8LjZbNyO7Utqx6CyJtRKS3WO+HE39rfmv1RPiHrv30lTDTNJK6dCYe01V2HIUPVEwcobHlBYjcRieES7Vf2p6JK7AOUd7RLcAJaH2HK2ssB6/jUKwcadKjZ9U5wzQS7rVnPukGNJIJO6PHC1qAJkKhgSKExHa1Sny6tsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=am8kunMd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rcPugo4i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=am8kunMd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rcPugo4i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C3C321B51;
	Mon,  9 Sep 2024 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725924429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=26hUkW4J2TlfC9zjU/qk1SaPEU461/OAez4XcXqlfHc=;
	b=am8kunMdi6eAMDt/bjaa37Uu5VQyratT/hmdd25CoN/nNQVnLTBd6u5vbnrwOat1E5h+wl
	B4yfdZrvzLd3leD9lEfPNlDrYOXyiucSreuFFuBaxg/jAz8w+ajyk6a+NL3dwZsQuLBzpE
	99lXoPzIKM7VnM6TztDP7gt0zDy3eWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725924429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=26hUkW4J2TlfC9zjU/qk1SaPEU461/OAez4XcXqlfHc=;
	b=rcPugo4iHUPHBbq0fF+yXSUzyX86D1VH5EF8CG3HRAX4syiefnu5xdNUdwHtBeitzdtGe8
	hKcP7OGp4lybcUCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725924429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=26hUkW4J2TlfC9zjU/qk1SaPEU461/OAez4XcXqlfHc=;
	b=am8kunMdi6eAMDt/bjaa37Uu5VQyratT/hmdd25CoN/nNQVnLTBd6u5vbnrwOat1E5h+wl
	B4yfdZrvzLd3leD9lEfPNlDrYOXyiucSreuFFuBaxg/jAz8w+ajyk6a+NL3dwZsQuLBzpE
	99lXoPzIKM7VnM6TztDP7gt0zDy3eWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725924429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=26hUkW4J2TlfC9zjU/qk1SaPEU461/OAez4XcXqlfHc=;
	b=rcPugo4iHUPHBbq0fF+yXSUzyX86D1VH5EF8CG3HRAX4syiefnu5xdNUdwHtBeitzdtGe8
	hKcP7OGp4lybcUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0E5313A3A;
	Mon,  9 Sep 2024 23:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tIndFkyE32Z6KgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Mon, 09 Sep 2024 23:27:08 +0000
Date: Mon, 9 Sep 2024 19:26:57 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] Lock page before checking for subpage in
 btrfs_subpage_start_writer_lock()
Message-ID: <xzakhkmqeav3ffk52ywudw6mx3l5ewwdrlyetnu55kht744gvl@awcq4gf4mee5>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

btrfs_subpage_start_writer_lock() locks the folio before
returning. The function checks the condition if it needs to process
subpage and then locks and returns 0.

Instead, first lock the folio and then check for subpage. This avoids
calling folio_lock() before returning.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ca7d2aedfa8d..1b501db14db0 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -361,11 +361,11 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
 				  struct folio *folio, u64 start, u32 len)
 {
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
-		folio_lock(folio);
-		return 0;
-	}
 	folio_lock(folio);
+
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping))
+		return 0;
+
 	if (!folio_test_private(folio) || !folio_get_private(folio)) {
 		folio_unlock(folio);
 		return -EAGAIN;



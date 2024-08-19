Return-Path: <linux-btrfs+bounces-7323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B27957529
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 22:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F01F257B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661C1DD390;
	Mon, 19 Aug 2024 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VgixNXd5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XrP24AET";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VgixNXd5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XrP24AET"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4618E0E
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097692; cv=none; b=EBE3POPS4XfAxBwvSn7+K3dn+Y0k4O6z9/bOIx6Y716h1mLJt/8gMt2ylkbrUuoJiH/VjsTRCuaVt/uqrpoiZ5J6JPsNA0ErXg5KK4VkpJYCnwJ7RdRrWc1y0vVEdBudkwJgKBfFcq+yVkoNJ+g1E22KkBimwpKQlozhqo2L+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097692; c=relaxed/simple;
	bh=srAvFjPLovCmit6fz/QndGVpTzpSE0/j+539hHXYe7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAP3QJBhxXrgS2l4mDTkGtubr6v8CytTDFZW5A0S6SGxJzEPHzDPx9sL3FrGXsnOVM7MHuKXWa1cmPMvCdgUIHxFqxm/D58mjfj8SesNjFaqub6rnU51Relouv1tB6f8TUnVlDgV/vdNwPniQ6A1N1B2nI8KxMDVpeA1DpXsx6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VgixNXd5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XrP24AET; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VgixNXd5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XrP24AET; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F8431FEF4;
	Mon, 19 Aug 2024 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724097688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rbpZ1ImgiCllce3+0WV5IKg2JaQf5MQlBYqmdghyTIM=;
	b=VgixNXd5G/RH5tG+5qOJE0D0AkciRQ9jOYmF/aOwHOAmlgupZYhWixYa2bSN0lq1TZBwoU
	Y8buuza+gYfKusjwcOkUhwxy5mScnTJCWrOscVAt94PzOIDjEEr9o6XxSSCbflwHxlri2O
	dBSbI5WG8i7E5PeMaHAGG1+OFLELimE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724097688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rbpZ1ImgiCllce3+0WV5IKg2JaQf5MQlBYqmdghyTIM=;
	b=XrP24AETRavgiTaaLht0S1h4x00+jXxNDb6sFu1ShNtC0QDlLgGYYpxEcqEToPooCvYQ5Q
	qPRMTr7utyclreAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724097688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rbpZ1ImgiCllce3+0WV5IKg2JaQf5MQlBYqmdghyTIM=;
	b=VgixNXd5G/RH5tG+5qOJE0D0AkciRQ9jOYmF/aOwHOAmlgupZYhWixYa2bSN0lq1TZBwoU
	Y8buuza+gYfKusjwcOkUhwxy5mScnTJCWrOscVAt94PzOIDjEEr9o6XxSSCbflwHxlri2O
	dBSbI5WG8i7E5PeMaHAGG1+OFLELimE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724097688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rbpZ1ImgiCllce3+0WV5IKg2JaQf5MQlBYqmdghyTIM=;
	b=XrP24AETRavgiTaaLht0S1h4x00+jXxNDb6sFu1ShNtC0QDlLgGYYpxEcqEToPooCvYQ5Q
	qPRMTr7utyclreAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE2FB137C3;
	Mon, 19 Aug 2024 20:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id acJFLpekw2aqZgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Mon, 19 Aug 2024 20:01:27 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 0/2] Reduce scope of extent locking while reading
Date: Mon, 19 Aug 2024 16:00:51 -0400
Message-ID: <cover.1724095925.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Extent locking is not required for the entire read process. Once the
extent map is read all information to retrieve is available in the
extent map, and is cached in em_cached for later retrieval. The extent
map cached is also refcounted so it would not disappear.
Limit the extent locking while reading the extnet maps only. The rest is
just creating bio and fetching/decompressing the data according to the
extent map provided.

The only reason this was not working is because we would get EIO as
the CRCs would not match (or were not committed to disk as yet) for
folios that were written and released. In order to get over it, mark the
extent as finished only after all folios are cleared of writeback.

I have run the xfstests on it without any deadlocks or corruptions.
However, a fresh outlook on what could go wrong with a limiting the
scope of locks would be good.

Goldwyn Rodrigues (2):
  btrfs: clear folio writeback after completing ordered range
  btrfs: take extent lock only while reading extent map

 fs/btrfs/compression.c |  5 ---
 fs/btrfs/extent_io.c   | 99 +++---------------------------------------
 2 files changed, 7 insertions(+), 97 deletions(-)

-- 
2.46.0



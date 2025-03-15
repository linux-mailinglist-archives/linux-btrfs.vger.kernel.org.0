Return-Path: <linux-btrfs+bounces-12296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C125A62351
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 01:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD71701CD
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94704AD51;
	Sat, 15 Mar 2025 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C4Z+S7kC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C4Z+S7kC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71B16426
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999376; cv=none; b=mwZyCnod95+aDGFTwFrikx+JwbBEewj1n9/c05gko0PZIrBoGlW+8k2+HxAZii/bTg846eOTlRbx8kezCAL0t72OcmcdhyIhMbTN7jhqM2eGNduYKS1EaqHV9IjvIznN9ElKXnO8Z3wQ2RLgIr64uj2xzvVOVLJtGrIKVP63B7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999376; c=relaxed/simple;
	bh=/xzmG5K76lfmL5ajvWSgzrrRon+QcYkuwFUJpQk94xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTWrFXxaZuS8dFzqoe6YY/DsoZICm/8SSMMcKWyek6c2rdfGs1VjYEx/Lao1cgyN2/D9tlk5YVNlpgVI0D9S8r4rRkFQF9PrnyxWmEQ3+Gdx4RrT0Z1YzXD8NmTfrM2mBuxAjsE8tyY2Up1Mz3nVD37zI86U9KFdR0TiruCMoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C4Z+S7kC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C4Z+S7kC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C97F21174
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uLHrKI2W0qNotF19LaH0Esuj3bfTzC1d82Ak37dtTg=;
	b=C4Z+S7kCgKMTc7EVwu69RPjTrwip4yjjFMrGjIsj714ij90x/YouQNQ2twwLD18Lwc4EoV
	br1Ybhcel4SqSvJLfZ2JB7l6Z2iahzCvmsleJimLHI0g6CQ67RoaREXc8lv1I4ieI3A3WL
	QtGFS8p96Hg6fiC+aLvC4XAQawictyE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uLHrKI2W0qNotF19LaH0Esuj3bfTzC1d82Ak37dtTg=;
	b=C4Z+S7kCgKMTc7EVwu69RPjTrwip4yjjFMrGjIsj714ij90x/YouQNQ2twwLD18Lwc4EoV
	br1Ybhcel4SqSvJLfZ2JB7l6Z2iahzCvmsleJimLHI0g6CQ67RoaREXc8lv1I4ieI3A3WL
	QtGFS8p96Hg6fiC+aLvC4XAQawictyE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 392A513797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yHWWNQPN1GegXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/7] btrfs: prepare prepare_one_folio() for larger data folios
Date: Sat, 15 Mar 2025 11:12:15 +1030
Message-ID: <d2d7e40ffd88980a8f72cc81ee27b371123b2999.1741999217.git.wqu@suse.com>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The only blockage is the ASSERT() rejecting larger folios, just remove
it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4213807982d6..c2648858772a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -875,8 +875,6 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 			ret = PTR_ERR(folio);
 		return ret;
 	}
-	/* Only support page sized folio yet. */
-	ASSERT(folio_order(folio) == 0);
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
 		folio_unlock(folio);
-- 
2.48.1



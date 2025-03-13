Return-Path: <linux-btrfs+bounces-12253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB645A5EA83
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 05:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770B93B522D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 04:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0252CCC5;
	Thu, 13 Mar 2025 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jW3RnX1j";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jW3RnX1j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706247DA6A
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839699; cv=none; b=j26PLaHsS241W24s7gDULcMWY5nHfI0L3mBT8tHJBNeg5TZ97sPB+nEcw8we+YUSdr92WuMj7QbnSGTteSMm0yMQIrhWt3AVBFwokjv+OGTntBnB7P43OCOCkWU3gIFH0vIBqcqil0/qNlPHcCbfjIKvGkle/lhlXTJLMNKnb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839699; c=relaxed/simple;
	bh=/xzmG5K76lfmL5ajvWSgzrrRon+QcYkuwFUJpQk94xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdT9i2Wi4bHx42XWdsfbtP64C+SUsX1ilkm6v/M85HZWQOs2Awm9CTjihAUk8xLS4c3ywigb9mhkHCsaIX19G86mad+GVqiAKoqwybubI4TnM3iK0rnpmpLJr51y4JNFmYMW5VVJb43DsHnyTdZl5f+D583pl/rpgrS2k2sGxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jW3RnX1j; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jW3RnX1j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8A1D2118D
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uLHrKI2W0qNotF19LaH0Esuj3bfTzC1d82Ak37dtTg=;
	b=jW3RnX1jpVmxI+OGZU/4uRQY7hcQJNrmBxqgo+5JO0nRaxDm0P/AjIEo/xwcbR4+CLTuVH
	LvRpfkixCMCbxuEAC7Z0J1Ya4HyBBWqP8uLUWkzEf8x1VipKsiL1VPYUsBgWe44BTxjHkT
	7dRLUqM79qZOKR2D34RGDW+JMxZ1kEc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=jW3RnX1j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uLHrKI2W0qNotF19LaH0Esuj3bfTzC1d82Ak37dtTg=;
	b=jW3RnX1jpVmxI+OGZU/4uRQY7hcQJNrmBxqgo+5JO0nRaxDm0P/AjIEo/xwcbR4+CLTuVH
	LvRpfkixCMCbxuEAC7Z0J1Ya4HyBBWqP8uLUWkzEf8x1VipKsiL1VPYUsBgWe44BTxjHkT
	7dRLUqM79qZOKR2D34RGDW+JMxZ1kEc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F277413797
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sNwALDdd0mcrYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: prepare prepare_one_folio() for larger data folios
Date: Thu, 13 Mar 2025 14:50:46 +1030
Message-ID: <20cf962e9d343e2549d43fa95f3169b088370efb.1741839616.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741839616.git.wqu@suse.com>
References: <cover.1741839616.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C8A1D2118D
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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



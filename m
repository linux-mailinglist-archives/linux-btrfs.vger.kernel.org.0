Return-Path: <linux-btrfs+bounces-12319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AE1A64305
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B55188386F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13221ABB7;
	Mon, 17 Mar 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IVy+bld0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IVy+bld0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB99321ADA9
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195511; cv=none; b=j835E2Gp+TCO3GJKnRJuLsR5Kl9/Y5aJGZojCBukQIndMrxqQSspndgIdhga8V2AZFbYciWpeRGP5C/LRsYMcu0YWOIvXympM6EojaT3yTjvyEP8bi5czHk++ScLK/lPACIaHAo/PPDMY5l5aMOP1RP1vFvpb8eQpCToP3AMjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195511; c=relaxed/simple;
	bh=/xzmG5K76lfmL5ajvWSgzrrRon+QcYkuwFUJpQk94xk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEQYF1EZPiQ3nQItx8s74SYUa9eqfScXkjc/VfdvkCQIUPR2jjdSu+g20piHoLcK3HTOjxWC83I7B3D00gsdArFAIEgoFuWtruL68dfLiEPi0rYDHl2906ZKk7/0pWCtFbNV+h5ybexaQQfulX0ToVSGmqHgO9/s8rz5/UFask8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IVy+bld0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IVy+bld0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C899922114
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uLHrKI2W0qNotF19LaH0Esuj3bfTzC1d82Ak37dtTg=;
	b=IVy+bld03iBug88OMs9MB1VTNUUDRFSdSFOIJZ0+LtaGUUQNQ2MaaDyQXxaZpNacQS4CG+
	/dltl31FCx7akPJciGU8X6Kksur44a+pyRzoTDuZreEUe+Cq7pbu7srWvYxxguffKvqk/Q
	TrTVPwomzd3jczsqbufztXwtz99EnpI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uLHrKI2W0qNotF19LaH0Esuj3bfTzC1d82Ak37dtTg=;
	b=IVy+bld03iBug88OMs9MB1VTNUUDRFSdSFOIJZ0+LtaGUUQNQ2MaaDyQXxaZpNacQS4CG+
	/dltl31FCx7akPJciGU8X6Kksur44a+pyRzoTDuZreEUe+Cq7pbu7srWvYxxguffKvqk/Q
	TrTVPwomzd3jczsqbufztXwtz99EnpI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 065B9139D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SP2fLhzL12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/9] btrfs: prepare prepare_one_folio() for larger data folios
Date: Mon, 17 Mar 2025 17:40:49 +1030
Message-ID: <a7e018735545d46b1eb689b927b96a2ded26fd3e.1742195085.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742195085.git.wqu@suse.com>
References: <cover.1742195085.git.wqu@suse.com>
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



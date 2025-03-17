Return-Path: <linux-btrfs+bounces-12314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904B2A64300
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 08:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0822C3A5D4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA3321ABB2;
	Mon, 17 Mar 2025 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QQsVlTQJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QQsVlTQJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805A21ABC9
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195494; cv=none; b=PAMAo14aYfAA9k8e0osFXu/FAa4+xjpNAKYNxVyc47jN6rbCq8VARP1ZhinlY4wy0WrsZ4waJxWn95TGDSQTOx8EuqNmU4Irnku/uH537gWCdHGmjzxm31ty1qgVvCl3IlMIsUN4XnDlXvn83S3gA2wRVg9Ewr9I0tDnw7JsO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195494; c=relaxed/simple;
	bh=mp7Hg6NTG1kBcAShqejDWAvWrektxAdwNKEVLqfJgn0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCO8ZosrcF8zgFXKYhskpPrZROiGDIy3nO6BlK89IsUp/YQYRhZt+mV0EXvxarR+eKOW3tiF4OZ0D8buads5GQMolA7TUw1ZHqidcWTyqMyvyyEbpSVdCT9mdI99Ql5Y+AByE+F8vbyskJuYHvDR0wEwyEOy/Ox9OE4ACXqv14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QQsVlTQJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QQsVlTQJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16DC420190
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Awe5QSBb8KdrfiIW4nThvXS249QD03t8AlI5GqNY4I4=;
	b=QQsVlTQJ1ChDzhGbolnWb+fATvJStrxf/g6dFD1Y4jQZ7LcF+xgcDjPDYfrl7PhF3pRv0f
	w1BZexjF/0zu24ffRVhBFwOrnAI3zTfuNSdRV4vDIF5UTPonfFD1HFF4fwt1V7Wka5/2R3
	B2GUcFSmMDge/A9t3mKqTv5QxsbuEUY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742195487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Awe5QSBb8KdrfiIW4nThvXS249QD03t8AlI5GqNY4I4=;
	b=QQsVlTQJ1ChDzhGbolnWb+fATvJStrxf/g6dFD1Y4jQZ7LcF+xgcDjPDYfrl7PhF3pRv0f
	w1BZexjF/0zu24ffRVhBFwOrnAI3zTfuNSdRV4vDIF5UTPonfFD1HFF4fwt1V7Wka5/2R3
	B2GUcFSmMDge/A9t3mKqTv5QxsbuEUY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 475EE139D2
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OLzbAh7L12e1YwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 07:11:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 5/9] btrfs: prepare end_bbio_data_write() for larger data folios
Date: Mon, 17 Mar 2025 17:40:50 +1030
Message-ID: <ed24c6a155501d460df61047035502526fe4ad85.1742195085.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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

The function is doing an ASSERT() checking the folio order,  but all
later functions are handling larger folios properly, thus we can safely
remove that ASSERT().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7db74a173b77..d5d4f9b06309 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -462,9 +462,6 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		u64 start = folio_pos(folio) + fi.offset;
 		u32 len = fi.length;
 
-		/* Only order 0 (single page) folios are allowed for data. */
-		ASSERT(folio_order(folio) == 0);
-
 		/* Our read/write should always be sector aligned. */
 		if (!IS_ALIGNED(fi.offset, sectorsize))
 			btrfs_err(fs_info,
-- 
2.48.1



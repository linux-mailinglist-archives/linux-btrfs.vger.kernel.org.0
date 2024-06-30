Return-Path: <linux-btrfs+bounces-6052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1FF91D009
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jun 2024 06:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE661C20B68
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jun 2024 04:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FEB2AF12;
	Sun, 30 Jun 2024 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gDiGjcrp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rE2AWl8v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E910E6
	for <linux-btrfs@vger.kernel.org>; Sun, 30 Jun 2024 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719722847; cv=none; b=U4VhVr6mkL4xB0JA8mWL4ZySOofYydt6mOrGJu4qBkYcS3+/lql5gioDUINKIvG8DNuu1vYfintJMD0AIaJiZYZaLHvfPBdp3y01Y6mMov7ks9YFZouUNZ44C9OtLU4uoqnu07yH/0XeEw7xZp692QQPBghwc+N0VMjBfEfEolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719722847; c=relaxed/simple;
	bh=+uMHd0ZnnXd2mWFrEiXpqoh+tQjflaNPS9eJ5q9ENfs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UJr+J8ypNltJqWHTyq+ZT29U+mIKz6TCRgw4LlCGfQRovq0NeiXhYLt9XNUKk1K791ffnby0lTXilclE8l+mxGyCScGZTNJrYXNKPPyUdDBOiVFNSDxtOE4056ExjaJbJP5k7H4KYAbiIGEAqnFHb3532KweHP+B0EF6GkIzv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gDiGjcrp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rE2AWl8v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A9AF21BEA;
	Sun, 30 Jun 2024 04:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719722835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X1YgYH2MX1INAdZBNXDDBsErl1GVvMZEJ/1tjk9KUt8=;
	b=gDiGjcrp2ADhQnM2WE3PAWxUc2kQR4VXscKRBYBn5s9+u7ZhTVQjQxeYuiTb6a1eHYaEyu
	B9BHTFyoEPJW8KeHdSJ2Y7T8XKI75mwlzwJArI5EoFnqx0SU+Kg4JzDYiqfR/xlbWVcECr
	oYg3uAMaJDVJhKfbuGCo5I/nGKzdWNE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719722834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X1YgYH2MX1INAdZBNXDDBsErl1GVvMZEJ/1tjk9KUt8=;
	b=rE2AWl8vjO96K8qrSV+LT5lb8Wi5No7a8Bb35dPGvgNiLb8VXSCegcjND/o6MwOdDhPnaD
	ZgmGR8EcVKk0MzPKTHfADy2ovGa2WZuR5rdO/D01I+YzQ1GoYLtE6M949p9d4Ds1hd9jbB
	ctnBpcrlzDNWvPWmti1+sAmaSgTKHX4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B0061340C;
	Sun, 30 Jun 2024 04:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pt6IAVHjgGZXDwAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 30 Jun 2024 04:47:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/page_alloc: unify the warning on NOFAIL and high order allocation
Date: Sun, 30 Jun 2024 14:16:51 +0930
Message-ID: <0432aa5966e7bc9d88a05dcacb210b80320e0700.1719722782.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.64
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.64 / 50.00];
	BAYES_HAM(-2.84)[99.33%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

Inside rmqueue() there is a dedicated WARN_ON_ONCE() to make sure
__GFP_NOFAIL is not combined with any order > 1 allocation.

However the following locations are doing the same check, but with
order > PAGE_ALLOC_COSTLY_ORDER as the threshold:

- VM_BUG_ON() inside pcp_allowed_order()
- WARN_ON_ONCE_GFP() inside __alloc_pages_may_oom()

So this looks like a behavior mismatch, and it's better to unify all the
__GFP_NOFAIL check using PAGE_ALLOC_COSTLY_ORDER for the order.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..697e5cc7f3f1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3005,9 +3005,11 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	/*
 	 * We most definitely don't want callers attempting to
-	 * allocate greater than order-1 page units with __GFP_NOFAIL.
+	 * allocate greater than PAGE_ALLOC_COSTLY_ORDER page units
+	 * with __GFP_NOFAIL.
 	 */
-	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
+	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) &&
+		     (order > PAGE_ALLOC_COSTLY_ORDER));
 
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
-- 
2.45.2



Return-Path: <linux-btrfs+bounces-22073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGVdHTu3oWm+vwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22073-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 16:24:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A91B9B8D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 16:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB66630AEC8B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 15:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DC643DA52;
	Fri, 27 Feb 2026 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="I5Mwv879"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7643D4EE;
	Fri, 27 Feb 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205508; cv=none; b=gEoyLJOCneZBZmYoJ4JXdnm06y/SzdFM8JySoqrfHttF+d5q6/dpMMf1+yu33KChHEN4Bk8/Ix8AQaRKhMJ6sRSWVqvfYKn1YCeINeYFgLfFtIkUQ7GLdGwQj3L6R4iC4JTi8HyzJNTsBJzevIWVrszxkVXBb5erJcOGZdKckB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205508; c=relaxed/simple;
	bh=fl7jQGTvsC3ojATpqZT9R/QFVdjDoWbg5HqK9AjFOnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyJHldF6D/bmA1KWtCKM1OeKwRkXyKbJc5HHF5qgXwU4RMzrZKSMQCWerNHij0sZf4HaFvM3QfTGd/tlu23NcFwXFJG6aU9c8vjPldwDM9n3iAu4VZL36E3IR/tCu+wu2UWAdDHGQZB5x7WngR7+3vr32kq23ajPUhVbihKBryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=I5Mwv879; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fMsR144x0z9tdd;
	Fri, 27 Feb 2026 16:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1772205501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2gr55nK34t+qwZft7veoNCYKCfapDhr2mloccIQd3E=;
	b=I5Mwv879ZWzdczKLrD32izj+kLCCQzBirrw7tLJMIVlLkg6vO0zzXBV3K7zxi1dZ1neRpw
	3DwbQX/cqyTQfi0inpIkCQilGfyzWkkdF+pqqdyyroMBqWAB7iiq0kc0nSMoQelPaC4yEa
	ZMJ9z6vzC4iO+2tgYwMKLowI7tvYTJYGrk7E46y0vzpjZzIL02imX52t1Bsc6j1MzN0s/V
	hqXqduQhELyVoSCa9mGxau7PhAyLylsPjRFo+S2TBSDVEC0lZw55GSye5pNhASJk370J2Z
	jzLWgPDqUdeAJXEyvBe9Of+LjCQG57saoBpVCEURMJZhTxFLi9rZu0b/soOPpw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: dsterba@suse.com
Cc: clm@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 2/2] btrfs: return early if allocations fail on raid56
Date: Fri, 27 Feb 2026 16:17:59 +0100
Message-ID: <20260227151759.704838-3-mssola@mssola.com>
In-Reply-To: <20260227151759.704838-1-mssola@mssola.com>
References: <20260227151759.704838-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22073-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mssola.com:mid,mssola.com:dkim,mssola.com:email]
X-Rspamd-Queue-Id: 236A91B9B8D
X-Rspamd-Action: no action

In both the recover_sectors() and the recover_scrub_rbio() functions we
initialized two pointers by allocating them, and then returned early if
either of them failed. But we can simply allocate the first one and do
the check, and repeat for the second pointer. This way we return earlier
on allocation failures, and we don't perform unneeded kfree() calls.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/raid56.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index e31d57d6ab1e..c8ece97259e3 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2094,8 +2094,8 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
 
 static int recover_sectors(struct btrfs_raid_bio *rbio)
 {
-	void **pointers = NULL;
-	void **unmap_array = NULL;
+	void **pointers;
+	void **unmap_array;
 	int sectornr;
 	int ret = 0;
 
@@ -2105,11 +2105,15 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 	 * @unmap_array stores copy of pointers that does not get reordered
 	 * during reconstruction so that kunmap_local works.
 	 */
+
 	pointers = kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
+	if (!pointers)
+		return -ENOMEM;
+
 	unmap_array = kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
-	if (!pointers || !unmap_array) {
-		ret = -ENOMEM;
-		goto out;
+	if (!unmap_array) {
+		kfree(pointers);
+		return -ENOMEM;
 	}
 
 	if (rbio->operation == BTRFS_RBIO_READ_REBUILD) {
@@ -2126,7 +2130,6 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
 			break;
 	}
 
-out:
 	kfree(pointers);
 	kfree(unmap_array);
 	return ret;
@@ -2828,8 +2831,8 @@ static inline int is_data_stripe(struct btrfs_raid_bio *rbio, int stripe)
 
 static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 {
-	void **pointers = NULL;
-	void **unmap_array = NULL;
+	void **pointers;
+	void **unmap_array;
 	int sector_nr;
 	int ret = 0;
 
@@ -2839,11 +2842,15 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
 	 * @unmap_array stores copy of pointers that does not get reordered
 	 * during reconstruction so that kunmap_local works.
 	 */
+
 	pointers = kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
+	if (!pointers)
+		return -ENOMEM;
+
 	unmap_array = kzalloc_objs(void *, rbio->real_stripes, GFP_NOFS);
-	if (!pointers || !unmap_array) {
-		ret = -ENOMEM;
-		goto out;
+	if (!unmap_array) {
+		kfree(pointers);
+		return -ENOMEM;
 	}
 
 	for (sector_nr = 0; sector_nr < rbio->stripe_nsectors; sector_nr++) {
-- 
2.53.0



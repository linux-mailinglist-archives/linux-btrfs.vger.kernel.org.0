Return-Path: <linux-btrfs+bounces-7580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A7C96198B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFC31C23067
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01ED1D415E;
	Tue, 27 Aug 2024 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lj8nwtvZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fnsrQOFF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A491D3652
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795728; cv=none; b=fzo0WUpSJOfQwxJq8zWMQ5VE2HiIuZNIRJr+tySEyTx6yFOb+7hDzoS//ODvV9RGdBmNOk+xUPZvjBI1+gVj9T0mmvxt86elgTzKKXkceuCfuNOwqRgdW8vzweKHldLIDNWfXy5/WbFCAIGwGgajxr66fBygob5vy8pAIKlE0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795728; c=relaxed/simple;
	bh=KRTYuQ0EJ5+oXOcy+3mGa1CooSBO6HTl9SoMSR0kB30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMsa0IUEvObpc2ZPWNEb6hbkwJbGsdOrdpLSZ0E40WFlm8g4xSe2o8U4tXpLMJLBWkVLBD6UnlEYtfQLjMGafvwchGpRhhVf8tNDBAxYAahYxVTdsbDp3OnXYf4tzTX4Y1JqreCmLQRc1KFaLGsPu9nPERTnW1HcIbq0cLocbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lj8nwtvZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fnsrQOFF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9571FB85;
	Tue, 27 Aug 2024 21:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sD06mQ3OxzAzF+QeJ9lNVUNR7h9fbumiIkbfIYZoPwY=;
	b=lj8nwtvZUeKqCmE1O3L4k02ss8uRfh2+1K6IbQs3jZYmZbOcBI7dTCl6co+CEmUfEDlBCy
	Cc4IckFmdvsvPdRGbNil8LMQ+r1LxyTBgfOXPab5r/PCrhnpQRNlzZn4AD3CwlgGczixL0
	sOiTJWEtAUB2G6FXyHXOl8tYqhT2YjQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sD06mQ3OxzAzF+QeJ9lNVUNR7h9fbumiIkbfIYZoPwY=;
	b=fnsrQOFFvyrcZR6OdD034l3VhaKnEHSLK62AegpjZOs3nhfg+HUFR+8EwZuJh9SMDwJK/c
	zvzmN9G85iO6i06OK0IiYFwlMYB7fDrlS91sg706M9r52lAE3f9EE2bxR/Kn6jUcygiOgQ
	WDnuZQCk0by+iQopHfocSpnGz1A68U4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56CD413A20;
	Tue, 27 Aug 2024 21:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bn0uFUpLzmZgGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/12] btrfs: rename __btrfs_submit_bio() and drop double underscores
Date: Tue, 27 Aug 2024 23:55:22 +0200
Message-ID: <6716b61ac93f5717509cde56e2fe1443ee3578ab.1724795624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Previous patch freed the function name btrfs_submit_bio() so we can use
it for a helper that submits struct bio.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4f3e265880bf..d5dcc356df33 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -502,8 +502,8 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 	btrfs_submit_dev_bio(bioc->stripes[dev_nr].dev, bio);
 }
 
-static void __btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
-			       struct btrfs_io_stripe *smap, int mirror_num)
+static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
+			     struct btrfs_io_stripe *smap, int mirror_num)
 {
 	if (!bioc) {
 		/* Single mirror read/write fast path. */
@@ -603,7 +603,7 @@ static void run_one_async_done(struct btrfs_work *work, bool do_free)
 	 * context.  This changes nothing when cgroups aren't in use.
 	 */
 	bio->bi_opf |= REQ_BTRFS_CGROUP_PUNT;
-	__btrfs_submit_bio(bio, async->bioc, &async->smap, async->mirror_num);
+	btrfs_submit_bio(bio, async->bioc, &async->smap, async->mirror_num);
 }
 
 static bool should_async_write(struct btrfs_bio *bbio)
@@ -752,7 +752,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		}
 	}
 
-	__btrfs_submit_bio(bio, bioc, &smap, mirror_num);
+	btrfs_submit_bio(bio, bioc, &smap, mirror_num);
 done:
 	return map_length == length;
 
@@ -878,7 +878,7 @@ void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_
 		ASSERT(smap.dev == fs_info->dev_replace.srcdev);
 		smap.dev = fs_info->dev_replace.tgtdev;
 	}
-	__btrfs_submit_bio(&bbio->bio, NULL, &smap, mirror_num);
+	btrfs_submit_bio(&bbio->bio, NULL, &smap, mirror_num);
 	return;
 
 fail:
-- 
2.45.0



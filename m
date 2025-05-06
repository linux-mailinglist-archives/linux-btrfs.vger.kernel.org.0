Return-Path: <linux-btrfs+bounces-13721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABAAAC2D0
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC35D7B4512
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 11:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C4275869;
	Tue,  6 May 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hY8VB6A4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hY8VB6A4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A97E221D93
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531314; cv=none; b=IJ0L818GLxRBt0aDshkjHJU2ucnnZJxd19wRoAeoDc9Hi+anfFkg+Sg2dOWS3QATnOq0pjdw/mOmgoB9pgU/3B5KM/cZwmGx+qpgevVk0TXNqwg5WdzrGNrN5jYTSCY+oUZbtcWMp7PT6TYhG9mphJYaXgKLvu5odFU9+MCYAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531314; c=relaxed/simple;
	bh=smxuVE2ELhmQOQEfEa0Quyx3YDf8mUAYjRoJTP6Lg9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwTnIWO5BidxEMsg00pp//IqWET1DIoo1PYchp+MBKlvTGJ4dZm8SdpJN67fSKOvpHYy/jJeoUoQh6qk2MRENUMwEo1YYge1xtBxZiGwMjfo0PPyhOPf+YpMYjw9mfE8o/xqA3Gnsn4/kCbjE690B+Sr51Q4UZ9x3kNv0HBliss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hY8VB6A4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hY8VB6A4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AE2E21211;
	Tue,  6 May 2025 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746531310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOgn9+u7KDw3Z8q/QCTAS8kfuGxXcBQZSon6EMWEqt0=;
	b=hY8VB6A4DOLZTtdccu4omb4mbitj8Ji8GFuqRj92JgOmY8NFP8uuIDKTOkZNKVdUOa1MD9
	NaI4ogZxU6wdVWk63GcWoy3sN6xHOZKjFtVNgDH/kjqVF6qlHsi5+SzXQmPJdKPS0V3198
	kmtDLgOlX970VTYvMwA1kbF9/qqHFjE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746531310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOgn9+u7KDw3Z8q/QCTAS8kfuGxXcBQZSon6EMWEqt0=;
	b=hY8VB6A4DOLZTtdccu4omb4mbitj8Ji8GFuqRj92JgOmY8NFP8uuIDKTOkZNKVdUOa1MD9
	NaI4ogZxU6wdVWk63GcWoy3sN6xHOZKjFtVNgDH/kjqVF6qlHsi5+SzXQmPJdKPS0V3198
	kmtDLgOlX970VTYvMwA1kbF9/qqHFjE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43574137CF;
	Tue,  6 May 2025 11:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FBRxEO7zGWgdGAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 May 2025 11:35:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: update list of features built under experimental config
Date: Tue,  6 May 2025 13:04:25 +0200
Message-ID: <c6c2a504d4ea8b1cfca3f69c5c00dfc0bf31a47b.1746529400.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746529400.git.dsterba@suse.com>
References: <cover.1746529400.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The list is out of date, the extent shrinker got fixed in 6.13. Add new
entries: the COW fixup warning in 6.15, rund robin policies in 6.14.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 98fa7650a1c20f..d3e85b373344e0 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -90,7 +90,14 @@ config BTRFS_EXPERIMENTAL
 
 	  Current list:
 
-	  - extent map shrinker - performance problems with too frequent shrinks
+	  - COW fixup worker warning - last warning before removing the
+				       functionality catching out-of-band page
+				       dirtying, not necessary since 5.8
+
+	  - RAID mirror read policy - additional read policies for balancing
+				      reading from redundant block group
+				      profiles (currently: pid, round-robin,
+				      fixed devid)
 
 	  - send stream protocol v3 - fs-verity support
 
-- 
2.49.0



Return-Path: <linux-btrfs+bounces-12576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77EA706F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B8E7A33AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34325EFAE;
	Tue, 25 Mar 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AYD44J3b";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AYD44J3b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2925DD0C
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Mar 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920332; cv=none; b=ZFw5XCn443JTzwSoSVLjmcNRcA/QtASGcNHZbMl3ilTnSiSs0kgKVwzGEn+RAVKirjGpWq5tcKZ64f4s20KZxRPS/fT3nffUqlc4SNbxVoLwbIkpVChbmcgKTfx1DlvcjQJF/LBcCVkTiUus2zU7kUwn/l8r7/hMKE4z+5gyNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920332; c=relaxed/simple;
	bh=t6Xn95IvU+J2bJaw2+l8nek9BBFTQCW0KHBm5p+6t5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsXkWYwfLfuX/lpnOtkwmXEqxGr5q84d5vWLWUQYpVMUkvb3IfkxdCQDevnE1uTC0kAa6RzDmN1pCCejk+rLGt1iLK/aDWDFia2VwnNCKSEf1eQDccvIJBdUFAUESJ2OfknVZEt71J229o+R4hJiKRtcldNadizJw52j4WqnTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AYD44J3b; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AYD44J3b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52F132118E;
	Tue, 25 Mar 2025 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keKA1QXk0B3yXlCgjkx5ZeYx5ztU4tYHOV/ICSs8kJM=;
	b=AYD44J3biQI0Sz1r8LMwF9uCO2TvyqUfYWwibcOeGK6iNfdoMesSILvVbtiIXqUg4aMg1M
	WQJ60q+oKvbpINbtZCC5iX6kARg1g6vSjplJCpKvzh2vexckMVZuRUGr6yHNZafCmgJJKk
	ZGFnMlG2TvG2BzADtok+EiGQnEWwXTQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=AYD44J3b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742920314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keKA1QXk0B3yXlCgjkx5ZeYx5ztU4tYHOV/ICSs8kJM=;
	b=AYD44J3biQI0Sz1r8LMwF9uCO2TvyqUfYWwibcOeGK6iNfdoMesSILvVbtiIXqUg4aMg1M
	WQJ60q+oKvbpINbtZCC5iX6kARg1g6vSjplJCpKvzh2vexckMVZuRUGr6yHNZafCmgJJKk
	ZGFnMlG2TvG2BzADtok+EiGQnEWwXTQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CDF5137AC;
	Tue, 25 Mar 2025 16:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UFInDnra4meDSQAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 25 Mar 2025 16:31:54 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] btrfs: cleanup EXTENT_BUFFER_READAHEAD flag
Date: Tue, 25 Mar 2025 17:31:37 +0100
Message-ID: <20250325163139.878473-3-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250325163139.878473-1-neelx@suse.com>
References: <20250325163139.878473-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52F132118E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This flag is no longer being used. Remove it.

It was added by commit ab0fff03055d ("btrfs: add READAHEAD extent buffer flag")
and used in commits:

79fb65a1f6d9 ("Btrfs: don't call readahead hook until we have read the entire eb")
78e62c02abb9 ("btrfs: Remove extent_io_ops::readpage_io_failed_hook")
371cdc0700c7 ("btrfs: introduce subpage metadata validation check")

Finally all the code using it was removed by commit f26c92386028 ("btrfs: remove
reada infrastructure").

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/extent_io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index fb3f5815b28e7..d0b3526749aa2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -39,8 +39,6 @@ enum {
 	EXTENT_BUFFER_UPTODATE,
 	EXTENT_BUFFER_DIRTY,
 	EXTENT_BUFFER_CORRUPT,
-	/* this got triggered by readahead */
-	EXTENT_BUFFER_READAHEAD,
 	EXTENT_BUFFER_TREE_REF,
 	EXTENT_BUFFER_STALE,
 	EXTENT_BUFFER_WRITEBACK,
-- 
2.47.2



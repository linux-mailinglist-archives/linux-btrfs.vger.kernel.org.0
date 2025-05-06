Return-Path: <linux-btrfs+bounces-13722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF62AAC2CC
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 13:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50641C40802
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 May 2025 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2AF278742;
	Tue,  6 May 2025 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kHRYvtnp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kHRYvtnp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83064A02
	for <linux-btrfs@vger.kernel.org>; Tue,  6 May 2025 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531321; cv=none; b=ibJPsC8AIPhAyDhcf363/ahqDt/55mOhww7oVxidvQaHFSFmku7Pw7ejFYpqKSyD/q/e//Eya1UhHb81cpczGX5FPAJg/eEJCScoFPnvU9n2UyQM9KpQZxrnWI+LVEBWoN1rq0zkBwJTp41f2LS1wgb1NH5/xePPKRVsCy2RK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531321; c=relaxed/simple;
	bh=d09o8PN2+uTpepzErlOq6fkzoX++ONGMpD55QAlP3Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucprYbrGyDqC6VXQi0+heUIBfWXOTwKDf9KztF65oCPrfdjP4Tl6H+bNfyS3WqFyt52q8qK0zIXMT+KueMJFKGVcNPGRDEWbUss5jFbrIr/oAVu7XATyqYh7sK8WdCIm/H2T7yygDDrPN1sPaWbdkgauPDMAT8VxZdKJmoypNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kHRYvtnp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kHRYvtnp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80158211FE;
	Tue,  6 May 2025 11:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746531316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQiYn6Q04MMvOkfSz2TFvEPKFnABcv85t+FOvgOScJk=;
	b=kHRYvtnpyX2tyQ9NKjaWmOPUvxv2wYiNB5rdT3losodoutYxeswhxy14D9s+1wTZhXVRVX
	JCQO+JCZAm6uD2WAl8/FBL5DXwHzo6yL+Is8PK+/TGqqU8XBRme0c4jRE9XFkYIGueZAIa
	ZjmrPIKSkcaFFIkMvvq/U1r79HsRfGM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kHRYvtnp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746531316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQiYn6Q04MMvOkfSz2TFvEPKFnABcv85t+FOvgOScJk=;
	b=kHRYvtnpyX2tyQ9NKjaWmOPUvxv2wYiNB5rdT3losodoutYxeswhxy14D9s+1wTZhXVRVX
	JCQO+JCZAm6uD2WAl8/FBL5DXwHzo6yL+Is8PK+/TGqqU8XBRme0c4jRE9XFkYIGueZAIa
	ZjmrPIKSkcaFFIkMvvq/U1r79HsRfGM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79649137CF;
	Tue,  6 May 2025 11:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6d6jHfTzGWgoGAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 May 2025 11:35:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: update Kconfig option descriptions
Date: Tue,  6 May 2025 13:04:26 +0200
Message-ID: <0ffc952ee7832be0f301e6562da0596f4d2ead5e.1746529400.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 80158211FE
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
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Expand what the options do and if they are OK to be enabled.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/Kconfig | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index d3e85b373344e0..3a4112a3bea2ea 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -53,10 +53,10 @@ config BTRFS_FS_RUN_SANITY_TESTS
 	bool "Btrfs will run sanity tests upon loading"
 	depends on BTRFS_FS
 	help
-	  This will run some basic sanity tests on the free space cache
-	  code to make sure it is acting as it should.  These are mostly
-	  regression tests and are only really interesting to btrfs
-	  developers.
+	  This will run sanity tests for core functionality like free space,
+	  extent maps, extent io, extent buffers, inodes, qgroups and others,
+	  at module load time.  These are mostly regression tests and are only
+	  interesting to developers.
 
 	  If unsure, say N.
 
@@ -64,9 +64,12 @@ config BTRFS_DEBUG
 	bool "Btrfs debugging support"
 	depends on BTRFS_FS
 	help
-	  Enable run-time debugging support for the btrfs filesystem. This may
-	  enable additional and expensive checks with negative impact on
-	  performance, or export extra information via sysfs.
+	  Enable run-time debugging support for the btrfs filesystem.
+
+	  Additional potentially expensive checks, debugging functionality or
+	  sysfs exported information is enabled, like leak checks of internal
+	  objects, optional forced space fragmentation and /sys/fs/btrfs/debug .
+	  This has negative impact on performance.
 
 	  If unsure, say N.
 
@@ -74,8 +77,10 @@ config BTRFS_ASSERT
 	bool "Btrfs assert support"
 	depends on BTRFS_FS
 	help
-	  Enable run-time assertion checking.  This will result in panics if
-	  any of the assertions trip.  This is meant for btrfs developers only.
+	  Enable run-time assertion checking. Additional safety checks are
+	  done, simple enough not to affect performance but verify invariants
+	  and assumptions of code to run properly. This may result in panics,
+	  and is meant for developers but can be enabled in general.
 
 	  If unsure, say N.
 
-- 
2.49.0



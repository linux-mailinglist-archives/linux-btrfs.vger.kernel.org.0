Return-Path: <linux-btrfs+bounces-22046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDxiM90QoWlDqAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22046-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 04:34:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D841B24A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 04:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA4230E0528
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 03:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859C32FA37;
	Fri, 27 Feb 2026 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="geKDQ2Fu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="geKDQ2Fu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2732F766
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163263; cv=none; b=cyKMQuGwrC9PIg9Abu6fY7u0QKfj9LVccZ/uL4JdmV7Rpg+AXIQZORGfgA+AF7rrYH1fnIvSk6Y58ithroSBOzYVQtXijTdvqKLTFgSW5YH5DZqHIDajujLDso4aoajjnuszLKzkPvhMtllT0ePuMoXmjXeAJ+ntyyPs0PQejtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163263; c=relaxed/simple;
	bh=Ujv2UuC+5cA/M90P6UHIccQbI/qV3wzJu1w+XPAT53I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKnqMWqEhncRG+OCXCx5yIScC9eCFZfIkHKrCxYyhvJZV1yTYJZB1LN/Hx2g9oFXbsNcHwrbf8v6MHMzW0uk4KxF1fJGNzItxrbcB3cDdsxObPSgjZj+R+ihnHA/1kW3KzvZc0h2JOzNobpLvjwpcwRYI7XlXeB1iOLxpGa703Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=geKDQ2Fu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=geKDQ2Fu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99C7E4DBA0
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 03:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772163254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfFR3ES9MkVBQm2HMZ3nAQJAuYAGFVGTlsa70268sxU=;
	b=geKDQ2Fu5U9eqfBgW4QduWH8dPdxJTrnarKcs3KpT7gwax8SkdlMZ4y2H3ZTOWdrMdMFGR
	aJBxMYVtnqxqc79BdCuEj9ymwiqzuVHSwf36FDRKql4I4ptqS82uaw/NV8JIAjYxJWDOR/
	dRE76rG/tO8yXODGN9gxHCY5M6j47UU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=geKDQ2Fu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772163254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfFR3ES9MkVBQm2HMZ3nAQJAuYAGFVGTlsa70268sxU=;
	b=geKDQ2Fu5U9eqfBgW4QduWH8dPdxJTrnarKcs3KpT7gwax8SkdlMZ4y2H3ZTOWdrMdMFGR
	aJBxMYVtnqxqc79BdCuEj9ymwiqzuVHSwf36FDRKql4I4ptqS82uaw/NV8JIAjYxJWDOR/
	dRE76rG/tO8yXODGN9gxHCY5M6j47UU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFF8A3EA69
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 03:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QNzEI7UQoWmcNAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 03:34:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: drop 2K block size support
Date: Fri, 27 Feb 2026 14:03:43 +1030
Message-ID: <228a7e9b75212e33b93cd009b08d232b240e9e51.1772162871.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772162871.git.wqu@suse.com>
References: <cover.1772162871.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22046-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35D841B24A7
X-Rspamd-Action: no action

Commit 306a75e647fe ("btrfs: allow debug builds to accept 2K block
size") added a new block size, 2K as the minimal block size if the
kernel is built with CONFIG_BTRFS_DEBUG.

This is to allow testing subpage routines on x86_64 (page size is fixed
at 4K).

But it turns out that the support is not that widely adopted, and there
are extra limits inside btrfs-progs, e.g. 2K node size is not supported.

Finally with the larger data folio support already in experimental
builds for a while, it's very easy to trigger a large folio and testing
subpage routines by just doing a 64K block sized buffered write.

Let's just remove the seldom utilized 2K block size completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.c | 10 ++--------
 fs/btrfs/fs.h | 11 +----------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 14d83565cdee..d7e7011a48c2 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -129,18 +129,12 @@ void btrfs_csum_final(struct btrfs_csum_ctx *ctx, u8 *out)
 /*
  * We support the following block sizes for all systems:
  *
- * - 4K
+ * - MIN_BLOCKSIZE (4K)
  *   This is the most common block size. For PAGE SIZE > 4K cases the subpage
  *   mode is used.
  *
  * - PAGE_SIZE
  *   The straightforward block size to support.
- *
- * And extra support for the following block sizes based on the kernel config:
- *
- * - MIN_BLOCKSIZE
- *   This is either 4K (regular builds) or 2K (debug builds)
- *   This allows testing subpage routines on x86_64.
  */
 bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
 {
@@ -148,7 +142,7 @@ bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
 	ASSERT(is_power_of_2(blocksize) && blocksize >= BTRFS_MIN_BLOCKSIZE &&
 	       blocksize <= BTRFS_MAX_BLOCKSIZE);
 
-	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
+	if (blocksize == PAGE_SIZE || blocksize == BTRFS_MIN_BLOCKSIZE)
 		return true;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/*
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f2f4d5b747c5..3396ac6209ff 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -49,17 +49,8 @@ struct btrfs_subpage_info;
 struct btrfs_stripe_hash_table;
 struct btrfs_space_info;
 
-/*
- * Minimum data and metadata block size.
- *
- * Normally it's 4K, but for testing subpage block size on 4K page systems, we
- * allow DEBUG builds to accept 2K page size.
- */
-#ifdef CONFIG_BTRFS_DEBUG
-#define BTRFS_MIN_BLOCKSIZE	(SZ_2K)
-#else
+/* Minimum data and metadata block size. */
 #define BTRFS_MIN_BLOCKSIZE	(SZ_4K)
-#endif
 
 #define BTRFS_MAX_BLOCKSIZE	(SZ_64K)
 
-- 
2.53.0



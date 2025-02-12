Return-Path: <linux-btrfs+bounces-11418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F974A330AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 21:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92B5188B68B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7E9202C20;
	Wed, 12 Feb 2025 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dIHPkS2L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dIHPkS2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7520126C
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391726; cv=none; b=Qr7zJZ+kPHvMQmPBDTHPq5M7YkhfAPxJJ/KB+MTFgNmP7bvewTWNspbo9dx7sQU3t5Ba9RFuBqu7Oa6ygMGFcFM4culiYAs3KGQ5QO6AD3ANDkmkCgkdZdMM7Nr0AAILBxmdY9tERKzyBMCQOcULOvs9rAtT43kWWXkKfm2VD10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391726; c=relaxed/simple;
	bh=vUS9DQ6ZIFvCaWnGZwBZCRozVWipC7wNngO9TJjTK0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eau32B7inMN5EVqetup78nvSjtkLUrcbVJUZyT85ZIdhrOxscE83GGT75VzOKqlLHCdG0dx/7AJx7C9ysiMh6PxcszDZdI6jClu7nDLUN6JpDwWx9PbeHdwiZOXwZuk46TuR9naWnEwjhoXKqxDFZEI4E3nBt6V+FN4tB3KQKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dIHPkS2L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dIHPkS2L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35BEF337B7;
	Wed, 12 Feb 2025 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVO4OjARFHDEpJxknEDMIgW46SJMydBatlCSNSDPVd0=;
	b=dIHPkS2L2PzwEBG30o6nYvqdqJ64FwoqQa7/1WT/8FMtLXQnYGdzBPEPDnPcrjZrZ6lJBo
	hGNhWgbIEDM2QUFM8EXbQiqdDfrk5xUalh0ND85h3E7kcxdZTQCt7AEJCr4fHEE9sUsxaU
	IlA094VW6xOd+MF4yb0J8ptKxPKk6kA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739391723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVO4OjARFHDEpJxknEDMIgW46SJMydBatlCSNSDPVd0=;
	b=dIHPkS2L2PzwEBG30o6nYvqdqJ64FwoqQa7/1WT/8FMtLXQnYGdzBPEPDnPcrjZrZ6lJBo
	hGNhWgbIEDM2QUFM8EXbQiqdDfrk5xUalh0ND85h3E7kcxdZTQCt7AEJCr4fHEE9sUsxaU
	IlA094VW6xOd+MF4yb0J8ptKxPKk6kA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F86E13AEF;
	Wed, 12 Feb 2025 20:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lySYC+sCrWefJgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Feb 2025 20:22:03 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/7] btrfs: zstd: move zstd_parameters to the workspace
Date: Wed, 12 Feb 2025 21:22:02 +0100
Message-ID: <335e4ffce79982059e7d80960805e32e92d1da2b.1739391605.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739391605.git.dsterba@suse.com>
References: <cover.1739391605.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Reduce stack consumption of zstd_compress_folios() by 40 bytes
(10*sizeof(int)) as we can store struct zstd_parameters in the workspace
that is reused for each call.

typedef struct {
	ZSTD_compressionParameters cParams;
	ZSTD_frameParameters fParams;
} ZSTD_parameters;

typedef struct {
    unsigned windowLog;
    unsigned chainLog;
    unsigned hashLog;
    unsigned searchLog;
    unsigned minMatch;
    unsigned targetLength;
    ZSTD_strategy strategy;
} ZSTD_compressionParameters;

typedef struct {
    int contentSizeFlag;
    int checksumFlag;
    int noDictIDFlag;
} ZSTD_frameParameters;

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zstd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index a7bfbf8bea7d..5419c47b854f 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -53,6 +53,7 @@ struct workspace {
 	struct list_head lru_list;
 	zstd_in_buffer in_buf;
 	zstd_out_buffer out_buf;
+	zstd_parameters params;
 };
 
 /*
@@ -402,15 +403,14 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
 	unsigned long max_out = nr_dest_folios * PAGE_SIZE;
 	unsigned int pg_off;
 	unsigned int cur_len;
-	zstd_parameters params = zstd_get_btrfs_parameters(workspace->req_level,
-							   len);
 
+	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
 	*out_folios = 0;
 	*total_out = 0;
 	*total_in = 0;
 
 	/* Initialize the stream */
-	stream = zstd_init_cstream(&params, len, workspace->mem,
+	stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
 			workspace->size);
 	if (unlikely(!stream)) {
 		struct btrfs_inode *inode = BTRFS_I(mapping->host);
-- 
2.47.1



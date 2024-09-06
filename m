Return-Path: <linux-btrfs+bounces-7872-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E6096E90E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 07:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798E9B20D23
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 05:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6271311A7;
	Fri,  6 Sep 2024 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l3zy3fDi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l3zy3fDi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5075823DE
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599823; cv=none; b=s0py/xoHLr772fObaqBCIdM496w159OxLJm2hEWWetDKORJzTfx2+IPZU5lmuBmWa9tmfloPz6vqDMfTo4hE2JCr2F/OT/Yvj33SLzqDS6y+NU2DwSoP3PdHHyZfrdPv6ZFPO8YG1eXK0UoP7P53GtjC0wMni9gQc8pHaW3jc8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599823; c=relaxed/simple;
	bh=8wUYTs1p4bP6qdDA9pZEmT6Y0i1CH28NuOUS3x7kroI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCXvwED39+DWIDt7+/KI/ymrg7Qr0lsD/3kTVzZozwSb65gY1TpCUbi3FZdrBdN2cEIy7BDTtyY2o5WYR35Sk65ZAhhnslpxYVDWKXzj/AWiW0CU5wh0XkL5+EJIzgGu+SbjtuzLSzB3A26WKWEaDzpO6GxQhUuDEiSA3JotEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l3zy3fDi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l3zy3fDi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E86632198C
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725599819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iOvP2zWsGCteZr9apUrtW3ZJKt2W7Ac/qCGZW+VQks=;
	b=l3zy3fDisqK3wGZr5y6kh9nFUkUsNEEER8Lqkne7ovt/1n1Mms4Wdd+Hv8aAa8b1ZD/tVD
	YTBYtMMAqseJqED1pLh55+4RGWcHFGtfigdao30L2JstO/SH3X/lsYShgC++Y9PPNovF3U
	MgUGYnvy8xbNTzje7UglSIaehyUKaCw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725599819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iOvP2zWsGCteZr9apUrtW3ZJKt2W7Ac/qCGZW+VQks=;
	b=l3zy3fDisqK3wGZr5y6kh9nFUkUsNEEER8Lqkne7ovt/1n1Mms4Wdd+Hv8aAa8b1ZD/tVD
	YTBYtMMAqseJqED1pLh55+4RGWcHFGtfigdao30L2JstO/SH3X/lsYShgC++Y9PPNovF3U
	MgUGYnvy8xbNTzje7UglSIaehyUKaCw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D14C1395F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qP/jN0qQ2ma6DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2024 05:16:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: compression: add an ASSERT() to ensure the read-in length is sane
Date: Fri,  6 Sep 2024 14:46:22 +0930
Message-ID: <56cd7dba707d1a4c65e7c9b86e65359a0d11cfa9.1725599171.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725599171.git.wqu@suse.com>
References: <cover.1725599171.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
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

There are already two bugs (one in zlib, one in zstd) that involved
compression path is not handling sector size < page size cases well.

So it makes more sense to make sure that btrfs_compress_folios() returns

Since we already have two bugs (one in zlib, one in zstd) in the
compression path resulting the @total_in be to larger than the
to-be-compressed range length, there is enough reason to add an ASSERT()
to make sure the total read-in length doesn't exceed the input length.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 90aef2627ca2..6e9c4a5e0d51 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1030,6 +1030,7 @@ int btrfs_compress_folios(unsigned int type_level, struct address_space *mapping
 {
 	int type = btrfs_compress_type(type_level);
 	int level = btrfs_compress_level(type_level);
+	const unsigned long orig_len = *total_out;
 	struct list_head *workspace;
 	int ret;
 
@@ -1037,6 +1038,8 @@ int btrfs_compress_folios(unsigned int type_level, struct address_space *mapping
 	workspace = get_workspace(type, level);
 	ret = compression_compress_pages(type, workspace, mapping, start, folios,
 					 out_folios, total_in, total_out);
+	/* The total read-in bytes should be no larger than the input. */
+	ASSERT(*total_in <= orig_len);
 	put_workspace(type, workspace);
 	return ret;
 }
-- 
2.46.0



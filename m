Return-Path: <linux-btrfs+bounces-15174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC8AF01AD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2F7520295
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D91227F19B;
	Tue,  1 Jul 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g5Z56Htc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g5Z56Htc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC126D4E3
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390643; cv=none; b=b2Dv0Sf5ZMcqSqyzbSb1zHQKdGw9uwMTN++xEa4PD09YYhuhqxH8vegbwhupiuQkATpy4sAtPLO5xElI5eL055v427AIcvc+vIX87+CHa63Hh5LDIKB9zZ7y+VdGVHipKNEh22ZjPQPMAbR94GIB1rB/ftL7BkLleuuWRVu67PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390643; c=relaxed/simple;
	bh=jS5tUzxG3DabkjCkntpHguHv6lx1v9FbLabf7avQ1J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUJX78vFr+2w6cdK/cv3lZDQ76QarfGZsuo+eTl1sl9yRPLIXuPdTr0vTDDt+b/JcNq0Bo7wiyPzkBqeiAgtnEz0neg4K8RLpssmrokkAeW2Np0Z+GN7L92CGurqSs1yuVqOwNERMVG3OhjD0lWR1cQmnHiuzRwmQnpXv7riw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g5Z56Htc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g5Z56Htc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89B2F1F453;
	Tue,  1 Jul 2025 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QFhc8TOUdMfC6rqSgfYY0o8iNchioN9hWSYW7OtMI=;
	b=g5Z56Htc/I3MpO6BnSXgL4hIrvfQdgtUrujNEW7gCa5wG3wSyB/9JSx85F49PySJtmWzj+
	Jr8GnNLXOqdOIqoAxHaIexZImy5UGgqtythft5crX6bRdF8af2sI/BAPqSfQrFYVOUVPDb
	2zSd0ToewNmgLQvt8vFO963QbNN6dzw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QFhc8TOUdMfC6rqSgfYY0o8iNchioN9hWSYW7OtMI=;
	b=g5Z56Htc/I3MpO6BnSXgL4hIrvfQdgtUrujNEW7gCa5wG3wSyB/9JSx85F49PySJtmWzj+
	Jr8GnNLXOqdOIqoAxHaIexZImy5UGgqtythft5crX6bRdF8af2sI/BAPqSfQrFYVOUVPDb
	2zSd0ToewNmgLQvt8vFO963QbNN6dzw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7844013890;
	Tue,  1 Jul 2025 17:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tCFaHa8ZZGgzRgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Jul 2025 17:23:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/7] btrfs: accessors: simplify folio bounds checks
Date: Tue,  1 Jul 2025 19:23:48 +0200
Message-ID: <bda0f63b597bd0c29e643caa73a725a02e65da68.1751390044.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751390044.git.dsterba@suse.com>
References: <cover.1751390044.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

As we can have non-contiguous range in the eb->folios, any item can be
straddling two folios and we need to check if it can be read in one go
or in two parts. For that there's a check which is not implemented in
the simplest way:

  offset in folio + size <= folio size

With a simple expression transformation:

  oil + size <= unit_size
        size <= unit_size - oil
    sizeof() <= part

this can be simplified and reusing existing run-time or compile-time
constants.

Add likely() annotation for this expression as this is the fast path and
compiler sometimes reorders that after the followup block with the
memcpy (observed in practice with other simplifications).

Overall effect on stack consumption:

  btrfs_get_8                                        -8 (80 -> 72)
  btrfs_set_8                                        -8 (88 -> 80)

And .ko size (due to optimizations making use of the direct constants):

     text    data     bss     dec     hex filename
  1456601  115665   16088 1588354  183c82 pre/btrfs.ko
  1456093  115665   16088 1587846  183a86 post/btrfs.ko

  DELTA: -508

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 5cfb0801700e6c..b54c8abe467a06 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -59,7 +59,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oil + size <= unit_size)	\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || likely(sizeof(u##bits) <= part))	\
 		return get_unaligned_le##bits(kaddr + oil);		\
 									\
 	memcpy(lebytes, kaddr + oil, part);				\
@@ -82,7 +82,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
-	    oil + size <= unit_size) {					\
+	    likely(sizeof(u##bits) <= part)) {				\
 		put_unaligned_le##bits(val, kaddr + oil);		\
 		return;							\
 	}								\
-- 
2.49.0



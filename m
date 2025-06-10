Return-Path: <linux-btrfs+bounces-14587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCFAD35EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 14:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3FB3B8F97
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F52290BBA;
	Tue, 10 Jun 2025 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j7gb3qrn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j7gb3qrn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287D28F950
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557893; cv=none; b=gf3Uz86DCp1ptwPutYWLcWQGk87fWXzb6RvMK9TcaJwanM7JAqnDWFBar0MCUaEAqmVyMvMUs3/Xn9o3zhjGdErR8qLIYj0l40LHahrJAhZpUYv22J0SkTk72WinWr576xSCeWSr5pwKuWKgvtUPl/JlqibxVslafskzQeEh8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557893; c=relaxed/simple;
	bh=cX0/LZ+3FKMtSMUheAwMypbVN2Om/5u+HqUeeUZObL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+WPARmZPDKWrszAFNDqx/PStNtQseCfYps7PgGF5Hi6CyklD6Vr4hrKKQylKf1L3WZvkaVkt/+gjX0l0uCp6neJ6esxII6YqBa4SqR880ejfefm43YMwQVTLmMBTTYNqG6qah9HtnpKgn5bMcByLVR2SSIEcxUeTldv/Yc9GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j7gb3qrn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j7gb3qrn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BBF221F7C2;
	Tue, 10 Jun 2025 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749557873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJfbnx9bwUIFUSVfdZIX5wUn4qI1eTW5ivG2Byq7LXs=;
	b=j7gb3qrn1OMDw9vaWep00HoazZs5ZBeVwyUtd2PCvxCRmUgujmtTiv3XaJl6SHkL70GEKe
	4BnkwQsuRfcECSRemB+l1vFQRZuUNxfKKQ/nBaCCd84bnka16RrciJkylqoTb71ytzwAeA
	rxn7yoUEAVMZj/R8y+ULR75/iLU60w0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749557873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJfbnx9bwUIFUSVfdZIX5wUn4qI1eTW5ivG2Byq7LXs=;
	b=j7gb3qrn1OMDw9vaWep00HoazZs5ZBeVwyUtd2PCvxCRmUgujmtTiv3XaJl6SHkL70GEKe
	4BnkwQsuRfcECSRemB+l1vFQRZuUNxfKKQ/nBaCCd84bnka16RrciJkylqoTb71ytzwAeA
	rxn7yoUEAVMZj/R8y+ULR75/iLU60w0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5330139E2;
	Tue, 10 Jun 2025 12:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zXU7LHEiSGi9cgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 10 Jun 2025 12:17:53 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 3/4] btrfs: add helper folio_end()
Date: Tue, 10 Jun 2025 14:17:53 +0200
Message-ID: <3b3190a56dfabfeb0632fc131648567b84fcb04f.1749557686.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749557686.git.dsterba@suse.com>
References: <cover.1749557686.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

There are several cases of folio_pos + folio_size, add a convenience
helper for that. This is a local helper and not proposed as folio API
because it does not seem to be heavily used elsewhere:

A quick grep (folio_size + folio_end) in fs/ shows

     24 btrfs
      4 iomap
      4 ext4
      2 xfs
      2 netfs
      1 gfs2
      1 f2fs
      1 bcachefs
      1 buffer.c

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/misc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 9cc292402696..ff5eac84d819 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -7,6 +7,8 @@
 #include <linux/bitmap.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/math64.h>
 #include <linux/rbtree.h>
 
@@ -158,4 +160,9 @@ static inline bool bitmap_test_range_all_zero(const unsigned long *addr,
 	return (found_set == start + nbits);
 }
 
+static inline u64 folio_end(struct folio *folio)
+{
+	return folio_pos(folio) + folio_size(folio);
+}
+
 #endif
-- 
2.47.1



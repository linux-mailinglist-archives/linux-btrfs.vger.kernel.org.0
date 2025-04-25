Return-Path: <linux-btrfs+bounces-13411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986EDA9BFAC
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 09:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149553A9A14
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768322DF91;
	Fri, 25 Apr 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cBPyKQbE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cBPyKQbE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89781F4CAC
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565869; cv=none; b=Qqfuqf3D+6HKZU/Mcl7tj6ZmjeyOHTOciksU3gkx7ml7V7BU4lo9W2uPji/IabB6zoGOHNaIsARhOe6QnMSe+ohuLfeOI2R/JaFaEeKRNBFrT1uY379TvWQ6m/bLvyqcYYPkecbjNiB0cGT84pPnOwyGKrS33DI95YYKlR/kVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565869; c=relaxed/simple;
	bh=jtMg5avLmNq08dx5MIn9AAqzj5O59LTOfT07aatcj5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emlpUFxnu+by0G2cBWkaC1XzCNOpUuWGIxYYSkpVgggyegsb4wSNnpDYUXr+tNu6khhIGa11xsbAKKWcbWEglnqgcyzkHTrpgxXcV9/Bij+zfepR1EsudqqhFJ9imM+alB1NbuOfuoY8xQYUlw3lZ1BSC9H/LP7gYQYOu82A2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cBPyKQbE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cBPyKQbE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA1571F38C;
	Fri, 25 Apr 2025 07:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745565865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HkKwnWomWBsjN0jjbqpwbwTR7RSwLivqmv0zAlY5UMk=;
	b=cBPyKQbEQZfCTleWSNKT85c6UgHotWvRAaZf+uoclpxMfQ3w4ME2fH3crWtWqQrOPLXI6s
	qb6r4kabAIH1j1VoeXBqDB9IOe895FUL84heYrJAYYT9q+IoTKlXjEPcogdK0oK2RJDgHC
	m9N4RQikAUCDqUWk7IQw5ZohGtgHAbU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cBPyKQbE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745565865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HkKwnWomWBsjN0jjbqpwbwTR7RSwLivqmv0zAlY5UMk=;
	b=cBPyKQbEQZfCTleWSNKT85c6UgHotWvRAaZf+uoclpxMfQ3w4ME2fH3crWtWqQrOPLXI6s
	qb6r4kabAIH1j1VoeXBqDB9IOe895FUL84heYrJAYYT9q+IoTKlXjEPcogdK0oK2RJDgHC
	m9N4RQikAUCDqUWk7IQw5ZohGtgHAbU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93A2B13A79;
	Fri, 25 Apr 2025 07:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bapPI6k4C2hqbQAAD6G6ig
	(envelope-from <neelx@suse.com>); Fri, 25 Apr 2025 07:24:25 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: get rid of goto in alloc_test_extent_buffer()
Date: Fri, 25 Apr 2025 09:23:57 +0200
Message-ID: <20250425072358.51788-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA1571F38C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The `free_eb` label is used only once. Simplify by moving the code inplace.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/extent_io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ea38c73d4bc5f..20cdddd924852 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3004,15 +3004,13 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 			goto again;
 		}
 		xa_unlock_irq(&fs_info->buffer_tree);
-		goto free_eb;
+		btrfs_release_extent_buffer(eb);
+		return exists;
 	}
 	xa_unlock_irq(&fs_info->buffer_tree);
 	check_buffer_tree_ref(eb);
 
 	return eb;
-free_eb:
-	btrfs_release_extent_buffer(eb);
-	return exists;
 #else
 	/* Stub to avoid linker error when compiled with optimizations turned off. */
 	return NULL;
-- 
2.47.2



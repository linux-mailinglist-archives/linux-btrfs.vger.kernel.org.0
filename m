Return-Path: <linux-btrfs+bounces-14104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99AABABF9
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EA217737E
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C1F442C;
	Sat, 17 May 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gJOFDQXk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gJOFDQXk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395EA2D052
	for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747508642; cv=none; b=JPtFR5Md1YzNZiS932gJ2EV2McbdIa59MC6GpSc8s8IwVmbA9TJAPAKVRasAzv0Byd09RDSdGxlJzYYhlZUHnZVjAyDjGluFY+CXuUYpcAXbQpjS4fMKJoveWVS5qMbtUAjXWjbAR4SzJOkSzOi4p9rsNrOqBEQkHuagMyNOlj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747508642; c=relaxed/simple;
	bh=POkEBA/cnKce7F1kFD/vk3O4yZ4Iue9Unau1JZ5TUr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3cfAmGLM5P5sITBmvkaBMaFmXI9HIcq+OSTQUODoL04Io4VrBbesth5Z8cmnb00Jv1ZAdoQLPTWkz9eo1W8KV7lJwW3ancnBGatEuiPtvTfdv8hiZCM++Grk8WAFM5kZWhOG2YG7wik7pEyAkUpdmr5bEfugucSZJA8kUUHpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gJOFDQXk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gJOFDQXk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6943421F50;
	Sat, 17 May 2025 19:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747508638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qUUAjk6ZWDmoGEcjsK46936JtMcXOKvxYJGqXBOlepI=;
	b=gJOFDQXkbeA+7zTuJAoA/LlcZMFFqhpYUPExQ1ks/S3Zp/dNzPHJheZMKmznTNVQN2xxl2
	D1WgCOMVK6J9yeS+KnU1W+ANhiSnO1kDO9UHjVGbOAU8Huc8RQwbtxmKWwVYkDZy9Nz55f
	1FCLkK1VTlgn3aGjM6AL8YLsZnArrow=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747508638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qUUAjk6ZWDmoGEcjsK46936JtMcXOKvxYJGqXBOlepI=;
	b=gJOFDQXkbeA+7zTuJAoA/LlcZMFFqhpYUPExQ1ks/S3Zp/dNzPHJheZMKmznTNVQN2xxl2
	D1WgCOMVK6J9yeS+KnU1W+ANhiSnO1kDO9UHjVGbOAU8Huc8RQwbtxmKWwVYkDZy9Nz55f
	1FCLkK1VTlgn3aGjM6AL8YLsZnArrow=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E10D13991;
	Sat, 17 May 2025 19:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDawFp7dKGh/bwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Sat, 17 May 2025 19:03:58 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: move transaction aborts to the error site in add_block_group_free_space()
Date: Sat, 17 May 2025 21:03:57 +0200
Message-ID: <20250517190357.3027788-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Transaction aborts should be done next to the place the error happens,
which was not done in add_block_group_free_space().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 0c573d46639ae9..6cbdb578e66c1f 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1408,16 +1408,17 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	ret = __add_block_group_free_space(trans, block_group, path);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 
 out:
 	btrfs_free_path(path);
 	mutex_unlock(&block_group->free_space_lock);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
-- 
2.49.0



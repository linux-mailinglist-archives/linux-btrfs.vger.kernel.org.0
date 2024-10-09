Return-Path: <linux-btrfs+bounces-8698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314F996DD2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD4281B1B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51967FBA2;
	Wed,  9 Oct 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lwBLw111";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lwBLw111"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C314E2E8
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484263; cv=none; b=khTTytAJbaI4GiwxcsK83rKm8mQkxQgObs0KTzNOqqo8r0Ti81kwC2O03TXpMMKNf/Jjuf9rv5hrB91YA8ElW7xuNpiitysTXW4IG52kNCaUCqKXLC2i8eXsqC8S7IxGHLaJXJVW5vdCdJLa/Gb+R4sjElkMhfLuzq4lNLTG4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484263; c=relaxed/simple;
	bh=Agzr6XowE3eOT9U4Ztu10V21e2aX6duZxbLwMnrS4Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5iVKtffZGwc5XLwyyiqqGZn46fviePqaHQS28hexXxdCvVeIYubhTsb1FGEymn7ItpAKkrPirt64N/hkHw2ZrXNU7i2FqvyEDb0J45G5P1oHCtes4f+G4Ag8ZNp1TabSPK2wzCwnOPmeHULyf8jVMz4PRDr0XQSBaV9tksFbsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lwBLw111; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lwBLw111; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3BDA21F83;
	Wed,  9 Oct 2024 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmE/nAVGM5XjamokrMYwnkh5NzYGvIsuh1fEDbkxDks=;
	b=lwBLw111DpdIlI3gIFv+1GgQHRydtKfv9WyO53Vy+e4kIANhScvMSa+s8TRd4f/SnwqgPK
	Ju3Gf4HK8u6GnWX+2u5lhxLl++AwnHn8uxREXKlukPXR2pD78PBSX/RzbfzBmBhjSwRrek
	i5+LWDpYePSl+HaU9gG/hUZQ7hNvmfE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmE/nAVGM5XjamokrMYwnkh5NzYGvIsuh1fEDbkxDks=;
	b=lwBLw111DpdIlI3gIFv+1GgQHRydtKfv9WyO53Vy+e4kIANhScvMSa+s8TRd4f/SnwqgPK
	Ju3Gf4HK8u6GnWX+2u5lhxLl++AwnHn8uxREXKlukPXR2pD78PBSX/RzbfzBmBhjSwRrek
	i5+LWDpYePSl+HaU9gG/hUZQ7hNvmfE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5765136BA;
	Wed,  9 Oct 2024 14:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uzgaNKOTBmf+RAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:30:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/25] btrfs: drop unused parameter ctx from batch_delete_dir_index_items()
Date: Wed,  9 Oct 2024 16:30:59 +0200
Message-ID: <84deed843ca880ac75642c86d043d2251dd8b3fe.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The ctx parameter is not used, we can drop it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e2ed2a791f8f..d76f9293189e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6204,7 +6204,6 @@ static int log_delayed_deletions_full(struct btrfs_trans_handle *trans,
 static int batch_delete_dir_index_items(struct btrfs_trans_handle *trans,
 					struct btrfs_inode *inode,
 					struct btrfs_path *path,
-					struct btrfs_log_ctx *ctx,
 					const struct list_head *delayed_del_list,
 					const struct btrfs_delayed_item *first,
 					const struct btrfs_delayed_item **last_ret)
@@ -6265,7 +6264,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
 		if (ret < 0) {
 			return ret;
 		} else if (ret == 0) {
-			ret = batch_delete_dir_index_items(trans, inode, path, ctx,
+			ret = batch_delete_dir_index_items(trans, inode, path,
 							   delayed_del_list, curr,
 							   &last);
 			if (ret)
-- 
2.45.0



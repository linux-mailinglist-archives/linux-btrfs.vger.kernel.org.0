Return-Path: <linux-btrfs+bounces-12803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7AAA7C32E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 20:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EF53B8D20
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7459211282;
	Fri,  4 Apr 2025 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t3l4lZz0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="If5e0/bm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180081494A6
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790788; cv=none; b=hlnyJCKYf5GqArE5aTqVap08zzzH0aH08gxbAfo9vLN8ZfDu6biWzckaThq/YsDVfaSy5HTbJ0BuYGvKusKrFip26EMgoz5hRj5AsxVOvBJZut67KWBbnCkKJhJJhPkD13a54I2EmBoEYkryw6bO7s9nBKdFQKCnrG1xRmY7A0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790788; c=relaxed/simple;
	bh=aOgXcZm9iJZvSwIl1RRHYIfDBfUCVixqd0Im/9a5bf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lu5gT562zl1i7YgJk6H0u8pdP1CzPq6gHnim/cUrWJ2Y3VtA8NqzfzBbTFiF4ySlG+a+kiVS0R4stuEeU9p+KzUyY0i3G/fv0b+xDOhWVYBMbyeINFvdhgz7itfrdvSQeKQgubs5wV+8LItdJoo7OynH3tGi8ALcjLlTyP4eLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t3l4lZz0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=If5e0/bm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAF901F385;
	Fri,  4 Apr 2025 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743790779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDrL/fDpjLLcZSQqZjAGXXCw4SsfOc/uMf6ZMunZPgg=;
	b=t3l4lZz0XIJ/nWFMU3kYVvTgUvPLo8T1Hw7owX7Je1M5S7kEF4wZt/FghSf1MKDIOSaBbo
	6WcdbY8uTykGcx6zLinfiBEPWxDBEuEKvsJrPxHgACcufJqJOaIUoMajkNTfuilqjsMktl
	op6DF7Quh4KR5z8ZT/mc4ppJiIPZvMg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="If5e0/bm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743790778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDrL/fDpjLLcZSQqZjAGXXCw4SsfOc/uMf6ZMunZPgg=;
	b=If5e0/bmgyUDc3RZa0Y2MgTTjFP6r4uEg/eXKHcvrzK+JgNFwGIuRUcMoZQf92N1MqQeo1
	/7K2zESrh89E8ey8lcVx+3gL/bjVPgO9Rvu1fQSBWLMedKRqiKzQdaCnrrgjvPJjBDt4yh
	nTYv3LfRC+x6v1mmiCZmMt201oQtrBw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C721364F;
	Fri,  4 Apr 2025 18:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K4ymN7oi8GevLwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 04 Apr 2025 18:19:38 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: tree-checker: more unlikely annotations
Date: Fri,  4 Apr 2025 20:19:38 +0200
Message-ID: <08777c492e146ecb91816e8df2402669c7ad2ab6.1743790644.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1743790644.git.dsterba@suse.com>
References: <cover.1743790644.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EAF901F385
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Add more unlikely annotations to branches that lead to EUCLEAN, overall
in the tree checker this helps to reorder instructions for the no-error
case.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-checker.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 43979891f7c8..732e0ca8f447 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -2229,7 +2229,7 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
 	int ret;
 
 	found_level = btrfs_header_level(eb);
-	if (found_level != check->level) {
+	if (unlikely(found_level != check->level)) {
 		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
 		     KERN_ERR "BTRFS: tree level check failed\n");
 		btrfs_err(fs_info,
@@ -2251,7 +2251,7 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
 		return 0;
 
 	/* We have @first_key, so this @eb must have at least one item */
-	if (btrfs_header_nritems(eb) == 0) {
+	if (unlikely(btrfs_header_nritems(eb) == 0)) {
 		btrfs_err(fs_info,
 		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
 			  eb->start);
@@ -2263,9 +2263,9 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
 		btrfs_node_key_to_cpu(eb, &found_key, 0);
 	else
 		btrfs_item_key_to_cpu(eb, &found_key, 0);
-	ret = btrfs_comp_cpu_keys(&check->first_key, &found_key);
 
-	if (ret) {
+	ret = btrfs_comp_cpu_keys(&check->first_key, &found_key);
+	if (unlikely(ret)) {
 		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
 		     KERN_ERR "BTRFS: tree first key check failed\n");
 		btrfs_err(fs_info,
-- 
2.47.1



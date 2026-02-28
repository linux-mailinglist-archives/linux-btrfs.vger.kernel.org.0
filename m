Return-Path: <linux-btrfs+bounces-22091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E75FJc1omnR0wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22091-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 01:23:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7E81BF653
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 01:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E09C2308BCEB
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 00:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B72356D9;
	Sat, 28 Feb 2026 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D2OqmOhe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D2OqmOhe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64674C14
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238214; cv=none; b=oCSlYqnH0+ZuNHHpd6hViU7DwxDk1Eg4DfVJcA5VdAOekBFLow6kIkJb2qJfkCDqHzLjGI7/lW0xAOcve0v97r01x1yGVGOqqiUBkh3Xk8QBaUm+55fElHZ3r/YDveguYNhhqUPHjmulmAbsIP/v3dp6hyWhLxeC9hhSr8uZMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238214; c=relaxed/simple;
	bh=EcpZ7eR/vK1b43oGybCB/UcFVp/8O55QoYC+wfRFESY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VJ0/Gz4X9q1etzSjatYsV1NBKQMou1+EedaYDdmULMpGQUWvGq+SOwq3TniCOl8dV/BErNG2GcLnpfFFjoXPxmXQCjeKpTVQI/OuuYH0lpENB1kW4J0Y0uvwKqgQceC5t2KkXyr7fhz+C9XywBFepK5KtE8P27v+cnTUvnWH5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D2OqmOhe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D2OqmOhe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50FC23F9BB
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772238211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y3CflqBGCdq2aw9er7jVsoAb5GHg4OzL9IV972Ux/vk=;
	b=D2OqmOhe0fxsiJwZrWFezWVezAlTerCZZU3XBIBJbFjS9MA60YfaEESwBTlsoDkjVE/okY
	vXZ+8E9gOzQJr04ZF2ZdH3S+VR6J8sMEv5G4FhFZKqE6NkU/K0mLyG8qzgUwu5DHm/rprW
	+jndUhiVezMgIMzZn3Yz+zlZXKK2Xzo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=D2OqmOhe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772238211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y3CflqBGCdq2aw9er7jVsoAb5GHg4OzL9IV972Ux/vk=;
	b=D2OqmOhe0fxsiJwZrWFezWVezAlTerCZZU3XBIBJbFjS9MA60YfaEESwBTlsoDkjVE/okY
	vXZ+8E9gOzQJr04ZF2ZdH3S+VR6J8sMEv5G4FhFZKqE6NkU/K0mLyG8qzgUwu5DHm/rprW
	+jndUhiVezMgIMzZn3Yz+zlZXKK2Xzo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 875C23EA65
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qunAEYI1omkgbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix unpaired compr folio allocation/freeing
Date: Sat, 28 Feb 2026 10:53:10 +1030
Message-ID: <cover.1772238005.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22091-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA7E81BF653
X-Rspamd-Action: no action

With the recent *_compressed_bio() rework, we're using compressed_bio
everywhere for reads/writes (including regular and encoded).

However this requires us to allocate/free folios using
btrfs_alloc_compr_folio() and btrfs_free_compr_folio().

Not using the later to release a folio allocated by
btrfs_alloc_compr_folio() can screw up the LRU list.

Fix the unpaired calls as a hot fix.

For the long run, I'd like to remove btrfs_(alloc|free)_compr_folios()
with regular folio_(alloc|put)() instead.
As I do not think the compr pool is that helpful compared to the extra
maintanance needed.

Qu Wenruo (2):
  btrfs: fix the incorrect freeing of a compression folio in
    btrfs_submit_compressed_read()
  btrfs: fix the incorrect freeing of a compression folio in
    btrfs_do_encoded_write()

 fs/btrfs/compression.c | 2 +-
 fs/btrfs/inode.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.53.0



Return-Path: <linux-btrfs+bounces-21572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IElhKw2limmhMgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21572-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:25:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1824D116BB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 04:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98415300E71E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 03:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F772FD681;
	Tue, 10 Feb 2026 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p+wIH6s+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p+wIH6s+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231603A1C9
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770693894; cv=none; b=u8PtNjKgi1eHeOEYIbEO2XCcaq7ggbH+YCmsIjjO+aeK0bVAS/G6KZMjiyorTmznff0kQwE5ZRk/X26L87hLAIIgaQGNsfRo2TLEnowH2NKnPGlseP5S0uXD1zfQrw4NS/LKMGQYed8QGh4Z/s4MxhDgNvyJ+hUli6BFX0mSyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770693894; c=relaxed/simple;
	bh=oYM2LbtvsMre9QIWIRVAKDhM4/uhGOvDI6x4xb6laPA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H6OFGRognTxaMnpBIAME05YSg6Nha3xamrkQVn3kKgezorOXG0igl8bI3xhZ6op28v7FH5RmHrp5KrgGyFzEbvBBHG/81LoSlnIUtR2LpMY067G2Sr88odFVwqyPK59EJXMTMe+NrelBIPcEKxSyb4ANpKEot56Cx+UId+QL4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p+wIH6s+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p+wIH6s+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B16F3E70A
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770693891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=33uek6LCtUobvediYmcgunhbO1UuFSSuoC910OEAt8I=;
	b=p+wIH6s+O44qYdTxO99lV9VS7RKMTLbkudiVi25jKYMu+zPCoSjnGVihbFsnMwnyMZOM3i
	U+eiiehzpKhxvZVtcoL9O77OeycC7JoZe6P7LjcGrt2VlVJKfp6NNCHlMhOSY1A5y71Vpb
	pxC81E/U4XayiBcADrD5r+ns5ZDDSUs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770693891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=33uek6LCtUobvediYmcgunhbO1UuFSSuoC910OEAt8I=;
	b=p+wIH6s+O44qYdTxO99lV9VS7RKMTLbkudiVi25jKYMu+zPCoSjnGVihbFsnMwnyMZOM3i
	U+eiiehzpKhxvZVtcoL9O77OeycC7JoZe6P7LjcGrt2VlVJKfp6NNCHlMhOSY1A5y71Vpb
	pxC81E/U4XayiBcADrD5r+ns5ZDDSUs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFDCD3EA62
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9K3sJQGlimkrEgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 03:24:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: ordered extent csum list related cleanup
Date: Tue, 10 Feb 2026 13:54:28 +1030
Message-ID: <cover.1770693583.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21572-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1824D116BB3
X-Rspamd-Action: no action

Trivial changes, please refer to the commit message of each patch.

Qu Wenruo (3):
  btrfs: rename btrfs_ordered_extent::list to csum_list
  btrfs: make add_pending_csums() to take an ordered extent as parameter
  btrfs: rename btrfs_csum_file_blocks() to btrfs_insert_data_csums()

 fs/btrfs/file-item.c    |  6 +++---
 fs/btrfs/file-item.h    |  6 +++---
 fs/btrfs/inode.c        | 18 ++++++++++--------
 fs/btrfs/ordered-data.c | 10 +++++-----
 fs/btrfs/ordered-data.h |  2 +-
 fs/btrfs/tree-log.c     |  8 ++++----
 fs/btrfs/zoned.c        |  7 +++----
 7 files changed, 29 insertions(+), 28 deletions(-)

-- 
2.52.0



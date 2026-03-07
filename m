Return-Path: <linux-btrfs+bounces-22273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJflB1/sq2lYiAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22273-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Mar 2026 10:14:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FF22AD54
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Mar 2026 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56CEA302428F
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Mar 2026 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBB3876CF;
	Sat,  7 Mar 2026 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oHl0TR/3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VoAid5t0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD685382391
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874839; cv=none; b=A/k7z3ho2enitM9Sk4mFSXVVAqIYARZ9AnjyA9KROjUH9ITHGmVpDLtRByc41l6THsRKK5I1YqEbaKugIiaYpIdOUCoBJ23O8f0tTZeIFjyyqx7ZV7YWDSmrWd+/rwYMy/cw6bcQOUAnPqUyIzkbiMDr5m53BlzH+Aihhm5LJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874839; c=relaxed/simple;
	bh=pKgl9YdBYp+meG2977aBny2P7kJK8xkiHyA6OZVivyg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OumUkVdF1V8j1uJ8wdZYCbZQPHU9+XI6itxLu2IHU6tDOJDdTRHw38pMfVJ4sfykq9lZ3rwcgWiNe9S91BGF6/e/RB7xJEDYarJlAPinYKinNne+XfQ9tgcQX0Xj1SvCsMG+6A5UfgNEGZijoEvseQLGOrTEkuTkFXSaDsQ7ziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oHl0TR/3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VoAid5t0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F39CF3FCF6
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772874836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WVLsBK3Q4dWbUTyKsYEoUB50s0HvtZvQNyvGv5cHxIE=;
	b=oHl0TR/3LYW1DLdQbo4+D5JP78ZdodaInyF0X3dUuyvk7O45cDTJV1KGttRXaaKyZOQ5Ck
	cOwLzp15v+H/FuNSB3nvYjaiFCESVkL/vB5w6Ip1ZULjmjSdiDB+HdCheXmI0oy3eE63RO
	7dAPKGFUdkElqyN7Iw0XvWhLDHy9s3o=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772874835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WVLsBK3Q4dWbUTyKsYEoUB50s0HvtZvQNyvGv5cHxIE=;
	b=VoAid5t0d25/z89zK85EH6TEgmyFPmv7GFqaE/5ewVqd9UwWZD71Bycn0KvgAP+076/ovY
	HTZ2V7CLyAGAr0CIwUh415xLPXoUh8SSjR8sNO6h+am3Ayc3Q2HrHfcDM5bSXJafmt5FMt
	fDpdTw4SarKC5a09ZEtgkSQgB2VNI1A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3675F3EA61
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 09:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id THXHOVLsq2kkLQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 07 Mar 2026 09:13:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: enhance BTRFS_ORDERED_* flags sanity checks
Date: Sat,  7 Mar 2026 19:43:35 +1030
Message-ID: <cover.1772874800.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D12FF22AD54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22273-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim,suse.com:mid]
X-Rspamd-Action: no action

During my development of introduce a new DELAYED type, I incorrectly
called something like:

	oe = alloc_ordered_extent(.., BTRFS_ORDERED_DELAYED, ..);

That doesn't trigger any warning at runtime, but will cause unexpected
bugs due to the fact that, BTRFS_ORDERED_* can not be directly used as a
flag. They are only bit numbers, thus should be utilized with bit
operations like "test_bit(BTRFS_ORDERED_DELAYED, ..)".

My stupid bug inspired me to enhance the @flags sanity checks in
alloc_ordered_extent().

The first one is to make sure that my stupid bug can always be caught
early.

The second one is to enhance the error message when a duplicated OE is
found during insert_ordered_extent().

Qu Wenruo (2):
  btrfs: check type flags in alloc_ordered_extent()
  btrfs: output more info when duplicated ordered extent is found

 fs/btrfs/ordered-data.c | 24 +++++++++++++++---
 fs/btrfs/ordered-data.h | 55 +++++++++++++++++++++++------------------
 2 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.53.0



Return-Path: <linux-btrfs+bounces-21398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBB+GAsvhWn/9gMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21398-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 01:00:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56AF8798
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 01:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7448F301A388
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Feb 2026 00:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDC233DEED;
	Fri,  6 Feb 2026 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rS3sSPZB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rS3sSPZB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2B33DED6
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336004; cv=none; b=u4yDVuCCSwddohBUck0a8vIepDOr6fuYNBT8taXZYW2eMTPtx9IS9WiPAlIsfClvKzL0c2a8pw3uHCfv3OyIgHGqN0elFzbfcePxPdeIB81QGbVfsYhVgacdMo12LDcRzqtu/5MtaYs2u9hJ6bN4Cq/dDu+cSOyfdw2v9K8Oqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336004; c=relaxed/simple;
	bh=Y1wY+Q7PwG72C4VWnNU+ZF7Fcat7qpB4PlE7nM4T+4k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L6aRPVb88itDTfbUwV3EjOt6YVOuohOv1h2yS3Guu4ancKUwupjW2bFuifDLM/CbeBshThiYqvwYCvfA1AkSt+Qzf2CUyf2sqamz+zS0OYxL5KTEVMU6dPEUUyobY+c2dWaIsR6YMazEjQggK/s7a/n1G1s5PJ8EUhSFyOML/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rS3sSPZB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rS3sSPZB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D2E93E6D2
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770336002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wxsUQh4qh4IZIQJ1U9kTlEO0fQ8iVkhtxgkGvDWI5Lk=;
	b=rS3sSPZBRzmBHE2DlA/AuNBUWg/duiTMkgu7gtUVSGm88g49wzd9stpdGwSOXvIASZ4axj
	uXnpUwvNdO/570KDmt3CNDKQSAzstzO6tEtC9UAeaUrBHVu7NUqdu0eZkPAr45yA/W9EWD
	CCvO1OcVu8xK/h9Nm3cnr2iCKeqIaek=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rS3sSPZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770336002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wxsUQh4qh4IZIQJ1U9kTlEO0fQ8iVkhtxgkGvDWI5Lk=;
	b=rS3sSPZBRzmBHE2DlA/AuNBUWg/duiTMkgu7gtUVSGm88g49wzd9stpdGwSOXvIASZ4axj
	uXnpUwvNdO/570KDmt3CNDKQSAzstzO6tEtC9UAeaUrBHVu7NUqdu0eZkPAr45yA/W9EWD
	CCvO1OcVu8xK/h9Nm3cnr2iCKeqIaek=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FB4E3EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LFHuAAEvhWlzOQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Feb 2026 00:00:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: add repair support to delete orphan
Date: Fri,  6 Feb 2026 10:29:40 +1030
Message-ID: <cover.1770335913.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
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
	TAGGED_FROM(0.00)[bounces-21398-lists,linux-btrfs=lfdr.de];
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
X-Rspamd-Queue-Id: 0B56AF8798
X-Rspamd-Action: no action

This is the same PR in github:
https://github.com/kdave/btrfs-progs/pull/1083

The mail thread is mostly for tracking and review purposes.

Since v6.16.1 btrfs check adds the ability to detect orphan free space
entries, and older mkfs.btrfs forgot to delete free space entries of
temporary chunks, which can be detected by newer btrfs-progs now.

Although we're already pushing for a kernel auto fix, the kernel fix
will take some time to reach upstream, and more time to reach distros.

So there is still some value to have the repair ability in btrfs-check.

Furthermore, the new repair ability is more flex than the kernel one,
which can handle orphan free space info key, not only the ones exposed
by the recent btrfs-check.
Although only the recent exposed one is tested.

Qu Wenruo (3):
  btrfs-progs: check: report all orphan free space info keys
  btrfs-progs: check: add repair support for orphan fst entry
  btrfs-progs: fsck-tests: add a new test case for deleting orphan fst
    entries

 common/clear-cache.c                          | 141 +++++++++++++++++-
 .../071-orphan-fst-entry/.lowmem_repairable   |   0
 .../orphan_fst_entries.img.xz                 | Bin 0 -> 1864 bytes
 3 files changed, 137 insertions(+), 4 deletions(-)
 create mode 100644 tests/fsck-tests/071-orphan-fst-entry/.lowmem_repairable
 create mode 100644 tests/fsck-tests/071-orphan-fst-entry/orphan_fst_entries.img.xz

--
2.52.0



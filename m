Return-Path: <linux-btrfs+bounces-20797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBrpFMxqcGkVXwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20797-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 06:57:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1318E51CA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 06:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61B454E70DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70842342CBA;
	Wed, 21 Jan 2026 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VYrGV7Ku";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VYrGV7Ku"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADB3612F4
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768975042; cv=none; b=u/IkJ8NEmat36gZisPkAd/HKkECsaDVFjftP5HV2QF/yqHIZNwx6NnCQwcgO2XQakv7Q9xIbFvN52i5abb4Qi97K6HVXj/o029sTRNNnJNi24wC9fXAx7HqgBFyxouhuDFU5+F3Sxd3SB3XR9JEr8TQZ7UKXcwsRpMnITbi+mEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768975042; c=relaxed/simple;
	bh=0e/oB84uKeRkHdwuoWROsJ2gqpH/0gmbyXXxxgaEmMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZ9mu5y0X3r/TU1gpXFh8GJzs/mJpeGDG6SN00mRkVodBz3mtbYxt3OQxDMe1ZsXbvo7+yluB1/UpoNchUmLWGB/5F3x4u9lCG909hHwHIYAs53sBHumc3iHz/MK0kVflKvFPhYy5CV6LreQotB4z6X2VYhxlGomaFUuMol/ymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VYrGV7Ku; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VYrGV7Ku; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDE713368B;
	Wed, 21 Jan 2026 05:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768975038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LxafchXHKqKIVSYO0OSSD2wClO8m52dJJmYORDabAh0=;
	b=VYrGV7KuDAMXR8jNapEpSdngB0N6vZg6SUkFjtfdG2xHEb6Yma++lx7KrD7uIp+5O8sYbg
	JJnv7Vnnt9RphmvSOuuZJ1eC4PIqRmyM18S76UpiP5dqZW9aEGbtkQQudSlAoVFoEClGUd
	CTkQuoA5tNBvuBtD7KZdeAaofK3RitU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768975038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LxafchXHKqKIVSYO0OSSD2wClO8m52dJJmYORDabAh0=;
	b=VYrGV7KuDAMXR8jNapEpSdngB0N6vZg6SUkFjtfdG2xHEb6Yma++lx7KrD7uIp+5O8sYbg
	JJnv7Vnnt9RphmvSOuuZJ1eC4PIqRmyM18S76UpiP5dqZW9aEGbtkQQudSlAoVFoEClGUd
	CTkQuoA5tNBvuBtD7KZdeAaofK3RitU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C38893EA63;
	Wed, 21 Jan 2026 05:57:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AM5ZL75qcGkdagAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 21 Jan 2026 05:57:18 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.19-rc7
Date: Wed, 21 Jan 2026 06:56:59 +0100
Message-ID: <cover.1768969871.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	TAGGED_FROM(0.00)[bounces-20797-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 1318E51CA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

please pull the following btrfs fixes. Thanks.

- protect reading super block vs setting block size externally (found
  by syzbot)

- make sure no transaction is started in read-only mode even with some
  rescue mount option combinations

- fix checksum calculation of backup super blocks when block-group-tree
  is enabled

- more extensive mount-time checks of device items that could be left
  after device replace and attempting degraded mount

- fix build warning with -Wmaybe-uninitialized on loongarch64-gcc 12

----------------------------------------------------------------
The following changes since commit 437cc6057e01d98ee124496f045ede36224af326:

  btrfs: remove zoned statistics from sysfs (2026-01-14 22:08:04 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.19-rc6-tag

for you to fetch changes up to 34308187395ff01f2d54007eb8b222f843bdf445:

  btrfs: add extra device item checks at mount (2026-01-20 17:18:48 +0100)

----------------------------------------------------------------
Edward Adam Davis (1):
      btrfs: sync read disk super and set block size

Mark Harmstone (1):
      btrfs: fix missing fields in superblock backup with BLOCK_GROUP_TREE

Qiang Ma (1):
      btrfs: fix Wmaybe-uninitialized warning in replay_one_buffer()

Qu Wenruo (2):
      btrfs: reject new transactions if the fs is fully read-only
      btrfs: add extra device item checks at mount

 fs/btrfs/disk-io.c  | 19 ++++++++++++++++++-
 fs/btrfs/fs.h       |  8 ++++++++
 fs/btrfs/tree-log.c |  2 +-
 fs/btrfs/volumes.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h  |  4 ++++
 5 files changed, 73 insertions(+), 2 deletions(-)


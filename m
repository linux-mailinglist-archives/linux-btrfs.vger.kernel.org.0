Return-Path: <linux-btrfs+bounces-3169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2BF877AD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 07:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA72281FEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 06:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61DCA50;
	Mon, 11 Mar 2024 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KYd14mg0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KYd14mg0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0464B647
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710137352; cv=none; b=NxMK+2lo/rdSSK7iwqk/X7IDSVV4cVCfb7kFIBUbVy0Iefz4p4bPoV+OFm1uvMKzkHO764pxiRTZt+AXc9ir3GcDi5kX+xGfyEVXsOefgtg2MkgR1YBup4OoOU3sx4+YrjZvKXLL86O39P6Jguq94u7ExwFQNdMyuDJ2sSVuA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710137352; c=relaxed/simple;
	bh=d2uQaeIlFywFhxHgAsdj+gqP1KPq2r1t9XQTwDNWWKM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mult1TaqxJoEVz/5snNoamCtKD5nfDlc0/IdHhlQIVzUQtThiEZOtVG1BJACjhSoPISLalovHvBlKR8fu8s0m230o/smVcujOZjgYj3PrY1jyTVqt0HXHCzZ8gb2Jr8BoyPytdeq2to3JWI1L6wrDPJd+iwOxnkM4qRLDIkN4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KYd14mg0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KYd14mg0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D11245C2BF
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 06:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710137348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rMY0LYFAWrEEyuub4uwSqhg+0ZGAMeW3H0o+JtQsfSw=;
	b=KYd14mg0F6VlxfzsvZWQxaUyBprjhUvayewPjt9QjmTsJ+OP1mDwBHG2lY63C1Q9+EZ1HH
	/V+zkYuEUGKzzn6wbAsfkbpGVrfx2SUYmN1nyk2doMTILaUmzD5aBzBYKDZ6QomzwV1c+6
	qL0avEu/E719ekAHNU2g/0pKxzLcd/k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710137348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rMY0LYFAWrEEyuub4uwSqhg+0ZGAMeW3H0o+JtQsfSw=;
	b=KYd14mg0F6VlxfzsvZWQxaUyBprjhUvayewPjt9QjmTsJ+OP1mDwBHG2lY63C1Q9+EZ1HH
	/V+zkYuEUGKzzn6wbAsfkbpGVrfx2SUYmN1nyk2doMTILaUmzD5aBzBYKDZ6QomzwV1c+6
	qL0avEu/E719ekAHNU2g/0pKxzLcd/k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79B01383D
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 06:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nKUYJAOg7mUdQwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 06:09:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: defrag: better lone extent handling
Date: Mon, 11 Mar 2024 16:38:43 +1030
Message-ID: <cover.1710137066.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.61%]
X-Spam-Score: 4.89
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Remove the "lone" naming
  Now the two new members would be named "usage_ratio" and
  "wasted_bytes".
  
- Make "usage_ratio" to be in range [0, 100]
  This should be much easier to understand.

When a file extent which can not be merged with any adjacent ones (e.g.
created by truncating a large file extent) is involved, it would haven no
chance to be touched by defrag.

This would mean that, if we have some truncated extents with very low
utilization ratio, or defragging it can free up a lot of space, defrag
would not touch them no matter what.

This is not ideal for some situations, e.g.:

  # mkfs.btrfs -f $dev
  # mount $dev $mnt
  # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
  # sync
  # truncate -s 4k $mnt/foobar
  # btrfs filesystem defrag $mnt/foobar
  # sync

In above case, if defrag touches the 4k extent, it would free up the
whole 128M extent, which should be a good win.

This patchset would address the problem by introducing a special
entrance for such file extents.
Those file extents meeting either usage ratio or wasted bytes threshold
would be considered as a defrag target, allowing end uesrs to address
above situation.

This change requires progs support (or direct ioctl() calling), by
default they would be disabled.

And my personal recommendation for the ratio would be 5%, and 16MiB.

Qu Wenruo (2):
  btrfs: defrag: add under utilized extent to defrag target list
  btrfs: defrag: allow fine-tuning defrag behavior based on file extent
    usage

 fs/btrfs/defrag.c          | 46 +++++++++++++++++++++++++++++++++++---
 fs/btrfs/ioctl.c           |  6 +++++
 include/uapi/linux/btrfs.h | 40 ++++++++++++++++++++++++++++-----
 3 files changed, 84 insertions(+), 8 deletions(-)

-- 
2.44.0



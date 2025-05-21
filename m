Return-Path: <linux-btrfs+bounces-14165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3923FABF094
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C371B65AF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15305248F6C;
	Wed, 21 May 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hp5wqZKD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hp5wqZKD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E435259C8C
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821525; cv=none; b=dn3L+CG7coQGY8tv2voG8ONDpA0VEMd4OQis5EFxSyI0rQD1Z+A5qdA6FgyLPBNrfcqM9/64IP0t1kcZFWDPYUYqkDbZkyP6hCbVj8+BArIWwhujBYgeN41BzmFy8or+vkTyK3D+1Zso+isidenLyr8H1nfL6Af7OmIvJEDp4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821525; c=relaxed/simple;
	bh=IHEYDvZUQBXyWp9qYFpL5f/t9sUEONkUE0/V/nU0wE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KbIPlLm9p+Xt6yGrwV3xNJbPWHdVqYHscCUCr75LKRpIl6rwKgJTIMr65rI5FeDe5uYWYr1Qc688Ts1w1N5xQZT7fK8TimfYHqqpzBZTGFbNyFmAMWEKasHpJShPfYJ+hDij54wYnipmnW4mUl9PLfwsj+gyaNHF3msBvkXjVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hp5wqZKD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hp5wqZKD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 29C4C20906
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T3lCJinOUgFZ99R3KRf2ra6effygPYxos556+Lbm/Pk=;
	b=hp5wqZKDml670wHKIxL45GCfonDrmZt8qngNR3H2nG/ixuz0p/yy6v4y2qSbRgk5d91eLX
	gwVeUSh/iDltRnM33H1UBPG1tXeYPA1o3VPryf6sFIoK241N7UH5K1yJbrm4nTm6REtgUa
	RsYpNq2h/F+H+1SnNUmFlSOtnmTkcDA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hp5wqZKD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T3lCJinOUgFZ99R3KRf2ra6effygPYxos556+Lbm/Pk=;
	b=hp5wqZKDml670wHKIxL45GCfonDrmZt8qngNR3H2nG/ixuz0p/yy6v4y2qSbRgk5d91eLX
	gwVeUSh/iDltRnM33H1UBPG1tXeYPA1o3VPryf6sFIoK241N7UH5K1yJbrm4nTm6REtgUa
	RsYpNq2h/F+H+1SnNUmFlSOtnmTkcDA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56CF513888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yYRoBc+jLWj6RwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:58:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs-progs: new --inode-flags option
Date: Wed, 21 May 2025 19:28:17 +0930
Message-ID: <cover.1747821454.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 29C4C20906
X-Spam-Level: 
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Fix typos
  Exposed by github CI:

   ./mkfs/rootdir.c:1618: inheritted ==> inherited
   ./kernel-shared/inode.c:161: Similiar ==> Similar
   ./Documentation/mkfs.btrfs.rst:219: speicified ==> specified

The new --inode-flags option allows us to specify certain btrfs specific
flags to each inode.

Currently we only support *nodatacow* and *nodatasum*.

But in the future compression flag can also be added, allowing more
accurate per-file compression.

Furthermore child inodes will inherit the flag from their parents,
meaning one only needs to specify the flag to the parent directory, then
all children files/directories will have the flag.

This new option also works well with --subvol, although one has to
note that, the inode flag inheritance does not cross subvolume boundary
(the same as the kernel).

Finally, nodatacow and nodatasum will disable compression, just like the
kernel.

Qu Wenruo (4):
  btrfs-progs: allow new inodes to inherit flags from their parents
  btrfs-progs: do not generate checksum nor compress if the inode has
    NODATACOW or NODATASUM
  btrfs-progs: mkfs: add --inode-flags option
  btrfs-progs: mkfs-tests: a new test case for --inode-flags

 Documentation/mkfs.btrfs.rst             |  35 +++++++
 kernel-shared/inode.c                    |  64 ++++++++++++
 mkfs/main.c                              | 120 ++++++++++++++++++++++-
 mkfs/rootdir.c                           |  95 ++++++++++++++++--
 mkfs/rootdir.h                           |  15 +++
 tests/mkfs-tests/038-inode-flags/test.sh |  55 +++++++++++
 6 files changed, 375 insertions(+), 9 deletions(-)
 create mode 100755 tests/mkfs-tests/038-inode-flags/test.sh

--
2.49.0



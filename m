Return-Path: <linux-btrfs+bounces-14160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C594ABF076
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 11:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4D11B63769
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872525A2B7;
	Wed, 21 May 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pnC/7/mn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pnC/7/mn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267020ADF8
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821093; cv=none; b=WfVCptVspY1+rzRZQpPVkRcIN7ix9KhEDp5XDFMtRHlrrRwQUAMQQ4DU9kZ8IHMKoGWGTHLKRfOAqQNiE5dYUSzQ3SsO3LURkNukrCkXncsB2FYUhHLHU/FRvpbRVUEJoa+XH6/V0V+Ym0E4js2R0VBx5KZQsbK2S95rnIJdIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821093; c=relaxed/simple;
	bh=6dFHFGsiucksmuHAiavAe6U4ht7pH1xY90/6H0zM8iY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d3cJzuWny9zxWvCTejql4b84bsLYrlxFnnf/Ma4cgLWwceU398g0ELGF3AjeRLj57OeTb7l9/fat9kIcQlz3HQQ9kSZBksc2lPIyNY4g5ugT45RDk3KKCE5d5aW38ionF6QECuXRQ+CClmcBZZjr8lwRpHfmxAh71nFoUQSC6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pnC/7/mn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pnC/7/mn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6153D208EE
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GUc6vITucAup6m81DDQTPvFyopMrEeYW6q2rBlOJUac=;
	b=pnC/7/mn2Fgm1Ny3kJo/xa6NLY8N33UA3cV2GWCw6DVWz+n/Uw2ZEEV5JlagsG3k+j3lFR
	XLQgWH8seqejT6YdWIgfKWvBru73ELPNrOHpMQDlekVe4YjQTgAimeIoGvXKKxwHLKMRhQ
	6Ey/GTUVBYkIFKn9FqVXNshmKK1QCY8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="pnC/7/mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747821089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GUc6vITucAup6m81DDQTPvFyopMrEeYW6q2rBlOJUac=;
	b=pnC/7/mn2Fgm1Ny3kJo/xa6NLY8N33UA3cV2GWCw6DVWz+n/Uw2ZEEV5JlagsG3k+j3lFR
	XLQgWH8seqejT6YdWIgfKWvBru73ELPNrOHpMQDlekVe4YjQTgAimeIoGvXKKxwHLKMRhQ
	6Ey/GTUVBYkIFKn9FqVXNshmKK1QCY8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2ADC13888
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q9WVGSCiLWgBRgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 09:51:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: new --inode-flags option
Date: Wed, 21 May 2025 19:21:06 +0930
Message-ID: <cover.1747820747.git.wqu@suse.com>
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
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 6153D208EE
X-Spam-Level: 
X-Spam-Flag: NO

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



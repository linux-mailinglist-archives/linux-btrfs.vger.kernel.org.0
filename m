Return-Path: <linux-btrfs+bounces-14197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B0BAC2D02
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48ED4E13C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E318C933;
	Sat, 24 May 2025 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oXeL4q+h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UqGTvQ4k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF957E9
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052518; cv=none; b=Vn4pcNddaRIj8Mked+xUi/UjQSAuyHtJOaypQE8qeSAFs+jOMejvnaJ0w+T7xU3IxaTBveVK48xWPDaEBYIcWPwGj/oIfXiwgL1wT8WeZT6/25o8wx9t4vtHo9cs98yJy90Tl0zE4z8YqIz42N6qSpcBEfOdo0sQxIkGLIPXL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052518; c=relaxed/simple;
	bh=EezbhZxPINkPCA1pnAwwFkEEzOc+oiXj6f+prql18HM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Nx4KmYMZNy9ZMXYiPXggFWaSJdIM91LttPKmFJ2++gDJx//mSfqpIl16tc4iWYV1/M+V9vVwxY/49c9OjG1KRJP3qGCFoeIHY4OknPfLkAaWxEQzjPTbrPmGnZwTTPEVONUj7fcZ3jN9/LawIXVdqh+T+aul9aPZdKSV6miIFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oXeL4q+h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UqGTvQ4k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCA9821AEF
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q9xv+zZ2c9eraeqotkjzmy0PC4malifgHNN25aVzKzg=;
	b=oXeL4q+hEZYWi/KxHDUa/NqHkGt9NG/J9DUfEbr79nwv8cUFgZt7F3NTo9n1lG/kZL8MFl
	OxrAh6sUdWchmv2+DeaYGu8AUe7erLsVbBU9CUQIScWNcxGsAwIxgH1ru/uNh8Tlqi/6sE
	hgoonknf3PbzD0QTMITamJ+Y/8CwNl0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UqGTvQ4k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q9xv+zZ2c9eraeqotkjzmy0PC4malifgHNN25aVzKzg=;
	b=UqGTvQ4kfUO3tfPq3cNuLDWbRtPOuFFJb10icdDetwp4NJJ9SmUIjQppUf0GeGXUC1R8hW
	9tvpaTMWf7JFmxW8OeMoYF5t1wgktoh9G8mF+rHK82THocZiPT2jBdMMEIp1OFXnjHe8BX
	uZvHCT4vCMZbwjX+Q4voy/Cyp6jsIxI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F471373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1vbNMyAqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/9] btrfs-progs: convert: fix a long bug that bgt feature never works
Date: Sat, 24 May 2025 11:38:05 +0930
Message-ID: <cover.1748049973.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CCA9821AEF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]

There is a long bug that, "btrfs-convert -O bgt" doesn't create a fs
with bgt feature at all.

In fact "mkfs.btrfs -O bgt" is no different than "mkfs.btrfs -O ^bgt".

The root cause is explained and fixed in the second last patch.

The first 7 patches are mostly preparation and cleanup for properly
intorduce block group tree at temprory fs creation time.

Qu Wenruo (9):
  btrfs-progs: convert: add feature dependency checks for bgt
  btrfs-progs: convert: replace the bytenr check with a UASSERT()
  btrfs-progs: convert: simplify insert_temp_root_item()
  btrfs-progs: convert: simplify insert_temp_dev_item() and
    insert_temp_chunk_item()
  btrfs-progs: convert: simplify insert_temp_dev_extent()
  btrfs-progs: convert: simplify insert_temp_extent_item() and
    insert_temp_block_group()
  btrfs-progs: convert: merge setup_temp_fs_tree() and
    setup_temp_csum_tree()
  btrfs-progs: convert: implement the block group tree support properly
  btrfs-progs: convert-tests: add a test case for bgt feature

 convert/common.c                              | 337 +++++++++---------
 convert/main.c                                |   6 +
 .../028-block-group-tree/test.sh              |  20 ++
 3 files changed, 201 insertions(+), 162 deletions(-)
 create mode 100755 tests/convert-tests/028-block-group-tree/test.sh

--
2.49.0



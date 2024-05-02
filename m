Return-Path: <linux-btrfs+bounces-4665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF498B972B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 11:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFE71C21455
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2A9524D4;
	Thu,  2 May 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sZeSGt5u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sZeSGt5u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F620B3E
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640898; cv=none; b=USXCQzsoKN+tvxXxPVCIbmc8paveH0LsikzIFNV9XV4eyRKvy8qEr+e3+1ynWxYYLaxytGx3BI6SE/ZcFjsA3ug28Iium5Dxc0CSoGcILBHpJkAkRRjtF5srWHWMp36iIz95HsmFdTSf4QXUO6vqe3+vb3e9If9t/UPFUkhdalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640898; c=relaxed/simple;
	bh=VXpv/Stbnt46Enctbjg0PVcdtG1od0tY1spMM8Q0Np4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BDmrt3N948/8dTr7RpNuRKHrYVH7ISiFzmQzdGQwK/lyTCI9xKtqwF5PZBKZCf6lfMAphC5zBriYlxr01+Sw1atJmXJntSrCTjCCxGPsS7furZUiZ6DNLrRqWAoAhAvmWI69P2L1spizbn+zJNPyKGCSxzJCCygf9VEAicdUhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sZeSGt5u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sZeSGt5u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 265C11FBBF
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714640895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7M7WLcF8lkMQI5n99+gaiK2hYWt9c6fixSpBkohYw3Y=;
	b=sZeSGt5u7MQteYZVy/8lecxjjCa1Flp1ZIzkD0gkT8F6+SGtBjwbURoJGPRpyMQ1HYWfvX
	6wyIRP6q8QQV9YD1EnKZea7OZksGhYsYnQ7GkmQTeO3dbXqJv82rRiayTxG1llJpfloKps
	12BY27J9ez9SkQsSNgBhkYASDiRIKRc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sZeSGt5u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714640895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7M7WLcF8lkMQI5n99+gaiK2hYWt9c6fixSpBkohYw3Y=;
	b=sZeSGt5u7MQteYZVy/8lecxjjCa1Flp1ZIzkD0gkT8F6+SGtBjwbURoJGPRpyMQ1HYWfvX
	6wyIRP6q8QQV9YD1EnKZea7OZksGhYsYnQ7GkmQTeO3dbXqJv82rRiayTxG1llJpfloKps
	12BY27J9ez9SkQsSNgBhkYASDiRIKRc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F3391386E
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7bOyNf1XM2ZZcAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 09:08:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: check: detect and repair ram_bytes mismatch for non-compressed data extents
Date: Thu,  2 May 2024 18:37:52 +0930
Message-ID: <cover.1714640642.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.97 / 50.00];
	BAYES_HAM(-2.96)[99.85%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 265C11FBBF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.97

There are at least one kernel bug that makes on-disk
btrfs_file_extent_item::ram_bytes incorrect for non-compressed non-hole
data extents.

Thankfully kernel just doesn't care ram_bytes for non-compressed extents
at all, so it doesn't lead to any data corruption or whatever, and this
is really just a minor problem.

But for the sake of consistency and to follow the on-disk format, we
should still detect and repair such problems.

This patchset would implement detection and repair for both lowmem and
original mode, and a new hand crafted test case for it.

The reason why the test case is still handle crafted is, we do not have
the btrfs-corrupt-block support for corrupting ram_bytes to a specific
value yet.

I'd prefer to do the binary image migration to script in a dedicated
patchset in the future.

Qu Wenruo (3):
  btrfs-progs: check/lowmem: detect and repair mismatched ram_bytes
  btrfs-progs: check/original: detect and repair ram_bytes mismatch
  btrfs-progs: tests/fsck: add test case for ram_bytes detection and
    repair

 check/main.c                                  | 126 +++++++++++++++++-
 check/mode-lowmem.c                           |  69 ++++++++++
 check/mode-lowmem.h                           |   1 +
 check/mode-original.h                         |   8 ++
 .../default.img.xz                            | Bin 0 -> 2076 bytes
 5 files changed, 200 insertions(+), 4 deletions(-)
 create mode 100644 tests/fsck-tests/062-noncompressed-ram-bytes-mismatch/default.img.xz

--
2.45.0



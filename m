Return-Path: <linux-btrfs+bounces-15819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0CB196DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 01:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F2818937F0
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 23:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF10218AA0;
	Sun,  3 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BqX/nXZ/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RsV9/qWu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6586359
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754265181; cv=none; b=CnqER4B82/cBA9e9p48cb1as3P37i5m8rjo/15qIokCGzEKanvJhii8Ae3wMYO/TpkYGEn6pZWKT6pgtJ6mk10GhD+fKuA/FkGR9z4DHraGFIpXHjX1qS5OYoAQPtLwAn17tAs8yDRPz//KmbVUjIvFzxumppjAAZmvS4bdRr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754265181; c=relaxed/simple;
	bh=ns6EQuCKOYGXqNZgWa+ZgSSV4Au3hJp1Suo1bINJ74A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eiTqAcJ+stdFYpUPTW80cW6F2mVnWiZByirmgq5Jo98y/Z9ozT2D8QYKKX1uhvlOFmDREYO1Uk02ilGgRPPmlLFr0P9E+JKKZ+Yhez4hjl+TBhsmU5P+LEmNTOjlltNUsRglIpuC8NCVsbzzSN7c4eQh3iC1XmclCVU03hMABpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BqX/nXZ/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RsV9/qWu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA3971F387
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754265177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IPwdbz+xYR+c0xKujLKopnCBV5cHS6HUy9Tubw9B6UQ=;
	b=BqX/nXZ/miqLC0wQTltGIlIfpO3Lhdu0RJCnjFUNQz6vbVBUB4LTm771MCUweBOVEVG+tF
	kvsJj/yjvXIxNrZFPQWrRWFVmSxCqRP9L0qxksh/pcZyBObKlAMYLSteLmPKy3iYOWax/w
	eqKw3bYF7ea37+G0MuOGIg0KpI27mPo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754265176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IPwdbz+xYR+c0xKujLKopnCBV5cHS6HUy9Tubw9B6UQ=;
	b=RsV9/qWun5y/KF1nGvOjW3LaY/vDB1OQV4xR//bJxRB/JeKA37g1335Rva7JHyHAeg2NNU
	OWKaljDzqJt4B1LUCHcsB6s2LK3N9bDEM7SM98vU93WqGOzhO1EWugQ5c8RkYjzccdagCf
	4blq0i80byiL/NZSZUwEcxXYC61WA4Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CEC713974
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RiJaL1f2j2hPZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 03 Aug 2025 23:52:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: updates related to seed device and v6.17 kernel
Date: Mon,  4 Aug 2025 09:22:35 +0930
Message-ID: <cover.1754265134.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Kernel commit 40426dd147ff ("btrfs: use the super_block as holder when
mounting file systems") changed the block device holder so that each
device of a mounted btrfs can only belong to a single fs.

This is fine for most users, but for a corner case of seed devices, it
can be problematic.

As previously we allow the same seed device to be mounted through both
the seed device and the sprouted fs, as at that time all btrfs devices
share the same holder.

But now since each block device can only belong to a single mounted fs,
it means the seed device can only be mounted through either the seed
device itself or a sprouted fs, not both at the same time.

This series will update the docs to be more explicit about the seed
device mounting behavior, and updated the test case misc/046 to follow
the new kernel behavior.

And since we're here, also update a note where newer kernel fix a bug in
orphan roots cleanup.


Qu Wenruo (3):
  btrfs-progs: docs/seed: update a note related to orphan roots cleanup
  btrfs-progs: docs/seed: add extra notes for v6.17 and newer kernels
  btrfs-progs: misc-tests: do not try to mount a block device into
    different filesystems

 Documentation/ch-seeding-device.rst           | 14 +++++++++++++-
 tests/misc-tests/046-seed-multi-mount/test.sh | 17 ++++++++---------
 2 files changed, 21 insertions(+), 10 deletions(-)

--
2.50.1



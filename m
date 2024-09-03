Return-Path: <linux-btrfs+bounces-7779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EE496956F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA971F23BDB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24001DAC7B;
	Tue,  3 Sep 2024 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SQWrG5ui";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SQWrG5ui"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018F200101
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348569; cv=none; b=krMumdbw0pB2mpIWDcQuLNfYoJ81XGTuiKPQrxM2waXfI14LXzBE0jZ3xNLtIas4CzNJUiWDnsXbjTDBf4JToyj20Zk9G8JCWJu0zXIIdPi4FRZrVApWVpnxbm/tg2Kw5zrgzvESxGt+28I2vTgAb8hWdaXu6NFAH9mwoxUB6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348569; c=relaxed/simple;
	bh=IzMC4wNhQI1Sl/NP+hb/gPiZ6FCG7YghItxm02O7Ouw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lYBUcOr+FPrUEN0fq+0OPgbbcdWsnZ/UWmo2+7ROSKFUinCG8Eq6ZvgkivtjLf0K2GXMQmkru91zFdn8gxEirzqwcuKJ4ezZhxfOzghU0SelRyjnlMTd7AotJgqcUUt5QbqTgoiFgeKm1JSIpOe/INN24zFscYZMMa4me27TewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SQWrG5ui; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SQWrG5ui; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 482851FCF2
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725348565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=du/6xO3zntD+baiGbk1UtCxP22SdESr2+2Eq4SWdRPc=;
	b=SQWrG5uiWUUqZ2+nYT6UdN/TKBPob/wDYAnvbrOZWGM9NM535sOk5ty0S7WWQe9Sr4C4Aw
	AI7TxUjmJaalU+Qdc4VmJkM7/BKUU9ht8PBhgU9C4jS9G8M1iJUz4w3am0YUxKJnp0O8RP
	GU6himYXRs3bDgkKsFRGMzXYoK2Os0k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725348565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=du/6xO3zntD+baiGbk1UtCxP22SdESr2+2Eq4SWdRPc=;
	b=SQWrG5uiWUUqZ2+nYT6UdN/TKBPob/wDYAnvbrOZWGM9NM535sOk5ty0S7WWQe9Sr4C4Aw
	AI7TxUjmJaalU+Qdc4VmJkM7/BKUU9ht8PBhgU9C4jS9G8M1iJUz4w3am0YUxKJnp0O8RP
	GU6himYXRs3bDgkKsFRGMzXYoK2Os0k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 812ED13A52
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p0HJENS61mY2TwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 07:29:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: convert: fix the invalid regular extents for symbol links
Date: Tue,  3 Sep 2024 16:58:58 +0930
Message-ID: <cover.1725348299.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
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

Test case btrfs/012 fails randomly after the rework to use fsstress to
populate the fs.

It turns out that, if fsstress creates a symbol link whose target is
4095 bytes (at the max size limit), btrfs-convert will create a regular
extent instead of the expected inline one.

This regular extent for symbol link inodes will be rejected by kernel,
resulting test case failure.

The reason that btrfs-convert created such regular extent is,
btrfs-convert accidentally added one byte for the terminating NUL,
enlarge the should-be inlined file extent to be a regular one.

The first patch will fix the bug.
Then two patches to enahnce btrfs-check to detect the error (regular and
lowmem mode)
Eventually a dedicated test case for btrfs-convert, so in the future we
won't cause the problem again.

Qu Wenruo (4):
  btrfs-progs: convert: fix inline extent size for symbol link
  btrfs-progs: check/original: detect invalid file extent items for
    symbol links
  btrfs-progs: check/lowmem: detect invalid file extents for symbol
    links
  btrfs-progs: convert-tests: add a test case to verify large symbol
    link handling

 check/main.c                                  |  7 +++
 check/mode-lowmem.c                           | 44 +++++++++++++++++++
 convert/source-ext2.c                         | 12 +++--
 convert/source-reiserfs.c                     |  4 +-
 kernel-shared/file-item.c                     |  3 ++
 .../027-large-symbol-link/test.sh             | 33 ++++++++++++++
 6 files changed, 98 insertions(+), 5 deletions(-)
 create mode 100755 tests/convert-tests/027-large-symbol-link/test.sh

--
2.46.0



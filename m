Return-Path: <linux-btrfs+bounces-7331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97650957BFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 05:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF461C238E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 03:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA0F39FC1;
	Tue, 20 Aug 2024 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lCZd9xBD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Tu+pldGJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1A2F2A
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125568; cv=none; b=fm6Y2GWdUySuQ77G+zE6bbyb7/fYmEgoSNhP5i6EIGh5wrzPT/dGNs1TpgR/N68F5pxA4xMqhbkcy5kINcsOp7BFdjzSFqj43ZhVwTBjpwrwO66pxb9vtuV7OaZkq2lEvHnMcEH/91TEBB0e6OiCvuMwbK1n0A1EHag1PA93zeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125568; c=relaxed/simple;
	bh=pnXXe3Xbx47oKrpdQXS5t1wFAroP94vgjCt0NZdmlPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ESXkSGBmHrPLCXW+1/FlhpwwjaYQjZqBYqyXZHwbCAlvs2PDSTfmpfKv7reGFUWy1IXSKIX/ZCcaYZr3ADB+1GIK4YoZbb4p5r90ageCqMWpPAfClCZOmKt900kE0b4Ru4iHj2kMZvu4urkpZvcUi+CuAl3hb/6CG+oXXcRCBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lCZd9xBD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Tu+pldGJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 165C71FF6C
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724125563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UBdN9DCYVWCNyqPIf4QIdGDTOuR7wX2uoUSRhVZXF+U=;
	b=lCZd9xBD4ck6QGi4rI8lx+ieTxdTabeS+2cR4CQJ+UJcM3KjYzF0E7MUGgtgjPAUagL4tR
	ev82Q+6UNodsfOGamNGhUed+KwMlqSKhuSE6Yrm0338eD9n/h9+AVu1Yrl8NA4Ry0YCjSy
	w+yVPwkFPtS5C+yUwXl7r3TqgGJoCFk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Tu+pldGJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724125562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UBdN9DCYVWCNyqPIf4QIdGDTOuR7wX2uoUSRhVZXF+U=;
	b=Tu+pldGJdO+BoUzG4aHo5aXgTOH+1zGcVBOekKtbqyPQ7WmejU/EdhgPbojW39WNdkT77u
	vGKM3ArrR5GJyJiHkU6oI9aZ8w1M7W+x4BTzUO3wcNXR03CKztV+V4MQed3Ptce/M+bNO5
	x10N/2avtROY0+J2BcxiYi0mCsyDJoo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51C6313A17
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jyIsBXkRxGYbYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 03:46:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs-progs: mkfs/rootdir: add hard link support
Date: Tue, 20 Aug 2024 13:15:41 +0930
Message-ID: <cover.1724125282.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 165C71FF6C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_FAIL(0.00)[2a07:de40:b281:106:10:150:64:167:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[Changelog]
v2:
- Fix several grammar errors and change "can not" to more formal
  "cannot"
- Initialize the temporary hardlink_entry structure as const
- Double quote the $nr_hardlink used in test case

With the recently reworked --rootdir support, although it solves several
hard link related problems, it splits the hard links into new inodes.

And on each split, it shows a warning on each file with hardlinks.

Although the split behavior doesn't cause any data corruption, it can
still be pretty noisy for rootfs creation, as there are a lot of distros
storing timezone files as hardlinks.

This patchset adds back the hard link detection and creation, with
enhanced handling to co-operate with --subvol option.

The details can be found in the first patch, with the new corner case
introduced by --subvol option.

The second patch enhances the existing --rootdir and --subvol test case
with extra corner cases like hard links, and hard links split by
subvolume boundary.

Qu Wenruo (2):
  btrfs-progs: mkfs/rootdir: add hard link support
  btrfs-progs: mkfs-tests: add hardlink related tests for --subvol

 Documentation/mkfs.btrfs.rst                |  13 ++
 mkfs/rootdir.c                              | 199 +++++++++++++++++---
 tests/mkfs-tests/036-rootdir-subvol/test.sh |  78 ++++++--
 3 files changed, 247 insertions(+), 43 deletions(-)

--
2.46.0



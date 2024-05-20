Return-Path: <linux-btrfs+bounces-5120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F18CA2EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 21:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129BBB22376
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 19:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9F51386CC;
	Mon, 20 May 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f9cEp7XX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qr9U7grp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935F12E6A
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234741; cv=none; b=A5Mte5AnTjv07tswsgU2nEM33EuYG4S9QQ6XKQb4d7ENv+EIWI8+8USLRUNBwHhjyL4pjMPcqs3Eh0VxUYF7vIq4MJwhyvZAyhcC5I0pSRq8Sk37YVKKCmAqgAkXvjuagVrj24LxhK1hbxINOXziuetVdQAy3lvh3sNsmL3XZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234741; c=relaxed/simple;
	bh=+juwOG7Ydzsd485RnPMfZfMNcwt7WUzVRTla84lb5RU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/vNdshhaKGrpd+JfuVRDmffafh0JKAZ1NGNb5KZQNcDRz8CZx4Nn0BO/YR2Bod8nmBRkAAIMjIH//AeQVh90nFQ2b+uO9M5d7xiTCbUx0PlTKjKVesemTi3LaKYGpQizU33q9WukTxBXDcHLrdFJ3PBg4JS2MiNmpHUSsESS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f9cEp7XX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qr9U7grp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFFC020F86;
	Mon, 20 May 2024 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xhaj7sbTTG/H4zOm3nxivBBUTuadKBInMsSL7DI8ByQ=;
	b=f9cEp7XX9BQRMrgUTDLoM0oyfB7PGuvhedrwAXXXBXvR0127IXM7r6DxPFeOQgCiBXm6ZQ
	KRR3Y6vB+QCAmI06aBsl+mpkFxEt05hnfIzsbZPnG5Gd0daT8GdQtq5QhgzBXpr0rU6SnO
	L6oSYOFJ9gvF4FJs1sV9kcTsuAMiw10=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qr9U7grp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xhaj7sbTTG/H4zOm3nxivBBUTuadKBInMsSL7DI8ByQ=;
	b=qr9U7grpVczaT1MxJZ5glxygSbE7eQzuBD6DFiH3hlzX60FOudvheQEOm2Xr8ZxSCnZsVH
	cPcYltW4CNSydmmdaF+500VqPMbB50Ys2X3RD/M1eblbEJqguhSMqgf1KMmOa78VpA9Xjq
	UJ9SA4O9Dipx+Tl0QctqDQQJbWamix8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D752C13A6B;
	Mon, 20 May 2024 19:52:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s7X9M++pS2ZeQgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 20 May 2024 19:52:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/6] Cleanups and W=2 warning fixes
Date: Mon, 20 May 2024 21:52:08 +0200
Message-ID: <cover.1716234472.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.27 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.26)[73.78%];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -0.27
X-Spamd-Bar: /
X-Rspamd-Queue-Id: DFFC020F86
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

We have a clean run of 'make W='1 with gcc 13, there are some
interesting warnings to fix with level 2 and even 3. We can't enable the
warning flags by defualt due to reports from generic code.

This short series removes shadowed variables, adds const and removes
an unused macro. There are still some shadow variables to fix but the
remaining cases are with 'ret' variables so I skipped it for now.

David Sterba (6):
  btrfs: remove duplicate name variable declarations
  btrfs: rename macro local variables that clash with other variables
  btrfs: use for-local variabls that shadow function variables
  btrfs: remove unused define EXTENT_SIZE_PER_ITEM
  btrfs: keep const whene returnin value from get_unaligned_le8()
  btrfs: constify parameters of write_eb_member() and its users

 fs/btrfs/accessors.h   | 12 ++++++------
 fs/btrfs/extent_io.c   |  6 ++----
 fs/btrfs/inode.c       |  2 --
 fs/btrfs/qgroup.c      | 11 +++++------
 fs/btrfs/space-info.c  |  2 --
 fs/btrfs/subpage.c     |  8 ++++----
 fs/btrfs/transaction.h |  6 +++---
 fs/btrfs/volumes.c     |  9 +++------
 fs/btrfs/zoned.c       |  8 +++-----
 9 files changed, 26 insertions(+), 38 deletions(-)

-- 
2.45.0



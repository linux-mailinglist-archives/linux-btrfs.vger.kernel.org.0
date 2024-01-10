Return-Path: <linux-btrfs+bounces-1348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAB829288
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 03:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463D2B24630
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 02:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279E753AA;
	Wed, 10 Jan 2024 02:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Piag+T7i";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Piag+T7i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42B23D0
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01F0821B7D
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704855239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VuUx/vtKo7cX/oNRA21NtkNEgZ+r9CJq//8XAiWREmw=;
	b=Piag+T7iF1Db/X8PNI+vU6z/CM+rmmuxr+SoK3z6rFAP5n/MRWwm1GLNVE6FWFmE+O+ObD
	1nSWrkWPnRUdFCPZrcb4sy5Xww/+tIydz/drFyuUPjBrbJklf/lO2AO/oNYmbhbin3fO4m
	qRyAA9K6ySSVZBc4mj8fygO306oiHQU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704855239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VuUx/vtKo7cX/oNRA21NtkNEgZ+r9CJq//8XAiWREmw=;
	b=Piag+T7iF1Db/X8PNI+vU6z/CM+rmmuxr+SoK3z6rFAP5n/MRWwm1GLNVE6FWFmE+O+ObD
	1nSWrkWPnRUdFCPZrcb4sy5Xww/+tIydz/drFyuUPjBrbJklf/lO2AO/oNYmbhbin3fO4m
	qRyAA9K6ySSVZBc4mj8fygO306oiHQU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A3D13786
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uJt3NcQGnmWqKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 02:53:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fix the return value of "btrfs
Date: Wed, 10 Jan 2024 13:23:30 +1030
Message-ID: <cover.1704855097.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *******
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Piag+T7i
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [7.97 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.86%]
X-Spam-Score: 7.97
X-Rspamd-Queue-Id: 01F0821B7D
X-Spam-Flag: NO

There is a bug report ("https://github.com/kdave/btrfs-progs/issues/730")
that after commit 5aa959fb3440 ("btrfs-progs: subvolume create: accept
multiple arguments"), "btrfs subvolume create" no longer properly return
1 for error cases.

It turns out that the offending commit changed how we determine the
return code, thus for several error cases, we still return 0 for
create_one_subvolume().

Fix it and add a test case for it.

Qu Wenruo (2):
  btrfs-progs: cmd/subvolume: ix return value when the target exists
  btrfs-progs: cli-tests: add test case for return value of "btrfs
    subvlume create"

 cmds/subvolume.c                              | 11 ++++++-
 .../025-subvolume-create-failures/test.sh     | 30 +++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100755 tests/cli-tests/025-subvolume-create-failures/test.sh

--
2.43.0



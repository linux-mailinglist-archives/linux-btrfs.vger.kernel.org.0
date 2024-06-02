Return-Path: <linux-btrfs+bounces-5388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFEA8D7382
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 05:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE211C2258C
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69506134BC;
	Sun,  2 Jun 2024 03:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GZQPxZUP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GZQPxZUP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE5442F
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299967; cv=none; b=bGMTbZ65SwjYclJVds7J11oJ6rmd5NcZe9IIGtBNm0wqUmR+4hNsqNYgk9unHm/eYTrXnDhHYd3boELcikN1zMC2z6h94mWbluaBC4Wl9e3cfXezMJhpXmevqe4cNOtJD3pBvJicS2lv91pgkb8hFvOv26F5tNX/PQamjGsBJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299967; c=relaxed/simple;
	bh=xh984BTz8BOpIVUtm4n51gaTvldA93pssLW1337cgy8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VeFfbCOdYa16jrakXf2xuZkbjuzaPGAr4MiQiK+w27DVmxGVmF/3kzcaMwxf/BNx8e/tHn6leuRcTg50fR8XEz7hz6rgw3n3zKV4ZghpWg1A2YtkPd+LiB3sgoUbUTX2VPMo6oW3+jczNKyYsGm9101vaTESEVCMTHlf6uQuPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GZQPxZUP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GZQPxZUP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B63B9220DB
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717299956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EOyEWoJA1EiE6GZgz80GjmqvOklXawFKJRwm7OPRbzk=;
	b=GZQPxZUPNJQFfeBlFcIvofNe3BbONt9hnRYcZlLua9nVuarqlBZ8cAZAc5YIuhxMy03s56
	Y1p3P/ehpyJYDO8s2olEIoNF9eNojbI/PYZnYAOHWzWumSvdFS1ATyPbtVzx0QFtQ60P36
	MqHalUOBB34KShOpwNKtz5drB1JIMyY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717299956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EOyEWoJA1EiE6GZgz80GjmqvOklXawFKJRwm7OPRbzk=;
	b=GZQPxZUPNJQFfeBlFcIvofNe3BbONt9hnRYcZlLua9nVuarqlBZ8cAZAc5YIuhxMy03s56
	Y1p3P/ehpyJYDO8s2olEIoNF9eNojbI/PYZnYAOHWzWumSvdFS1ATyPbtVzx0QFtQ60P36
	MqHalUOBB34KShOpwNKtz5drB1JIMyY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4DC81399C
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rVm6HfPqW2bnOAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 02 Jun 2024 03:45:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: btrfstune: fix false alerts on dev-replace when changing csum
Date: Sun,  2 Jun 2024 13:15:31 +0930
Message-ID: <cover.1717299366.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.36 / 50.00];
	BAYES_HAM(-2.56)[98.04%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.36
X-Spam-Flag: NO

There is a bug report that if a btrfs has experienced any dev-replace,
"btrfstune --csum" would always report a running dev-replace and refuse
to continue.

It turns out that, DEV_REPLACE item is not a transient one (but not
created properly as mkfs time either), after a dev-replace the
DEV_REPLACE item would exist forever, recording the last dev-replace
timestamp.

Although I really hate such behavior (especially when balance item would
be gone after a balance is finished/canceled), at least fix the problem
first.

The first patch enhances the print-tree to properly output the
contents of the dev-replace item, then the second patch fixes the
problem.

I'd like to add test cases for it, but it turns out there is no csum
change test cases.
My guess is we do not have proper way to skip the test if it's
experiemental feature?

Maybe it's time to move csum change out of experiemental features?

Qu Wenruo (2):
  btrfs-progs: print-tree: add support for dev-replace item
  btrfs-progs: change-csum: handle finished dev-replace correctly

 kernel-shared/print-tree.c | 79 ++++++++++++++++++++++++++++++++++++++
 tune/change-csum.c         | 18 +++++++--
 2 files changed, 94 insertions(+), 3 deletions(-)

--
2.45.1



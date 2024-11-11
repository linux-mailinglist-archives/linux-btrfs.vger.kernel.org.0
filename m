Return-Path: <linux-btrfs+bounces-9405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF809C3735
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 04:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA5B1C20F1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 03:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098F149E17;
	Mon, 11 Nov 2024 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e83oQTVn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e83oQTVn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DA139578
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731297572; cv=none; b=uzXWt3sGmpLhsSEDUJzFstDlYemjU8afsk+jgsxmL8GWNc0ID194r5CWYnImv63hiyVWLDbTUuhRI9h/eqk9ZOn30rjKJBqlb6W8CQODC0MKUUdYJZkmmIEuHeB9b8CxEjJu6cPoLQ54BpdOUkWOUhex6bweVxn8cIpiWlk8aXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731297572; c=relaxed/simple;
	bh=aMUQ5lYBH5rh21kgdW8wIVffvrO4FocJMt2hBR5HvhE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MVWiAtyIMk3bvPjvO+REJPv9UFpWpi5RYVd2hOoe0QrCb98WbZ56RLsussCvpwLFtL7eyhnWOb/gFeIeOp+bDUeqdRHiQvSueSV8TEScPhhsrAwx+a+qSBzohb7cRT9HFYaOKB6P+9kOL78wMvqJbdWj/cMzqnIpY5Li1EUT5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e83oQTVn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e83oQTVn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B384219E1
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731297568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MHzjQyGqL11Rg2TJ3vQ2yQMei08QOJM5QqSY3oNOvvw=;
	b=e83oQTVnilq/Emn3kUrFipPWxVBBdRS0jrLbM2zNYLths2dBzd6UOzLi5lVJvqjRJp6QAB
	PsjvD4WYZl47y9YLwT7aHbNrsw+xHF4qGkD8GH4E2fyJ2w0BDaX0UvmNq8VL6Vu/BR8v4N
	woa+CupEfVeYadSA3lyHySl3bzeXMzg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=e83oQTVn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731297568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MHzjQyGqL11Rg2TJ3vQ2yQMei08QOJM5QqSY3oNOvvw=;
	b=e83oQTVnilq/Emn3kUrFipPWxVBBdRS0jrLbM2zNYLths2dBzd6UOzLi5lVJvqjRJp6QAB
	PsjvD4WYZl47y9YLwT7aHbNrsw+xHF4qGkD8GH4E2fyJ2w0BDaX0UvmNq8VL6Vu/BR8v4N
	woa+CupEfVeYadSA3lyHySl3bzeXMzg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 990A813967
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J4BOFh+BMWcbJgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 03:59:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: btrfs_buffered_write() cleanups
Date: Mon, 11 Nov 2024 14:29:06 +1030
Message-ID: <cover.1731297381.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B384219E1
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This series is to cleanup btrfs_buffered_write() so that it's more
aligned to generic_perform_write(), and makes later migration much
easier.

All those changes are inside btrfs, and the last 2 should improve the
readablity, and prepare for the migration (since everything is now done
inside the loop).

Qu Wenruo (3):
  btrfs: make buffered write to respect fatal signals
  btrfs: cleanup the variables inside btrfs_buffered_write()
  btrfs: remove the out-of-loop cleanup from btrfs_buffered_write()

 fs/btrfs/file.c | 90 ++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

-- 
2.47.0



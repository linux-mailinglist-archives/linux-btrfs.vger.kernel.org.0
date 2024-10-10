Return-Path: <linux-btrfs+bounces-8766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB997997BF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 06:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780B3B225D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581219D89B;
	Thu, 10 Oct 2024 04:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UZBRjmOf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UZBRjmOf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD83D66
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535595; cv=none; b=q+7H9A5FsK26mPgs4eLid/LWVDq28uz/y1fo8+qwbA0CJYZwJ8W2hlrlXrFfEcFNSAeWH7wxNSBDmNiX12m0q9Cas4fVrYLvYGxECWY9cWY3uahgakx9caeFgGQ/qDGGnv+md+YS25SoK+jxHv5ZXw3Up/nLRRNCJc4AYthqXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535595; c=relaxed/simple;
	bh=dx3dCrWP5SnBRLQJrpYv6lRMjsQVi4iBwQxBNK36w2s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Yhe3hI85M3C3jNjkU/a0r48Q5WJakyR/f3iYQit8pQNVYmcuXQh6tWYehxJI7FAgtkF6xrOzJRNxUtGxlBazZstQ13iHL1HC/UwvhnW2oCCw3mQl9xBewfAgCxFoSZyRIBmslpNwwTFOBknnF0DmtyQLvPborQOXzlG5Pi5Pyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UZBRjmOf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UZBRjmOf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9209321F7C
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728535591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8jjDKOWmu7gBcY2xLQ2lqOa+uFRcOImJifFkWvTpypU=;
	b=UZBRjmOfS+BqsFHWYzNToYGfT5hW7jUJvwxe23xJMJD/nFqA6alNT/67fuMN6d+lTpesk6
	SFdWxqvR8gIz1uucmDYGbyowqj8xnm1VML8skWpFj1sShg1oojscrg6cLSvcDuMFLsjik3
	xDVgVNT1QIqaZhhzCqRtYUG0DLKEOnQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UZBRjmOf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728535591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8jjDKOWmu7gBcY2xLQ2lqOa+uFRcOImJifFkWvTpypU=;
	b=UZBRjmOfS+BqsFHWYzNToYGfT5hW7jUJvwxe23xJMJD/nFqA6alNT/67fuMN6d+lTpesk6
	SFdWxqvR8gIz1uucmDYGbyowqj8xnm1VML8skWpFj1sShg1oojscrg6cLSvcDuMFLsjik3
	xDVgVNT1QIqaZhhzCqRtYUG0DLKEOnQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D35301370C
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VbZ3JSZcB2dZLQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 04:46:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: convert btrfs_buffered_write() to folio interface
Date: Thu, 10 Oct 2024 15:16:11 +1030
Message-ID: <cover.1728532438.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9209321F7C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Inspired by generic_perform_write(), convert btrfs_buffered_write() to
go a page-by-page iteration, then convert it to use folio interface.

This should provide the basis for use to go
address_operations->write_begin() and write_end() callbacks.

There is a tiny timing change.
Before this patchset we wait for the page writeback after we get an
uptodate or no need to read the page.

But now we follow the regular FGP_WRITEBEGIN, which implies FGP_STABLE
and will wait for writeback before reading the page.

Qu Wenruo (2):
  btrfs: make buffered write to copy one page a time
  btrfs: convert btrfs_buffered_write() to use folio interface

 fs/btrfs/file.c             | 259 +++++++++++++-----------------------
 fs/btrfs/file.h             |   2 +-
 fs/btrfs/free-space-cache.c |  15 ++-
 3 files changed, 102 insertions(+), 174 deletions(-)

-- 
2.46.2



Return-Path: <linux-btrfs+bounces-8594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D858D99399C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162E91C231C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740E18C929;
	Mon,  7 Oct 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rUIMa8dk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rUIMa8dk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2016E87D
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338347; cv=none; b=p9OWZ9LNahB6JRihQH9ohUPfLf5W+FwHnzxySZWo4cR+nBtBdaxMiYYvS1ZKryxxylUq2rs9+56jRlqdE/0Q+JdSfVoDvXQLrnhvXkWRAuPpj1wx019JNUva0ORPfEjAblE5yZmtu2AUSSP17Fl6uJCfO+qL4ohaVSdku6sX2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338347; c=relaxed/simple;
	bh=cjLy5fHtOLfeTbhjxzd4uVzkT9MTgB1nRYTG09TewOo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ndnfqTl2J/6WjNt1eGlD8eDjnUtc51MFavAypjyblEdOOZb99E/FAnZnv6/ndTjm9Y+Z8sN3ew0qix7scs0mWpgnBxAHyWCHLB+vosg+0dlItn7hhywaCf5l735fvJHUROB+5oqI9PWDIwDvwuFRh2XWbdcLuiHhXyyotyw8AUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rUIMa8dk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rUIMa8dk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6C201FD7C
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728338343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SNIw1ouifsJXDsJE3SIw8ZZY56k8EYHCrp6GBcCWbcI=;
	b=rUIMa8dkuo4Jw9+AQW+OdcbqfY4SaJiD5GDUre1EEPQhxOsMgpelZPsi2yNzEnrV2Auh6f
	G/yL170bzciK17f+Q/DHhaU8qgHYe/wC7r2H3ZTDdCcQ6vlDOvpu5RWMspyCmipNH9/Zxu
	RBBqI2llFdBt1qRPIZqDgvVJxt3XfBk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rUIMa8dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728338343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SNIw1ouifsJXDsJE3SIw8ZZY56k8EYHCrp6GBcCWbcI=;
	b=rUIMa8dkuo4Jw9+AQW+OdcbqfY4SaJiD5GDUre1EEPQhxOsMgpelZPsi2yNzEnrV2Auh6f
	G/yL170bzciK17f+Q/DHhaU8qgHYe/wC7r2H3ZTDdCcQ6vlDOvpu5RWMspyCmipNH9/Zxu
	RBBqI2llFdBt1qRPIZqDgvVJxt3XfBk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F305713786
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YbfCLKZZBGfsfAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 21:59:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: unify the read and writer locks for btrfs_subpage
Date: Tue,  8 Oct 2024 08:28:43 +1030
Message-ID: <cover.1728338061.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B6C201FD7C
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
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

When the handling of sector size < page size is introduced, there are
two types of locking, reader and writer lock.

The main reason for the reader lock is to handle metadata to make sure
the page::private is not released when there is still a metadata being
read.

However since commit d7172f52e993 ("btrfs: use per-buffer locking for
extent_buffer reading"), metadata read no longer relies on
btrfs_subpage::readers.

Making the writer lock as the only utilized subpage locking.

This patchset converts all the existing reader lock usage and rename the
writer lock into a generic lock.

This patchset relies on this patch "btrfs: fix the delalloc range
locking if sector size < page size", as it removes the last user of
btrfs_folio_start_writer_lock().

Qu Wenruo (2):
  btrfs: unify to use writer locks for subpage locking
  btrfs: rename btrfs_folio_(set|start|end)_writer_lock()

 fs/btrfs/compression.c |   3 +-
 fs/btrfs/extent_io.c   |  20 +++----
 fs/btrfs/subpage.c     | 126 ++++++++---------------------------------
 fs/btrfs/subpage.h     |  33 ++++-------
 4 files changed, 44 insertions(+), 138 deletions(-)

-- 
2.46.2



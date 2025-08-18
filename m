Return-Path: <linux-btrfs+bounces-16115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496DB295D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 02:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D47ADFB2
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5D1A5B8C;
	Mon, 18 Aug 2025 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HTmLm47L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HTmLm47L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7A1E2606
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477136; cv=none; b=Tv0qhYmxu+6c4k3CkW2SrDGNyZzJimerKC5M1i+LqMPYnRNBPj8rPhMpYbaC62UH1gUYTzi2MZSkl8klrKy1Gqq6oyjXiI9MEJo48nAVvXtubLX396ptvSI9mL1pz3H+IwdDixdsY+j77ruar0TvkK8aETX5mGp6YRdTQn0CxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477136; c=relaxed/simple;
	bh=CCqmFDdI8/hLeCwbAEnyBQuMMFrYMYai7hz51n3Yt3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tWXnMZ0vhBHN5PTy+gVmV9UhZSvEzVOqSioH+QlxsSr34yIsKeKY0XiFGxFaT+BP5TnpjcRsDiwXi9KXIaKpApHmNMyWcXpjBNzh7KwKepbEQVhofRQzyUcX//OolxvljpTquTGL4lx2jfIquW4MyXZz1W9kZCFOzo9+bpntHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HTmLm47L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HTmLm47L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C05A218FA
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lYiNiWusnAeShbzn22kV830TfAHKmM12WwSYd7mNYV4=;
	b=HTmLm47LImqkQWLPyGo1m1qGgCqLV1AXRDxcZgFnovj8HD/oiLwYYT6pEP7j5fhRqUzxLk
	TifAotZC1WgI/i9PzpOXugjy8DQgz2IENsyr/6OtT/BcKBsrOqHsNjPSiySAIwJe72qsPE
	h6vP6pBf74q4eh/DEHyuL1JDnUqfAqg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HTmLm47L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lYiNiWusnAeShbzn22kV830TfAHKmM12WwSYd7mNYV4=;
	b=HTmLm47LImqkQWLPyGo1m1qGgCqLV1AXRDxcZgFnovj8HD/oiLwYYT6pEP7j5fhRqUzxLk
	TifAotZC1WgI/i9PzpOXugjy8DQgz2IENsyr/6OtT/BcKBsrOqHsNjPSiySAIwJe72qsPE
	h6vP6pBf74q4eh/DEHyuL1JDnUqfAqg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53E9B13686
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IBp+BYV0omhWKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/5] btrfs-progs: enhance --subvol/--inode-flags options
Date: Mon, 18 Aug 2025 10:01:42 +0930
Message-ID: <cover.1755474438.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 1C05A218FA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Currently both --subvol and --inode-flags save the full path into their
structures, and check each inode against those full path.

For long paths it can be time consuming, and this introduces extra
memory for each structure.

This series enhance the handling of those options by:

- Extract the validation part into a dedicated helper inside
  rootdir.[ch]

- Use st_dev/st_ino to replace full_path
  This reduces runtime and memory usage for the involved structures.

- Remove the memory usage warning note
  Even with the old 8K per structure memory usage, 1024 options will
  only 8M memory, that's accetable even for a lot of micro-controllers,
  not to mention modern desktop/servers.

  I'm a little paranoid at that time, with the memory usage almost
  halved, we can safely remove that warning note.

Qu Wenruo (5):
  btrfs-progs: mkfs/rootdir: extract subvol validation code into a
    helper
  btrfs-progs: mkfs/rootdir: extract inode flags validation code into a
    helper
  btrfs-progs: mkfs/rootdir: enhance subvols detection
  btrfs-progs: mkfs/rootdir: enhance inode flags detection
  btrfs-progs: doc/mkfs: remove the note about memory usage

 Documentation/mkfs.btrfs.rst |   5 --
 mkfs/main.c                  |  84 ++------------------
 mkfs/rootdir.c               | 147 +++++++++++++++++++++++++++++++----
 mkfs/rootdir.h               |  14 +++-
 4 files changed, 148 insertions(+), 102 deletions(-)

--
2.50.1



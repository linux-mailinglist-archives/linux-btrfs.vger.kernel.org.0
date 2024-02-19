Return-Path: <linux-btrfs+bounces-2489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301985A1A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97084B223A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EF52C197;
	Mon, 19 Feb 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tibkx4bx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tibkx4bx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078032C182
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341200; cv=none; b=qKQSxz49uS7PZMWK6hnMIVlyDRsWA9jeknDOFsndpAawyTyasaIMNdaEZwY3Ec0puREySD14+y2Y1YYjV0ye2yPdCqF43NVtVGqE+3Vuq3QRQ9sj6Mjo70/dts4ss3TDtdMlDXE+sUZIYDNTzOXqWMq2pV7zUUH4+L0WinlOjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341200; c=relaxed/simple;
	bh=rP06Seag6PSc4FPHi3lcGhgrWdxW0BMpvUpQJtKdaWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZaxE76TI2RdzoYU55xgGNAxsAqexDJQb4KBNa0N2fgWPnaVDAF2bKsJeiy0HVqp/Xr8/CCL0rMxvH9AoTqrk9c1wZJ5tOBEI0ORpX2eHO3cNgoUSMf+hYmxu2FhswU0fRXWqCq6gt6Q0xtCr4XLXd+FBmdMpp8GoGlLiroCw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tibkx4bx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tibkx4bx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41FC21F7F3;
	Mon, 19 Feb 2024 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ov+eOnTTsmc/xy0/ysYnM+cUKI+nqhxjqkvKaUxZTdw=;
	b=tibkx4bxkzwVjTGP2TMaQIcZZ+ltcgvcG/6VmbM/cYDnrgMWMcT8qNZUQlQHHJvro3uVFy
	nf+TjX0M9MKtOx8Pg27cU6GbjMZAskK2zmgQ+44ABc47ldrcUAvt8BK0yw2J2RLF+/X954
	OfSNQkJDBBR4A1F65yxU8AeKGRjIzTQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708341196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ov+eOnTTsmc/xy0/ysYnM+cUKI+nqhxjqkvKaUxZTdw=;
	b=tibkx4bxkzwVjTGP2TMaQIcZZ+ltcgvcG/6VmbM/cYDnrgMWMcT8qNZUQlQHHJvro3uVFy
	nf+TjX0M9MKtOx8Pg27cU6GbjMZAskK2zmgQ+44ABc47ldrcUAvt8BK0yw2J2RLF+/X954
	OfSNQkJDBBR4A1F65yxU8AeKGRjIzTQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BB60139C6;
	Mon, 19 Feb 2024 11:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IV+QDsw302VxZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/10] Static inline cleanups
Date: Mon, 19 Feb 2024 12:12:40 +0100
Message-ID: <cover.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.84
X-Spamd-Result: default: False [2.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.86)[85.58%]
X-Spam-Flag: NO

Historically there are many static inlines in headers that do not
qualify as such, move them to .c. Some can be open coded.

David Sterba (10):
  btrfs: move balance args conversion helpers to volumes.c
  btrfs: open code btrfs_backref_iter_free()
  btrfs: open code btrfs_backref_get_eb()
  btrfs: uninline some static inline helpers from backref.h
  btrfs: uninline btrfs_init_delayed_root()
  btrfs: drop static inline specifiers from tree-mod-log.c
  btrfs: uninline some static inline helpers from tree-log.h
  btrfs: simplify conditions in btrfs_free_chunk_map()
  btrfs: open code trivial btrfs_lru_cache_size()
  btrfs: uninline some static inline helpers from delayed-ref.h

 fs/btrfs/accessors.h     |  39 -------------
 fs/btrfs/backref.c       |  94 +++++++++++++++++++++++++++++-
 fs/btrfs/backref.h       | 120 ++++-----------------------------------
 fs/btrfs/delayed-inode.c |  11 ++++
 fs/btrfs/delayed-inode.h |  13 +----
 fs/btrfs/delayed-ref.c   |  65 +++++++++++++++++++++
 fs/btrfs/delayed-ref.h   |  72 +++--------------------
 fs/btrfs/lru_cache.h     |   5 --
 fs/btrfs/relocation.c    |   3 +-
 fs/btrfs/send.c          |   7 +--
 fs/btrfs/tree-log.c      |  46 +++++++++++++++
 fs/btrfs/tree-log.h      |  48 +---------------
 fs/btrfs/tree-mod-log.c  |  13 ++---
 fs/btrfs/volumes.c       |  41 ++++++++++++-
 fs/btrfs/volumes.h       |   2 +-
 fs/btrfs/zoned.c         |   3 +-
 16 files changed, 290 insertions(+), 292 deletions(-)

-- 
2.42.1



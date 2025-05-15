Return-Path: <linux-btrfs+bounces-14026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C9AB7F81
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 10:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1324C521B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C81A4F2F;
	Thu, 15 May 2025 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D9A6TdcH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D9A6TdcH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B52063F3
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296044; cv=none; b=PnbJtG+A9TFggxczWHfEQDhr30etuXr02mfranBTPa4WBEclhjezR7ijlcLQoSiMaSAXybaDZ5S5HpX7cc0C24Q4A+5KW4rzPSznWCOnSTJxOkmuQEHjeHMpqpIHgYdgHttmQe7cO6bc7FgVgW4BmZ8eW3tj6avUwdwBbN0eAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296044; c=relaxed/simple;
	bh=IskkjqtnosTU5I8+bHErfDxAFI5o9b7I7zuTDiQHaM4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tc5MhrwPzM5k9OAj+Q+eWawquDrbUZW0afPBPXKj9zWfWb7ZH5d7woNt++z25vydf1fff8Hws9+CCsTua+18KfXNrhU9caZPcoOQYxtk3FxNCbwQzqQXDuCgyEVNhAxPKwEmUTbb3yRnUJfn0ivBjt6DelbGEEtVoTXhDVBwjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D9A6TdcH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D9A6TdcH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E05F521202
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1IaKd5FLfRAd17Wg2RNFFj+p6vurS2UhWotKm/0FWmA=;
	b=D9A6TdcHJScWYt/SWXwWxRYhCWA7uJqJ6JBvJ+QFcc9t2N0DjyQjvSS1MHS8yND2lFKp3S
	VeEXaOC2DIncyN6htN9R6VI3RxFX1CFYDXTXq6h6AceNY6wZ6tCRaKCCGgU+EJo2Q3xcdI
	BwPQfiBirNfuT8ub7gEcOKOq3mxRN5w=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1IaKd5FLfRAd17Wg2RNFFj+p6vurS2UhWotKm/0FWmA=;
	b=D9A6TdcHJScWYt/SWXwWxRYhCWA7uJqJ6JBvJ+QFcc9t2N0DjyQjvSS1MHS8yND2lFKp3S
	VeEXaOC2DIncyN6htN9R6VI3RxFX1CFYDXTXq6h6AceNY6wZ6tCRaKCCGgU+EJo2Q3xcdI
	BwPQfiBirNfuT8ub7gEcOKOq3mxRN5w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25B43137E8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yuQTNiafJWi8LwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/6] btrfs-progs: introduce "btrfs rescue fix-data-checksum"
Date: Thu, 15 May 2025 17:30:15 +0930
Message-ID: <cover.1747295965.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[]

[CHANGELOG]
v2:
- Rename the subcommand to "fix-data-checksum"
  It's better to use full name in the command name

- Remove unused members inside corrupted_block
  The old @extent_bytenr and @extent_len is no longer needed, even for
  the future file-deletion action.

- Fix the bitmap size off-by-1 bug
  We must use the bit 0 to represent mirror 1, or the bitmap size will
  exceed num_mirrors.

- Introduce -i|--interactive mode
  Will ask the user for the action on the corrupted block, including:

  * Ignore
    The default behavior if no command is provided

  * Use specified mirror to update the data checksum item
    The user must input a number inside range [1, num_mirrors].

- Introduce -m|--mirror <num> mode
  Use specified mirror for all corrupted blocks.
  The value <num> must be >= 1. And if the value is larger than the
  actual max mirror number, the real mirror number will be
  `num % (num_mirror + 1)`.

We have a long history of data csum mismatch, caused by direct IO and
buffered being modified during writeback.

Although the problem is worked around in v6.15 (and being backported),
for the affected fs there is no good way to fix them, other than complex
manually find out which files are affected and delete them.

This series introduce the initial implementation of "btrfs rescue
fix-data-checksum", which is designed to fix such problem by either:

- Update the csum items using the data from specified copy

The subcommand has 3 modes so far:

- Readonly mode
  Only report all corrupted blocks and affected files, no repair is
  done.

- Interactive mode
  Ask for what to do, including

  * Ignore (the default)
  * Use certain mirror to update the checksum item

- Mirror mode
  Use specified mirror to update the checksum item, the batch mode of
  the interactive one.

In the future, there will be one more mode:

- Delete mode
  Delete all involved files.

  There are still some points to address before implementing this mode.

Qu Wenruo (6):
  btrfs-progs: introduce "btrfs rescue fix-data-checksum"
  btrfs-progs: fix a bug in btrfs_find_item()
  btrfs-progs: fix-data-checksum: show affected files
  btrfs-progs: fix-data-checksum: introduce interactive mode
  btrfs-progs: fix-data-checksum: update csum items to fix csum mismatch
  btrfs-progs: fix-data-checksum: introduce -m|--mirror option

 Documentation/btrfs-rescue.rst  |  28 ++
 Makefile                        |   2 +-
 cmds/rescue-fix-data-checksum.c | 511 ++++++++++++++++++++++++++++++++
 cmds/rescue.c                   |  65 ++++
 cmds/rescue.h                   |  10 +
 kernel-shared/ctree.c           |  17 +-
 kernel-shared/file-item.c       |   2 +-
 kernel-shared/file-item.h       |   5 +
 8 files changed, 635 insertions(+), 5 deletions(-)
 create mode 100644 cmds/rescue-fix-data-checksum.c

--
2.49.0



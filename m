Return-Path: <linux-btrfs+bounces-13862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32959AB26F1
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 May 2025 08:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A733F170945
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 May 2025 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C50199934;
	Sun, 11 May 2025 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GmV5p8l/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GmV5p8l/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F8156678
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746946128; cv=none; b=jkHgp/Vmz31ekdN+bifPbXdfLdiafEpp/HqbdJkB0vjIJb1nEi2rIEAWxUkt79P576n2mK8TdTeqYgR4QSVrJmh1BoyNvKPIfcS6vcOqI9rwd1oqNm50H5SViNbmmMEywp53ulwp7aZZz2OUnapWjYSrC/0abyvFEeGSMWmA3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746946128; c=relaxed/simple;
	bh=UNw241Bi5h8hnFtjTCblrTOJXeQH/8G9VojY0e19pww=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e1tse+3tvmd4wfAstRh8IMHwmgY17VEG/kMcfFOq9/jSkji9cJFwEIoHqAJ9KdTZEXOdRUDWQTkJ786gk1pp/yYhwciu2fzj0HZFraVeJwFHYZoKksyHkMn4v6JKctLRfmKhhXLTgCmDCOIPMV9LA6+RXRjkzXv8/+WQcfg4qGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GmV5p8l/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GmV5p8l/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7351021170
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 06:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746946124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WCyl3kAadX1c9GfXxba0w04QwAXGE/8BzHxlbjw/rLA=;
	b=GmV5p8l//j9pmaFbpbKE3hjzdXzq2sBQA4svQe25ZEYLy+uKOCsoERGJZ00it9WmuFLc0u
	g4yTQaBcRUuFEUXAvemj0f6TOHKOGuBT3jqPYFBq2GgBDMjYqR5ZRyS0uKb81XG0MvJPDB
	YaquR1cMhCugQN3oS+2S0h7EiZYSiBI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="GmV5p8l/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746946124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WCyl3kAadX1c9GfXxba0w04QwAXGE/8BzHxlbjw/rLA=;
	b=GmV5p8l//j9pmaFbpbKE3hjzdXzq2sBQA4svQe25ZEYLy+uKOCsoERGJZ00it9WmuFLc0u
	g4yTQaBcRUuFEUXAvemj0f6TOHKOGuBT3jqPYFBq2GgBDMjYqR5ZRyS0uKb81XG0MvJPDB
	YaquR1cMhCugQN3oS+2S0h7EiZYSiBI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EE77137E8
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 06:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qaxDF0tIIGh5BwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 11 May 2025 06:48:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: introduce a skeleton version of "btrfs rescue fix-data-csums"
Date: Sun, 11 May 2025 16:18:18 +0930
Message-ID: <cover.1746945864.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7351021170
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.01

We have a long history of data csum mismatch, caused by direct IO and
buffered being modified during writeback.

Although the problem is worked around in v6.15 (and being backported),
for the affected fs there is no good way to fix them, other than complex
manually find out which files are affected and delete them.

This series introduce the initial implementation of "btrfs rescue
fix-data-csums", which is designed to fix such problem by either:

- Delete the affected files
- Update the csum items using the data from specified copy

But for the first step, just detect such csum mismatch (pretty much the
same as "btrfs check --check-data-csum"), and print out the affected
files.

No real repair is done yet, only dry run is supported (the default and
only mode yet).

Qu Wenruo (3):
  btrfs-progs: introduce "btrfs rescue fix-data-csums"
  btrfs-progs: fix a bug in btrfs_find_item()
  btrfs-progs: fix-data-csums: show affected files

 Documentation/btrfs-rescue.rst |  19 ++
 Makefile                       |   2 +-
 cmds/rescue-fix-data-csums.c   | 379 +++++++++++++++++++++++++++++++++
 cmds/rescue.c                  |  44 ++++
 cmds/rescue.h                  |   6 +
 kernel-shared/ctree.c          |  17 +-
 6 files changed, 463 insertions(+), 4 deletions(-)
 create mode 100644 cmds/rescue-fix-data-csums.c

--
2.49.0



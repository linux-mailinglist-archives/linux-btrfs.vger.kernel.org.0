Return-Path: <linux-btrfs+bounces-14291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27DCAC79C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 09:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF507B59C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173DD256C93;
	Thu, 29 May 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Rkx/Puvc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dmY+RYlT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D741C8638
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748503708; cv=none; b=Jlth6F1E79LUFlMbiDf6H3BR1ZLWuHnYe/uB0Wf3Ti4yR9eQkonPgYa9U3VEx2zWaYw82m2xcESP4Wp6cTYEFUq+V4GAl8rSMCCHs6vNMFEUnP+K66Z/QTSr/0V58WUFX4kRjqAR0/3j+ez58/iPariDZAln3dsfBhFgMUop14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748503708; c=relaxed/simple;
	bh=5CIpUyw3A+eT+TWkm3XNpLmZ4JaXoHf+PnH4wjBr4cg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sKTwJIl6zhwSyaCfwcEo1jLS0YyD+OJU4C2kAcLvsEHpfeR8OhanzacqKuxhtVrn9IJEi5qOhpkuk0At13MabKLaKCEWgnXPTuEYHRS6eUJJAlUs0VY+wObtDZ7+wctXnTP+J+YMDxvjuXw8YdciC8Fhq/pt6Rg/bMiJLr5jxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Rkx/Puvc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dmY+RYlT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1B511F454
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 07:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748503704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iXwHJno+/AKQnLN0axRg1YvmXKG136evGHtu8wj4Dd8=;
	b=Rkx/PuvczraYm1mrRX11UtMR9v6SUe2XLNcxaDlkAAC37OkbX0DLGOXdaY+PHr+OUIXXeF
	cjgCkdaZztrOFpowKW59hGTfI0JY85qktyoO7oouuaSbxYupIv3/dLgMhrFUhKM6r9NSzW
	VLbwyNXv4dwUD168nvoPzhgMCPsln0s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dmY+RYlT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748503703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iXwHJno+/AKQnLN0axRg1YvmXKG136evGHtu8wj4Dd8=;
	b=dmY+RYlTC6iIubhvNA4ftvAaAOQqm+ttnENMtc6zBuN9vdWBuWxZ3uoqQOX9Yv7iAv2Ypz
	ZtqJeKATPadkOt7WRNdqoSDSCdCwnRwyjVGcK7pJkD4lbqwUt4BnByLpiaO737frVXvyQK
	LiEV5w1biaBwrtV80WXPTFNzOofk1bM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D4C4136E0
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 07:28:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ODBfOJYMOGjiUwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 07:28:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fix an old bug in lowmem mode
Date: Thu, 29 May 2025 16:58:18 +0930
Message-ID: <cover.1748503407.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E1B511F454
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid]
X-Spam-Score: -5.01
X-Spam-Level: 

Inspired by Mark's recent enhanced super block dev item check against
chunk tree device item, it turns out there are several existing images
not passing the check.

One of the check is fsck/020/keyed_data_ref_with_reloc_leaf.img, which
may be caused by some older kernels (the bug is already fixed a long
time ago).

The first patch is to fix a lowmem mode check bug, that it doesn't
correctly account the keyed backref with shared backref.

This is exposed by the image from the next patch.

Then the last patch is to update the image with a proper note on how to
re-create it.
And the new image also acts as a regression test for the above lowmem
bug.

Please note this is not the last fsck image which has such problem,
fsck/057 is another one, and will be addressed in a dedicated patch.

Qu Wenruo (2):
  btrfs-progs: check/lowmem: fix a false alert when counting the refs
  btrfs-progs: fsck-tests: fix an image which has incorrect super dev
    item

 check/mode-lowmem.c                           | 145 +++++++++++++++++-
 .../keyed_data_ref_with_reloc_leaf.img        | Bin 16384 -> 19456 bytes
 2 files changed, 139 insertions(+), 6 deletions(-)

--
2.49.0



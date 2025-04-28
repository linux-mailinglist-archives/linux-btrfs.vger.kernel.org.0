Return-Path: <linux-btrfs+bounces-13452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F194CA9E5A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 03:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A23B32A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 01:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4659C3596F;
	Mon, 28 Apr 2025 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="seNll2jK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gp0PVLP3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0187494
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745802980; cv=none; b=RGmNbnra3SMjVruah/bs5BSKxzakyiMBzoJ06geK/9x4+qlVsidcCSAVk1NGYi8pi1S5/2l5BvHskKuue31Fz0hujzVY6sPXkkl2vrSmEIS9hUf1yyGBd0bg34ovV3JeA28GcjYiEp6jjyosQqIHo/4/VnVtDcS1b2ayivxSA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745802980; c=relaxed/simple;
	bh=vlrxcAaOHL57s+1I7PVehBAQie1UJOhZps11UExV9Xs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SuX3GbfnXt2inSq0WogARDIUvv0Dlq+S9zUP2yuOhUgvSxG0U6WKUhUWKlsHTbB5id8YrM/WLjJEc/XwYxeyvBot/jK9a0dr+GvhQoxIONJ4EaKIGSGuuuvAMs6CPXw/kPmAw7yZTFUaYX9Re2mylIF4t4mGlf6BdvJnlZ97RSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=seNll2jK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gp0PVLP3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C35E11F390
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745802975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WyzXt+m4Ch9mHsMDT92Bj9FMXmfVQ+aXVpNnMRAMwgU=;
	b=seNll2jKCqV39+9rHk1pHOv01dlZ/puDC27QnqRwtozqbp0dzZUFds07iVNLYvJSShk71v
	Fmze97ZC/dXNewNA+rc7F5MVc5WsT5RKlVGQK5HqT9MkaXwbEe8xSEqGJxGheLIcp7gBxN
	yUFCy8ppPz8BsFKnQrJKr14TCjbBHyc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Gp0PVLP3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745802974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WyzXt+m4Ch9mHsMDT92Bj9FMXmfVQ+aXVpNnMRAMwgU=;
	b=Gp0PVLP353OT3y6oAl0vCVeCymUZj1BAFDmqlK8EawnWzSVvkeVkjF2G9v6m6rX3nKLzSf
	CAkGpSe7SaY0AU4fYdP/nOwAHcRym+yxnlajq0T31tb8mRSkVEidaStEvQAOS3tVIjV7P8
	S4eah0/wRRUS3/GDPMIUgG8532T9u+4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FB2413A25
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qupIMd3WDmhADgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 01:16:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: merge the two different super block read functions into one
Date: Mon, 28 Apr 2025 10:45:50 +0930
Message-ID: <cover.1745802753.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C35E11F390
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

We have two functions to read a super block from a block device:

- btrfs_read_dev_one_super()
  Exported from disk-io.c

- btrfs_read_disk_super()
  Local to volumes.c

Which are doing mostly the same thing, so the first patch merge them
into btrfs_read_disk_super().

The second patch removes the btrfs_read_dev_super() function, as it
never really implement the full super blocks scan, and can be replaced
by a btrfs_read_disk_super() call reading the primary super block.

This not only reduce the duplication, but also removes the confusion
between all the similiarly named functions.

Qu Wenruo (2):
  btrfs: merge btrfs_read_dev_one_super() into btrfs_read_disk_super()
  btrfs: get rid of btrfs_read_dev_super()

 fs/btrfs/disk-io.c | 81 +-----------------------------------------
 fs/btrfs/disk-io.h |  3 --
 fs/btrfs/super.c   |  2 +-
 fs/btrfs/volumes.c | 88 +++++++++++++++++++++++-----------------------
 fs/btrfs/volumes.h |  2 ++
 5 files changed, 48 insertions(+), 128 deletions(-)

-- 
2.49.0



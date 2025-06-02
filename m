Return-Path: <linux-btrfs+bounces-14351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC21ACA7F8
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 03:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E1A16EE32
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85A199FB2;
	Mon,  2 Jun 2025 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bHmwVCyF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vNf6o5yC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438219993D
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824766; cv=none; b=um2bmBOmw0/UZTcu/jmmElT6prpBAZxPv6S1/bOzZGvjgHoc7zjcDtyWx2iXZsLUKuLU+HS87LA8uSC/fhvLyFmTyb2it/kgtYne8xucgfHDkXBA+Y0SxZ/vqQ/XmFyECIYJmqaLqKTJFgpB4mu9IYdkNL1f/bfWoZuYZeXn55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824766; c=relaxed/simple;
	bh=88jLwP/lSnBfs9VYNZSUqmAHPk9u7USSiyFLyiA1T3w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OB5ABK50JUJuHRgQe2a6IRhiS2jes/mlJNj192Aut3XUmdOcGGjbKJJzjBhga/pSxMvMYJUDtGngE7OQ+goWPZ0PvBRalAWO/OXHPUiZwUgxo/9ScU1XJ4ZILNTSgnobsA/KeX3NtPyQTOdGsVfJD1rAgG43GpXXcnWRbul+0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bHmwVCyF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vNf6o5yC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAFB31F385
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 00:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748824756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OuICFv63FZ1RakNy6U5CzCsU+37Cqa6ffx2DGX+KYjI=;
	b=bHmwVCyFwsBy/l7+c1JFaGwC3ZDHwqySKkozqUof6qsy6Y/iyqoWo1VVooVg7CYxf2U0AN
	dENwksYL9O/x9KG/uLb7b5rIc5z1kpuaxQa2h1l3YhB+CZMzR2pmkR6xoOKaiB8tN1WVHl
	AwqFiWU4jw4CcSXjB0i3x2WvF54kNDI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vNf6o5yC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748824755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OuICFv63FZ1RakNy6U5CzCsU+37Cqa6ffx2DGX+KYjI=;
	b=vNf6o5yC5p3W3AdvomkpLc9Msm3rVZq+QTP+p6/hurLoPC2ay8VLWzeArmYK9heLrzcZ10
	JpPF2t7YKCjyOCclgqw3h3sebZsFRIxhxrlhz/HJrRw1jd10bYfenQqj1Xb7IdEGud0NCH
	zLGznkfBDl54wTNsh4EjfNvSuOdMFxg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21BAD13A63
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 00:39:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DgX1NLLyPGgOdwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 00:39:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: rename btrfs_subpage to btrfs_folio_state
Date: Mon,  2 Jun 2025 10:08:51 +0930
Message-ID: <cover.1748824641.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EAFB31F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

This migration is mostly to align the naming to iomap, so btrfs_subpage
is renamed to btrfs_folio_state.

But before the rename, explain why btrfs needs the following extra
sub-bitmaps in the first patch.

Qu Wenruo (2):
  btrfs: add comments on the extra btrfs specific subpage bitmaps
  btrfs: rename btrfs_subpage structure

 fs/btrfs/extent_io.c |  29 +++---
 fs/btrfs/inode.c     |   8 +-
 fs/btrfs/subpage.c   | 239 +++++++++++++++++++++----------------------
 fs/btrfs/subpage.h   |  46 +++++++--
 4 files changed, 172 insertions(+), 150 deletions(-)

-- 
2.49.0



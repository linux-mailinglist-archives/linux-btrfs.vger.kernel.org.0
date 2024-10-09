Return-Path: <linux-btrfs+bounces-8677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B0E995F40
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 07:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F3328485F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 05:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C89166307;
	Wed,  9 Oct 2024 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lailfWzx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lailfWzx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481252AF1D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453098; cv=none; b=GfxmE7nkx1mOnZ6wgQh4Da5j44IUoc0aHEbXsa3lQSHJ+UmFjCveZMMeMHpR10xCktREqdTyDFWeeeWFcEk1ZMoMTv6lvmw8nAf7XuPp2iI/YS1esO4q+tc6EOqJ5Tb+RnQQHWXHOV55OerJIg9Ojy8Y2bGaAoaottlv4FY6wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453098; c=relaxed/simple;
	bh=eP2uP7DMdHAbWDBhSsdLZ9fP2cvRwKq526koOV443Qk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=feEDiCWPLhKshpdRM014As8AKUGkWMXARcYmyaeEppGGpCBjlz35wTu/OsMQiSsYhi6bST0YAaGZRDYmRprBNSU39lIO/QDO/EpSIxtHRvQ/p5pLcwwDhucdt019GjElG8vBr7LC1IjKWwq8VAPeOkKBDQt0F02sbCiFQlbgvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lailfWzx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lailfWzx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4858221AD2
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728453094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E3U7CnALkqHWnzoM8YyKgK8RQfplMWILDSl69xhLrgA=;
	b=lailfWzxlF52OekjFTiB/+01mC6gz6j1N67JIz5Eib0hYqP6ZTX4bodpd2pcZeM7hMXwUY
	jmV7bi/hxcNCV2iO1qmjDkU14UlQVZvi4TtByNRoxFFgbWzonTrKlPbPbLvRGCh96L+Jvl
	GRFIdhSEh+SVwxYWgvResPH7yKED0V4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lailfWzx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728453094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E3U7CnALkqHWnzoM8YyKgK8RQfplMWILDSl69xhLrgA=;
	b=lailfWzxlF52OekjFTiB/+01mC6gz6j1N67JIz5Eib0hYqP6ZTX4bodpd2pcZeM7hMXwUY
	jmV7bi/hxcNCV2iO1qmjDkU14UlQVZvi4TtByNRoxFFgbWzonTrKlPbPbLvRGCh96L+Jvl
	GRFIdhSEh+SVwxYWgvResPH7yKED0V4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 825B0132BD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zj0LEeUZBmcFHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 05:51:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: unify the read and writer locks for btrfs_subpage
Date: Wed,  9 Oct 2024 16:21:05 +1030
Message-ID: <cover.1728452897.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4858221AD2
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
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGELOG]
v2:
- Rename btrfs_subpage::locked to btrfs_subpage::nr_locked

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
 fs/btrfs/extent_io.c   |  20 +++-----
 fs/btrfs/subpage.c     | 108 ++++++++++-------------------------------
 fs/btrfs/subpage.h     |  33 +++++--------
 4 files changed, 45 insertions(+), 119 deletions(-)

-- 
2.46.2



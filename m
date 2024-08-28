Return-Path: <linux-btrfs+bounces-7613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52741962799
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 14:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7710A1C23A61
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5017BEAC;
	Wed, 28 Aug 2024 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FwAu/V9a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P+KF70M3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FwAu/V9a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P+KF70M3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64104156C4B
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849165; cv=none; b=Dip7uF60QNwJ5zlT95JiVUa1oRn9i4DeHigSF7StoeFqVRTQigVcJQ3o9V1nvLXQGUYk1zvlT5F8YMYAxb4e3JbDlXAilE8OtCwyAnSiYjSzxx5zoAoWTyW6UtFZOGRQyRLgRAc+DbEYyKcmhJNYU+i/KB4BaCJrfH4dn2tF7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849165; c=relaxed/simple;
	bh=yawzdFQFKiex0F7Wwp2grRDf3y5iqxxIq+3dMNQyWRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ogf4+cOcNejf3pN7wknwhyMHXmtTh8e1XapEGgczmjfLcOHvVnW4M7iHNj0UxwYqZX8H7HCSWuB9zHq92MaskZp11tN1aM6XXbyXieL6O85Ior2LgrOKGaWJMCHm9me1LlP187h+LWx1VOKaO+VaVAhsjaWM7sqzW0p2+y9VunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FwAu/V9a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P+KF70M3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FwAu/V9a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P+KF70M3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6892A1FBB5;
	Wed, 28 Aug 2024 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724849161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yZ84zTcN5tP89XZq18AeDb8h1U50iXLSqXBXEWDy2d4=;
	b=FwAu/V9ab2G0ohc7MxIlF3hQVl3z3ZLIjpen0I7diRW34ICJ802NMWkg9964CHvNb1C7XT
	opzll8TN/XkpW3c/dst/Cs7f3g+DUju2nvNpHSqHlwLZ4gxPz3tjQOtYNMMbZZ9rlofYe5
	s5wQto+zP1G7G21lt/E8nEjFMZzF9N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724849161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yZ84zTcN5tP89XZq18AeDb8h1U50iXLSqXBXEWDy2d4=;
	b=P+KF70M3uYRDNE+rJlFUZT+rNZPAmX5vxIS2OhpPDHzS648Sny8CP8cWg8ghTqohDFUlkO
	vOurQQIG1/XIVtBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="FwAu/V9a";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P+KF70M3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724849161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yZ84zTcN5tP89XZq18AeDb8h1U50iXLSqXBXEWDy2d4=;
	b=FwAu/V9ab2G0ohc7MxIlF3hQVl3z3ZLIjpen0I7diRW34ICJ802NMWkg9964CHvNb1C7XT
	opzll8TN/XkpW3c/dst/Cs7f3g+DUju2nvNpHSqHlwLZ4gxPz3tjQOtYNMMbZZ9rlofYe5
	s5wQto+zP1G7G21lt/E8nEjFMZzF9N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724849161;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yZ84zTcN5tP89XZq18AeDb8h1U50iXLSqXBXEWDy2d4=;
	b=P+KF70M3uYRDNE+rJlFUZT+rNZPAmX5vxIS2OhpPDHzS648Sny8CP8cWg8ghTqohDFUlkO
	vOurQQIG1/XIVtBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FEAC138D2;
	Wed, 28 Aug 2024 12:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wdTvBQkcz2b9GAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 28 Aug 2024 12:46:01 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 0/2] Limit scope of extent locks in btrfs_buffered_write()
Date: Wed, 28 Aug 2024 08:45:48 -0400
Message-ID: <cover.1724847323.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6892A1FBB5
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is in preparation for using iomap for btrfs. It will help in
keeping the extent lock limited to iomap_end() function.

The extent locks are taken for a majority of the write sequence. With
Josef patches limiting the extent locks to recording extent changes, we
can reduce the scope of locking of extent locks during write to only
when recording the extent as delalloc. Restrict the locking to
btrfs_dirty_pages(). However, the write needs to make sure that there
are no pending ordered extents. So, wait for any pending ordered extents
before performing the copying of data from userspace.

As for testing, it did go through a round of xfstests without any crash
or failure. However, since this touches a crucial part of write, please
make sure this is correct especially in terms of data corruption by
overwrites/staleness.

Goldwyn Rodrigues (2):
  btrfs: btrfs_has_ordered_extent() to check for ordered extent in range
  btrfs: reduce scope of extent locks during buffered write

 fs/btrfs/file.c         | 109 ++++++----------------------------------
 fs/btrfs/ordered-data.c |  11 ++++
 fs/btrfs/ordered-data.h |   1 +
 3 files changed, 28 insertions(+), 93 deletions(-)

-- 
2.46.0



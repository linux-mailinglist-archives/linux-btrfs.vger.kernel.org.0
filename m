Return-Path: <linux-btrfs+bounces-15529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410CB07F60
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 23:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E293B2FFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 21:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7E1A0BF1;
	Wed, 16 Jul 2025 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EF9KVJFi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EF9KVJFi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC514501A
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700523; cv=none; b=kwOIbVdG6RoMixYX2adAL1PpJ14XhQLwZx6je3pmFqa7Pf/59j9z3KLGBAvj+/6IvHsiYqeGVZ9uu+gXomNHR3h8c/l67iiennLJO9jqQT3yHp3YgmoexN3zrA5qy15swIoJdwrAMpWjCv5BNMtTkWCN8VETgTcQ5kCsSZP8QgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700523; c=relaxed/simple;
	bh=OLS3GxPW84iN1+ZbKL1hUmGOBk9Z8YAJUfUTS7+oE9s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KNEFrdkA3CChLMRbOkZJLD4r3vIvMwkXDfHBYXcvbxNn6KOv8zyq5yCvb8tMX+xr8eilgTpY+la0ugiXMAr60oxFgZ8JXyUUp40jZJ+P9v87Lw3hkI/vxkn3mq3W0lzQ/93zjYFORtfWGBRyizS1xsXt8Yr8Fb7QbG89SSCZyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EF9KVJFi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EF9KVJFi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4BC81F78E
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752700518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZYFYZjIeNdtoe7Pr7IZbZnM4+qXK4c1zd3ovrvYw5bc=;
	b=EF9KVJFi8c8b9AaZsb1xRlqLhEEsTMuGiEHzevAofx3TzzbmGq2vpbtL6jr+UGfxh6V7Wl
	H4yTQG+wEP9fmJQ8REj9VvIgb5CbRj3hGcDZQzvlRS9/Si8zO4+ADzsxj3SzhiF7ucXx7r
	bBOwJomb01fT1zf/+v1jTZ6ic4fOQB0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EF9KVJFi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752700518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZYFYZjIeNdtoe7Pr7IZbZnM4+qXK4c1zd3ovrvYw5bc=;
	b=EF9KVJFi8c8b9AaZsb1xRlqLhEEsTMuGiEHzevAofx3TzzbmGq2vpbtL6jr+UGfxh6V7Wl
	H4yTQG+wEP9fmJQ8REj9VvIgb5CbRj3hGcDZQzvlRS9/Si8zO4+ADzsxj3SzhiF7ucXx7r
	bBOwJomb01fT1zf/+v1jTZ6ic4fOQB0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8BAF13306
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +H/8GmUWeGipBwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: enable large folios for data reloc inodes
Date: Thu, 17 Jul 2025 06:44:56 +0930
Message-ID: <cover.1752700452.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B4BC81F78E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

Although large data folios are enabled for experimental builds, data
reloc inodes are excluded due to the cluster folio handling are still
done in fixed page size.

But data reloc inodes fit large folios better than regular inodes, as
each relocation cluster is one or more file extents that are contiguous
in their logical addresses.

This series will enable large folios for data reloc inodes by:

- Simplify the handling of cluster boundary folio invalidation
  This patch has been sent to the list already, but it's the dependency
  of the series.

- Enhance the output of btrfs_subpage_assert() 
  As it easily caught a lot of bugs in the relocation code that are
  still using PAGE_SIZE

- Enable large folios for data reloc inodes
  The last patch that remove the PAGE_SIZE usage and fixed PAGE_SIZE
  itearation of data reloc inodes.

Qu Wenruo (3):
  btrfs: reloc: unconditionally invalidate the page cache for each
    cluster
  btrfs: output more info when btrfs_subpage_assert() failed
  btrfs: enable large data folios for data reloc inode

 fs/btrfs/btrfs_inode.h |  4 ---
 fs/btrfs/relocation.c  | 82 +++++++++++-------------------------------
 fs/btrfs/subpage.c     |  5 +--
 3 files changed, 24 insertions(+), 67 deletions(-)

-- 
2.50.0



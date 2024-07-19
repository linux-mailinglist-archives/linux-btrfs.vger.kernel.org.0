Return-Path: <linux-btrfs+bounces-6566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FBB937310
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 06:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47331F21E3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 04:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1D374C4;
	Fri, 19 Jul 2024 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hsy7Ts71";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N6/ivtk+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7D3BBF0
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721364571; cv=none; b=sMsC85H/CY1yvC6YkXal9TS/OHwOKVvp/j0MLf66OCFGbKIQjBbz6VE/MJEhT8/8VQgcTrfrnklC0j+i/LDH6YnSFdN8hiDLpJ15ctKv98nmrb8cU5MfYRLNjIErAohBzP58g8J+yCLomNiZIMtIBbuv3boXovgAX4z38c23SjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721364571; c=relaxed/simple;
	bh=j9ytogxTz6OQyBImBHjUhbdB2qzbcoHqNWuqtVfBZSY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZVdtSxk5wdDp0uSTfaNhr5BBYIka/oOIc62zZdKlAWRmwlOxCJKZyq2b/aQ8dv+euFE2IefkhAhy307s38y0j5A8i/+LXBhAycDhhZqnHVhZgfSLK9WaPtIR+0Iv3qjLehPP9DQ7j3v3vLbUoe50Z0D5V5oqnWJzvWTgK6X1RbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hsy7Ts71; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N6/ivtk+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E72941FCFA
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721364566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gD0deRN/DmElfkm64lU7kWjO+WFbGZbfRnAfxviACIQ=;
	b=hsy7Ts7186RF0bOrm2275I0aj3wfT2VPgW/+WexF14vgzV/OPRypVarLvt2o8o3vKN06e7
	23nwqRKxUhgmj3F2YbfAY6CrdOO15m2cXcwRGX2VnA0vlum91CKBFlBGOtAq1iEOt9ARmZ
	Cvnc8uWb0vQAx0iKUIQ6zSVBDLerAr8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="N6/ivtk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721364565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gD0deRN/DmElfkm64lU7kWjO+WFbGZbfRnAfxviACIQ=;
	b=N6/ivtk+AwJK5u1tqrV+bEZpNtlR9v0yAXuHsJtMYBAXe5kz5ipIAbNV62E4qus0y3ULQX
	dCrNaUm6r5Rd4ayoRo58M55laHuBLJXaRFVRz62+2me9JVAfcgz8yb/7oB/+8xp52ZhSiM
	p6wz6waKit/dLNV1czjoB+eXaLLbMMs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 129F3136F7
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 83gYL1TwmWYPdQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:49:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v5 0/2] btrfs: try to allocate larger folios for metadata
Date: Fri, 19 Jul 2024 14:19:04 +0930
Message-ID: <cover.1721363035.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E72941FCFA
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

[CHANGELOG]
Changlog:
v5:
- Use root memcgroup to attach folios to btree inode filemap
- Only try higher order folio once without NOFAIL nor extra retry

v4:
- Hide the feature behind CONFIG_BTRFS_DEBUG
  So that end users won't be affected (aka, still per-page based
  allocation) meanwhile we can do more testing on this new behavior.

v3:
- Rebased to the latest for-next branch
- Use PAGE_ALLOC_COSTLY_ORDER to determine whether to use __GFP_NOFAIL
- Add a dependency MM patch "mm/page_alloc: unify the warning on NOFAIL
  and high order allocation"
  This allows us to use NOFAIL up to 32K nodesize, and makes sure for
  default 16K nodesize, all metadata would go 16K folios

v2:
- Rebased to handle the change in "btrfs: cache folio size and shift in extent_buffer"

This is the latest update on the attempt to utilize larger folios for
btrfs metadata.

The previous version exposed a reproducibe hang at btrfs/187, where we
hang at filemap_add_folio() around its memcgroup charge code.

Even without the problem, I still believe for btree inode we do not
really need all the memcgroup charge, nor using __GFP_NOFAIL to work
around the possible memcgroup limits.

So in this update, suggested by the memcgroup people from SUSE, there is
a new patch to make btree inode filemap folio attaching to use the root
memcgroup, so that we won't be limited by the memcgroup.

Then for the patch enabling the larger folio, I reverted back to the old
behavior that we only try larger folio once without extra retry, just to
be extra safe.

Qu Wenruo (2):
  btrfs: always uses root memcgroup for filemap_add_folio()
  btrfs: prefer to allocate larger folio for metadata

 fs/btrfs/extent_io.c | 112 ++++++++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 34 deletions(-)

-- 
2.45.2



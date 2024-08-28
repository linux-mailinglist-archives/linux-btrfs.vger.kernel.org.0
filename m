Return-Path: <linux-btrfs+bounces-7623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887A8962C9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EBD1C21A55
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7111A2C36;
	Wed, 28 Aug 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QwZ/s46Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="npjt1ug/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217218DF8A
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859685; cv=none; b=WodTK1bxjKUfh09uQgucqkBPD+r/WGrrz8FRq6WML5Mc0C4lf8Iaw4oWtE4PpTN2dRijmn2cc258+eyZ4wH75b1Q1fbqSVxmSJyjIOzpIy4MscSiebPAbwUKsX8/18wX1Yf06/jD/W0xfcKZPKcAE4OcfJ2saTvWnp5a9EjvUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859685; c=relaxed/simple;
	bh=adMJJWftOCnYutkcl93yli9eOaEURD7XD9J8Fh25om4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrpnxKs/wENF8W9T/KcpIHkS62TaXBvzT9XllYqY4yVPPDqy47BKNLcHxNl9aQndRBOt1vxaBuo9HDu+zCqItmr1MIGeq6ZhPqgc9D+E7dYU9okPIdFmNBFk4Ir3X2uJNLQIlc3NDVBd2w594EXgurtyjP+mDm70ILw1Q1yef1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QwZ/s46Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=npjt1ug/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF2B51FC85;
	Wed, 28 Aug 2024 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724859682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tNWi/4KLjFtjMVZdyqXcnyys0XyRwEJeOvMXHBxzPEs=;
	b=QwZ/s46Y4ZP0tJQesY4Gwt5/Ls7A/tkLPT/hb7BiaiU/NnWm2Jo3WYzf0WLv5VGjDKMgEW
	e6x8U3xODyAO3FZGIAlK3zo1R32aKdK1Hiz5Eg7aE6bnOS7r+dPqT4aVu3zfhDcTQIlU9Z
	hfG1U7gpCcr/HCRtUr5YlEBe8CKccfQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="npjt1ug/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724859681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tNWi/4KLjFtjMVZdyqXcnyys0XyRwEJeOvMXHBxzPEs=;
	b=npjt1ug/fNSanNffpgnisTFdcqSUeTtZwV+D2RmunIKsy6FS2FjLdmEFr42Mz0sHR36952
	ZLM3j5vIUpxt36+P6yB6iyuDZkzScxTPAUim3s9l8fo7tkDQhYyzsYzJj+du71yACZBhTP
	b7nO/PlEbvQKF6QpCVL1JnsyWp+f8z0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E870C138D2;
	Wed, 28 Aug 2024 15:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJO6OCFFz2b4VAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 28 Aug 2024 15:41:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Const parameter updates
Date: Wed, 28 Aug 2024 17:41:15 +0200
Message-ID: <cover.1724859619.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF2B51FC85
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Use _Generic for BTRFS_I macro and some const parameter updates.

David Sterba (2):
  btrfs: rework BTRFS_I as macro to preserve parameter const
  btrfs: constify more pointer parameters

 fs/btrfs/backref.c           |  6 +++---
 fs/btrfs/block-group.c       | 34 +++++++++++++++++-----------------
 fs/btrfs/block-group.h       | 11 +++++------
 fs/btrfs/block-rsv.c         |  2 +-
 fs/btrfs/block-rsv.h         |  2 +-
 fs/btrfs/btrfs_inode.h       | 10 ++++++----
 fs/btrfs/ctree.c             | 18 +++++++++---------
 fs/btrfs/ctree.h             |  6 +++---
 fs/btrfs/discard.c           |  4 ++--
 fs/btrfs/file-item.c         |  4 ++--
 fs/btrfs/file-item.h         |  2 +-
 fs/btrfs/inode-item.c        | 10 +++++-----
 fs/btrfs/inode-item.h        |  4 ++--
 fs/btrfs/space-info.c        | 25 ++++++++++++-------------
 fs/btrfs/space-info.h        | 10 +++++-----
 fs/btrfs/tree-mod-log.c      | 14 +++++++-------
 fs/btrfs/tree-mod-log.h      |  6 +++---
 fs/btrfs/zoned.c             |  2 +-
 fs/btrfs/zoned.h             |  2 +-
 include/trace/events/btrfs.h |  6 +++---
 20 files changed, 89 insertions(+), 89 deletions(-)

-- 
2.45.0



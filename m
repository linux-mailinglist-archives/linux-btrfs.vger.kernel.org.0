Return-Path: <linux-btrfs+bounces-14562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BD2AD24C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492003A9DD9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433021C9E3;
	Mon,  9 Jun 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VGN1qoAZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VGN1qoAZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9C21B8E7
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488980; cv=none; b=R8rg484u273ZxPEg0oPnSgvJZySNzFzJOKSV6R9kowhIsrs5JNJBV1tt8wxxB8mYkc8FRcqb37U69wh+JG21UKPM0FCNH66mkQo0+9g1nevICBeVTeeV3lkT8KymzbhZ3hUEYa6xHDjVvfuETjiXcQkvWR+bOxdz2ytvDVF8Xto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488980; c=relaxed/simple;
	bh=SEURqFX+BK1OldQPf1SKLdIjsk8io6TGeCtg4NaYXhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdjgZQKrXnP7l0/6rSMUNGI4J95tMJhPpMoB/q0Wq9asK9uu0U5aSPpnr3Nml3KsiEAg9nFhvXzlEP04V6BeN3vWBCygvYsfvxyHktUwugceFpZafRl5X6u5SVA4NPlu6pglnPjy8HVX8R+qR4gcRQBWKZRHKTH6txG7biBMuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VGN1qoAZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VGN1qoAZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EB681F766;
	Mon,  9 Jun 2025 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aPUiM/DhSh9AQ+lfVbviKrhZODqx/C29DcflmPNF+c0=;
	b=VGN1qoAZ+v0kWj4V1RvWMIvXi2KOxf/Y0pq9Dj7Kjk8vEdlqo/crcfpW3N+yZMfFmjo7+x
	rh8gH41dv3W90Cy+Z1OQLXYyDryJmsN63ZZe/0kH2Zy493uT+/QHAFHoQC34QTXNpkybYh
	rwNuuN6e1buYWTIxJ/KPIIqZAGFMRTY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VGN1qoAZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aPUiM/DhSh9AQ+lfVbviKrhZODqx/C29DcflmPNF+c0=;
	b=VGN1qoAZ+v0kWj4V1RvWMIvXi2KOxf/Y0pq9Dj7Kjk8vEdlqo/crcfpW3N+yZMfFmjo7+x
	rh8gH41dv3W90Cy+Z1OQLXYyDryJmsN63ZZe/0kH2Zy493uT+/QHAFHoQC34QTXNpkybYh
	rwNuuN6e1buYWTIxJ/KPIIqZAGFMRTY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4634A137FE;
	Mon,  9 Jun 2025 17:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uwwiEU4VR2hoHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:09:34 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 00/11] Clean up of RCU in message helpers
Date: Mon,  9 Jun 2025 19:09:20 +0200
Message-ID: <cover.1749488829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4EB681F766
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

Add the RCU protection to the plain message helpers, remove the
specialized versions, plus some related cleanups.

David Sterba (11):
  btrfs: open code rcu_string_free() and remove it
  btrfs: remove unused rcu-string printk helpers
  btrfs: remove unused levels of message helpers
  btrfs: switch all message helpers to be RCU safe
  btrfs: switch RCU helper versions to btrfs_err()
  btrfs: switch RCU helper versions to btrfs_warn()
  btrfs: switch RCU helper versions to btrfs_info()
  btrfs: switch RCU helper versions to btrfs_debug()
  btrfs: remove remaining unused message helpers
  btrfs: simplify debug print helpers without enabled printk
  btrf: merge btrfs_printk_ratelimited() and it's only caller

 fs/btrfs/bio.c         |   4 +-
 fs/btrfs/dev-replace.c |  14 +++---
 fs/btrfs/disk-io.c     |   2 +-
 fs/btrfs/extent-tree.c |   2 +-
 fs/btrfs/ioctl.c       |   2 +-
 fs/btrfs/messages.h    | 107 +++++++----------------------------------
 fs/btrfs/rcu-string.h  |  18 -------
 fs/btrfs/scrub.c       |  18 +++----
 fs/btrfs/volumes.c     |  21 ++++----
 fs/btrfs/zoned.c       |  26 +++++-----
 10 files changed, 63 insertions(+), 151 deletions(-)

-- 
2.49.0



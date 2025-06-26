Return-Path: <linux-btrfs+bounces-15000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342FEAEA08E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2928E5A347E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6842EA752;
	Thu, 26 Jun 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VIvt7W8A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VIvt7W8A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216B2F1FF0
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948220; cv=none; b=SWSnXCz/XRL9znznXJ3M4GByiAnL3gfpf5vTo80L2HJmwVaV4lYESCSTJ+x1+Fz7O/lj4Ke3gYkG4aMdJGSV/OvK8hEet3TQvWqmGTXE9Hw/1K/OKSEYyRguMJtrKxBBFGhK9kp7IqN8VJbJAk+gsyEHcoIOmTDBAAwYisp6dQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948220; c=relaxed/simple;
	bh=ISeV2ua+pCLprgUVdxwYj1mwkYTBmUaqFMCbgbWOVXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7KzwZWJsvu3cg68nRncyZMxSQ4mCWfXZs0NOw2ScVnY4wYmrsbw/FVhqjLbYsgSZpYGHH2ZqhtBWh/g0QRw3W2DCw+4oYUtlUQd1QLdyjNCRDQuTjPuglz/2Ffrb3NBfjMTL8kKBf9pQktcwQhXhwiycW6VMMG8pPc2gWBAVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VIvt7W8A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VIvt7W8A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B96E2116E;
	Thu, 26 Jun 2025 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LZnBaD9YYRnZTIu4IM1wm9HiDNYjRq47VDbcgpyYriU=;
	b=VIvt7W8AQrjhVjL8NS42slwBnrk3m4uACl3m5D5vZZQIwDab5XAtuBFpfm65yKkwTgG0UZ
	dU9IBVyTIX1itVahgF1nrgOoQQZsm58ENqasnjFt2Zo5AikhVwofD0iirF+QIaJNFZphF8
	+qlLq1hCiy6v4QSfpI9Qwl3VJT/INYk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VIvt7W8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LZnBaD9YYRnZTIu4IM1wm9HiDNYjRq47VDbcgpyYriU=;
	b=VIvt7W8AQrjhVjL8NS42slwBnrk3m4uACl3m5D5vZZQIwDab5XAtuBFpfm65yKkwTgG0UZ
	dU9IBVyTIX1itVahgF1nrgOoQQZsm58ENqasnjFt2Zo5AikhVwofD0iirF+QIaJNFZphF8
	+qlLq1hCiy6v4QSfpI9Qwl3VJT/INYk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F91F138A7;
	Thu, 26 Jun 2025 14:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u8RIC3dZXWgNLgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 26 Jun 2025 14:30:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Parameter cleanups for subvolume/snapshots ioctls
Date: Thu, 26 Jun 2025 16:30:08 +0200
Message-ID: <cover.1750948128.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3B96E2116E
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

Use qstr for name + length parameters, some other parameter type or name
adjustments.

David Sterba (4):
  btrfs: use struct qstr for subvolume ioctl helpers
  btrfs: pass dentry to btrfs_mksubvol() and btrfs_mksnapshot()
  btrfs: pass bool to indicate subvolume/snapshot creation type
  btrfs: rename inode number parameter passed to
    btrfs_check_dir_item_collision()

 fs/btrfs/dir-item.c |  4 ++--
 fs/btrfs/dir-item.h |  2 +-
 fs/btrfs/ioctl.c    | 37 +++++++++++++++++--------------------
 3 files changed, 20 insertions(+), 23 deletions(-)

-- 
2.49.0



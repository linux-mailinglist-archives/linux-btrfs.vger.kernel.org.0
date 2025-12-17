Return-Path: <linux-btrfs+bounces-19821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A254CC682B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 09:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD3BF30647B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9B336EF9;
	Wed, 17 Dec 2025 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mhYdh0sC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mhYdh0sC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F43274B28
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958903; cv=none; b=S+crUnCOVSqA3GeXO0U38R89pu8nIPIg5wrelS/8P3By8uNhvxehTN4JGpx21dXEUNY63bT78+MO4ZrlDDVi59FIeaCf3YqBnSJX/GKv/gn5gXMJxSgs6xXcemgFzD9H1j+1Q0yNwQOVlwHanp2H1B3e4WwehInkJ1osaE9uoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958903; c=relaxed/simple;
	bh=m/TB+kgSpX1VoDphU12oydyqfbymovTtbrAHS0DHLeA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MHlXpuOoI7LafDvyuu+YG7a30TQmHny6Vp/kVXRrOSkPmNkSxZrCJgCqNc1MTXwuLl/aYnPl0LBzcdULqNUSV+z7utRS0AGtkE/Kp0cz83tnEilZFBjTRc2UCpSrvEWdwLWAKfBj0lBzc3vxXatT/5TFiJ9JNrCoax4m2LRuboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mhYdh0sC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mhYdh0sC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89175336C4
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765958899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hZLjuIN/03VMtwmmXlQeGcbO5dfCHr1PyJPcJ1weLWA=;
	b=mhYdh0sCPZpC0EmoCoRud/dZ8MX5kuSSpxXvldPTDVmEEfz+ge/YvuiHvUcJtxxb2Kx4B2
	0Xm1lrIm6NBMyidBM2uanLzA8yVQrF5zHafTkkhD3VPmGGw78gif3OSo7MV4LUtukpGeRt
	xYW9UgbICQmi/jekRLoC7vg7w0ykN2M=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mhYdh0sC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765958899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hZLjuIN/03VMtwmmXlQeGcbO5dfCHr1PyJPcJ1weLWA=;
	b=mhYdh0sCPZpC0EmoCoRud/dZ8MX5kuSSpxXvldPTDVmEEfz+ge/YvuiHvUcJtxxb2Kx4B2
	0Xm1lrIm6NBMyidBM2uanLzA8yVQrF5zHafTkkhD3VPmGGw78gif3OSo7MV4LUtukpGeRt
	xYW9UgbICQmi/jekRLoC7vg7w0ykN2M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE4BC3EA63
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VHiFJPJkQmmoGQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: check: properly fix missing INODE_REF cases
Date: Wed, 17 Dec 2025 18:38:12 +1030
Message-ID: <cover.1765958753.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 89175336C4
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

This is inspired by a recent corruption report that an INODE_REF key hits a
bitflip and becomes UNKNOWN.8 key.

That cause missing INODE_REF, and unfortunately neither original nor
lowmem mode can properly handle it.

For the original mode it just completely lacks the handling for such
case, thus fallback to delete the good DIR_INDEX, making things
worse.

For the lowmem mode, although it is trying to keep the good
DIR_INDEX/DIR_ITEM, it doesn't handle index number search, thus using
the default (-1) as index, causing incorrect new link to be added.

Fix both modes, and add a new test case for it.

Qu Wenruo (3):
  btrfs-progs: check/original: add dedicated missing INODE_REF repair
  btrfs-progs: check/lowmem: fix INODE_REF repair
  btrfs-progs: fsck-tests: add a test case for repairing missing
    INODE_REF

 check/main.c                                  |  51 ++++++++++++++++++
 check/mode-lowmem.c                           |  11 ++++
 .../070-missing-inode-ref/.lowmem_repairable  |   0
 .../070-missing-inode-ref/default.img.xz      | Bin 0 -> 2092 bytes
 4 files changed, 62 insertions(+)
 create mode 100644 tests/fsck-tests/070-missing-inode-ref/.lowmem_repairable
 create mode 100644 tests/fsck-tests/070-missing-inode-ref/default.img.xz

--
2.52.0



Return-Path: <linux-btrfs+bounces-11941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0473A49C60
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569067A4A0E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1322702B7;
	Fri, 28 Feb 2025 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tCkitP/i";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tCkitP/i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDE92686A0
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754171; cv=none; b=kwjLBndEY1OwDcgrUMy36vm0RbElUOA6C+0I3iEJEYvh7o2CqQU9MTwWZUEVTiHJzxUo6hR+v2rRBnzPAJSl2TShTP+jsUaHnyanypqIJQ+QpUbDkVA/p2cqYQNXWIhcfceGHXRvQ7EkSoPCWGEFI0I4Pr0Hbs3EDPkv2HaG4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754171; c=relaxed/simple;
	bh=qdLXlJKOWzR5PidJyjwPXOnXNffT3lnR8M3Jjwag9Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldQxW5fnz3bzALxqC7jkjjGNmMsCsHAbn2spScYtDXXR72CXY3rBX7BR8WPKXf63iGhNXcaoD5KekIojaF3+GlYeB3wIuov1MDmTAL0pazbZqPlA9kxx7Y0LJp0GenAxeXi/fxCCi7zyU0eWiXyZNwLdW9CEF1Mpl4mJv8K5AH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tCkitP/i; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tCkitP/i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6944721185;
	Fri, 28 Feb 2025 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b72AtrbNymSKNmKmb1CCoTFiEnjRceEbXDpglAojTAg=;
	b=tCkitP/iR1l5Y5UJgFglrDi4jGxsWF9ywbPFcnTK8X4c8D6v5MPrTv3WqeENOz2Uf8nEls
	LINy9Jfmc5nt3786Bb1m/OSbX1rmb0EVQQQV73r0Az+R646yG7kampbzJZy7lXquj05Lh2
	HxC7lzvmjnTUhbh6glqJkW5OaB1Hf0A=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="tCkitP/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740754167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b72AtrbNymSKNmKmb1CCoTFiEnjRceEbXDpglAojTAg=;
	b=tCkitP/iR1l5Y5UJgFglrDi4jGxsWF9ywbPFcnTK8X4c8D6v5MPrTv3WqeENOz2Uf8nEls
	LINy9Jfmc5nt3786Bb1m/OSbX1rmb0EVQQQV73r0Az+R646yG7kampbzJZy7lXquj05Lh2
	HxC7lzvmjnTUhbh6glqJkW5OaB1Hf0A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A57137AC;
	Fri, 28 Feb 2025 14:49:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t+BoFPfMwWdDPQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 28 Feb 2025 14:49:27 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Ioctl to clear unused space in various ways
Date: Fri, 28 Feb 2025 15:49:20 +0100
Message-ID: <cover.1740753608.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6944721185
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
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Add ioctl that is similar to FITRIM and in addition to trim can do also
zeroing (either plain overwrite, or unmap the blocks if the device
supports it) and secure erase.

This can be used to zero the unused space in e.g. VM images (when run
from inside the guest, if fstrim is not supported) or free space on
thin-provisioned devices.

The secure erase is provided by blkdiscard command but I'm not aware of
equivalent that can be run on a filesystem, so this is for parity.

David Sterba (5):
  btrfs: extend trim callchains to pass the operation type
  btrfs: add new ioctl CLEAR_FREE
  btrfs: add zeroout mode to CLEAR_FREE ioctl
  btrfs: add secure erase mode to CLEAR_FREE ioctl
  btrfs: add more zeroout modes to CLEAR_FREE ioctl

 fs/btrfs/discard.c          |   4 +-
 fs/btrfs/extent-tree.c      | 159 +++++++++++++++++++++++++++++++-----
 fs/btrfs/extent-tree.h      |   5 +-
 fs/btrfs/free-space-cache.c |  29 ++++---
 fs/btrfs/free-space-cache.h |   8 +-
 fs/btrfs/inode.c            |   2 +-
 fs/btrfs/ioctl.c            |  42 ++++++++++
 fs/btrfs/volumes.c          |   3 +-
 include/uapi/linux/btrfs.h  |  46 +++++++++++
 9 files changed, 258 insertions(+), 40 deletions(-)

-- 
2.47.1



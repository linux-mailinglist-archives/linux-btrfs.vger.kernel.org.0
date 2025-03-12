Return-Path: <linux-btrfs+bounces-12225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F134A5DB1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 12:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A43F3A67AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A423ED60;
	Wed, 12 Mar 2025 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="czFelHI4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="czFelHI4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4A4207F
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777940; cv=none; b=uN0LGQLZ+AaXSA4Gv2sBSBNCRBu2kaCYmdVjMKXcGEui4V+1c0fNVVta8dOVtPoCVavCLVVDVInM9gGE8PClIGIQ4u6u8QGD3Y+oAGiTrx45mR/GZy2p79LwMkaIgHfVa41NOTdQ/Nufw0g+e8yE8r8I0aC3orGuRHDIePg8UFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777940; c=relaxed/simple;
	bh=SjvIXEVQZcsoIiUwxq8UF3uDXoXqAupiAS2VPvePr4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fp/IS+Sdon4ksJg9J3i0Esn9jAVso9u/gUFBezvVTxD8P4uw98Z/ZLpnJJN5XN22ca2VO7M0hvETIAV7FhtUAYfxqKOl8dCZmQ76VySc8MTX9gDiMuVzfJMXmoBrlBebJN5IuBTf3Smj+po5g15c28/FBlzSLNX6DXMV2mnG2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=czFelHI4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=czFelHI4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5CC1F385;
	Wed, 12 Mar 2025 11:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gj/2d4VuNSER/S/wvmYytKcq8UXnBi0JGVDvjQXhr5Y=;
	b=czFelHI4w3v6TI/pd5EkZ4HWKlCTo8qcNJmXs/t5XwZ2ezXaRmZhKzDY0SDqxzvkq0FrFS
	8Z4XyHq7VhzCqrUBGj9GQVnE5Ett0OV5RaUe2o/fkV7iWDKBN1WTdWTcJpR8XeLK7E2WGm
	AGqniGbouIj04ppTDpU9/4kbZGhRpn8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=czFelHI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Gj/2d4VuNSER/S/wvmYytKcq8UXnBi0JGVDvjQXhr5Y=;
	b=czFelHI4w3v6TI/pd5EkZ4HWKlCTo8qcNJmXs/t5XwZ2ezXaRmZhKzDY0SDqxzvkq0FrFS
	8Z4XyHq7VhzCqrUBGj9GQVnE5Ett0OV5RaUe2o/fkV7iWDKBN1WTdWTcJpR8XeLK7E2WGm
	AGqniGbouIj04ppTDpU9/4kbZGhRpn8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E001132CB;
	Wed, 12 Mar 2025 11:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id irFoEhBs0WcWNgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Mar 2025 11:12:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 0/6] Ioctl to clear unused space in various ways
Date: Wed, 12 Mar 2025 12:12:10 +0100
Message-ID: <cover.1741777050.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A5CC1F385
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Add ioctl that is similar to FITRIM and in addition to trim can do also
zeroing (either plain overwrite, or unmap the blocks if the device
supports it) and secure erase.

This can be used to zero the unused space in e.g. VM images (when run
from inside the guest, if fstrim is not supported) or free space on
thin-provisioned devices.

The secure erase is provided by blkdiscard command but I'm not aware of
equivalent that can be run on a filesystem, so this is for parity.

v2:
- return -EOPNOTSUPP for zoned mode, with a note
- add new operation to reset the chunk map status wrt trim

David Sterba (6):
  btrfs: extend trim callchains to pass the operation type
  btrfs: add new ioctl CLEAR_FREE
  btrfs: add zeroout mode to CLEAR_FREE ioctl
  btrfs: add secure erase mode to CLEAR_FREE ioctl
  btrfs: add more zeroout modes to CLEAR_FREE ioctl
  btrfs: add mode to clear chunk map status to CLEAR_FREE ioctl

 fs/btrfs/discard.c          |   4 +-
 fs/btrfs/extent-tree.c      | 159 +++++++++++++++++++++++++++++++-----
 fs/btrfs/extent-tree.h      |   5 +-
 fs/btrfs/free-space-cache.c |  29 ++++---
 fs/btrfs/free-space-cache.h |   8 +-
 fs/btrfs/inode.c            |   2 +-
 fs/btrfs/ioctl.c            |  62 ++++++++++++++
 fs/btrfs/volumes.c          |   8 +-
 fs/btrfs/volumes.h          |   1 +
 include/uapi/linux/btrfs.h  |  53 ++++++++++++
 10 files changed, 291 insertions(+), 40 deletions(-)

-- 
2.47.1



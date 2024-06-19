Return-Path: <linux-btrfs+bounces-5823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4490F4CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 19:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5291C21CBA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A9E155738;
	Wed, 19 Jun 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e3lINhQg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e3lINhQg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC81C3E
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2024 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816937; cv=none; b=IMLXGlQ3Rg5BqZfs4cyfH4pT+rUrNSa3z37Gxe9UkMwmU6KEwaxd8mu33HxDJa10MtkG5n2CGt9l7gQVOCPURqG5jQc26d3z+aPbrz7ksGj0Uu0GLyoGcnqx+n7NxWX2UosvkZx4MsO6l76674LJq1i7csLdBM9KQsXQrRmI+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816937; c=relaxed/simple;
	bh=Eq14Wwj/3zKACFMeIO0ftf1ViTj82cxdRGPK5xXl28g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIWBoW/rZ9cLbST3ns7iyZM0slWj0pJ8m1Epalh75+/D3ceIFqVA8W0AdZYGgVE/4MgGFOQNFgtJHYFiHeUGr+jaNXh5D6FD3Io6miT7kbMHN6XlV1GuzfPLj7DWfnxKG7P8ygioRLQBg5w3ainLfeEnWe2J8w7lhPWUOV1WVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e3lINhQg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e3lINhQg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4E661F7CC;
	Wed, 19 Jun 2024 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718816932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FMF7arEQGuEn1pDCqa0PdFMaI4c3xA9F/Z4MWJ/SRms=;
	b=e3lINhQg8A8vrrNM7PTW6QfbVSmAQ+PzWDeWpYEZXdvBLNXjZxCeXTERZz8GQJroXYt+eM
	kF0VU8u+u0i5PeD1s0g46qBxz3cFp1YLsdY3M12+XsQGpAJsCgyofIVrPUlL37FTsiwx85
	PiVD2eAK59yewVqBMIPSkYrHfU2fc/8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718816932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FMF7arEQGuEn1pDCqa0PdFMaI4c3xA9F/Z4MWJ/SRms=;
	b=e3lINhQg8A8vrrNM7PTW6QfbVSmAQ+PzWDeWpYEZXdvBLNXjZxCeXTERZz8GQJroXYt+eM
	kF0VU8u+u0i5PeD1s0g46qBxz3cFp1YLsdY3M12+XsQGpAJsCgyofIVrPUlL37FTsiwx85
	PiVD2eAK59yewVqBMIPSkYrHfU2fc/8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F72B13668;
	Wed, 19 Jun 2024 17:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HRGjJqQQc2ZmQwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 19 Jun 2024 17:08:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/5] Error handling fixes
Date: Wed, 19 Jun 2024 19:08:50 +0200
Message-ID: <cover.1718816796.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

A few replacements of btrfs_handle_fs_error() with transaction abort or
other means.

David Sterba (5):
  btrfs: abort transaction if we don't find extref in
    btrfs_del_inode_extref()
  btrfs: only print error message when checking item size in
    print_extent_item()
  btrfs: abort transaction on errors in btrfs_free_chunk()
  btrfs: qgroup: preallocate memory before adding a relation
  btrfs: qgroup: warn about inconsistent qgroups when relation update
    fails

 fs/btrfs/inode-item.c |  4 ++--
 fs/btrfs/ioctl.c      | 25 +++++++++++++++++++------
 fs/btrfs/print-tree.c |  2 +-
 fs/btrfs/qgroup.c     | 25 ++++++++-----------------
 fs/btrfs/qgroup.h     | 11 ++++++++++-
 fs/btrfs/volumes.c    | 15 +++++++++------
 6 files changed, 49 insertions(+), 33 deletions(-)

-- 
2.45.0



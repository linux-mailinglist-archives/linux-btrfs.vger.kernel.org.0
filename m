Return-Path: <linux-btrfs+bounces-11825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AACA4543A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 05:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E31188E9D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 04:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5A825D54D;
	Wed, 26 Feb 2025 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I6Ph8Ua7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I6Ph8Ua7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C832676CE
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542386; cv=none; b=ddgJgf43xrHHzLscDsoHALyr2ezIvmpwv8uDjNUVfLxa1pAbEwFgoLe+9akQSWM1miCjSBfsyNHPe01hj9jhYEI71Gn38plSznUVGIoyfceso29Y4yHffpzdGSnelxwxcWBDxapc4tqBYVkfKD5+bBQR+0B6W+Th1eNu4JxiNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542386; c=relaxed/simple;
	bh=kF7EuRK50jN84h6w3ARuBAbIUwAvGTldb2UvM6zSfLU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GLe9/yMLrK9iBbXOCkp/ntf4dBshkk/EcPTFicar0qHbyCmK841a5kmsSKbURx2aceFTnqCBV4lxDuWDorIY4dr5G9QbKb/2bRG/H3ZJ/wAqUUwu+2yF6MdTNXX24p3hUlaw7K3KrNbYZfbDbEZsTHRmx2PcugCf80k55tdjLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I6Ph8Ua7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=I6Ph8Ua7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DD4421189
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o2gMwLCKKrLEQqD65AFhVCUiLco+UyR7/mrkqeHgdWU=;
	b=I6Ph8Ua7/XMy9DDdfVpjISJnbAZeLfgBLyRv5frpdGVkV8oOWudWC3/neFEaTcWuZioaz8
	WQO9R0134p+DCxtorrJ78KpEkK8kjnKPZh/6DL7x/nEnq47FRvtK4wZrnit2GxGVVoeyET
	66l8mZ3GuOhnTaz0IHPxhH5K2/yuIy0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o2gMwLCKKrLEQqD65AFhVCUiLco+UyR7/mrkqeHgdWU=;
	b=I6Ph8Ua7/XMy9DDdfVpjISJnbAZeLfgBLyRv5frpdGVkV8oOWudWC3/neFEaTcWuZioaz8
	WQO9R0134p+DCxtorrJ78KpEkK8kjnKPZh/6DL7x/nEnq47FRvtK4wZrnit2GxGVVoeyET
	66l8mZ3GuOhnTaz0IHPxhH5K2/yuIy0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 875E113404
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7WPLEauRvmdOegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: allowing 2K block size for experimental builds
Date: Wed, 26 Feb 2025 14:29:13 +1030
Message-ID: <cover.1740542229.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Btrfs always has its minimal block size as 4K, but that means on the
most common architecture, x86_64, we can not utilize the subpage block
size routine at all.

Although the future larger folios support will allow us to utilize
subpage routines, the support is still not yet there.

On the other hand, lowering the block size for experimental/debug builds is
much easier, there is only one major bug (fixed by the first patch) in
btrfs-progs at least.

Kernel sides enablement is not huge either, but it has dependency on
the subpage related backlog patches to pass most fstests, which is not small.

However since we're not pushing this 2K block size for end users, we can
accept some limitations on the 2K block size support:

- No 2K node size mkfs support
  This is mostly caused by how we create the initial temporaray fs.
  The initial temporaray fs contains at least 6 root items.
  But one root item is 439 bytes, we need a level 1 root tree for the
  initial temporaray fs.

  But we do not support multi-level trees for the initial fs, thus no
  such support for now.

- No mixed block groups mkfs support
  Caused by the missing 2K node size support

Qu Wenruo (3):
  btrfs-progs: fix the incorrect buffer size for super block
  btrfs-progs: support 2k block size
  btrfs-progs: convert: check the sectorsize against BTRFS_MIN_BLOCKSIZE

 common/device-scan.c    |  2 +-
 common/fsfeatures.c     | 11 ++++++++---
 convert/main.c          |  2 +-
 kernel-shared/ctree.h   |  6 ++++++
 kernel-shared/disk-io.c | 11 ++++-------
 mkfs/main.c             |  7 -------
 6 files changed, 20 insertions(+), 19 deletions(-)

--
2.48.1



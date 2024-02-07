Return-Path: <linux-btrfs+bounces-2202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C08784C612
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 09:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3B01C22AB7
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CBA200D6;
	Wed,  7 Feb 2024 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L9FUTErd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L9FUTErd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CB6200B8;
	Wed,  7 Feb 2024 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293776; cv=none; b=BZdoGkNZzFTrWotyKvdCW7umqYO2wHteZ44JH2IbQxxEj/6yzSiVWtJ+PToNDeJ8ca6cXD9ahN/IBIQ5JrbSgSb9SlEETwspYB1+6VfDkdYtF3dak+OhUdoCpBxQYiuzCgquA26/OinMqV9oYmU5uNM5TWz7j3DUjVz4oc9Elgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293776; c=relaxed/simple;
	bh=mBOPDuJtheLZFjVCT9NAa8bxHETU85T5CfwCM5DIDkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDt2vfunfOhUaiubry9mCioTgnDc+3N4MWBW8FH+OHq4esztnKXDwpy4PeKt6e1FUwDjmrfzFdrnbIR/k7G4PLOmUKw95ofcuHL3CghLKmv9r4uqyJhfFdbYGpj7bULqwle2yUcX8b71VcRGvXtOnlXk4OOSZXFHHvQsNmzH3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L9FUTErd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L9FUTErd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5FA0221C9;
	Wed,  7 Feb 2024 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707293772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vjdgUStxN6xe4JkvGLiFcWVEOzjvm7ZwqCC/qMHmtzI=;
	b=L9FUTErdrKdE0NJePWFVT/aa+T27mBzpHfAzEhD+NyyyUyI7bXWqLfNhdScMizdFCQxaA/
	vnxNhLh3jYQzRc2mlMdW5dxdqT+5b1l1zYt7yTFbPWD4UQWnd4wGil5Y/elVZlH5pv0pea
	4YQRi8AMifJ1LXVFpzz5Dq0OJiqQb2o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707293772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vjdgUStxN6xe4JkvGLiFcWVEOzjvm7ZwqCC/qMHmtzI=;
	b=L9FUTErdrKdE0NJePWFVT/aa+T27mBzpHfAzEhD+NyyyUyI7bXWqLfNhdScMizdFCQxaA/
	vnxNhLh3jYQzRc2mlMdW5dxdqT+5b1l1zYt7yTFbPWD4UQWnd4wGil5Y/elVZlH5pv0pea
	4YQRi8AMifJ1LXVFpzz5Dq0OJiqQb2o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DECD713931;
	Wed,  7 Feb 2024 08:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wwpgNkw8w2WqPAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 07 Feb 2024 08:16:12 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.8-rc4
Date: Wed,  7 Feb 2024 09:15:35 +0100
Message-ID: <cover.1707292515.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Hi,

please pull a few error handling fixes. Thanks.

- two fixes preventing deletion and manual creation of subvolume qgroup

- unify error code returned for unknown send flags

- fix assertion during subvolume creation when anonymous device could
  be allocated by other thread (e.g. due to backref walk)

----------------------------------------------------------------
The following changes since commit 7f2d219e78e95a137a9c76fddac7ff8228260439:

  btrfs: scrub: limit RST scrub to chunk boundary (2024-01-18 23:43:08 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc3-tag

for you to fetch changes up to e03ee2fe873eb68c1f9ba5112fee70303ebf9dfb:

  btrfs: do not ASSERT() if the newly created subvolume already got read (2024-01-31 08:42:53 +0100)

----------------------------------------------------------------
Boris Burkov (2):
      btrfs: forbid creating subvol qgroups
      btrfs: forbid deleting live subvol qgroup

David Sterba (1):
      btrfs: send: return EOPNOTSUPP on unknown flags

Qu Wenruo (1):
      btrfs: do not ASSERT() if the newly created subvolume already got read

 fs/btrfs/disk-io.c | 13 +++++++++++--
 fs/btrfs/ioctl.c   |  5 +++++
 fs/btrfs/qgroup.c  | 14 ++++++++++++++
 fs/btrfs/send.c    |  2 +-
 4 files changed, 31 insertions(+), 3 deletions(-)


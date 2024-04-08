Return-Path: <linux-btrfs+bounces-4025-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD31989CBC7
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 20:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05B91C21C1F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 18:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C46A8A4;
	Mon,  8 Apr 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Aa5mZBgf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Aa5mZBgf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C6847B;
	Mon,  8 Apr 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601453; cv=none; b=PwiJccTfvbvlaaAqfZ8MFRXuryHjfQ3qOBANeLx6E3TwZCwjtjWZnq1Vt2jSboOfWiuvoKjg/fmp3tRyT4yi5XFe+GFgYqpnLCiFxvyJtbuTY7443odRnxCdu3Ec1Xb2on8JwHc3kRzRhc7nDUEFbTVVKyutKZdEd4kQoUUQNGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601453; c=relaxed/simple;
	bh=X3gMZuPTkA24xg4GBDYXxkbjxx+qArTWWjLrmKHVY8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hF3ZA/XJ/oYdKslLUk4Fv4EehcxfEFfu9qDTHXG+F7kwgJmYbdwy6Qo5kuzhaRyjHrE9uyIVO0zq7UG7JnBzCPNyACl+ngvUVGNEzEXstrUjmDTIja6hg2smdee1qjL9j9Sg1Mhfqslv0PJxNgOW1Ok046SxWo5V3So0fc2+Qgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Aa5mZBgf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Aa5mZBgf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F86722BE8;
	Mon,  8 Apr 2024 18:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712601449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y6bzAk/xb8dxffg3BI2yQFTeUeIj6VKMQ2AM0NvO6u0=;
	b=Aa5mZBgftkH01EZNu0eMK+V1F6yUvv8KuG+r6nATgcmCTKmLXqz5KJ5DVhhrOPcE80sIBE
	bnnK8A1hOuAmwCbRcNT+eFdP9J6uZpE/nmMP29cKE54JU8nWBhxxkRQPihDlpXUn4kLvfe
	RtX6r51xBARhQidlr7GotVG2f1HJjR0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712601449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=y6bzAk/xb8dxffg3BI2yQFTeUeIj6VKMQ2AM0NvO6u0=;
	b=Aa5mZBgftkH01EZNu0eMK+V1F6yUvv8KuG+r6nATgcmCTKmLXqz5KJ5DVhhrOPcE80sIBE
	bnnK8A1hOuAmwCbRcNT+eFdP9J6uZpE/nmMP29cKE54JU8nWBhxxkRQPihDlpXUn4kLvfe
	RtX6r51xBARhQidlr7GotVG2f1HJjR0=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2664F1332F;
	Mon,  8 Apr 2024 18:37:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4kccCWk5FGa5JQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 08 Apr 2024 18:37:29 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.9-rc3
Date: Mon,  8 Apr 2024 20:30:02 +0200
Message-ID: <cover.1712333355.git.dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.27 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.47)[79.29%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.27
X-Spam-Flag: NO

Hi,

please pull several fixes to qgroups that have been recently identified
by test generic/475, thanks.

- fix prealloc reserve leak in subvolume operations

- various other fixes in reservation setup, conversion or cleanup

----------------------------------------------------------------
The following changes since commit ef1e68236b9153c27cb7cf29ead0c532870d4215:

  btrfs: fix race in read_extent_buffer_pages() (2024-03-26 16:42:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-rc2-tag

for you to fetch changes up to 6e68de0bb0ed59e0554a0c15ede7308c47351e2d:

  btrfs: always clear PERTRANS metadata during commit (2024-04-02 19:19:13 +0200)

----------------------------------------------------------------
Boris Burkov (6):
      btrfs: qgroup: correctly model root qgroup rsv in convert
      btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations
      btrfs: record delayed inode root in transaction
      btrfs: qgroup: convert PREALLOC to PERTRANS after record_root_in_trans
      btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
      btrfs: always clear PERTRANS metadata during commit

 fs/btrfs/delayed-inode.c |  3 +++
 fs/btrfs/inode.c         | 15 +++++++++++++--
 fs/btrfs/ioctl.c         | 37 ++++++++++++++++++++++++++++---------
 fs/btrfs/qgroup.c        |  2 ++
 fs/btrfs/root-tree.c     | 10 ----------
 fs/btrfs/root-tree.h     |  2 --
 fs/btrfs/transaction.c   | 19 +++++++++----------
 7 files changed, 55 insertions(+), 33 deletions(-)


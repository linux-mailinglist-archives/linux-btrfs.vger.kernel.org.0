Return-Path: <linux-btrfs+bounces-14230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B5AAC385E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 06:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E1316EC85
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 04:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1218C02E;
	Mon, 26 May 2025 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="usTIzxTO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="usTIzxTO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1357263A
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748232181; cv=none; b=RSX4sjq0fl4Z9H2xlo4wnyH8d4fUlxAldF/uqQBJ9nH/zkL2yFXlVkboiNTbG+T9I7i+384eDZMMUz1ZRcFvZccVgrzZNguFVs1UUUPoXJBBPjz1QIJx3wjPv1EEtU/GNfM9ZOfQTe1UAm/cpNhSPiYFKSpBe/JsG7l6QaYfPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748232181; c=relaxed/simple;
	bh=bEBfWR/oPKxerfs3nY38vwCFb8A3UuhE8RW/JNvOiS8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nBYNEkadMWOBXAGAASzd/jC2tbj44l2KhX9EEnD7RLQxevH/erBw2V1P5zPC01JBxwxFHMdZJM6GtJxJ5JJ+Q9ZoMRhEVKZt+y+JuOCUe8hHJymgJsZgITbHBfFBB1biR9+0D35ZTYZW/eQnBq43FzljxbU0aMYRrYT8LN9c9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=usTIzxTO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=usTIzxTO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8C531FD73
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748232175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o3NmjQvF2XsE/yXfgmmI/PRvgxmCmQ1DhMcK5u/36VU=;
	b=usTIzxTOTWB4+Lxp+QTBGw9eHizF3m1GgnDCv7eTREyUCK5gADp4kp/JKGaIYeRn7Lml65
	AaHe+exqfQ5DO3cTbugsY27mNIxrQMFs3qpRlpCqs27csxApTfjdaHUoKPpf3iNvPkyHwz
	oLv87UlAVadZLPTnLehl4GZt5s9inOc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748232175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o3NmjQvF2XsE/yXfgmmI/PRvgxmCmQ1DhMcK5u/36VU=;
	b=usTIzxTOTWB4+Lxp+QTBGw9eHizF3m1GgnDCv7eTREyUCK5gADp4kp/JKGaIYeRn7Lml65
	AaHe+exqfQ5DO3cTbugsY27mNIxrQMFs3qpRlpCqs27csxApTfjdaHUoKPpf3iNvPkyHwz
	oLv87UlAVadZLPTnLehl4GZt5s9inOc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD99D13770
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OykGJ+7nM2g3ewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: minor cleanups related to extent buffer
Date: Mon, 26 May 2025 13:32:34 +0930
Message-ID: <cover.1748232037.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

The first patch is a cleanup to remove the unused @fs_info parameter
from btrfs_csum_data().

The second patch uses btrfs_csum_data() directly to calculate super
block checksum and avoid use extent buffer helpers.

The final patch enhance btrfs_print_leaf() to be called with temporary
extent buffers in mkfs/convert, which have no eb->leaf populated.

Qu Wenruo (3):
  btrfs-progs: remove the unused fs_info parameter for btrfs_csum_data()
  btrfs: mkfs: do not use extent buffer to writeback super block
  btrfs-progs: enhance btrfs_print_leaf() to handle NULL fs_info

 check/main.c                    |  2 +-
 cmds/rescue-chunk-recover.c     |  2 +-
 cmds/rescue-fix-data-checksum.c |  4 ++--
 convert/common.c                |  2 +-
 convert/main.c                  |  2 +-
 kernel-shared/ctree.c           |  4 +---
 kernel-shared/disk-io.c         | 12 +++++-------
 kernel-shared/disk-io.h         |  3 +--
 kernel-shared/file-item.c       |  3 +--
 kernel-shared/print-tree.c      | 34 +++++++++++++++++----------------
 mkfs/common.c                   |  9 +++------
 tune/change-csum.c              |  7 +++----
 12 files changed, 38 insertions(+), 46 deletions(-)

--
2.49.0



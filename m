Return-Path: <linux-btrfs+bounces-2639-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300FF85F7D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 13:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4F528869B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9F860BB6;
	Thu, 22 Feb 2024 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DvhxP7oI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DvhxP7oI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E960BA1
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604092; cv=none; b=dqarqPAj6doWrePNxZv4AD4UtsQsYjD4RtysKQP1tbX6ronRLBJztPYTGM2PMuB74fcEE0fm9I/4JVMrsk8kP2AWHn0UlRJIRm+v/I5ba8JjSYaONmPyk48Sby2PNHQ3sna0x2biMWOC2ZkhwXiuGBuMTLFiL5BWhbZYkc/fG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604092; c=relaxed/simple;
	bh=S9dXtwmfBmUOXWOV37ZNcp0c1Ulieocvjdj+nhqpcYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oS1lcEBY5Qnn0LnEErGVgQsGv7GyKhFQw/TxnQx7gFTQmF9vR85IYWsg4yqxUAcf7JyYmWrBP4xbOonUtb+fvwB+z2JTWqVfFLZKh+vcc9FCcs/smKNa12CqxzB7B1TwHVEB/1MCpwwmBY9vuIkyFzqoub9Y/UMAPPFxKUMnaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DvhxP7oI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DvhxP7oI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 308581F457;
	Thu, 22 Feb 2024 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708604089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gYkAG4NWgSIRg/AA5cce4I6HvimZbIe4G6EO4mCf3TE=;
	b=DvhxP7oITbHFR22f3NELTdauZe31fIrr0euA95edsPoQ1nMzwFcadwBd7RSgfkLhjLAv5q
	8kK+21wjqxXhwDEdFCWnaBIItQ2U9habSWte1ZckJ6o9O4LRlxnqRmK+GhJm9UIVK72l4l
	MxrsxhC0dY8+QjsmampzsHYrNPl/+6A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708604089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gYkAG4NWgSIRg/AA5cce4I6HvimZbIe4G6EO4mCf3TE=;
	b=DvhxP7oITbHFR22f3NELTdauZe31fIrr0euA95edsPoQ1nMzwFcadwBd7RSgfkLhjLAv5q
	8kK+21wjqxXhwDEdFCWnaBIItQ2U9habSWte1ZckJ6o9O4LRlxnqRmK+GhJm9UIVK72l4l
	MxrsxhC0dY8+QjsmampzsHYrNPl/+6A=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A70213A6B;
	Thu, 22 Feb 2024 12:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id bjRVCrk612VzRQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 22 Feb 2024 12:14:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Simple cleanups
Date: Thu, 22 Feb 2024 13:14:07 +0100
Message-ID: <cover.1708603965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.55%]
X-Spam-Level: ****
X-Spam-Score: 4.88
X-Spam-Flag: NO

David Sterba (4):
  btrfs: handle transaction commit errors in flush_reservations()
  btrfs: pass btrfs_device to btrfs_scratch_superblocks()
  btrfs: merge btrfs_del_delalloc_inode() helpers
  btrfs: pass a valid extent map cache pointer to __get_extent_map()

 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/dev-replace.c |  3 +--
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent_io.c   | 11 ++++++++---
 fs/btrfs/inode.c       | 14 +++++---------
 fs/btrfs/qgroup.c      |  2 +-
 fs/btrfs/volumes.c     | 13 +++++--------
 fs/btrfs/volumes.h     |  4 +---
 8 files changed, 23 insertions(+), 28 deletions(-)

-- 
2.42.1



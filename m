Return-Path: <linux-btrfs+bounces-8166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E797EB0A
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F4B1C212F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE771974FA;
	Mon, 23 Sep 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tTsJV+hR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qsPQ1ggJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7C1E487;
	Mon, 23 Sep 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092349; cv=none; b=YscI+3MjbvdEOBlUPgabnb+shjwO1mqKrQJKM8RO1EHMIcE/sy5fJVfdUFPy7vntgaqakHyzFQRdxSFNnnprGFx5J2jQcQGZ9MZApNuJwK0JoyzIBr7qL5EHUCrcGMrK5+uUCIZnpGUqLz9kku7/bOV/Dy7LppPHTCZXwYQvcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092349; c=relaxed/simple;
	bh=JOdICVRsp1bq1r70VQ8lIBskbtQCPJ2ofXQCF4GKrUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZH96+An7GFvszDBI2ZjlfLy5QKs3qi0XpJACNdeXbroib+DgRT/Tm+WzF7mgSVZ5Nkd29qVXRMiw7FDlGCYOg/5Vk9ooYMZ84tkzieyOF9ejV8wm0/a/oeZ3YVdTxwB6XM4VBGk13urxHxR1zsvUXYuj3GUJN2mCDxUFfNKbaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tTsJV+hR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qsPQ1ggJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E539621E19;
	Mon, 23 Sep 2024 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727092345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YATKUI4nrthUQM6d2BJ7FjobzAxlVZVIUKgiieO3eHg=;
	b=tTsJV+hRmESZdJKH+K0GL7p6lg6NclwxhB0KIByqInZmDyjyOFZGhRi/bI68vbiRY9LeKd
	if1aXO2TPO6WjtdIVOD9U2508AC5LwFQrNILLN7oYDdo+wiNFAHZoFEqAP4weTdXzEWYiq
	WT7REBuHVl4ZOxPXNxMEg6R+dwB62tk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qsPQ1ggJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727092344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YATKUI4nrthUQM6d2BJ7FjobzAxlVZVIUKgiieO3eHg=;
	b=qsPQ1ggJtupl9b5q/Ps0DKDwAA+MbzXCd3ARW/EG2NyhvQKLEx/zYQjUAb8RGfqKWG/zDL
	xzSwkEmbg0pJsxXjPjWbYQeQPTarnV2BqWnNrkhDX/02p7T45k6Smm1Qlv7S8pxUUAlYwZ
	vth77ZkFK5DcMnayWljZL7peO/+9ZI8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE1CE1347F;
	Mon, 23 Sep 2024 11:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wfw1NnhW8WbqMAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 23 Sep 2024 11:52:24 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updates for 6.12, part 2
Date: Mon, 23 Sep 2024 13:52:06 +0200
Message-ID: <cover.1727091859.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E539621E19
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

a few more patches that I'd still like to get merged before rc1 as they
are fixes for user reported bugs.

Please pull, thanks.

- fix dangling pointer to rb-tree of defragmented inodes after cleanup

- a followup fix to handle concurrent lseek on the same fd that could
  leak memory under some conditions

- fix wrong root id reported in tree checker when verifying dref

----------------------------------------------------------------
The following changes since commit bd610c0937aaf03b2835638ada1fab8b0524c61a:

  btrfs: only unlock the to-be-submitted ranges inside a folio (2024-09-10 16:51:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-tag

for you to fetch changes up to 7f1b63f981b8284c6d8238cb49b5cb156d9a833e:

  btrfs: fix use-after-free on rbtree that tracks inodes for auto defrag (2024-09-17 17:35:53 +0200)

----------------------------------------------------------------
Filipe Manana (2):
      btrfs: fix race setting file private on concurrent lseek using same fd
      btrfs: fix use-after-free on rbtree that tracks inodes for auto defrag

Qu Wenruo (1):
      btrfs: tree-checker: fix the wrong output of data backref objectid

 fs/btrfs/btrfs_inode.h  |  1 +
 fs/btrfs/ctree.h        |  2 ++
 fs/btrfs/defrag.c       |  2 ++
 fs/btrfs/file.c         | 34 +++++++++++++++++++++++++++++++---
 fs/btrfs/tree-checker.c |  2 +-
 5 files changed, 37 insertions(+), 4 deletions(-)


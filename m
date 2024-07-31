Return-Path: <linux-btrfs+bounces-6906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC7942B05
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 11:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260421C2483D
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36681AC430;
	Wed, 31 Jul 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YtpEgIM7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YtpEgIM7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0261A8C12
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418752; cv=none; b=tQ5lxFJyV+RMVFeMDuRT+RPvGpNPEnNgAGiQaUl4YMFZ5TMRYCe+dC/uCUNx5UbHypePnO+/jvuwRIy2t/taDpDTYYgS4UAYlUSTPQ4ZvNWEdqOb/OdTOZpiR+GdZB7cxxjGDPmI9xZd8xV8w91suMGg3RiZ7SnPyuVX12jYZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418752; c=relaxed/simple;
	bh=TJSG8uibtX52po1q6UkqeVB+E2pLfEIZfeH7OcC0aO4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uPIFDW5J4mCvYNCmT8V0lS9kvQMLVnGegnO2KaQknziXY2fj4pXWEHfbMTPbCnXpC2iOfCjmt6/Yf/CvHKFylxq/ZMhqLCsDwHQszkflpL09ybWmz7P19stIbumiv6KNNUvpRxaD2P0p732gNU8oYuefND7VMSmXP2NjbC048JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YtpEgIM7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YtpEgIM7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48BB71F839
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722418747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c7+oiz7PGxIFaIN83OkVscidHRZ2Mn82U6/Mll7Zoow=;
	b=YtpEgIM7atuxdvlzVJkiL5VAaWnlvFsMvpGLC0k3pOinAsyemxAYWYhiZlZYNqQX5Qfzmj
	ryHoGEqoxZT+gN6DJd6sSIYO3ZiogkozM6nNHCx+ItBicEzOxfPG0pSUAB6d6sLX7Eq05J
	yqIOm8qWwEzgLTKVlvfZiPCWBf0xpEk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YtpEgIM7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722418747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=c7+oiz7PGxIFaIN83OkVscidHRZ2Mn82U6/Mll7Zoow=;
	b=YtpEgIM7atuxdvlzVJkiL5VAaWnlvFsMvpGLC0k3pOinAsyemxAYWYhiZlZYNqQX5Qfzmj
	ryHoGEqoxZT+gN6DJd6sSIYO3ZiogkozM6nNHCx+ItBicEzOxfPG0pSUAB6d6sLX7Eq05J
	yqIOm8qWwEzgLTKVlvfZiPCWBf0xpEk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A3741368F
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zYU6CToGqmZgHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 09:39:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: rework how we traverse rootdir
Date: Wed, 31 Jul 2024 19:08:45 +0930
Message-ID: <cover.1722418505.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: 48BB71F839

Thanks to Mark's recent work, I finally get some time to rework rootdir
traversal.

All the problems are described inside the second patch.
While the last patch is a small enhancement to --rootdir to reject hard
links.

With this change, it's much easier to support subvolume creations at
mkfs time:

- Create a hashmap (or other similar structure) to record all the
  directories that should be subvolume

- Call btrfs_make_subvoume() other than btrfs_insert_inode() if a path
  should be a subvolume

- Call btrfs_link_subvolume() other than btrfs_add_link() for a
  subvolume

Everything like parent directory inode size is properly handled by
btrfs_link_subvolume() and btrfs_add_link() already.

Qu Wenruo (3):
  btrfs-progs: constify the name parameter of btrfs_add_link()
  btrfs-progs: mkfs: rework how we traverse rootdir
  btrfs-progs: rootdir: reject hard links

 kernel-shared/ctree.h |   2 +-
 kernel-shared/inode.c |   2 +-
 mkfs/rootdir.c        | 676 +++++++++++++++++-------------------------
 mkfs/rootdir.h        |   8 -
 4 files changed, 271 insertions(+), 417 deletions(-)

--
2.45.2



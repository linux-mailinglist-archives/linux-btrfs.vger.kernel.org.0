Return-Path: <linux-btrfs+bounces-6125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E7923917
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C6D284137
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 09:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245DC14B06C;
	Tue,  2 Jul 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Eawtc7v7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Eawtc7v7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796D12E1DC
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911075; cv=none; b=aJqGJHI+MuKO+89R4eU3bKbWrwU1i+VXWx6DtwT34tgwCvA0cm37WoHMxZuq8uKcO5Bfng90WT+tvUGYqdK8NLwvb6/8QoighdmNclqErtyiXWVAYSwm2q0P6gmJ9ur7UlNfKc6N5e2BM2Xtn8attklNlS/0fGLr4Gbbw/CmOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911075; c=relaxed/simple;
	bh=T2qI/Tpf4ex/xE3APjZkkHfmDzlLTJ+GDnemy/6Nn0A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JR89AkIWfw69CiNenyit48Yq4wpuMl4Jt1Uan1/yd9ZcFLA8OEUB0QiC/AxXJ22ROy6FFbs1myY+eQWNcwFD51WSmPSwWpp7ksnRgJK261AZw8NhOjwfdjXUEEoYOQgHLSJ8p9NzqAOD+wFrojZNlwmTyMOGTXfK4Rx5dyCkVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Eawtc7v7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Eawtc7v7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B2AF21B14
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719911071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zMVXBxS9V+AwbywbiESorTOylNOaZi3en6zLEYMieAM=;
	b=Eawtc7v7Uq0SaaWk3Y2rjFigiqmQS9CI+TtwTc95/ppvno1ZJTyzHZaoRX5NnHmRJf4UJh
	6YlDKYyILz+clAmVDaOVwbUqwCOFEQCZ8E8obT7CN8Kj/MIn6lZHY0AQwZY63a6U3FiRY2
	qpSDUAhFVwg1UXqi1ozeC2sbQpRKqEI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719911071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zMVXBxS9V+AwbywbiESorTOylNOaZi3en6zLEYMieAM=;
	b=Eawtc7v7Uq0SaaWk3Y2rjFigiqmQS9CI+TtwTc95/ppvno1ZJTyzHZaoRX5NnHmRJf4UJh
	6YlDKYyILz+clAmVDaOVwbUqwCOFEQCZ8E8obT7CN8Kj/MIn6lZHY0AQwZY63a6U3FiRY2
	qpSDUAhFVwg1UXqi1ozeC2sbQpRKqEI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9766C1395F
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 09:04:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GPfCE57Cg2Z0JQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2024 09:04:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: small cleanups related to subvolume creation
Date: Tue,  2 Jul 2024 18:34:10 +0930
Message-ID: <cover.1719910680.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.56
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.56 / 50.00];
	BAYES_HAM(-2.76)[98.95%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Thanks to Mark's new effort to introduce subvolume creation ability, the
long existing duplicated subvolume creation problem is exposed again.

The first patch to do a small cleanup for btrfs_create_tree() so that
the parameter list matches the kernel one.

The second one is the main dish to fully merge the different functions
to create a subvolume.

We have btrfs_create_tree() to properly create an empty tree, and
btrfs_make_root_dir() to create the initial root dir.

So use them to create btrfs_make_subvolume():

- Calls btrfs_create_tree() to properly create an empty tree
  Unlike btrfs_copy_root() used in create_subvol(), which can be unsafe
  if the source subvolume is not empty.

- Calls btrfs_read_fs_root() to setup the cache and tracking
  Inside create_data_reloc_tree() we directly added the root to
  fs_root_tree, which is only safe for data reloc tree.

  As we didn't properly set the correct tracking flags.

- Calls btrfs_make_root_dir() to setup the root directory
- Calls btrfs_update_root() to reflect the rootdir change

Qu Wenruo (2):
  btrfs-progs: remove fs_info parameter from btrfs_create_tree()
  btrfs-progs: introduce btrfs_make_subvolume()

 Makefile                        |   1 +
 check/main.c                    |   1 +
 common/root-tree-utils.c        | 108 ++++++++++++++++++++++++++++++++
 common/root-tree-utils.h        |  26 ++++++++
 convert/main.c                  |  43 +------------
 kernel-shared/disk-io.c         |   4 +-
 kernel-shared/disk-io.h         |   1 -
 kernel-shared/free-space-tree.c |   2 +-
 mkfs/common.c                   |  39 ------------
 mkfs/common.h                   |   2 -
 mkfs/main.c                     |  78 ++---------------------
 11 files changed, 147 insertions(+), 158 deletions(-)
 create mode 100644 common/root-tree-utils.c
 create mode 100644 common/root-tree-utils.h

--
2.45.2



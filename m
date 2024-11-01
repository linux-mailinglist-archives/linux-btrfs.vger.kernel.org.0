Return-Path: <linux-btrfs+bounces-9299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9D09B9477
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DC21F21D3A
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882511C727F;
	Fri,  1 Nov 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DS+0S+Zu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SmicUxSX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA411411DE;
	Fri,  1 Nov 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475210; cv=none; b=X9ltbFrwQlt7SnidNnioqSTallo9JSR1VQEy1oj9Y6YSmwTyBdXYzgei2AmDD3I+D1Eg0aVjF9yLyqt/Bn8JcTeuYx9RpDZ0RMn/vhXk4gyHfzhPWohc+Tziws9p/dOSEpnXczZYwjc6fwXbKFupP56HuSGkWjFti/EFKvIbUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475210; c=relaxed/simple;
	bh=uCSR1nco/2JW9atNWLOSnQFj9xJZMV9LnFSXSd3tJPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YUWh43vRtOXHMjlo/PQlZxchf+d8VQi6OYeEpiLUWT0TAfRUszc7ao8ZKOvEX9sCz6+e4l+YMHZThUsXe7dfdLUfg4RtNkbeWdaLTMTBnckBYC3Hg+1+BahCGxHyqr7v2qdVxOcH++4w5NQg9ck77jiGzntY09n3pv4OaZOU/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DS+0S+Zu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SmicUxSX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88A4821A8E;
	Fri,  1 Nov 2024 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730475204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TWKnz5HG1q20ZBFi/CXAHOKDTVAn2SNuGFLjUE68GkY=;
	b=DS+0S+ZuIv1OZD3XuONjQzRJKC08XD79A4/kBU8P66ChDlfgGngKgG94xjhDNYeSjlCBoJ
	IgJ4N5qFDQ6jZbB39WmwoOdmfBD7GzdUoVrFU4CvcIuCEoo8ikvjOnYu3bqSfc7kijNBJM
	GjIJj8lacJFEmVemCc3qnHXmOvL90ac=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SmicUxSX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730475203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TWKnz5HG1q20ZBFi/CXAHOKDTVAn2SNuGFLjUE68GkY=;
	b=SmicUxSX4/6iHsuOh9Yg5NHW0T2QzRReBqMJ4UqGCc3hMPdLWZ5B/NR5HIaXVfgOmOZlIT
	qz1U93PKwPjh2qYnAQ9KRDvP/3VgNJd/dIoXjZ7IWlKHVwMqvqxcSQ/l7AukZfw1xAY75d
	QAhPlaQFm+RDEEpM8nZeS9e1PG2iuAA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81E09136D9;
	Fri,  1 Nov 2024 15:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id svqvH8P0JGeQGQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 01 Nov 2024 15:33:23 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fixes for 6.12-rc6
Date: Fri,  1 Nov 2024 16:33:19 +0100
Message-ID: <cover.1730474495.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88A4821A8E
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

please pull a few more stability fixes. There's one patch adding export
of MIPS cmpxchg helper, used in the error propagation fix.

- fix error propagation from split bios to the original btrfs bio

- fix merging of adjacent extents (normal operation, defragmentation)

- fix potential use after free after freeing btrfs device structures

----------------------------------------------------------------
The following changes since commit 75f49c3dc7b7423d3734f2e4dabe3dac8d064338:

  btrfs: fix passing 0 to ERR_PTR in btrfs_search_dir_index_item() (2024-10-22 16:10:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.12-rc5-tag

for you to fetch changes up to 77b0d113eec49a7390ff1a08ca1923e89f5f86c6:

  btrfs: fix defrag not merging contiguous extents due to merged extent maps (2024-10-31 16:46:41 +0100)

----------------------------------------------------------------
David Sterba (1):
      MIPS: export __cmpxchg_small()

Filipe Manana (2):
      btrfs: fix extent map merging not happening for adjacent extents
      btrfs: fix defrag not merging contiguous extents due to merged extent maps

Naohiro Aota (1):
      btrfs: fix error propagation of split bios

Zhihao Cheng (1):
      btrfs: fix use-after-free of block device file in __btrfs_free_extra_devids()

 arch/mips/kernel/cmpxchg.c |  1 +
 fs/btrfs/bio.c             | 37 +++++++++++++------------------------
 fs/btrfs/bio.h             |  3 +++
 fs/btrfs/defrag.c          | 10 +++++-----
 fs/btrfs/extent_map.c      |  7 ++++++-
 fs/btrfs/volumes.c         |  1 +
 6 files changed, 29 insertions(+), 30 deletions(-)


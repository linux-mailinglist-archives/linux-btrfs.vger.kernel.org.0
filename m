Return-Path: <linux-btrfs+bounces-16781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A6B51F7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 19:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502BB7BF507
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1893314BC;
	Wed, 10 Sep 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gGr7/Lnv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gGr7/Lnv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED91E520A
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526614; cv=none; b=iN6BN1cou282CvaM6EMIUtHU/+TvbOSOREY8UzBFIJUkyiHYJ+IJFjfFyPBjoEW9nfnJcQnVeYMO/U65KCB2nPaYhMpQVSpJq8/yz7gRbTD+tdthk9X3ulcpPRmM8rG6xBP9dETm/9yJiDfULAgyp+2xO31mvY+iJ6+0kwVYaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526614; c=relaxed/simple;
	bh=5etazdkWvvXGa/0aGmp7MRXMP7dpitZz483vgYvgY7s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hgwxdNPQ/g//WGmUuEk7iI9/eLaRVTnPy9JyNwHU1ZH4NSstnRas2Rjpx0d1nUJNwQ00donOy79SaT7sPNyATJGx90IhAEGFoyWIxQiW8N94e7zWkJV03jT4KD37C9g2jniyg+0/4V8/YydmeLorD62L9qe7lgsdgZe1hrKeHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gGr7/Lnv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gGr7/Lnv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EAC538A3F
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757526609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C2Q1/IsfNsoBi6pPJxNa/QSUyC6UmCY3IjkubLkeo9M=;
	b=gGr7/Lnv+AEcUctAgmaCl1LKgmNoqcLRtVNHV+bT6tUleqfAHD0rzqpzglPwofL6osWFkX
	v9A/ePoZP7kG/rzfwEgsZFTptPY7+VTVAjrzhMyqwawIsrhfuHcy7CwnKFp+Nyxnc9h9XY
	XiWGhpq7FiHm5X4dIVAI4u00JP8kMQQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="gGr7/Lnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757526609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C2Q1/IsfNsoBi6pPJxNa/QSUyC6UmCY3IjkubLkeo9M=;
	b=gGr7/Lnv+AEcUctAgmaCl1LKgmNoqcLRtVNHV+bT6tUleqfAHD0rzqpzglPwofL6osWFkX
	v9A/ePoZP7kG/rzfwEgsZFTptPY7+VTVAjrzhMyqwawIsrhfuHcy7CwnKFp+Nyxnc9h9XY
	XiWGhpq7FiHm5X4dIVAI4u00JP8kMQQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9645513310
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 17:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nkhgJFG6wWjYYAAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 17:50:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.16.1
Date: Wed, 10 Sep 2025 19:50:06 +0200
Message-ID: <20250910175007.23176-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9EAC538A3F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Hi,

btrfs-progs version 6.16.1 have been released. This is a minor feature update
(mkfs.btrfs) and bugfix release.

Changelog:

* mkfs:
   * add option --reflink, when used with --rootdir clone file extents instead
     of copying (requires source and target image on the same filesystem)
   * improved tracking of inodes and subvolumes for option --inode-flags
   * fix initializing raid-stripe-tree
   * extend what is trimmed/discarded during initialization (temporary chunks,
     free space)
* check: detect duplicate file names in directory items
* inspect tree-stats: accept string names for option -t
* receive: allow to dump stream from different user
* other:
   * updated documentation
   * new and updated tests

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.16.1


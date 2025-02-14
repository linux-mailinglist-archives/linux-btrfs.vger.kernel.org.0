Return-Path: <linux-btrfs+bounces-11475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D61A36936
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 00:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A93117104C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2025 23:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596C1FCFDA;
	Fri, 14 Feb 2025 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="svS671+x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p0VLWwFW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A51922DE
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577117; cv=none; b=Nv9tu4sG01fH8SyM+TUzvr/Iv4marvUGkyMpPXmDFOkSlsNePgn3s17ZERalIiN4vimiYuPV1BG6tbJ5BLJYkZZ0RcewL0wvXw5BWmlN8+qPcuFBoAlPRqw8dPRqcZdmwVNv0HQoVypHmrwbb7DseEPFcbR/hunA8G/gzQPsHas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577117; c=relaxed/simple;
	bh=SeP4DL1g2qaX9WeJRpbllVOHRRx0uKi+JIZaE6RtkYQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RffjRkkiA9j2iPGjc1S2MHd+CJnoND/ru09FCJp+lPXUEUUaeQJ9AyN0XMNhvFIPICP8gDhWvbF+9CerXypyP5ZPvogw8LTbydQJj3s8bRrMCbcBwHa7uQGp+fYcUUnzggAG09M0ZVe2h6nEorRSinCXn4NQ3XLQ3+aH1/nzYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=svS671+x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p0VLWwFW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71FE91F381
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 23:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739577113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JGyPCcHBgGFQotW0C4KWuti38K4ybMOquUHBFW36+IU=;
	b=svS671+xVmP8Mmc9pXkSmaLNd3YFCxIokFDtbFEZ0zwUEDDigT53qPkC9fXzTweToj0zOY
	iIEplXCeF1Fo03I23ZLV0y0NuNGJOC067eMzZY7Zyb4wfzBCp8ZdJKxDy9+iznuDklcxe4
	LiNMqLO7l+S/TcaSoPwqs4bueWdavSM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739577112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JGyPCcHBgGFQotW0C4KWuti38K4ybMOquUHBFW36+IU=;
	b=p0VLWwFWn4wOCp9FUHlT+tP1tVegNwdDqkEVESn55H/A+ZVBqEDlHopoiW7EJ4E1VWFBjw
	3BndJvH+87hPaO/QgEPT9oRjlb1zknc5akX0je2qX0Xb+gRz/OfXC8oE8AwUEHjE/kyX3u
	RgUVM5XxDT0XNVdJSc5gu/QsRj3jIBQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6574B13285
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 23:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Rp6GBjXr2dfSAAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2025 23:51:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.13
Date: Sat, 15 Feb 2025 00:51:46 +0100
Message-ID: <20250214235148.5285-1-dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

btrfs-progs version 6.13 have been released.

The highlight is addition of compression to mkfs, supporting all the
algorithms and levels.

Changelog:

* mkfs:
  * new option to enable compression
  * updated summary (subvolumes, compression)
  * completely remove option --leafsize, deprecated long ago
* btrfstune: add option to remove squota
* scrub:
  * start: new option --limit to set the bandwidth limit for the duration of the run
  * status: fix printing of Rate unit suffix (SI/IEC)
* qgroup clean-stale: check if quotas are enabled before starting filesystem sync()
* print builtin features and options in --version output (mkfs, convert, image, btrfstune)
* build:
  * Botan minimum version is now 3.x
  * target to build compile_commands.json (for LSP)
* other:
  * a bit more optimized crc32c code
  * sync some headers from kernel code
  * command help updates and fixes
  * build warning fixes
  * error message updates
  * cleanups and refactoring
  * updated tests
  * lots of documentation updates

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.13


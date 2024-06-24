Return-Path: <linux-btrfs+bounces-5946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E799159E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 00:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FB5282990
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ED51A01BD;
	Mon, 24 Jun 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NQOUMSRV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NQOUMSRV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935F73454
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268202; cv=none; b=IzWzyp2u9IetFMb41+oL4wNbQqQIllVGb5TW3GzSplwByCXBBFp9NG038mKac4KY2ewSfWVJbPP/hehjSuMMczuozinrA1lDFDrhAP/K+4+RRqDcwnrPHaOsg4T+f+4VEd3Vn/PthCTJLUxvaD0ycLA14PoZ8FoB9e4NrwdzYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268202; c=relaxed/simple;
	bh=2t3Eo0ycQn0Qusb8xHEsYm9BEbRI3V6gW0qxy6Y+RJ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IVvzqvqKT5wekPtVA7eAq1b/FrTv/lT/N+n+Ls7RvaXuKk4tHoK5d5ndxZMghYhB5duYqfekch21gNoGEP6I3jj89gq+8Jxvi6017C4vfyrZCueTdEkcofGizccWngeuqju2v7i2uGtI+OhC37cQNVL0Lz8CmOY1szjR14WjmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NQOUMSRV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NQOUMSRV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 238111F7E7
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 22:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719268193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VSU1sxyipAJJasKo4XuIS5F9ca+gRzHb+SAGTjL2FRU=;
	b=NQOUMSRVCQr1PaMnJ0k7+N9EsDVG9O+0Hi5ayAX0TiuXnux79tBTT6SUL12SWDu8R6Ghdn
	LbR1u2HZRIgV6ZKmi5sQD8OIAep0rGD8bYCymHVfopaVSRH16utDx/ufXv7M93KGneaYUA
	MzNju2wotR3FmpVoYN5UtnIWE+Q7TGY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NQOUMSRV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719268193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VSU1sxyipAJJasKo4XuIS5F9ca+gRzHb+SAGTjL2FRU=;
	b=NQOUMSRVCQr1PaMnJ0k7+N9EsDVG9O+0Hi5ayAX0TiuXnux79tBTT6SUL12SWDu8R6Ghdn
	LbR1u2HZRIgV6ZKmi5sQD8OIAep0rGD8bYCymHVfopaVSRH16utDx/ufXv7M93KGneaYUA
	MzNju2wotR3FmpVoYN5UtnIWE+Q7TGY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E2AE1384C
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 22:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 58ImA2HzeWY/EQAAD6G6ig
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 22:29:53 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.9.1
Date: Tue, 25 Jun 2024 00:29:47 +0200
Message-ID: <20240624222951.2807-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 238111F7E7
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi,

btrfs-progs version 6.9.1 have been released. This is a bugfix release.

Note: raid-stripe-tree has recently got a on-disk format update which is not
backward compatible, until the patches are in kernel (ETA release 6.11) use v6.9
or lower, both need either DEBUG or experimental build

Changelog:

   * fix detection of intermediate super block flags (e.g. csum change and
     other conversions)
   * raid-stripe-tree support (still experimental):
      * moved under experimental build flags (mkfs, convert)
      * format change, removed encoding type; backward incompatible
   * receive dump: escape special chars in xattr names and values, and clone
     source path
   * tune change csum: fix reservation size when starting a transaction
   * other:
      * new and updated tests
      * updated CI images, new reference build targets
      * cleanups and refactoring

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.9.1


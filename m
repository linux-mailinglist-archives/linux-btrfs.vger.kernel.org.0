Return-Path: <linux-btrfs+bounces-12077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70524A55F5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 05:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A351C170AA3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 04:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C819048F;
	Fri,  7 Mar 2025 04:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iCltJG3y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iCltJG3y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A2DDBE
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741321620; cv=none; b=bvqvQfrg5rHrr3Yq+orEGVCK3wOs4NqhsDR0l4UO7jZ0o1DDUFYnAB9fSvPlNN7th1sAV8MI0sZ1zMLCpanKz1I3xBsIZf/PCEuucNBumFQowEZPvSJ5H7tcorlxLlKbhKw/p1OnROQmKHQyjIqSU+YHWYm+C71XG00BHHmntpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741321620; c=relaxed/simple;
	bh=hIVh30F5fzmHPdFGuO4bzEDfv20TMgfeK5RLWWIyzdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKeECTtbCT+mHI/KyBUrbQkfnyrqVGrjyy6ru0VQjMEvhLmTzQ0sbbYrEldWo5/TyYfm50ABtAXDEVrWsMWIeyfzRfnKyDiOxYyiE5oT8iCmbeAWzcg19f6X4Y0ro1ChBMXO61GiitYpG5x99AESGWxugyNSve/IX1exASiIvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iCltJG3y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iCltJG3y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C98D3211AC;
	Fri,  7 Mar 2025 04:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741321616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+ooI0Eu3ZzNTBNIY6UzimPHm2IqUXP9Wd3gi/O1MSY8=;
	b=iCltJG3yNsaaOUmKdeOj5wMI0ff1tOA5hihYO98evX4nmzNb3dBfK7m7AIzQFvEc/S8OZT
	FfBLO7x52feROO5iMu/sfXz6RM9oPn/S5MNSXd6Sk9ro1MYEYdGH3+hZfM7wb3mr7rhB7D
	jzrc2u1YSKPQZPn3Alym78yFa2zeRfc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iCltJG3y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741321616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+ooI0Eu3ZzNTBNIY6UzimPHm2IqUXP9Wd3gi/O1MSY8=;
	b=iCltJG3yNsaaOUmKdeOj5wMI0ff1tOA5hihYO98evX4nmzNb3dBfK7m7AIzQFvEc/S8OZT
	FfBLO7x52feROO5iMu/sfXz6RM9oPn/S5MNSXd6Sk9ro1MYEYdGH3+hZfM7wb3mr7rhB7D
	jzrc2u1YSKPQZPn3Alym78yFa2zeRfc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF6AA13939;
	Fri,  7 Mar 2025 04:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wi+FH491ymeZcAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 07 Mar 2025 04:26:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org
Subject: [PATCH 0/2] btrfs: fix the delayed iputs ASSERT() when the fs
Date: Fri,  7 Mar 2025 14:56:35 +1030
Message-ID: <cover.1741321288.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C98D3211AC
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Although Filipe fixes a lot of cases where the delayed iputs ASSERT()
can be triggered, that's all focusing on the common cases where the fs
is still in a good shape.

However in my experimental 2K block size runs, the test case generic/475
has a very high chance that the emulated error makes the fs to flips
into an error status.

That error status will trigger a completely new path inside
close_ctree(), calling btrfs_error_commit_super() which flush and wait
for all ordered extents.

That btrfs_error_commit_super() will generate new delayed iputs
asynchronously, thus trigger the later ASSERT().

The first patch is to fix the error, at least I can no longer trigger
the ASSERT() in generic/475.

The second patch is to add an extra WARN_ON_ONCE() inside
btrfs_add_delayed_iput(), triggered if close_ctree() has processed after
btrfs_error_commit_super() calls.

Qu Wenruo (2):
  btrfs: run btrfs_error_commit_super() early
  btrfs: add extra warning if delayed iput is added when it's not
    allowed

 fs/btrfs/disk-io.c | 14 +++++++++++---
 fs/btrfs/fs.h      |  4 ++++
 fs/btrfs/inode.c   |  4 ++++
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.48.1



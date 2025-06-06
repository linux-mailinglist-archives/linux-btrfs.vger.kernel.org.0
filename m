Return-Path: <linux-btrfs+bounces-14519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA50AACFC4B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 07:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A85163C3D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 05:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C01D5AC0;
	Fri,  6 Jun 2025 05:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rLZSZQ1L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sWRKLHSM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6DF10E0
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749188859; cv=none; b=Vx7LQIJXjQxEUYvFu4NsUYAZ3q/XAUCU1XU+yFo5AcVgH0UdQDrCkIXJOi55WfAtIY0TXbrAxyrOdOTAThoCwwu21EibNhJLCw+6loVBiijbVqTfcDA2QBLAG3B8pDKojvvMAPlzplojjAdxk8qs4wCYGHvSS9zmurgot/Mynjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749188859; c=relaxed/simple;
	bh=Pi4vbNAcmEcxkaH07hcCybxxfy4svmzwuGo9txGQEb8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TyE6A8uef08z85oRs4HQcO5K20qigEzR0Bm/0tNU8JOxOsI7QCi/SUx9U1/WmKQUPTLSITRIVuu6Xwqn4tuSUHWULPekT+IauHYWhU0BLtFb8Wec8V/X8+A2gXW8f9DUUt/rdMYuw4cWw8QkT+zg4bUGk4TYXAogl7GPO2qSShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rLZSZQ1L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sWRKLHSM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBA203369F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749188855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NPeXAyScK3g1lor5T1UuHVffqW39EhZ54IYZUt8YAGQ=;
	b=rLZSZQ1L99UrQWlTKd3uV5IcBRvXWMkX+3Dl9Aw2+XtSjd5yyMN06I9BPRJgpcG0CQae62
	aSQIRjhPMIgCCOrjFKCo2aYihhvKPdJo9hszTQa9kDPqIxKzMV578k4RwEnSBFedSzoRQa
	cYPRjSnw1zT0WvQp22Yx6IE5pQoaTkg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749188854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NPeXAyScK3g1lor5T1UuHVffqW39EhZ54IYZUt8YAGQ=;
	b=sWRKLHSMsDixUv0vYwnwymkxQzjOyfe71+AU262OkJTi8kDq+6WHIng5lO0r9qmsZJsrVI
	75onhMRNW5KicfWzEZx9GaV9MiKblUnQNStHTFcHo09OlqzHVjnSeyXnTx1Jn/5lqZ8+Eb
	2LLup0txjvA6lx/WmyISVUqmx8BdnaQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 344721336F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c1+sOfWAQmjsTwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Jun 2025 05:47:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: implement blk_holder_ops call backs
Date: Fri,  6 Jun 2025 15:17:14 +0930
Message-ID: <cover.1749188673.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Although test case generic/730 is going to be skipped for btrfs due to
the missing shutdown support, it still exposed a problem that btrfs has
no implementation for blk_holder_ops, thus even if lower level driver
wants to notify btrfs there is a device that is going to be removed,
btrfs can do nothing but ignore such critical info.

This series will implement all 4 callbacks for blk_holder_ops, 3 of them
are straightforward, just call the full-fs version of
sync/freeze/unfreeze.

The trickier one is the mark_dead(), all other fses with shutdown
support will shutdown the fs, making all operations to return error,
even if there is a cached page.

For btrfs we do not yet have full shutdown support, but at least we can
notify such problem through dmesg, then check if the fs can still
maintain its RW operations.
If not then mark the fs error, so no more new writes will happen,
preventing further data loss.

Now btrfs will output something like this if the only device of a btrfs
is removed, instead of aborting transaction later due to IO error:

 BTRFS info (device sda): devid 1 device sda path /dev/sda is going to be removed
 BTRFS: error (device sda) in btrfs_dev_mark_dead:294: errno=-5 IO failure (btrfs can no longer maintain read-write due to missing device(s))
 BTRFS info (device sda state E): forced readonly

Future full-fs shutdown will depend on this feature to properly pass
generic/730.

Qu Wenruo (2):
  btrfs: use fs_info as the block device holder
  btrfs: add a simple dead device detection mechanism

 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/fs.h          |  2 -
 fs/btrfs/super.c       |  7 ++--
 fs/btrfs/super.h       |  2 +
 fs/btrfs/volumes.c     | 90 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h     |  6 +++
 6 files changed, 99 insertions(+), 10 deletions(-)

-- 
2.49.0



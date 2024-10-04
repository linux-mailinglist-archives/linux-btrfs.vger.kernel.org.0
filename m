Return-Path: <linux-btrfs+bounces-8534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B11B98FD1C
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 07:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A8E284480
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 05:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA49284037;
	Fri,  4 Oct 2024 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MVwB+wMp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MVwB+wMp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A571D5ADA
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728021153; cv=none; b=Cos9fQF2NJBz9RUstYjRuJFpW6h3xjUN/fo9HpHbyh3pmIB1A1l9h/XE4ahN/73CMMA5yD0/VEoT8Kj4L84oX3RHiG3rptHz4VPxjYFr3CBw+SEumJz2b9t9nTp7APb8IpnWdAmT41Arjh7xWQ7Bps2HdXJ20E6Gy+yNuVfc/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728021153; c=relaxed/simple;
	bh=qNUQnWOJDuBFcEksn7mz+84fsOLz2gwQSKzECbeOhQY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n3/OO7LjU0tcEIEg0vgxuyMgF/Y6MgSNTju/rMazllJLsmqO3s+yQbsq30GuwJEZru7tQf6sngM1YVHaL0tfLBwL12KdEiqA72bFMS5mMGp0bpc9ZXV0Zyev12/hNEPQ+9fsIXR6JxP80w5kpxoh+NhzeuE6tChZqaFArp6wrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MVwB+wMp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MVwB+wMp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14A561FED0
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728021148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FsTgnYkMMaXoVzg/wvw7n2d7XOdFXV0Kg5vM03EkXWg=;
	b=MVwB+wMpiMEpJCwMaP9NVzd0ZyVfOPr6oqWjRFOAH7UOUIqWYTOHGdPXLFuezlA3M9DB+t
	N9VQLLKq9Lqc0LHgiBpPvMdDzX0FxArETgRvJlFOav7ccSQ8h4M9bG0Ev75EZhfm6L/Lno
	UVUzyI0vNms7xLQysAO+nCkKUq4DfpQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728021148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FsTgnYkMMaXoVzg/wvw7n2d7XOdFXV0Kg5vM03EkXWg=;
	b=MVwB+wMpiMEpJCwMaP9NVzd0ZyVfOPr6oqWjRFOAH7UOUIqWYTOHGdPXLFuezlA3M9DB+t
	N9VQLLKq9Lqc0LHgiBpPvMdDzX0FxArETgRvJlFOav7ccSQ8h4M9bG0Ev75EZhfm6L/Lno
	UVUzyI0vNms7xLQysAO+nCkKUq4DfpQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4946D1376C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 05:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P1i4ApuC/2ZrRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2024 05:52:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: print-tree: cleanup for regular bitmap based flags print
Date: Fri,  4 Oct 2024 15:22:02 +0930
Message-ID: <cover.1728020867.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The first 2 are small cleanups for __print_readable_flag().

The last one introduces an sprint version, sprint_readable_flag(),
allowing the same bitmap handling of print_readable_flag() to be output
into a string buffer.

And use that sprint_readable_flag() to handle inode flags, inspired by a
recent report that Synology's out-of-tree btrfs can not be handled by
upstream kernel (unsupported inode flag).

This allows print-tree to handle the unknown flags of inode flags.

Unfortunately I didn't find any other location can benefit the
sprint_readable_flag() yet.

It's either bg flags which needs special handling for SINGLE profile, or
not bitmap in the first place (e.g. compress flags).

Qu Wenruo (3):
  btrfs-progs: print-tree: use ARRAY_SIZE() to replace open-coded ones
  btrfs-progs: print-tree: cleanup __print_readable_flag()
  btrfs-progs: print-tree: use readable_flag_entry for inode flags

 kernel-shared/print-tree.c | 128 +++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 56 deletions(-)

--
2.46.2



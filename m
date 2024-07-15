Return-Path: <linux-btrfs+bounces-6450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA39930D79
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 07:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADFAB20E8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 05:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6F13B2A9;
	Mon, 15 Jul 2024 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pYHV/mRv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Kr5MGe9M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796723A9
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020677; cv=none; b=lq1Pctadpqt27UDJLvnhIAI1yyqlYK4oA2ToWtedpuW8CWi9vD47bdDMK8LhetQl+PAFeF17kDUTdcFqkfk8M2oZmmhNqxYNtUJDkC7w1gij9h6Tt8zDWHUcGO3xJWRJzB6oJ8XM4WxXlmOvJOzWboBy2Fo/uozl7cQbQLvM9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020677; c=relaxed/simple;
	bh=XRwJBRZEWQ15tS68XMC5F7j076E+toMBoK6v6WN1JOY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ru5TfhCH6momtZul27ouXTJBXZEW41pK130vXRQdCH88qwf2GRSlZdwSID1T5Ord9qRwFLsgH1fGKQfD5YSDEH6hEwvaIWPt+KK7ypqr9V3ElpANJGuI7MLbxgsxJZVhepnozmZ3Z82dkeTNk5RKLAKwaSR0nui36YuRaWFKWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pYHV/mRv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Kr5MGe9M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F38CD219AB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEBCQQu6jMAuxfwYSi3c5n2m1BeW+oLFTsuysnwOSak=;
	b=pYHV/mRvqJ5h6p7WMTT6UTD35aru6cIJbJiNuDkgCJcbAtOxqrMjOWB8pAz1bmnSWHIA47
	3f75aH3vo7BtFxFA60nOvbNeCGT57LFCqyhhZqoi571cDhLp88jUKU/8aNSu6Rq0AYfv/U
	8jKXAx7J+qY4acXj2o3qTA3otIDeB0g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Kr5MGe9M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721020672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KEBCQQu6jMAuxfwYSi3c5n2m1BeW+oLFTsuysnwOSak=;
	b=Kr5MGe9MxIX1FgCj4xukiFZw1CUNZ5nLqBabeFq/uTSxRgByIzo+a41PgGcJ/iRPD9Fb45
	0DleXyTs/txPCR41RhcHNM+JgJ8k14h54KZwSk/b0aoIAsea0YWBDRZG3/b8LryPI7j7h5
	e0G+70g3PnDFfRDD+YPme2xnLx6TDOE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 187E8134AB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oUgMMf6wlGZRRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 05:17:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: convert: fix the rollback filename output
Date: Mon, 15 Jul 2024 14:47:31 +0930
Message-ID: <cover.1721020542.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: F38CD219AB

When testing my newer version of subvolume creation cleanup (which
removes btrfs_mksubvol(), utilized by convert), I found out that
"btrfs-convert -r" output is always corrupted.

It turns out to be a small string termination problem.

The first patch fixes it, then a new test case for it.

Qu Wenruo (2):
  btrfs-progs: convert: fix the filename output when rolling back
  btrfs-progs: convert-tests: new test case to verify the rollback
    output

 convert/main.c                                |  2 +-
 .../convert-tests/026-rollback-output/test.sh | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100755 tests/convert-tests/026-rollback-output/test.sh

--
2.45.2



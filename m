Return-Path: <linux-btrfs+bounces-9928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865139DA14F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 05:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D60168F10
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 04:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71F13AA3F;
	Wed, 27 Nov 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WJW5N8W2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WJW5N8W2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944D42AB3
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680421; cv=none; b=GS6kDPmlDV5PbimfLij2l8p0sMkRNEYG6aheTdgzmveKkpHqkN7nwicsEzU2d0gjMEYagfn+NJkIp7oFLnJR4F9groyDQKhnPU59Zu1pndWgraWYOPRRpD8kBRhjQpDAIetWOfz0D5jCv4B6+xJj/Z+M8JQnNRioEZywhweTvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680421; c=relaxed/simple;
	bh=Lz00OkESqnK1vHB2AHqHgEaZ8Eha4qc0ppNd8Sptkj4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JCl3CC7ehTlSm+TT+wkOxEChWe+lBSE5FhrB/U/RPC4JXegJyyF3Gh/LuUFkOYwg12c32lYgYYLzTA0AVraMMvE5wW0WCj/qYKQ0Fsp3mP2lZP8BK4rFDN/ayiNXMPYVLiuqlYax7kAepjYsVMgbbP+c2jLMA5lncN3G55dq2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WJW5N8W2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WJW5N8W2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1060D2116B
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732680417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E778uY6xzpzNC1pfWZQdLVpozVJ1ged0ZeQOIhU7k/g=;
	b=WJW5N8W2Esov3gQPOKY75V3LIdVgKn1NmqTHm9BnruUJeVLoi30XziWNOwAEyFN7IzDaf7
	i7ftUnu84Ua2deYk6mTqlpAWRabg9wKzqJz109qaZKxeZRlKDJRqtB4ZmX/mJHxFpjJohD
	YT4JgvAL9ub4TYTKn2pdw9Wpcw+IwO4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732680417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E778uY6xzpzNC1pfWZQdLVpozVJ1ged0ZeQOIhU7k/g=;
	b=WJW5N8W2Esov3gQPOKY75V3LIdVgKn1NmqTHm9BnruUJeVLoi30XziWNOwAEyFN7IzDaf7
	i7ftUnu84Ua2deYk6mTqlpAWRabg9wKzqJz109qaZKxeZRlKDJRqtB4ZmX/mJHxFpjJohD
	YT4JgvAL9ub4TYTKn2pdw9Wpcw+IwO4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36B8B13983
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nC91ON+aRmfAYwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 04:06:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: extra debug output for sector size < page size cases
Date: Wed, 27 Nov 2024 14:36:35 +1030
Message-ID: <cover.1732680197.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
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

The first patch is the long existing bug that full subpage bitmap dump
is not working for checked bitmap.
Thankfully even myself is not affected by the bug.

The second one is for a crash I hit where ASSERT() got triggered in
btrfs_folio_set_locked() after a btrfs_run_delalloc_range() failure.

The last one is for the btrfs_run_delalloc_range() failure, which is
not that rare in my environment, I guess the unsafe cache mode for my
aarch64 VM makes it too easy to hit ENOSPC.

But ENOSPC from btrfs_run_delalloc_range() itself is already a problem
for our data/metadata space reservation code, thus it should be
outputted even for non-debug build.

Qu Wenruo (3):
  btrfs: subpage: fix the bitmap dump for the locked flags
  btrfs: subpage: dump the involved bitmap when ASSERT() failed
  btrfs: add extra error messages for extent_writepage() failure

 fs/btrfs/extent_io.c | 16 +++++++++++++++
 fs/btrfs/subpage.c   | 47 ++++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.47.0



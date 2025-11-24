Return-Path: <linux-btrfs+bounces-19279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243BC7EEFE
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 05:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44CCC4E110D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 04:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89672BCF43;
	Mon, 24 Nov 2025 04:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uRWXX19b";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uRWXX19b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF61B4257
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763957754; cv=none; b=obzNX7HCUtt5YeViGNm9pgh8J50M+WR6ziE/U+1Uj1yPZ7XrdYgVYM+SEXkykH1o6BY+x9DAeBchkctaiQHtm4kBtNHjBp7MpMC3vk2tzEJjO4ZV6bBMpGu5VaAhsN9Fasaubs7Uz1KYMOT8UyNULPzMXcBlKj1DjvftVBrluyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763957754; c=relaxed/simple;
	bh=rZOylbWHliyb1DI3mUxPxcR9jR3CbAHeGCaB7bYV7CM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KQGOkKZ3p5cKyUXBGDgt2e5d65A/ednArvJVDYMw7tk3iq01ZvY/EQ0uYfbNnO09w41diVsVl7hYYIXh3y8DMlyxAxFnj6cMLl9mOWtb5hvfWB+x72b3LE7I3jWiOYAW6BBZregypt9/ejJ27F1MUazK2poFWn/SOZ1/rF9V7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uRWXX19b; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uRWXX19b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 033515BCFD
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763957750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R8kzCnLk/+GgN6VNY8neZTQFYH4RC+ubUBMPgaJnSp0=;
	b=uRWXX19bzmNcNhEehP4sQXkCorjwcgkkxcog1lrCOhfMkRGzbEfkFg/H/UsvV5MgnnVEEY
	9+kAjr76bsfN/dDFpMZcs2GA33+ucd5/WdGiJ/9qH/5J+khA1UCxolxpWZ5bYpJq4sbQsF
	Hdo+EgDdoez9iPUzJ9WKT92ay9wBgnw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763957750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R8kzCnLk/+GgN6VNY8neZTQFYH4RC+ubUBMPgaJnSp0=;
	b=uRWXX19bzmNcNhEehP4sQXkCorjwcgkkxcog1lrCOhfMkRGzbEfkFg/H/UsvV5MgnnVEEY
	9+kAjr76bsfN/dDFpMZcs2GA33+ucd5/WdGiJ/9qH/5J+khA1UCxolxpWZ5bYpJq4sbQsF
	Hdo+EgDdoez9iPUzJ9WKT92ay9wBgnw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23A333EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pXr9NPTbI2kDRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: enhance error handling of __free_extent()
Date: Mon, 24 Nov 2025 14:45:25 +1030
Message-ID: <cover.1763957608.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Score: -2.80

There is a github bug report about btrfs-convert crash, where
btrfs_print_leaf() is called on NULL path->nodes[0].

The first patch fix the bug by cross-port a fix from kernel part.

The second patch refactor the error handling of __free_extent(), mostly
follow the kernel patch "btrfs: refactor the error handling of __btrfs_free_extent()".

Qu Wenruo (2):
  btrfs-progs: do not dump leaf if the path is released inside
    __free_extent()
  btrfs-progs: btrfs: refactor the error handling of __free_extent()

 kernel-shared/extent-tree.c | 154 ++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 79 deletions(-)

--
2.52.0



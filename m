Return-Path: <linux-btrfs+bounces-19615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99680CB2710
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 09:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F96B31071E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 08:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2743054DF;
	Wed, 10 Dec 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KrZXwLqs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PFYxNm+g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A4302149
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355586; cv=none; b=BCc2Y9GjNLb7lOVe76TtJR5rWU9EtnYaJsmIXNZfKAbatna1Ua9j5qJLOHyq9AfaOuuhf0H1kCpUCLf5gk5Svq1+DlhP8nDzFVqCLEgrv1QRA60P1lzf7rXgwUV9PYO51xjBbYbhSaZ3zI6LhJi8+hGgUwaFcgszezbvGzUZS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355586; c=relaxed/simple;
	bh=ECjKUhCJRHytgweknLGcnUMnalgtcCtbWudbJX4soWk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IE17zDO7gSTzdnNFdUlNEtypnLJdANfAg54EkP9iXzRjs8xuBKjOoWaapMufz5AskzLLfWL2gTGbkh7GTfQXhqKfm1ijiHViWALC5OvOyBiJJu6ohK6WGogFloZBiVgUsQvAuej+N69R1AMN6y6QJTK4tgo4OYKB9VzOBlyBv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KrZXwLqs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PFYxNm+g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F216E5BE07
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765355582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wmlHEnU7LKSQtHeLkN7AOnGBhZ1XHJqFixRwU81/yyA=;
	b=KrZXwLqsAou2rfbl8Lcu3b4wURi55RJaUKWzwZFi5mjJUhJmuzHOCccR/HEADwN3xVPqaJ
	s4B4vjKBtLlNYbIuqyrrbQOjeaqtIzMl0ZuSxY8VuVRO4QwoM90KHevij0n2R1BEt/1iwl
	it93dmLM+56EuJRaAWdz7t87QaWZUxM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765355580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wmlHEnU7LKSQtHeLkN7AOnGBhZ1XHJqFixRwU81/yyA=;
	b=PFYxNm+g0qmPMwNitozZeRqKiHfuKnJbpwfSG2VETVhor+q0tfyFJKeoUc6w74I/o4B/ZE
	RMY3Kn8fUdweSbLSi51W20tfHLpAO9PAWeQQR/VI4xBM0ax6JEd0kAEXFsKWqXfddTdqeL
	xEB+ZKG1I1OBdd+jLgjtJYcP3wFjxlQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BB683EA63
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 08:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GClONzswOWnmHQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 08:32:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: minor cleanup related to bitmap operations
Date: Wed, 10 Dec 2025 19:02:32 +1030
Message-ID: <cover.1765354917.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.76 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.16)[-0.820];
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.76

This is the safer cleanup part extracted from the previous attempt:
https://lore.kernel.org/linux-btrfs/cover.1763629982.git.wqu@suse.com/

The first patch is to concentrate the error handling of
submit_one_sector() so we do not have two separate error handling.

The second patch is the convert for_each_set_bit() to a more efficient
for_each_set_bitmap() so that we can benefit from functions which
accept a range other than a single block.

Qu Wenruo (2):
  btrfs: integrate the error handling of submit_one_sector()
  btrfs: replace for_each_set_bit() with for_each_set_bitmap()

 fs/btrfs/extent_io.c | 55 +++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

-- 
2.52.0



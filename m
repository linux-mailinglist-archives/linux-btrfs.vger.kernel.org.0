Return-Path: <linux-btrfs+bounces-1651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F6839979
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 20:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8167291733
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293CB823BB;
	Tue, 23 Jan 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WvdGsHqR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q4rtS6jW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WvdGsHqR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q4rtS6jW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E150A64
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038039; cv=none; b=bB7QmXLkysvYQ3tesoFfctBCrOIykmcJR9fKRVVlH3fRK8HC+cHNfX+u/kVRczpJWIdhVIdCQclWPyPYIdaikfQjpJdpHZR49PHTaqipU1P6KUXVZ4yKWsHrmIrQVBPxel7Uia0deyyk3WDXQ8VxYubTfEyyFP6nKkiRRHh1Hr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038039; c=relaxed/simple;
	bh=qT1j6SVq4yr4WBajlu8ovMCwN8+kt9gveiqIjp0V1E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqyFavLKJ99I/jVdFbgTmV4OIU9JHoN7yq81dKd1lK04CL9DeKjTH5dAt1kbPRWSNI25itifw9jyhaMswlmAzOrHd6z7vpnwDsSFGiwEM17AO4CYE8BQUuRdZSwvaNxxczM/aCV7DUeQPjiYeQS4GN4ZR60+TiWMm7vvMMoWvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WvdGsHqR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q4rtS6jW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WvdGsHqR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q4rtS6jW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80D0621E88;
	Tue, 23 Jan 2024 19:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706038035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iP02eTu0sMG2Rlhktrd3mcpCK7OPRoo1HzqyDxHGxcc=;
	b=WvdGsHqRnWKaSQggmQoNx6yzna60bbKYPASuMLL6o1F/wNwDiaf4kGC7rSqXPt0QpEeN6p
	Ru8iUBoeiqvADU+CLXxqD0lAZ6Crf0nb5lYH4Os4/i1rCBcBnCNvPamFNssX+6aB+cWKZE
	lQrjXtltGShD8SGUOJr/4OazpSk3KvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706038035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iP02eTu0sMG2Rlhktrd3mcpCK7OPRoo1HzqyDxHGxcc=;
	b=q4rtS6jW5mvFiTPgOaHdhpZkVostvUe+uRAIeEsq/1x1q8w23QkfyCUiyg9Ieirf5nvBAP
	oWKe9BsenS8fx1BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706038035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iP02eTu0sMG2Rlhktrd3mcpCK7OPRoo1HzqyDxHGxcc=;
	b=WvdGsHqRnWKaSQggmQoNx6yzna60bbKYPASuMLL6o1F/wNwDiaf4kGC7rSqXPt0QpEeN6p
	Ru8iUBoeiqvADU+CLXxqD0lAZ6Crf0nb5lYH4Os4/i1rCBcBnCNvPamFNssX+6aB+cWKZE
	lQrjXtltGShD8SGUOJr/4OazpSk3KvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706038035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iP02eTu0sMG2Rlhktrd3mcpCK7OPRoo1HzqyDxHGxcc=;
	b=q4rtS6jW5mvFiTPgOaHdhpZkVostvUe+uRAIeEsq/1x1q8w23QkfyCUiyg9Ieirf5nvBAP
	oWKe9BsenS8fx1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B6D713786;
	Tue, 23 Jan 2024 19:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EMBlMhITsGXKQAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Jan 2024 19:27:14 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v2 0/3] page to folio conversion
Date: Tue, 23 Jan 2024 13:28:04 -0600
Message-ID: <cover.1706037337.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WvdGsHqR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q4rtS6jW
X-Spamd-Result: default: False [1.17 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.52)[80.37%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.17
X-Rspamd-Queue-Id: 80D0621E88
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

These patches transform some page usage to folio. All references and data
of page/folio is within the scope of the function changed.

Changes since v1:
Review comments - 
  * Added WARN_ON(folio_order(folio)) to ensure future development knows
    this code assumes folio_size(folio) == PAGE_SIZE
  * namespace restoration: prefix variable names with folio_
  * Line adjustments

Goldwyn Rodrigues (3):
  btrfs: page to folio conversion: prealloc_file_extent_cluster()
  btrfs: convert relocate_one_page() to relocate_one_folio()
  btrfs: page to folio conversion in put_file_data()

 fs/btrfs/relocation.c | 103 +++++++++++++++++++++---------------------
 fs/btrfs/send.c       |  44 +++++++++---------
 2 files changed, 75 insertions(+), 72 deletions(-)

-- 
2.43.0



Return-Path: <linux-btrfs+bounces-6009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E38B919E2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 06:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D671B22B33
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jun 2024 04:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677301A29A;
	Thu, 27 Jun 2024 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FVdWhEPo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FVdWhEPo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3C079F0
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719462748; cv=none; b=AFDNw0Stb98xkcuRO1fP+nlDeirgELEKdgBfF+ZLYHk3oP5RC7nadwultPvOQmMGrXQhY/YzNurarnudsi/eViP8T5rbWDsg5gUpPKltVeYnqz+oWCTYWiEn6uJK4zQxl8xjw8Sc+nacQUkg+EuOQJQyJ5vDODHOQ0q0gz5TtKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719462748; c=relaxed/simple;
	bh=WrJIQ0HM0j18DqxTe3aTlVevxKjB8XRSX9LbfsMpcuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s3RKnAgyyxqkUQJiu79ZZFe7RECh5XW5CbCAoLOF9wHa+LNDV7lh83Xojo1UVrz/84u832g7bje61WJ/B9AsZN2kbk1eZl6bbIkEafNgONMNb12WhzSCwZV5enGHX3WGSnmqj+kpxuEVNJ+DWcyDA732KW/heHb+LQAmrBcaA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FVdWhEPo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FVdWhEPo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2634521B37
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 04:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719462744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Y9hJWKUzzOjCIDIDvMwSLfvbACKeWWi6uZu8Ta9X+8I=;
	b=FVdWhEPo9uZfhyNN0CyhOxpWhctpULCobDiFDDnrjciVNxoPuL003oXPOI4aVnff5pTdAJ
	xTIoFejorsr6Cf0TshY96muyBNNaMDXXjnQroivtqbpqLmjotrVcrnUM3SW4wIdF88pxhs
	9HN/BCHnBtHQKTjwoDbrCj9llRrodVs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FVdWhEPo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719462744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Y9hJWKUzzOjCIDIDvMwSLfvbACKeWWi6uZu8Ta9X+8I=;
	b=FVdWhEPo9uZfhyNN0CyhOxpWhctpULCobDiFDDnrjciVNxoPuL003oXPOI4aVnff5pTdAJ
	xTIoFejorsr6Cf0TshY96muyBNNaMDXXjnQroivtqbpqLmjotrVcrnUM3SW4wIdF88pxhs
	9HN/BCHnBtHQKTjwoDbrCj9llRrodVs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38D8C1369A
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 04:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MjtaN1brfGarSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Jun 2024 04:32:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: cleanup on the extra_gfp parameters
Date: Thu, 27 Jun 2024 14:01:58 +0930
Message-ID: <cover.1719462554.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2634521B37
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

The @extra_gfp parameters for page/folio array allocation is only for
extent buffer allocation to pass __GFP_NOFAIL.

Meanwhile all the callers have to pay for the extra parameter.

This patchset removes the parameter, and introduce an internal version
of btrfs_alloc_page_array() to handle the __GFP_NOFAIL case.
Furthermore, for that internal version, use a bool to indicate wheter
it's a NOFAIL allocation or not.

Qu Wenruo (2):
  btrfs: remove the extra_gfp parameter from btrfs_alloc_folio_array()
  btrfs: remove the extra_gfp parameter from btrfs_alloc_page_array()

 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   | 51 +++++++++++++++++++++---------------------
 fs/btrfs/extent_io.h   |  6 ++---
 fs/btrfs/inode.c       |  2 +-
 fs/btrfs/raid56.c      |  6 ++---
 fs/btrfs/scrub.c       |  2 +-
 6 files changed, 34 insertions(+), 35 deletions(-)

-- 
2.45.2



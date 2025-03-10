Return-Path: <linux-btrfs+bounces-12150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B2A5A3CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608AF16B95A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 19:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885C23535F;
	Mon, 10 Mar 2025 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Sb7aP3/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qWfedqQm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0Sb7aP3/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qWfedqQm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1929D0B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634961; cv=none; b=mV5qtNcZGkVTlE1UjMwpOM3qCz9PhqN/zyiy3yMzfsXAVM4oKD1QiW38WLlwXsgz2ot48oAS87oaSD+UqRinLutsrxbhs3/v9F5xMdpMadezBVoBSC36jZncF1drcy4mAAtq4uWFZotk8ttIngFOCACJFrNU+WLFXjmNwau8ghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634961; c=relaxed/simple;
	bh=vIQoIDCuK7OHGoE9YlbgfDOW/L9WXbzOwLJgZpTv3eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ho+8o8/s6Ip4ERUloqH8AuywUNpDp1VSPME8AbNXxpKkKd/KWqV3CmAGsOtdAXlSpHzM0muli4SyILkJfylVDQO6YMTkj+lND3SRreoN568AuStCjKiirKtm0hOyPW1BNH/ddLovN7Xz11AgXMpek9txrv4kgwd2Sb8MuruxcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Sb7aP3/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qWfedqQm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0Sb7aP3/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qWfedqQm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E02131F38A;
	Mon, 10 Mar 2025 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741634956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i3e/7896xwadbvfKGG9dr6v/gjwmlCI0NSOMwLQbnCA=;
	b=0Sb7aP3/jl/LdCDeCTfPS9a3HYseWBsXVE9u+sI+hfGm1Gzv6gtgGo0sEtbUVZK22Y0Cwl
	op1NIGUj+nNhahJYYTASoBvS7e6SY/sy52WFJ0QewO/YTY5xlOsKs+34Z+o4o5Jj9h7T/q
	U/1k2ADqjepxJMVSwvuxKvzTNUx9bn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741634956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i3e/7896xwadbvfKGG9dr6v/gjwmlCI0NSOMwLQbnCA=;
	b=qWfedqQmX0FtDtDtRRcub56hj8FCLfFbrf6DRhRFbRUeDeNt5qthMJWOz/dGQHQAhDDz0n
	plQdHd/DrvI4u7Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="0Sb7aP3/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qWfedqQm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741634956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i3e/7896xwadbvfKGG9dr6v/gjwmlCI0NSOMwLQbnCA=;
	b=0Sb7aP3/jl/LdCDeCTfPS9a3HYseWBsXVE9u+sI+hfGm1Gzv6gtgGo0sEtbUVZK22Y0Cwl
	op1NIGUj+nNhahJYYTASoBvS7e6SY/sy52WFJ0QewO/YTY5xlOsKs+34Z+o4o5Jj9h7T/q
	U/1k2ADqjepxJMVSwvuxKvzTNUx9bn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741634956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i3e/7896xwadbvfKGG9dr6v/gjwmlCI0NSOMwLQbnCA=;
	b=qWfedqQmX0FtDtDtRRcub56hj8FCLfFbrf6DRhRFbRUeDeNt5qthMJWOz/dGQHQAhDDz0n
	plQdHd/DrvI4u7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A532E1399F;
	Mon, 10 Mar 2025 19:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C+bqIYw9z2euFAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Mon, 10 Mar 2025 19:29:16 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v2 0/2] Avoid setting folio->private
Date: Mon, 10 Mar 2025 15:29:05 -0400
Message-ID: <cover.1741631234.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E02131F38A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

folio->private was set in order to get release_folio() callbacks.
Instead if we set address_space flags AS_RELEASE_ALWAYS, there is no
need to set EXTENT_FOLIO_PRIVATE on every folio->private.

These patches are posted so we don't face conflicts with iomap's
iomap_folio_state, which also resides in folio->private.

Changes since v1:
 - Incorporated Dave Sterba's comments

Goldwyn Rodrigues (2):
  btrfs: add mapping_set_release_always to inode's mapping
  btrfs: kill EXTENT_FOLIO_PRIVATE

 fs/btrfs/compression.c      |  2 +-
 fs/btrfs/defrag.c           |  2 +-
 fs/btrfs/extent_io.c        | 61 ++++++-------------------------------
 fs/btrfs/extent_io.h        | 10 ++----
 fs/btrfs/file.c             |  6 ++--
 fs/btrfs/free-space-cache.c |  9 ------
 fs/btrfs/inode.c            | 13 +++++---
 fs/btrfs/reflink.c          |  2 +-
 fs/btrfs/relocation.c       |  4 +--
 9 files changed, 27 insertions(+), 82 deletions(-)

-- 
2.48.1



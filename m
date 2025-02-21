Return-Path: <linux-btrfs+bounces-11703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A141A400A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 21:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B020E3AAA3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 20:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A125333B;
	Fri, 21 Feb 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kMgZMc1u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4JcfkKAv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kMgZMc1u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4JcfkKAv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC92528F6
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169270; cv=none; b=TdlolhdZJnuuYQCkwmX3J/Nq1s3FJq3Z82X+tJLHSywZ3ug/Hr6Vp1FaKLSGU1NUoNw5ufZckWHE+qGszmiwsgVzB1UBj/TtDa8Hxoz+1BEWcO2p+pbzGpKb5SbA0wCI4vW9GtfXHrNhX3dNUhx43Cm/xNZ0Lnlhu7AMifvGfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169270; c=relaxed/simple;
	bh=18qsHXhExR8g4a4nY+KNlNowcjIYW+89AaMwbELYj3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/aN0bBvTbxiw+nZGWrkYTWEecnxg1+hF7w1ovI6YLJmB3AHCFDRH3Nu/ey4ZgarSzSswsYpLvLrmTOOeL4WYs6nPpv+CneJyPDszNcy8PdWRdHpyoBvfq/TZP50zUwlf2gIWePWvOJW/qXYW8JVzStVvCiyPAD56IZeBb9oSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kMgZMc1u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4JcfkKAv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kMgZMc1u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4JcfkKAv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40AEF1F791;
	Fri, 21 Feb 2025 20:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740169266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nrSQ4hNzUuKnjuEwwacD+Qr5ciN1pj2h1PP7uyR3Rc4=;
	b=kMgZMc1uG0+xzkUMEPvg+8A9joiMtgCRXdooU5ofSp71VugT/vl0psOTJJHFNruMR2fVxO
	By7zOkU/RPW5HDTWK3vitP4vLy0RYvsOAeWKgfqnhfGKd1fOMoaIs+EdTktZHJYChpnale
	KgB/qUlj5z3ZVT4Zo8ESDCM23WgL9lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740169266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nrSQ4hNzUuKnjuEwwacD+Qr5ciN1pj2h1PP7uyR3Rc4=;
	b=4JcfkKAvqnYknE9/Oz6IV0BVD0ywaydGeuDm1nYncPl0jTNpHc482aEVQy7YgivOu2cAbe
	JzRcURXEFFCHygDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kMgZMc1u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4JcfkKAv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740169266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nrSQ4hNzUuKnjuEwwacD+Qr5ciN1pj2h1PP7uyR3Rc4=;
	b=kMgZMc1uG0+xzkUMEPvg+8A9joiMtgCRXdooU5ofSp71VugT/vl0psOTJJHFNruMR2fVxO
	By7zOkU/RPW5HDTWK3vitP4vLy0RYvsOAeWKgfqnhfGKd1fOMoaIs+EdTktZHJYChpnale
	KgB/qUlj5z3ZVT4Zo8ESDCM23WgL9lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740169266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nrSQ4hNzUuKnjuEwwacD+Qr5ciN1pj2h1PP7uyR3Rc4=;
	b=4JcfkKAvqnYknE9/Oz6IV0BVD0ywaydGeuDm1nYncPl0jTNpHc482aEVQy7YgivOu2cAbe
	JzRcURXEFFCHygDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03E4E13806;
	Fri, 21 Feb 2025 20:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NP8nNjHguGekcgAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Fri, 21 Feb 2025 20:21:05 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 0/2] Avoid setting folio->private
Date: Fri, 21 Feb 2025 15:20:51 -0500
Message-ID: <cover.1740168635.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40AEF1F791
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

folio->private was set in order to get release_folio() callbacks.
Instead if we set address_space flags AS_RELEASE_ALWAYS, there is no
need to set EXTENT_FOLIO_PRIVATE on every folio->private.

These patches are posted so we don't face conflicts with iomap's
iomap_folio_state, which also resides in folio->private.

Goldwyn Rodrigues (2):
  btrfs: add mapping_set_release_always to inode's mapping
  btrfs: kill EXTENT_FOLIO_PRIVATE

 fs/btrfs/compression.c      |  2 +-
 fs/btrfs/defrag.c           |  2 +-
 fs/btrfs/extent_io.c        | 30 ++++++++++++++----------------
 fs/btrfs/extent_io.h        | 10 ++--------
 fs/btrfs/file.c             |  6 +++---
 fs/btrfs/free-space-cache.c |  9 ---------
 fs/btrfs/inode.c            |  9 ++++++---
 fs/btrfs/reflink.c          |  2 +-
 fs/btrfs/relocation.c       |  2 +-
 9 files changed, 29 insertions(+), 43 deletions(-)

-- 
2.48.1



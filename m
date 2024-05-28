Return-Path: <linux-btrfs+bounces-5311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC28D13F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 07:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C609C1F23401
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 05:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1834EB38;
	Tue, 28 May 2024 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rXRGd35V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rXRGd35V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1717E8FF
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874460; cv=none; b=EqJ9D+CRf7ELngH7j9PB+ehnz6VYybZnUsm9lq2/ZvfXsCdphSa/dFu81ClzTtiAFTr6kq8REESNpTYIlBazQL0FLTJ+rrV3ip+cBkBnhNu+rTNHHyCNLivI8RcZdFT+bGdwAKNUGTg5wDafq8expODXoHRZAEPGB0ipAFDR/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874460; c=relaxed/simple;
	bh=Phral+2mWpODDPchxiPWqfa4IyEGxWoewPKg8jumETY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tTCK8aC3Ngt7m8UsPS8gdbvDMgvMNTIJp5gEmXIflE6Poa7pPJTA6qcZ6bdSozWdSouW3FFR9eH4r5u9Zygl5YcHtA+YTyCibHuL837e1S50DLqaQIOW0DZqYjXmnbVEGGyihC+rdlbJ0OOvGHbOqzLgAydX4Tnf/ZHl1VP8WmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rXRGd35V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rXRGd35V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95CC520132
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716874451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gGnAhGcNOMauuc8b9URddU4RwJl9g/FbOqBti5P/Jzw=;
	b=rXRGd35V5r9nMaILoTuFgjP6WLKJJQ75QNJiwyZqEqtGbKFgux402SbPP+FguXXF9oZHPF
	YoB5WCxihDy9ruuEyTQD2c7fdpl/ePj2YMyYbyiLqJXsVXO+3CGaxRnXPBfls1rR6rHEsA
	fIm7T00GheKkyWRtydtYG7wzv3oPhok=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716874451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gGnAhGcNOMauuc8b9URddU4RwJl9g/FbOqBti5P/Jzw=;
	b=rXRGd35V5r9nMaILoTuFgjP6WLKJJQ75QNJiwyZqEqtGbKFgux402SbPP+FguXXF9oZHPF
	YoB5WCxihDy9ruuEyTQD2c7fdpl/ePj2YMyYbyiLqJXsVXO+3CGaxRnXPBfls1rR6rHEsA
	fIm7T00GheKkyWRtydtYG7wzv3oPhok=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A10B313A55
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X/XDFtJsVWYpdAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 05:34:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: basic header cleanups
Date: Tue, 28 May 2024 15:03:46 +0930
Message-ID: <cover.1716874214.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.75 / 50.00];
	BAYES_HAM(-2.95)[99.80%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.75
X-Spam-Flag: NO

While reading headers, clangd would do a lot of extra checks, from the
very basic like including the header itself, to missing type definition
inside the header's include chain.

There are 2 very basic fixes can be done immediately:

- Do not do recursive include

- Do not include rwlock_types.h
  As it already mentioned to include spinlock_types.h instead.

Qu Wenruo (2):
  btrfs: cleanup recursive include of the same header
  btrfs: do not directly rwlock_types.h

 fs/btrfs/btrfs_inode.h | 1 -
 fs/btrfs/extent_map.h  | 3 +--
 fs/btrfs/fs.h          | 1 -
 fs/btrfs/locking.h     | 1 -
 fs/btrfs/lru_cache.h   | 1 -
 5 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.45.1



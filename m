Return-Path: <linux-btrfs+bounces-14449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63433ACDAFF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 11:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29461188DAE7
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906D28C85F;
	Wed,  4 Jun 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Cz0D/5ts";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Cz0D/5ts"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F462204C2F
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029365; cv=none; b=aDdNHfzIzLpRrXBXgpaShnAFPE5ZvyXAa6fTotbHDGDqYyYyPHHFYmeYCwLSb0GgaI/T+52bovsl3aa3AYeo+bQiLuUdcwNPbac889Qt6DTEBNrDnh9ZrNXZ4hZrXPEANnumorUxRd+JsllxnOXiJIaiJQNExdXrthmKlv6c+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029365; c=relaxed/simple;
	bh=TyEvK9f7UXP/kan73IqBtFlK4HRy4ZbXDnFPGFHNjzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qK3zJmJeduegCDlVjOZAaYwOgou/xc2IBHsiESgBdcNqY/fE5ifjtnLdt5cm5P8/U8aOOU7521a+h2UBMyIl9be9qmGhWDyLkjQCAcqXcHyBWEDIcTjC/7JohsXc2k2/Ze5wCrV95F1FCK8Go6zusDh2T5WrLTfG4oBAfsuaGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Cz0D/5ts; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Cz0D/5ts; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27F2E5CBBC;
	Wed,  4 Jun 2025 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749029361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KQVe86AdT0obGtmdPTY5Qchp+PcOpudkbQHVBz/9Ut4=;
	b=Cz0D/5tsLgiSq6JFXR88+SWTlR5HT6F2S+xdG7BU0pVS6b04mkRHvaq83zpt/Bw8LCTbMR
	0y/NS8Dhbq8KksMoETxi/kMr8On2cSQw/dDlUYFdRv26hSLZDeNLVs4CFnhKChTa7hpy7P
	fGWXYUwYTdCq5ZJ3poWYM5A6cDtkoI0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749029361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KQVe86AdT0obGtmdPTY5Qchp+PcOpudkbQHVBz/9Ut4=;
	b=Cz0D/5tsLgiSq6JFXR88+SWTlR5HT6F2S+xdG7BU0pVS6b04mkRHvaq83zpt/Bw8LCTbMR
	0y/NS8Dhbq8KksMoETxi/kMr8On2cSQw/dDlUYFdRv26hSLZDeNLVs4CFnhKChTa7hpy7P
	fGWXYUwYTdCq5ZJ3poWYM5A6cDtkoI0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D9FA1369A;
	Wed,  4 Jun 2025 09:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U73sBvERQGiYEwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 04 Jun 2025 09:29:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3 v2] Switch to on-stack variables for block reserves
Date: Wed,  4 Jun 2025 11:29:18 +0200
Message-ID: <cover.1749029179.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The block reserve structure is small enough to fit on stack so do that
in a few functions and avoid allocation.

v2:
- drop patch replacing allocated reserve in relocation, crash in btrfs/190
- v1 https://lore.kernel.org/linux-btrfs/cover.1695408280.git.dsterba@suse.com/

David Sterba (3):
  btrfs: use on-stack variable for block reserve in btrfs_evict_inode()
  btrfs: use on-stack variable for block reserve in btrfs_truncate()
  btrfs: use on-stack variable for block reserve in
    btrfs_replace_file_extents()

 fs/btrfs/file.c  | 29 ++++++++++++-----------------
 fs/btrfs/inode.c | 47 ++++++++++++++++++++++-------------------------
 2 files changed, 34 insertions(+), 42 deletions(-)

-- 
2.47.1



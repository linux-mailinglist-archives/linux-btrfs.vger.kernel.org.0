Return-Path: <linux-btrfs+bounces-9222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90309B58DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 01:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623261F219DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 00:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B55538F91;
	Wed, 30 Oct 2024 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WiJQs2XO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WiJQs2XO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65649224EA
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249786; cv=none; b=AiNUE1IMcT3Im7r549NjLtFZTfeEIAoWu5zCU+ISRcsWUL/SCi/0E0OayEN1b0f5Eb2DuuGPRpl3HTHMIuRey5eq/lRkw20LGWg/BuGw3Mmi/gwjQeDf0t77oGw//8E/2yx8ulkKPrfZcNe96jlr7vi6l/hJNSTh/OIIuuPxcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249786; c=relaxed/simple;
	bh=5SiG3dBIP4GW1ejlTWC4HDWvs7KXYo2+CrZGGGhYDs8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o1NUPPUEyZk97Kt9CfzOfw0y0oOdN4Ja9aWs0T3MpUeSlA/3mw27u23rLlHPqg3kIAWdrvhiRbPm3f6MaaoUssPjRiw36scSHxO5NaKXkCNOVf5dWLlgES8g69ELgAyNvs9+pWr3cL0wB+p0Lv58sz6kpxauDdBcAq9BKooSjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WiJQs2XO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WiJQs2XO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6243021DB0
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730249782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LcAmRz1d1jX2lxeaE5J4dSQTjip+DghZUHzn4ecETN0=;
	b=WiJQs2XOJgYqFoOiBR8yVH7BAhkPTUlC63yZSp+Rr0XSU3BXCU4C0XsNgeldf8Dni5oaqa
	fEdyXojYLJKcaEXpJWuDop77OfEmEqTKxrZDqm1aJH3FIhqP5u9glh0IUrfeSrECtwbgyR
	lkL+IOpjqL80EtAKx1rclQ9gFZuZPD8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730249782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LcAmRz1d1jX2lxeaE5J4dSQTjip+DghZUHzn4ecETN0=;
	b=WiJQs2XOJgYqFoOiBR8yVH7BAhkPTUlC63yZSp+Rr0XSU3BXCU4C0XsNgeldf8Dni5oaqa
	fEdyXojYLJKcaEXpJWuDop77OfEmEqTKxrZDqm1aJH3FIhqP5u9glh0IUrfeSrECtwbgyR
	lkL+IOpjqL80EtAKx1rclQ9gFZuZPD8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FDE9136A5
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ad8AEzWEIWdJJAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2024 00:56:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fixes for the new fd-based API
Date: Wed, 30 Oct 2024 11:25:46 +1030
Message-ID: <cover.1730249396.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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
X-Spam-Score: -2.80
X-Spam-Flag: NO

There are two critical bugs, all introduced by the same new fd-based
mount API migration.

The first one will break the per-subvolume RW/RO mount, if using the
new fd-based mount API.
This is caused by the untrue promise that the new API will not set the
RO flag for the fsconfig() call (which sets the super flags), but only
set RO attribute for the mount point.

Based on the bad promise, we skip the RO->RW reconfiguration for the new
API based mount call. But since the new fd-based mount is already
rolling out to the end users, and it still sets RO flags for both super
and mount point.

So we should still do the same RO->RW reconfiguration, no matter the
API.


The second one is a long existing problem related the RO->RW
reconfiguration itself, where we retry without any lock, resulting race
between reconfiguration and RO/RW mounts.

This will leads to a failure to mount, exposed by SLE-micro bug report.


Those two bugs are all small but critical to the core function of btrfs,
thus should be queued for -rc kernels.

Qu Wenruo (2):
  btrfs: fix per-subvolume RO/RW flags with new mount API
  btrfs: fix mount failure due to remount races

 fs/btrfs/super.c | 88 +++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

-- 
2.47.0



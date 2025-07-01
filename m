Return-Path: <linux-btrfs+bounces-15173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F26DAF01AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FF344566F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120727EFEE;
	Tue,  1 Jul 2025 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N5yD5zMC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N5yD5zMC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4F1F0E4B
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390641; cv=none; b=ALkB/lWjuuJeWM9XPvHbDVN6q49gqGcOPGdWfZrIF2+XiQyhk5CHXcNYUkqrjuop2sJVCbFZqpjOIzKGF2swTyLEDkdmr9tT0Kl2o2rdUo8zdA8cat4Cg3DUY1ApmSOCVxdzF1WevoJlIXKQHhL+cVP1YGdp5drurHIAReBPJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390641; c=relaxed/simple;
	bh=AJcMoUZa+Te/oGuYaK/Jcmva/V7/qUARYj7YFaks0mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJ1t8QTLovIkmcD7AXQpxD7qfB8PD3eUHdOEFa+mOxZqyFHC8xKP06ErwHxDmg5RL+s1r5ZNhoBVI5Vbmk/1MBRv6YHoM0dPxENM2A4i8jK7CL9TRhq97tnOhMTk7Cm5XEj251HPUnEKzDfwNiPUUWv4tWROn23S7C25ZguWZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N5yD5zMC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N5yD5zMC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 301372117F;
	Tue,  1 Jul 2025 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fL8iBC+9VmD6OyXlODngzvJ0XC7SbXH4MA69cR70ijs=;
	b=N5yD5zMCuAYB38fWE/LO+mMf9EVwSoxqr8s58J0UQu9xUzg2bEcA4P/7f97gKp53NyPu7o
	SvK40RLPO/hfvoC7/PHjA8/B4dFVSIscr3CLfK7nw0hRDprF1nwlaUU7/5ijeCtgexQBpE
	Xej6dug336nm1k5Zzssq7S6ldgR5ucU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N5yD5zMC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fL8iBC+9VmD6OyXlODngzvJ0XC7SbXH4MA69cR70ijs=;
	b=N5yD5zMCuAYB38fWE/LO+mMf9EVwSoxqr8s58J0UQu9xUzg2bEcA4P/7f97gKp53NyPu7o
	SvK40RLPO/hfvoC7/PHjA8/B4dFVSIscr3CLfK7nw0hRDprF1nwlaUU7/5ijeCtgexQBpE
	Xej6dug336nm1k5Zzssq7S6ldgR5ucU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29B3C13890;
	Tue,  1 Jul 2025 17:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wc0oCq0ZZGgsRgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Jul 2025 17:23:57 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/7] Set/get accessor speedups
Date: Tue,  1 Jul 2025 19:23:47 +0200
Message-ID: <cover.1751390044.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 301372117F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

Followup to [1] bringing refactoring that allows compiler to do more
optimizations and stack usage reduction. As the set/get helpers are
heavily used in many functions this improves performance. I will provide
some numbers later as I've done mostly functional tests. During the
development I've identified a few more possible optimizations to improve
performance, but this series is OK as is.

Overall effects of this series:

Stack:

  btrfs_set_16                                          -72 (88 -> 16)
  btrfs_get_32                                          -56 (80 -> 24)
  btrfs_set_8                                           -72 (88 -> 16)
  btrfs_set_64                                          -64 (88 -> 24)
  btrfs_get_8                                           -72 (80 -> 8)
  btrfs_get_16                                          -64 (80 -> 16)
  btrfs_set_32                                          -64 (88 -> 24)
  btrfs_get_64                                          -56 (80 -> 24)

  NEW (48):
	  report_setget_bounds                           48
  LOST/NEW DELTA:      +48
  PRE/POST DELTA:     -472

Code:

     text    data     bss     dec     hex filename
  1456601  115665   16088 1588354  183c82 pre/btrfs.ko
  1454229  115665   16088 1585982  18333e post/btrfs.ko

  DELTA: -2372

[1] https://lore.kernel.org/linux-btrfs/cover.1751032655.git.dsterba@suse.com/

David Sterba (7):
  btrfs: accessors: simplify folio bounds checks
  btrfs: accessors: use type sizeof constants directly
  btrfs: accessors: inline eb bounds check and factor out the error
    report
  btrfs: accessors: compile-time fast path for u8
  btrfs: accessors: compile-time fast path for u16
  btrfs: accessors: set target address at initialization
  btrfs: accessors: factor out split memcpy with two sources

 fs/btrfs/accessors.c | 84 +++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 33 deletions(-)

-- 
2.49.0



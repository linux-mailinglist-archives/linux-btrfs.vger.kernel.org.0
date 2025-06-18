Return-Path: <linux-btrfs+bounces-14763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F22ADE99D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C10189537E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4728C029;
	Wed, 18 Jun 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vGeHLoyC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vGeHLoyC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368E288503
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244995; cv=none; b=VgPiwkPoZCHOZtQ+kC8MzJnLGX6Ye+Lv9NQFx4i8TaWlQKxqNTzZ4B/vyYRk3ieOtC4DsMHiX6GdIxTWU8sZvzG9c7i5GhDIxTjF1up3IaemQh4nYWwW5+XqdhX1m1BHbQTXhxOjFKdZvaPn+/B8bX6Q0BghDxJXczCPf8raCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244995; c=relaxed/simple;
	bh=Iv5LgEIAV6KnMPFtZHi33A1kYrH1/EyCFbqgztgW1ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBOheK103sbOV/bdvdDlPQAn/VKM1HiGay8AphnAbDILazvYAPGh/noByq0Ulx/inDCXA9zJim8vPT4JVsdz6mfn+nF6YawE5nDhJa9Fg/EviPFTken5dLQDwzJ2BGCBacb7pa8Txjuq/SuAq+a0dtyWZaYPlU4x0KFEoG9N4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vGeHLoyC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vGeHLoyC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 776742121C;
	Wed, 18 Jun 2025 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750244991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Nyui4v3sNnWwbeK7Y1I3EJ260PTwAr/xPdzRiY94qbQ=;
	b=vGeHLoyCoGZIby+4zYTw6y4aoPoM3c1Wg/LEMk6EP/KedbHWisgiIhDf1fUualXf9eWUEV
	WwsAFBzfU7MJxUXYdFgbvbcvyUHufXVymqrxZf33RxRZsjxi8qhv3z9XGp2ZD6lXFjRGBl
	4vSBdwgSS2KMlqaNPcXj0uqDI8gvP2Q=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vGeHLoyC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750244991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Nyui4v3sNnWwbeK7Y1I3EJ260PTwAr/xPdzRiY94qbQ=;
	b=vGeHLoyCoGZIby+4zYTw6y4aoPoM3c1Wg/LEMk6EP/KedbHWisgiIhDf1fUualXf9eWUEV
	WwsAFBzfU7MJxUXYdFgbvbcvyUHufXVymqrxZf33RxRZsjxi8qhv3z9XGp2ZD6lXFjRGBl
	4vSBdwgSS2KMlqaNPcXj0uqDI8gvP2Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DCC313A3F;
	Wed, 18 Jun 2025 11:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xXJ9Gn+eUmj4OAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:09:51 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Device name and RCU string
Date: Wed, 18 Jun 2025 13:09:40 +0200
Message-ID: <cover.1750244832.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
X-Rspamd-Queue-Id: 776742121C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

After recent simplifactions of the RCU usage in messages, this pathset
implements the RCU protection directly without the RCU string so this
API can be removed completely as we don't have nor plan anything else to
use it for.

David Sterba (3):
  btrfs: protect reading device name by RCU in update_dev_time()
  btrfs: open code RCU for device name
  btrfs: remove struct rcu_string

 fs/btrfs/rcu-string.h | 40 ----------------------------------------
 fs/btrfs/volumes.c    | 35 ++++++++++++++++++++---------------
 fs/btrfs/volumes.h    |  6 +++---
 fs/btrfs/zoned.c      | 23 +++++++++++------------
 4 files changed, 34 insertions(+), 70 deletions(-)
 delete mode 100644 fs/btrfs/rcu-string.h

-- 
2.47.1



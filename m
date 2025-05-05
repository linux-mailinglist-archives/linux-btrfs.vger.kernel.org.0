Return-Path: <linux-btrfs+bounces-13648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F42AA917C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 13:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15FD1758B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 11:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0894E1FF7CD;
	Mon,  5 May 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TTx4JClg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TTx4JClg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EE33E4
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746442895; cv=none; b=BAi1UwTr8uJ6yMB7J6bW+BmJ2rNLDfxLtJmA7wcPlFu5KtCbjtL+6GEcDp4+Z8I1QJ/dvCWI++TAowEpGgYB2PWGd1HePmnjasVPtCqOo86VIEVsTxnv0tcDtMlQRJIOMRPXK3NX4dNJmg7kF1ydX5hQA28FvVOTz+0y/OkirYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746442895; c=relaxed/simple;
	bh=lO9GYOvvCaHNT8R0GPcHBDTxo4r0yn4V0aFbjU8NYME=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ToauaId/ONPeCKtNsnIbOx5mCcdIj58qd3obUKpuecrdm1xB4c9RQUyeRjs3aKwNrBAOANFWZxXNS/RdV0OKzbm2J9cWqNXorR7JNHVXzZCQejqmMXuEmRNs5FUV2oVnaHZrjXFgKWGLqQ/wfjpYVX5PWUUgTc+gqf91JLDJtME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TTx4JClg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TTx4JClg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 369A61F453
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746442891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iyr/zOySK+HNS7oXhqynkbkIU/DaFE+eLjG1Vjt9YhQ=;
	b=TTx4JClgpehj9VuetwUErABubkA8Leb5C9ZWiHgnEsLvCNbKFaTD/HjUM/qgVBZkmpXc3M
	TR+I/TX9BhmJQM05dFo8pByNIr1HNpTzo6XvTJ8GzzDZ52NarN59MMDYzcmc9Av9FB4CJ8
	R1xgTA7YTjWyRcU2X+vt5NnT45I1lE4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=TTx4JClg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746442891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iyr/zOySK+HNS7oXhqynkbkIU/DaFE+eLjG1Vjt9YhQ=;
	b=TTx4JClgpehj9VuetwUErABubkA8Leb5C9ZWiHgnEsLvCNbKFaTD/HjUM/qgVBZkmpXc3M
	TR+I/TX9BhmJQM05dFo8pByNIr1HNpTzo6XvTJ8GzzDZ52NarN59MMDYzcmc9Av9FB4CJ8
	R1xgTA7YTjWyRcU2X+vt5NnT45I1lE4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 732C51372E
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 11:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bTGTDYqaGGg/CAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 May 2025 11:01:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: scrub: reduce memory usage for each scrub_stripe
Date: Mon,  5 May 2025 20:31:02 +0930
Message-ID: <cover.1746442395.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 369A61F453
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The first patch fixes a scrub error reporting bug that metadata bytenr
mismatch is reported as csum error, not a metadata error.

The second patch reduces the memory usage of each scrub_stripe by 24
bytes (on systems with 64 bits LONG), this is done by aggregating all
the small bitmaps (at most 16 bits, as we can have at most STRIPE_LEN /
blocksize blocks per stripe) into a larger bitmap.
Just like what we do with subpage helpers.

This will introduce a lot of small helpers:

- Set/clear bitmap range
- Set/clear/test single bit
- Bitmap weight
- Bitmap empty check
- Bitmap read
  The last one allows us to read out a unsigned long and use it for
  various bitmap operations directly.
  In fact the above weight/empty are just a wrapper around the read
  helper.

Those helpers are small enough thus can be inlined, this will slightly
increase the overhead but saves 24 bytes per scrub_stripe, and we have
128 scrub_stripes for one device, saving around 3KB for scrub/dev-replace
per device.

Qu Wenruo (2):
  btrfs: scrub: fix a wrong error type when metadata bytenr mismatches
  btrfs: scrub: aggregate small bitmaps into a larger one

 fs/btrfs/scrub.c | 287 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 196 insertions(+), 91 deletions(-)

-- 
2.49.0



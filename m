Return-Path: <linux-btrfs+bounces-19605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747BCB0AD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 193EB301C7F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D601329E70;
	Tue,  9 Dec 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RsjoKKFD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RsjoKKFD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB3329E58
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300290; cv=none; b=RWdPas4Zr7ASUJ1kyto/p3j2OtjKvV1R73DhVmN6Mc0Z6Zf80Jc80FVtc2LsqHWEyaJNBgCYtZdfvEEu4P/otdKKrWR1w7YVyn6pt58P/MvTo21WbqMqvmeS2F5P4L/CsZEAmBuHdkXHE2qba30tKrE0aJ5Xxfnn7QRxGifG7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300290; c=relaxed/simple;
	bh=OCqRavSYkjSkGLB7dVmITWo++BKnG2w4grvqKRMsu4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6hQfkCpl9jWRqTls4Fu8GJBPCmXgYp/V+PbTon5w7fCTxECQuRKCBRwy5yrrpAN3AAngSz9Xn1A+AYk92uFu5lL2oX0DJXUI2S+gXAIaqe3b72GE4XbyL7qPULkufo2blINxSWgC/ERvEVwYzT60SOVL4+SvIbVYLAQPTVx/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RsjoKKFD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RsjoKKFD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77C493375E;
	Tue,  9 Dec 2025 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765300286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IiussXFTvB6Ggo93UynoR3PVrEjFoqLn4eYsaDhRBls=;
	b=RsjoKKFDe3q1WLBwDaZ3/CE1jK2tS7RP/8Axji9Cni476Rv3bujPkMvxfMuJn+5j3trBCf
	iW1/qP9AJSP71pU1iSHoJ6RJ191Ixg7KHqA1dfqZquq0TPtVd+jOu7TAGS8hcE/mb8tEQO
	zyXJ71y4yreIUyjVh3k4VQaARqBfRO4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765300286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IiussXFTvB6Ggo93UynoR3PVrEjFoqLn4eYsaDhRBls=;
	b=RsjoKKFDe3q1WLBwDaZ3/CE1jK2tS7RP/8Axji9Cni476Rv3bujPkMvxfMuJn+5j3trBCf
	iW1/qP9AJSP71pU1iSHoJ6RJ191Ixg7KHqA1dfqZquq0TPtVd+jOu7TAGS8hcE/mb8tEQO
	zyXJ71y4yreIUyjVh3k4VQaARqBfRO4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71A743EA63;
	Tue,  9 Dec 2025 17:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id khO6Gz5YOGmuaQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 09 Dec 2025 17:11:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3] Simplify message helpers (avoid level parsing)
Date: Tue,  9 Dec 2025 18:10:29 +0100
Message-ID: <cover.1765299883.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Based on patch updating memcpy/strscpy use in printk level parsing
https://lore.kernel.org/linux-btrfs/20251130005518.82065-1-thorsten.blum@linux.dev/
it'll be better to avoid the parsing completely. This patchset updates
the internal interfaces and passes loglevel directly to the helpers so
we can print the description and pick the ratelimit state.

David Sterba (3):
  btrfs: simplify internal btrfs_printk helpers
  btrfs: pass level to _btrfs_printk() to avoid parsing level from
    string
  btrfs: remove ASSERT compatibility for gcc < 8.x

 fs/btrfs/messages.c | 26 ++++------------
 fs/btrfs/messages.h | 76 ++++++++++++++++++++-------------------------
 2 files changed, 39 insertions(+), 63 deletions(-)

-- 
2.51.1



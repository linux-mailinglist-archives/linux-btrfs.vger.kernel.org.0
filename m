Return-Path: <linux-btrfs+bounces-11782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD2A4480B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C92170912
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834B158520;
	Tue, 25 Feb 2025 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tGFd5zOp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tGFd5zOp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0A19E7F9
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504286; cv=none; b=Xt/43Lq5gxjMzaDAHGZ3VHs8nJmokV6aQOQZViaLoJF1hIefNMLQb94jzNcp/4L1F0fUYZFBktoAuSTreKWc4PEEs0KG41UPItedgOQ9+hCz1q8M4kQNXTp5EECEqPyRXb2C9i5+iksI2pXA0hmPrO3EvslyLAKsr2SP8kX06jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504286; c=relaxed/simple;
	bh=gAe8M0LdgB8nWwf6GaMGtFSE+NzDiv8RFDY2sjPO/Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xz1/L76t2RhoNBLq4X/I2t5ToJ1iYiUNsiUiZlWi4cIPRsl0uCCW3gBBpYVZvxi4BMf+TF/lqC7gfIxRzm9SLxvJ302vIx9yyGVFdbf3zAp2UelyoXAN3hSb/+DWIvbFZgzzAhe/rKmVQOLFYK1Q6TtELpqs4VP/qottegrgz8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tGFd5zOp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tGFd5zOp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 975A221170;
	Tue, 25 Feb 2025 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740504281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uf6scdzDS9HmAeYXwqXb44S/Vjv/XlZNLOz4UjnAXJo=;
	b=tGFd5zOpEEvs3591rQv8yU5FDnA9u6y7YhzOLJ2fzvhl/T9ypBwxKE9eqvvuIfs1tV0Dgs
	tDRp9ecMQXDFCdQ9xDOcMYjlu2MVER3lXL/2a+0kToO4ZjPjWi8h2giN3WBF7AXJvBJsxP
	LjccPbAAJeq+FlXHQJtC+kI+/Fdl2zM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tGFd5zOp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740504281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uf6scdzDS9HmAeYXwqXb44S/Vjv/XlZNLOz4UjnAXJo=;
	b=tGFd5zOpEEvs3591rQv8yU5FDnA9u6y7YhzOLJ2fzvhl/T9ypBwxKE9eqvvuIfs1tV0Dgs
	tDRp9ecMQXDFCdQ9xDOcMYjlu2MVER3lXL/2a+0kToO4ZjPjWi8h2giN3WBF7AXJvBJsxP
	LjccPbAAJeq+FlXHQJtC+kI+/Fdl2zM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 904E213332;
	Tue, 25 Feb 2025 17:24:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SpAyI9n8vWcDTwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 25 Feb 2025 17:24:41 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Page and folio count helper cleanups
Date: Tue, 25 Feb 2025 18:24:26 +0100
Message-ID: <cover.1740503982.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 975A221170
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Adding the __pure attribute to num_extent_folios() allows some
optimizations that can reduce stack space usage.

David Sterba (2):
  btrfs: add __pure attribute to eb page and folio counters
  btrfs: use num_extent_folios() in for loop bounds

 fs/btrfs/disk-io.c   |  3 +--
 fs/btrfs/extent_io.c | 48 +++++++++++++++++---------------------------
 fs/btrfs/extent_io.h |  7 +++++--
 3 files changed, 24 insertions(+), 34 deletions(-)

-- 
2.47.1



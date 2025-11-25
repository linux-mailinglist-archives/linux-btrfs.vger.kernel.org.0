Return-Path: <linux-btrfs+bounces-19329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A5EC83F30
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 09:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D323AAB79
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6A2D7DC1;
	Tue, 25 Nov 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oRftqGsv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oRftqGsv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777692D2391
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764058820; cv=none; b=T86FXg4lsoViRFQWFVhit+za11GoOxkl+B0Ai8aUOh+rn5XYcTOxuq889uMcgdCK7W/SybkvCeux+cO8YbGAcJK40kjNh0agwDJGeK8rga++XkaFLwTW7Oj7Glt6Lk1vYXuWt5eQgJSwHGKRWJlKrr+v0bAZ42UfAZIVt3XmAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764058820; c=relaxed/simple;
	bh=zeb7WZIZGtQYSSKmYd7k4oXnYh2hBdkKxcfsAL50zEw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZMgZiyUo3UJ96njI73MShrgH4xVnKvudfFJzoroZHzqJT4WakEAj+Hfq+YNiOE1Dv8k+jOrgbFGW75Km4aEg5ZAUJGbTa+ChhDU/ijSs+ksongCmv9dVOYWn9N2QExbItdlJTNdhVBiyVtSGtVagAtCKagh500Bp6sl0E1gaD2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oRftqGsv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oRftqGsv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49C915BD00
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764058816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HBgsZz2xFu0qZeReah5DBfFzupopBUyLw/TaRIShzoc=;
	b=oRftqGsv7LBksEfCEeHBzrJsAqZ9uBTH7mCHlYN7thVF378yZ/enTt2gXgjSir5XyW5CyU
	8eETo5piV9XT4EksRQUCN4XE9ZLeaWqQsVXFlnTeYm7Fp2M1W0P/Plyn/fLSKYCttqn4fn
	tHZSUPq8CK8v3QnvxPG5UY2r628fcFM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oRftqGsv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764058816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HBgsZz2xFu0qZeReah5DBfFzupopBUyLw/TaRIShzoc=;
	b=oRftqGsv7LBksEfCEeHBzrJsAqZ9uBTH7mCHlYN7thVF378yZ/enTt2gXgjSir5XyW5CyU
	8eETo5piV9XT4EksRQUCN4XE9ZLeaWqQsVXFlnTeYm7Fp2M1W0P/Plyn/fLSKYCttqn4fn
	tHZSUPq8CK8v3QnvxPG5UY2r628fcFM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 865263EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OVkqEr9mJWlRfwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 08:20:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: fix an on-stack path leak and migrate to auto-release for on-stack paths
Date: Tue, 25 Nov 2025 18:49:55 +1030
Message-ID: <cover.1764058736.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 49C915BD00
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

I thought patch "btrfs: make sure extent and csum paths are always released in
scrub_raid56_parity_stripe()" has already taught us that tag based
manual cleanup is never reliable, now there is another similar bug in
print_data_reloc_error().

This time it is harder to expose, as we always imply if the function
returned an error, they should do the proper cleanup.
But extent_to_logical() does not follow that assumption.

The first patch is the minimal fix for backport, the second patch is
going to solve the problem by using auto-release for all on-stack btrfs
paths.

Qu Wenruo (2):
  btrfs: fix a potential path leak in print_data_reloc_error()
  btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper

 fs/btrfs/ctree.h  |  5 +++++
 fs/btrfs/defrag.c |  5 +----
 fs/btrfs/inode.c  |  5 +----
 fs/btrfs/scrub.c  | 18 ++++++------------
 4 files changed, 13 insertions(+), 20 deletions(-)

-- 
2.52.0



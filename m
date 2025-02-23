Return-Path: <linux-btrfs+bounces-11722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9DFA41250
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 00:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335C21892A4D
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5D6EB7C;
	Sun, 23 Feb 2025 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pdUkhz6K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pdUkhz6K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326210E4
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354411; cv=none; b=apy9n0lw1G+36LzVh36K0jMOm+P7mquFY2QiGoM2mi0yuxELkZYbTP+W7L+Skks8/lk5MqUVGqIhBtepIu5M/4VboGj1mwTat31iPsJb0WBnEMnzv4ewQanvOMkyvREcYqbqXoAp5v9wYZ8m5H93cbbkla4Cw8/grParDHxA448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354411; c=relaxed/simple;
	bh=3l26eGp/ehVBElFMknCffi5DGLGi9F4Sq51C1ly5+1M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FfzacycMap0We36Kxh3/jU8RQTAUiHKZW38TDQNhFVaQJFffw3nkyvlzwfP7xNA1Lw4MOkZ6GP5V776oZCOVpIotysodT6lY27BtO1Gw7GWd08c1zeQDGIYo4pxeDGTucUuFOROFbyAipV0qQmiiuRY1S8tKq3N0fBMGLu6yZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pdUkhz6K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pdUkhz6K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5626D21170
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FpKIP2k6P0oR+pvCmhpgJR0NHnEDr6Pkkq8YSKwIIwg=;
	b=pdUkhz6K6pIElSlG8nhhyvSVet0Ap4yO9T4RxjMFonN21cPjCEzw+ioFHYwekNrIpIMaVT
	j3W4hbtgEzZpajR/1hIT2Byp+CM71pHlCxShhUow19PmSrPDLwLRzUdTUeRJWgmS1BjN7r
	RqsrtoS2mgPnjm2mE4ysCaO2DeK3eqU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pdUkhz6K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FpKIP2k6P0oR+pvCmhpgJR0NHnEDr6Pkkq8YSKwIIwg=;
	b=pdUkhz6K6pIElSlG8nhhyvSVet0Ap4yO9T4RxjMFonN21cPjCEzw+ioFHYwekNrIpIMaVT
	j3W4hbtgEzZpajR/1hIT2Byp+CM71pHlCxShhUow19PmSrPDLwLRzUdTUeRJWgmS1BjN7r
	RqsrtoS2mgPnjm2mE4ysCaO2DeK3eqU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EDE913A42
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mWulD2Czu2euTgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: make subpage handling be feature full
Date: Mon, 24 Feb 2025 10:16:15 +1030
Message-ID: <cover.1740354271.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5626D21170
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGLOG]
v1:
- Merge previous two patches into one
- Re-order the patches so preparation/fixes are always before feature
  enablement
- Update the commit message of the first patch
  So that we do not focus on the out-of-tree part, but explain why it's
  not ideal in the first place (double page zeroing), and just mention
  the behavior change in the future.

Since the introduction of btrfs subapge support in v5.15, there are
quite some limitations:

- No RAID56 support
  Added in v5.19.

- No memory efficient scrub support
  Added in v6.4.

- No block perfect compressed write support
  Previously btrfs requires the dirty range to be fully page aligned, or
  it will skip compression completely.

  Added in v6.13.

- Various subpage related error handling fixes
  Added in v6.14.

- No support to create inline data extent
- No partial uptodate page support
  This is a long existing optimization supported by EXT4/XFS and
  is required to pass generic/563 with subpage block size.

The last two are addressed in this patchset.

And since all features are implemented for subpage cases, the long
existing experimental warning message can be dropped, as it is already
causing a lot of concerns for users who checks the dmesg carefully.

Qu Wenruo (7):
  btrfs: prevent inline data extents read from touching blocks beyond
    its range
  btrfs: fix the qgroup data free range for inline data extents
  btrfs: introduce a read path dedicated extent lock helper
  btrfs: make btrfs_do_readpage() to do block-by-block read
  btrfs: allow buffered write to avoid full page read if it's block
    aligned
  btrfs: allow inline data extents creation if block size < page size
  btrfs: remove the subpage related warning message

 fs/btrfs/defrag.c       |   2 +-
 fs/btrfs/direct-io.c    |   2 +-
 fs/btrfs/disk-io.c      |   5 -
 fs/btrfs/extent_io.c    | 224 +++++++++++++++++++++++++++++++++++-----
 fs/btrfs/file.c         |   9 +-
 fs/btrfs/inode.c        |  34 +++---
 fs/btrfs/ordered-data.c |  29 ++++--
 fs/btrfs/ordered-data.h |   3 +-
 8 files changed, 239 insertions(+), 69 deletions(-)

-- 
2.48.1



Return-Path: <linux-btrfs+bounces-21540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMLgKu2/iWneBQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21540-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 12:07:25 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171910E81F
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 12:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E3293011776
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB93C36C0C6;
	Mon,  9 Feb 2026 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt/gYTss"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905B36BCF3
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770635235; cv=none; b=F7UZYchVe2uRYaZhJnljj+A+Uy5mswikvhXjvlSjzAmq2ZR4RD+DIFZ1BJ4p2pDOI3dJUvx0K9G3rSwgkj43m79AKj4p1Ann7aumLusaj7WU8qzdPDdlH8evdkdtMomaHTdpHxG8yT1DI2psSfJUMC0XfnRpnAhsOoW9aDgs76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770635235; c=relaxed/simple;
	bh=GKc+L+cFLPqy7eXsdGv7HVxesGC32OYB3Ty2NNP1Kc0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kRkeOePr4yJLcEObNhh8XTNF1Metb5STPBkNlEx2Bkp3Bo+ojlA0WUPP2zhzZkEml3P6ybI83CPCE1iaiOgrMKP/yBaKtZSlORBWNgWNq/2hJpdVAN6L4MbSP/XeUCWRSOVW5pRH5YxhRHHu2raSFE9BtN0WyewRLRVfmBHRNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt/gYTss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259CAC116C6
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770635234;
	bh=GKc+L+cFLPqy7eXsdGv7HVxesGC32OYB3Ty2NNP1Kc0=;
	h=From:To:Subject:Date:From;
	b=Vt/gYTssDlRQq+tnXMXoVVdy00r2uhPxEePCXrYZICJpIm2435WvJ3EzmxCDh8vtK
	 5ecyUlaQq28AJrEgq3syoCrIlRdJJo+rl99IjHcfvdx11ye/MWh5gIFlOv84cNcXJR
	 kgp5Y/0/edDQg9jElReq6XvLgivQdgVgZLzZAr1n/ka6PFbdKvMomKKefpOOpd1OM6
	 SSaPijlNuyqReYEIgss/nC51mGDCq8M6YUunQxRYMVwvdX08BrLZKaSA3wfwi+JxeV
	 Wxty62gkEW8MIlhTnX2MWmXWQflU489wDJMEgZYv+9RnsbvOJpy5Rr8TAfmqwg4JXc
	 fYS5RNwfGd1Rw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: remove stale code in read_tree_block() callers
Date: Mon,  9 Feb 2026 11:07:09 +0000
Message-ID: <cover.1770634919.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21540-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3171910E81F
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Details in the change logs.

Filipe Manana (2):
  btrfs: use the helper extent_buffer_uptodate() everywhere
  btrfs: remove redundant extent_buffer_uptodate() checks after read_tree_block()

 fs/btrfs/backref.c      | 10 ----------
 fs/btrfs/ctree.c        | 13 ++-----------
 fs/btrfs/disk-io.c      | 10 ----------
 fs/btrfs/extent_io.c    |  6 +++---
 fs/btrfs/extent_io.h    |  2 +-
 fs/btrfs/print-tree.c   |  4 ----
 fs/btrfs/qgroup.c       |  4 ----
 fs/btrfs/relocation.c   |  5 +----
 fs/btrfs/tree-mod-log.c |  8 +++-----
 9 files changed, 10 insertions(+), 52 deletions(-)

-- 
2.47.2



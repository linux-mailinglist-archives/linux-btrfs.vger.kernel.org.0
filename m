Return-Path: <linux-btrfs+bounces-15663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1FB11725
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 05:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17031AE2E30
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 03:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0F238D52;
	Fri, 25 Jul 2025 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nv3vI1e7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Nv3vI1e7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39022ACEF
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414872; cv=none; b=LUsXZgg2L8Oell1sjr2xQacSPUYK7Tw7HpiY4y2v0923K65O5UhXELA3w/e0gz2iTK90269YZQNwAkqMv5BmJuSszyB0d52jug+ub9bQv1kNF3vGaafLPvdDwvM7D/XejxKYqtOZEW9U8V9jLbjSL3mhACdItRJqmkSLqSDH49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414872; c=relaxed/simple;
	bh=xyvK5sTALn41ONTHySTJkzco73F0C+3T7Bc+dT/Q/RE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hp0A0OLANKYiB/wB8q99RUVACmITm+f0Mvx0wq1VPF8AtEePsvKk6/Iz06ePkk0n1I226qD2KJLPlSKhV/z013jTuFb2MQP+98dh843qUBDbpwb4qbAhBy4SJGOkH6HY727jJV1OAtzjUDoSnEb7Jke/3jD0V7hf4hMXnTSexU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nv3vI1e7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Nv3vI1e7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A43D219C4
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753414862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dDPCUSFU+ieaE3hLkUIdQr99oLxZtmltYWEDHH6rarc=;
	b=Nv3vI1e7nvk96bZ93NCuRzwebL8PjvnDaVdp5mElqvhllULPtp3IUCArLzHGTSzPxWsbNs
	AfoQUKsEUdoSLia5pIbQgfE5nNWmp1lnZhBm3nueLfPHTs3gLQhsES5MDSB9lMPR3cEsW1
	bDpSaOfTxgqly6OVyYV93JRX9yvd2/o=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753414862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dDPCUSFU+ieaE3hLkUIdQr99oLxZtmltYWEDHH6rarc=;
	b=Nv3vI1e7nvk96bZ93NCuRzwebL8PjvnDaVdp5mElqvhllULPtp3IUCArLzHGTSzPxWsbNs
	AfoQUKsEUdoSLia5pIbQgfE5nNWmp1lnZhBm3nueLfPHTs3gLQhsES5MDSB9lMPR3cEsW1
	bDpSaOfTxgqly6OVyYV93JRX9yvd2/o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7BF2134E8
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PQteHs38gmjbDQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: check: add detection for missing root orphan items
Date: Fri, 25 Jul 2025 13:10:40 +0930
Message-ID: <cover.1753414100.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

There is an internal bug report that some half-dropped subvolume makes
balance to fail.

It turns out that, the involved subvolume doesn't have an orphan item,
this means the half-dropped subvolume is never going to be cleaned up.

Then at balance time, a reloc tree is created for that half-dropped
subvolume, and since balance doesn't expect to get a half-dropped
subvolume, it doesn't check the drop_process_key and increased ref on
already dropped nodes.

The problem for progs is that, neither original mode nor lowmem detects
this kind of problem.

Original mode has a bad logic which prevents us from calling the proper
orphan item check.
Lowmem mode doesn't even take orphan item into consideration.

This series will add the detection part for btrfs-check, for both
original and lowmem mode, with a hand crafted image for test.

Qu Wenruo (3):
  btrfs-progs: check/original: detect missing orphan items correctly
  btrfs-progs: check/lowmem: detect missing orphan items correctly
  btrfs-progs: fsck-tests: a new test case for missing root orphan item

 check/main.c                                    |   3 +--
 check/mode-lowmem.c                             |  11 +++++++++++
 .../066-missing-root-orphan-item/default.img.xz | Bin 0 -> 13468 bytes
 .../066-missing-root-orphan-item/test.sh        |  14 ++++++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 tests/fsck-tests/066-missing-root-orphan-item/default.img.xz
 create mode 100755 tests/fsck-tests/066-missing-root-orphan-item/test.sh

--
2.50.0



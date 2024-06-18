Return-Path: <linux-btrfs+bounces-5780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84D90C404
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 08:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83063B21376
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A4C6BFA6;
	Tue, 18 Jun 2024 06:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BgF2oh52";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BgF2oh52"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059781B813
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693475; cv=none; b=Mf6l4LslzAl+XTMdp9xr3Mz3C0A/ofHfY5BFhhzqThRckipEqvIyfeLiRobCLBpZU2V+lKWgP/qSeykOtmg0FBtXWVHCUS87lXOv5d8jNfNitRQszLwpUk7xFnWI+7azs1y8DcrHafUAG4hCm87Ry4Bw5NSSdtgGldiYIpz9yLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693475; c=relaxed/simple;
	bh=R8TxbeetgFM5hxSpT8lc8RznaeX8iUbTM47AG0vOQ08=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cuaAR9sMicNaR6ubKT7FgpXj4fE97DFUzingk8G7deAAHvneXLxYXqJ4rkdVRRxjle8vcxSeStCP1+vpfolC4p/H6r7rL/+X3b3uvPBhN12rHA4RcwEoUHvVkkHmklSTYDMUqQ70yKXZdPGsJG0WDYy9TNUdTDrbF7ONN2deiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BgF2oh52; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BgF2oh52; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B27C22804
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718693472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8qrfK02z01LWUjv+eAjOYhgc2v9jRPgEDuq5QoQgNl4=;
	b=BgF2oh52pIPwGw6RZOLYqh9yeIp2JpxpbVV6yrgfTeDX0UN1Y6ZkViRpthiW4BMfeBVRZj
	mB5/N5b8cfjXD5gnybT/pZaLTcG+uktZRFn1Yj7GaTCMblRKGFXUuOCcNfv0OSrIvdlYDQ
	dGnjA1YiQl60dk/VyWfZRS9gvqtPdZs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718693472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8qrfK02z01LWUjv+eAjOYhgc2v9jRPgEDuq5QoQgNl4=;
	b=BgF2oh52pIPwGw6RZOLYqh9yeIp2JpxpbVV6yrgfTeDX0UN1Y6ZkViRpthiW4BMfeBVRZj
	mB5/N5b8cfjXD5gnybT/pZaLTcG+uktZRFn1Yj7GaTCMblRKGFXUuOCcNfv0OSrIvdlYDQ
	dGnjA1YiQl60dk/VyWfZRS9gvqtPdZs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4821A1369F
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VaxLO14ucWZ+ZQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 06:51:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fix csum metadata reservation and add a basic test case for itb
Date: Tue, 18 Jun 2024 16:20:47 +0930
Message-ID: <cover.1718693318.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.35 / 50.00];
	BAYES_HAM(-1.55)[92.09%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -1.35
X-Spam-Level: 

The current csum conversion is using an incorrect parameter for
btrfs_start_transaction(), which is 16K times larger than the expected
metadata space, thus it always fail with -ENOSPC.

Fix that first, then add a basic test case using the same populate_fs()
from convert test cases, and iterate through all the support csum
algorithms.

Qu Wenruo (2):
  btrfs-progs: change-csum: fix the wrong metadata space reservation
  btrfs-progs: misc-tests: add a test case for basic csum conversion

 .../064-csum-conversion-basic/test.sh         | 32 +++++++++++++++++++
 tune/change-csum.c                            | 22 +++++++++----
 2 files changed, 47 insertions(+), 7 deletions(-)
 create mode 100755 tests/misc-tests/064-csum-conversion-basic/test.sh

--
2.45.2



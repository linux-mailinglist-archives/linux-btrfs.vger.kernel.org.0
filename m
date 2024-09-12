Return-Path: <linux-btrfs+bounces-7961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BDD9764BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 10:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7359B23BCF
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398B18FDCD;
	Thu, 12 Sep 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZR2HtCnh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZR2HtCnh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C229118BBB6
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726130383; cv=none; b=fbyjz87G1xv1teDtkzZ+arE/BL3R4PCPS9qClqrUGGP21JTMpdLH7NrbECI+HiuKS0IniQg5xiwyhLi9lSbNK+/4bHaljDvZfTrPaq6vcWLnqnt1EHfCpGg5qKvt+AEhAnXsFEHx+6g6kcE41UmGvklT50Vp+ik6bZu8iTSi4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726130383; c=relaxed/simple;
	bh=usWdcLChKOB+yWI+MJCDYpwVnn5P5oJYS+U5TF4IeUc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ElrUczfcrI11kv1jyliLFMrkqve4J+xQHfapAe1zrZJLeGS6qMhTjRKcjDYWpfErpJKnlR69No2XT+dL4WwSzAmywtwwW48ioXhhtwaD4P29Y9HEnHg+3HOyxH4ZJmwLLOuDdShu3yTozYWPPnfE+DETv2pcVJcEb5etHm02hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZR2HtCnh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZR2HtCnh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0163F1F749
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726130379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xPJMxvYPye4dKTWtwNuExzT9XoQIcVoPEcOD7mFiQDM=;
	b=ZR2HtCnholM1/2k51uQOOyLGM759/0h5Wi4fLWWuSdlvEcqcP/W1e6aGqdj5N4UNkHVGlj
	OrpxHDPD9+dWWvuRKmTdzLBcTfcF92Ut4MkDRYvGzF1a27R3YrhazFsd/dHE+l8fvYOCQZ
	fgGsprI/BhVRV6JkvU1XhOAO8xAm3jQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726130379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xPJMxvYPye4dKTWtwNuExzT9XoQIcVoPEcOD7mFiQDM=;
	b=ZR2HtCnholM1/2k51uQOOyLGM759/0h5Wi4fLWWuSdlvEcqcP/W1e6aGqdj5N4UNkHVGlj
	OrpxHDPD9+dWWvuRKmTdzLBcTfcF92Ut4MkDRYvGzF1a27R3YrhazFsd/dHE+l8fvYOCQZ
	fgGsprI/BhVRV6JkvU1XhOAO8xAm3jQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 372B513AD8
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gu/fOsmo4ma5EQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2024 08:39:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: check: report deprecated inode cache as errors
Date: Thu, 12 Sep 2024 18:09:18 +0930
Message-ID: <cover.1726130115.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

There are two reports that inode cache is causing kernel to reject those
data backrefs.

It turns out the long to be deprecated inode cache is biting us
unexpectedly.
(And the design of those special inodes has no intention to properly
fill its members like mode and transid correctly).

However the original mode btrfs check is not updated to detect them, in
fact there are special hacks to not report them as errors.
Meanwhile the lowmem mode immediately picks them as errors from day one.

The first patch fixes the original mode to report inode cache as error,
and add extra messages on how to properly fix the problem using 'btrfs
rescue clear-ino-cache'.

The second patch is a new test case for both modes of btrfs check.

Qu Wenruo (2):
  btrfs-progs: check: detect deprecated inode cache
  btrfs-progs: fsck-tests: add a test case with deprecated inode cache

 check/main.c                                    |  12 +++++++++---
 check/mode-lowmem.c                             |   9 +++++++++
 check/mode-original.h                           |   1 +
 .../4k_nodesize.img.xz                          | Bin 0 -> 17320 bytes
 .../064-deprecated-inode-cache/test.sh          |  14 ++++++++++++++
 5 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 tests/fsck-tests/064-deprecated-inode-cache/4k_nodesize.img.xz
 create mode 100755 tests/fsck-tests/064-deprecated-inode-cache/test.sh

--
2.46.0



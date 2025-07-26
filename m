Return-Path: <linux-btrfs+bounces-15689-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0627B12CF8
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 00:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348777A7A01
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0F3219317;
	Sat, 26 Jul 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Vx24f48K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WjMhynjg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDBA262BE
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569215; cv=none; b=IjHvKdX2BRYFGexIR1/pdts3U/YUB2KuEMw1XTFKY9/AB8rwARgTezOnO3tCJ4mL/UBX7myxSRbUAnEab8lFucVuoLR2OQDtf51INhnTfRLOnQxeBrGMb+PwH7RTPGJ7dQgs6VvUHOIxM00dmgEZvMWXD7bIxuN2GVwbQhTU23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569215; c=relaxed/simple;
	bh=s9BYf72jpmFKKWpd7LKPL7ed9FZ6nEg4bXOwv737pnU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fD+IU5tOaMi0wOo3H1ic5jpQyrsQVuApJvQtkGv/z94f2eTRgB5qHIab54LjBXBC8p8JhZir5ZIS2ROqO8/KOPwl6nqy+KTjRVgtxlcD/wJqsmdILdyJXorcKoddAK/7dOXJLh94dgEMqdDkxohXzQGmxQe309Bl1TR7rMXMn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Vx24f48K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WjMhynjg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD8A01F38D
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753569205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=laiBiiTpy9M3zhW3hGVIjQfksJmbid1l1f485tvHyLs=;
	b=Vx24f48KWpmX5nvWUhEcM2YsSXmhsB724c3l/hlaY5Xw1KNbMtEFnAlU1hwya15MX8AIZV
	0stF2WY7AhP+L1/xCuBTA9vnuQGW1i5BNr1loQnd7kyxrJK0XbOD1HJy+3SsacjWXEZvea
	lZZgeCXadS9I/4usOU46fo5ekfSvcag=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753569204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=laiBiiTpy9M3zhW3hGVIjQfksJmbid1l1f485tvHyLs=;
	b=WjMhynjgriMvfxJ4OA1ypkOnxDJFLwOzHrnRk2BscMqsJDAkZYdlR/yINHglaStWTDu4tA
	Yd8kzXlo+Zs4x1D8D14Au7jPnyAOM0PNeQ32NzRhfalSpGWqDFVYvF17nbd6lvLDBEh3vC
	hxGA/47sImklve+ArCnK0ZI72dSRt8A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 195E51388B
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SXpwMrNXhWjWLAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs-progs: check: add detection for missing root orphan items
Date: Sun, 27 Jul 2025 08:02:59 +0930
Message-ID: <cover.1753569082.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[CHANGELOG]
v2:
- Enhance the original mode to detect any refs mismatch
  Thus even if the root item has 0 refs but we find some unexpected
  backref, then it will also report it as an error.

  Thanks Boris for point this out.

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

 check/main.c                                  |  39 +++++++++++-------
 check/mode-lowmem.c                           |  11 +++++
 check/mode-original.h                         |   3 ++
 .../default.img.xz                            | Bin 0 -> 13468 bytes
 .../066-missing-root-orphan-item/test.sh      |  14 +++++++
 5 files changed, 51 insertions(+), 16 deletions(-)
 create mode 100644 tests/fsck-tests/066-missing-root-orphan-item/default.img.xz
 create mode 100755 tests/fsck-tests/066-missing-root-orphan-item/test.sh

--
2.50.1



Return-Path: <linux-btrfs+bounces-14757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0AFADE2FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 07:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0EF1898B1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 05:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930561F4717;
	Wed, 18 Jun 2025 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n8M/fiL9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n8M/fiL9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1943A1DB
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750224244; cv=none; b=MpQDoqHQJfqirctp9uSqC/arQsIHCGx24cLNME3Wqg66XaEmRyrGVZceZLK8PexlpBCIyhbkcwHiwt4s/i7eSZ9D8b4UZSe40vLUrIqqxmPC2u70seL3/ftFjVmCU9ax4cHFot2oo3OoBTGBENCWeZIoB6/3XPh87X8KDnUETis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750224244; c=relaxed/simple;
	bh=dKgMVurIEn11HzVjJLOeH5ie3d3l+4iP5Br8ocysrRg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ke9PAo14uzzwit1IMxk7E+ITU9+YbjvgfVT8d+lrAwNUoHzIVdzjgK62MaK2uOwLKVVzevh3Owd4kokqv147SvzGnVjkywuNHvQcygdRAwL5zku47OyQcPIsA7EfB3pvFrUGZsJbRMBdlLgmsAYDO46HMQcCOWwG/61wi6OsJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n8M/fiL9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n8M/fiL9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 435AF1F7B4
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750224240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Iz7iXQj428Hpd++COs1vlDPkvQY2BqAqBLkA5Awzunk=;
	b=n8M/fiL99KIdn0uEWfoRbmY5DwA6owa3TYAtWry6X3lc1/Dh6AIGkNNNU9yomJiVBbEho6
	hNm6h+1zKsHzBHlCvICyuZygJvLoyDzz0CaH6+gZpQ3818uAElAuzCQ1EQ5L4idGgIwOYg
	EPFJD3AHZrViXI8kyWkstPkIQmCvYEU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750224240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Iz7iXQj428Hpd++COs1vlDPkvQY2BqAqBLkA5Awzunk=;
	b=n8M/fiL99KIdn0uEWfoRbmY5DwA6owa3TYAtWry6X3lc1/Dh6AIGkNNNU9yomJiVBbEho6
	hNm6h+1zKsHzBHlCvICyuZygJvLoyDzz0CaH6+gZpQ3818uAElAuzCQ1EQ5L4idGgIwOYg
	EPFJD3AHZrViXI8kyWkstPkIQmCvYEU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A9B113A99
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:23:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jfsAD29NUmgbVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 05:23:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: tune: bgt resume related fix and enhancement
Date: Wed, 18 Jun 2025 14:53:38 +0930
Message-ID: <cover.1750223785.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

There is a bug report from the mailing list (1) that btrfstune failed to
resume an interrupted conversion.

Although I hacked a small patch to skip the part of code that I believe
is the cause, it doesn't properly explain why the bug happened, as the
code looks good to me.

But with some time to tinker, I finally created a half-converted image
and can reproduce the bug somewhat reliably.

It turns out to be an uninitialized structure, and this also exposed an
inefficient behavior when reading block groups from the old extent tree.

Fix the bug first with the first patch.
Then enhance the extent tree block group items loading from the old
tree.

Finally a new test image for the bug.

(1): https://lore.kernel.org/linux-btrfs/a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com/

Qu Wenruo (3):
  btrfs-progs: tune: fix uninitialized value which leads to failed
    resume
  btrfs-progs: optimize the block group item load for half converted fs
  btrfs-progs: misc-tests: add an image for btrfstune bgt conversion

 kernel-shared/extent-tree.c                   |  47 ++++--------------
 tests/common                                  |   8 +++
 .../half-converted-bgt.raw.zst                | Bin 0 -> 2760068 bytes
 .../069-btrfstune-resume-bgt/test.sh          |  15 ++++++
 4 files changed, 33 insertions(+), 37 deletions(-)
 create mode 100644 tests/misc-tests/069-btrfstune-resume-bgt/half-converted-bgt.raw.zst
 create mode 100755 tests/misc-tests/069-btrfstune-resume-bgt/test.sh

--
2.49.0



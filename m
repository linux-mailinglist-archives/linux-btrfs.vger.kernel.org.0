Return-Path: <linux-btrfs+bounces-4176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BAF8A253F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 06:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0091F225FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 04:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD73C14F;
	Fri, 12 Apr 2024 04:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iPs48Aig";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iPs48Aig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB21BC20;
	Fri, 12 Apr 2024 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896901; cv=none; b=VGGFqnrqJVIkrpXDtzPGRqNMvTn/MsjC2xUxv0mQagsjeKaLKor0uD4UBiXLu4j3XiPPfLTK3JkSsq/RnaU3NZsaW9UKqLFvnHZr4CTCV1+etaoGKCEf/GALBe4aukYGSQ+d04KRfHTS9ZgCcQjEX7s0AlGlxUM6p9u/pzb+MVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896901; c=relaxed/simple;
	bh=MryDx7YAw8PsaOis2kJ5dKVqUt/Rr5pTFaeEgfSDae8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tmThoTxlqtnoeS6sKND9OcOzuX0npfGu48V7QepAS0Tx/pVaJxBcUSwYTYyRTjjtxyhfSABScSTpbkIRgv2pgsnkPGULde3zqgFVfOXP3GeZmhoWgiYRF0zQ5HoomfrYFFaxMjEFe+72SZjwXVGW49z54rkYudxdKuVjFU5ZbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iPs48Aig; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iPs48Aig; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 080195F7BA;
	Fri, 12 Apr 2024 04:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712896897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+nMRKQrkFVvs8S9ugcv837+3/CrBPKJhkt1VWu5/XzU=;
	b=iPs48Aig5ekHwjPnGFYjX3uyLdkO0daCb99dXPl14dJUgAnSVEwrg7j0o3yYf+3a/1twsB
	pjVpONRTEVPCNDqRcnVk25csRP93BRG8gxliez72/IUV6m3BRcv8Lk9/RAkH0XhPlkjagV
	1SFqIMvYoLm8yJQtiyw2xqt4oo20rCE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iPs48Aig
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712896897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+nMRKQrkFVvs8S9ugcv837+3/CrBPKJhkt1VWu5/XzU=;
	b=iPs48Aig5ekHwjPnGFYjX3uyLdkO0daCb99dXPl14dJUgAnSVEwrg7j0o3yYf+3a/1twsB
	pjVpONRTEVPCNDqRcnVk25csRP93BRG8gxliez72/IUV6m3BRcv8Lk9/RAkH0XhPlkjagV
	1SFqIMvYoLm8yJQtiyw2xqt4oo20rCE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF4131368B;
	Fri, 12 Apr 2024 04:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qkAOJ3+7GGYcOgAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 12 Apr 2024 04:41:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2 0/2] fstests: btrfs: migrate to use `_btrfs` for snapshotting
Date: Fri, 12 Apr 2024 14:11:15 +0930
Message-ID: <cover.1712896667.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 080195F7BA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

[CHANGELOG]
v2:
- Rename `_run_btrfs_util_prog` to `_btrfs` and use it as our
  recommended way for simple btrfs command

- Use the new `_btrfs` for snapshotting to fix the golden output
  mismatch

After more dicussion, it turns out that we'd better go the old
`_run_btrfs_util_prog` for most simple btrfs commands.

And to make it more closer to the regular "btrfs" command, just rename
it to `_btrfs`, and put it at the beginning of `common/btrfs` file, and
recommending it to be utilized.

Then fix the golden output by utilizing that new helper.
Now there is no "Create a " line in btrfs golden output anymore.

In the future, we will migrate to use `_btrfs` for subvolume creation
and deletion too.

Qu Wenruo (2):
  fstests: btrfs: rename _run_btrfs_util_prog to _btrfs
  fstests: btrfs: use _btrfs for 'subvolume snapshot' command

 common/btrfs        | 15 ++++++++-------
 tests/btrfs/001     |  2 +-
 tests/btrfs/001.out |  1 -
 tests/btrfs/004     |  2 +-
 tests/btrfs/007     |  6 +++---
 tests/btrfs/011     | 10 +++++-----
 tests/btrfs/017     |  6 +++---
 tests/btrfs/022     |  6 +++---
 tests/btrfs/025     | 20 ++++++++++----------
 tests/btrfs/028     |  4 ++--
 tests/btrfs/030     | 12 ++++++------
 tests/btrfs/034     | 12 ++++++------
 tests/btrfs/038     | 20 ++++++++++----------
 tests/btrfs/039     | 12 ++++++------
 tests/btrfs/040     | 12 ++++++------
 tests/btrfs/041     |  2 +-
 tests/btrfs/042     | 10 +++++-----
 tests/btrfs/043     | 12 ++++++------
 tests/btrfs/044     | 12 ++++++------
 tests/btrfs/045     | 12 ++++++------
 tests/btrfs/046     | 14 +++++++-------
 tests/btrfs/048     | 16 ++++++++--------
 tests/btrfs/050     |  6 +++---
 tests/btrfs/051     |  6 +++---
 tests/btrfs/052     |  2 +-
 tests/btrfs/053     | 12 ++++++------
 tests/btrfs/054     | 18 +++++++++---------
 tests/btrfs/057     |  6 +++---
 tests/btrfs/058     |  4 ++--
 tests/btrfs/077     | 12 ++++++------
 tests/btrfs/080     |  2 +-
 tests/btrfs/083     | 12 ++++++------
 tests/btrfs/084     | 12 ++++++------
 tests/btrfs/085     |  4 ++--
 tests/btrfs/087     | 12 ++++++------
 tests/btrfs/090     |  2 +-
 tests/btrfs/091     |  8 ++++----
 tests/btrfs/092     | 12 ++++++------
 tests/btrfs/094     | 12 ++++++------
 tests/btrfs/097     | 12 ++++++------
 tests/btrfs/099     |  4 ++--
 tests/btrfs/100     |  6 +++---
 tests/btrfs/101     |  6 +++---
 tests/btrfs/104     | 10 +++++-----
 tests/btrfs/105     | 14 +++++++-------
 tests/btrfs/108     |  6 +++---
 tests/btrfs/109     |  6 +++---
 tests/btrfs/110     | 16 ++++++++--------
 tests/btrfs/111     | 20 ++++++++++----------
 tests/btrfs/117     | 18 +++++++++---------
 tests/btrfs/118     |  8 ++++----
 tests/btrfs/119     |  6 +++---
 tests/btrfs/120     |  4 ++--
 tests/btrfs/121     |  2 +-
 tests/btrfs/122     | 10 +++++-----
 tests/btrfs/123     |  2 +-
 tests/btrfs/124     | 10 +++++-----
 tests/btrfs/125     | 18 +++++++++---------
 tests/btrfs/126     |  4 ++--
 tests/btrfs/127     | 12 ++++++------
 tests/btrfs/128     | 12 ++++++------
 tests/btrfs/129     | 12 ++++++------
 tests/btrfs/130     |  2 +-
 tests/btrfs/139     |  6 +++---
 tests/btrfs/152     | 14 ++++++--------
 tests/btrfs/152.out |  2 --
 tests/btrfs/153     |  4 ++--
 tests/btrfs/161     |  4 ++--
 tests/btrfs/162     |  6 +++---
 tests/btrfs/163     | 12 ++++++------
 tests/btrfs/164     | 12 ++++++------
 tests/btrfs/166     |  2 +-
 tests/btrfs/167     |  2 +-
 tests/btrfs/168     |  6 ++----
 tests/btrfs/168.out |  2 --
 tests/btrfs/169     |  6 ++----
 tests/btrfs/169.out |  2 --
 tests/btrfs/170     |  3 +--
 tests/btrfs/170.out |  1 -
 tests/btrfs/187     |  6 ++----
 tests/btrfs/187.out |  2 --
 tests/btrfs/188     |  6 ++----
 tests/btrfs/188.out |  2 --
 tests/btrfs/189     |  6 ++----
 tests/btrfs/189.out |  2 --
 tests/btrfs/191     |  6 ++----
 tests/btrfs/191.out |  2 --
 tests/btrfs/200     |  6 ++----
 tests/btrfs/200.out |  2 --
 tests/btrfs/202     |  3 +--
 tests/btrfs/202.out |  1 -
 tests/btrfs/203     |  6 ++----
 tests/btrfs/203.out |  2 --
 tests/btrfs/218     |  2 +-
 tests/btrfs/226     |  3 +--
 tests/btrfs/226.out |  1 -
 tests/btrfs/272     | 14 +++++++-------
 tests/btrfs/273     |  6 +++---
 tests/btrfs/276     |  2 +-
 tests/btrfs/276.out |  1 -
 tests/btrfs/278     | 14 +++++++-------
 tests/btrfs/280     |  2 +-
 tests/btrfs/280.out |  1 -
 tests/btrfs/281     |  3 +--
 tests/btrfs/281.out |  1 -
 tests/btrfs/283     |  3 +--
 tests/btrfs/283.out |  1 -
 tests/btrfs/287     |  6 ++----
 tests/btrfs/287.out |  2 --
 tests/btrfs/293     |  4 ++--
 tests/btrfs/293.out |  2 --
 tests/btrfs/300     |  2 +-
 tests/btrfs/300.out |  1 -
 tests/btrfs/302     |  3 +--
 tests/btrfs/302.out |  1 -
 tests/btrfs/314     |  3 +--
 tests/btrfs/314.out |  2 --
 tests/btrfs/320     | 16 ++++++++--------
 118 files changed, 376 insertions(+), 436 deletions(-)

-- 
2.44.0



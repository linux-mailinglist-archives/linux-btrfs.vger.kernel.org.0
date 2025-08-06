Return-Path: <linux-btrfs+bounces-15896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3ABB1C4AE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 13:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2DE189342E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C122928B400;
	Wed,  6 Aug 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mtgm75Lq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mtgm75Lq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34474221FBF
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754478883; cv=none; b=BXm/Fhhl/wgcyhnyJ1lCShZ2pzXXJ4vhlqSTPhXR8+ZzVh2USbu/PWTIACmuAOIMRmVUfRJjrVw0DdMSyfHeWx82ynY3MoWE6Tj7u7A3SWbI07eKz9OSxCCFXrnQRLSmM5Gw/+1eBILqxOAVOB4VlLD71zxL6XM5+qvg9yo71eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754478883; c=relaxed/simple;
	bh=gkLSb1+9KhRSJRm+nk8x89DyxO209uh9NGB1tf39aRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C35YJKre4q/mkgm+3yirl7mXZWRDd3O4wTUIoXfzI/KBGv4FewLj0PInY65UvWjRCZL6VHIJpkBMLC35vYbbXONSCzEBGXTqZRmWZl/P46cl12+4ME1C0nwsoF5k/3l+0NO5GIjJrlWk/wRGvTpVgBGcXN4SFfzWkTNHxLopHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mtgm75Lq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mtgm75Lq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 303C421AD9;
	Wed,  6 Aug 2025 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754478879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iNyrjRZm8VSFFq66QlpAiNsQN1L6TCrewJyfxPV1uGY=;
	b=mtgm75LqnmQRwk4vcgZ6xXrJSUnBj5Bo4qZBGlbitCnfGfVMUAsOxkx3VZBNKEtloHRMpH
	Mkc237VzJSXuJszNgzqBmUf/Pmcw7Upxy/8SmIOQDeAmbKH52B7bnEfmbp1yFxJtExw7pZ
	E83ho7uLXifHrIL3hoH65i0X3QRjLo8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mtgm75Lq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754478879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iNyrjRZm8VSFFq66QlpAiNsQN1L6TCrewJyfxPV1uGY=;
	b=mtgm75LqnmQRwk4vcgZ6xXrJSUnBj5Bo4qZBGlbitCnfGfVMUAsOxkx3VZBNKEtloHRMpH
	Mkc237VzJSXuJszNgzqBmUf/Pmcw7Upxy/8SmIOQDeAmbKH52B7bnEfmbp1yFxJtExw7pZ
	E83ho7uLXifHrIL3hoH65i0X3QRjLo8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25B0913AA8;
	Wed,  6 Aug 2025 11:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0nDrCB85k2g4QgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 06 Aug 2025 11:14:39 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs urgent fix for 6.17
Date: Wed,  6 Aug 2025 13:14:26 +0200
Message-ID: <cover.1754478249.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 303C421AD9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Hi,

please pull a single btrfs commit. It fixes a problem that people
started to hit since 6.15.3 during log replay (e.g. after a crash).
The bug is old but got more likely to happen since 5e85262e542d6da got
backported to stable (6.15 only). The summer vacation time caused delays
of the fix delivery, apologies to everyone. Thanks.

----------------------------------------------------------------
The following changes since commit 005b0a0c24e1628313e951516b675109a92cacfe:

  btrfs: send: use fallocate for hole punching with send stream v2 (2025-07-22 01:23:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.17-fix-tag

for you to fetch changes up to 0a32e4f0025a74c70dcab4478e9b29c22f5ecf2f:

  btrfs: fix log tree replay failure due to file with 0 links and extents (2025-08-06 13:01:38 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: fix log tree replay failure due to file with 0 links and extents

 fs/btrfs/tree-log.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)


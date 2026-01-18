Return-Path: <linux-btrfs+bounces-20658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C137BD392E7
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 06:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CEC9301818F
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 05:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37A17B425;
	Sun, 18 Jan 2026 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ElSTXfDi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YCt54Zuv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135F500962
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768714232; cv=none; b=T5JLBHS8IhVFMN2X6G3tUWarqRNYRzdPXQg0N7WzolNrs1KEFoBMhmbS/ZzHBVMcGA6yHxlBuR3jmIqUEoPjso1amfngjlUN8lAKiA3pPbBYOWxZ2Ysv/KYXgO8xjoXzNYuv9AgcJ/O86kbrlk6NEqwEZg6YWamHTPwO1BfkKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768714232; c=relaxed/simple;
	bh=57Np6Zi2x23dcRdBW6DkC+ohjoVVK2MGXIaT9bX+JC4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dgTUbilepTpL+yyynBguY77dzEYvqOuPlldLAA8+quxLhP5YhReMdpwrqgc1umxzcIaCZYt/xebUUpaw+jZCm41ZLNlVlkPbNuA+6AogR2x06RRmQdmugBXQtmSjb+zFwakNNaGKEXahjLX8Dd66lKCKynzA4Aw5YHumMaaxP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ElSTXfDi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YCt54Zuv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E33715BCC3
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768714224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AokTDU0xm3/KCsQELLUUHpIde1C+CQTECiD8I3aGLsc=;
	b=ElSTXfDiZHTpP4EwjtWytnErXQMfVysxWh+bQj/WF2PhknexD0zhKFIieiC52k32I/eYqF
	Eche6Uv+Gjy8XutA2BDg2UxP1Zd7Seh8SlwyHZIENU9+hFdk5wxiclTftd9SK8sSOv5jwY
	PJm7IUbATaSGQDHp/BIcCGqv0mNL88Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768714223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AokTDU0xm3/KCsQELLUUHpIde1C+CQTECiD8I3aGLsc=;
	b=YCt54Zuv5jBw3kZS5GGQZqGWUTeRqOqpwm0M9T7s0PcG1AkLO4ogJ4krIkpUt0slXaQAIH
	8xb1xR0RQ0ksO4GCmam7RfrpWcawhB6dEnxwaKwIu+USK2qqkw6yJ5V6vr395Y5AilrLhE
	eVEU5zUVO3+WBYVy9Z4Td3HfTtsljNk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF38F3EA63
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HKugHu5vbGnScQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 05:30:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: apply strict alignment checks to extent maps
Date: Sun, 18 Jan 2026 15:59:57 +1030
Message-ID: <cover.1768714131.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
X-Spam-Level: 
X-Spam-Flag: NO

Although we already have strict checks on file extent items from
tree-checker, we never do proper alignment checks for extent maps.

The reason is mostly due to the failure of self tests and how hard it is
to touch them, especially for the inode self tests.

I have to say the inode self test is really something, the extent maps
of the self test makes no sense, and would be rejected by tree-checker if
they show up in the real world.
Thankfully only the first few ones are invalid, the remaining ones are
totally fine.

The comments are not any better, after the first line, there are no more
aligned number at all, and the numbers are not offset by 1, but 3 or
even more.
Considering we're using decimals for most of our dump-tree and comments,
no one is really going to note the wrong numbers until one throw them
into python or whatever calculator one prefers.

The series will mostly rework the inode self tests file extent item
layout so that they represent the real world better, and update the
comments and make the poor person who needs to update that selftest
suffer less in the future.

Then address the minor problem in the extent-map selftest where
fs_info->sectorsize is never properly populated for the 4K based self
test.

With all those done, we can finally put a proper alignment check into 
validate_extent_map() which is called for every new, merged or replaced
extent map.

Qu Wenruo (3):
  btrfs: tests: remove invalid file extent map tests
  btrfs: tests: prepare extent map tests for strict alignment checks
  btrfs: add strict extent map alignment checks

 fs/btrfs/extent_map.c             |  12 ++++
 fs/btrfs/tests/extent-map-tests.c |  16 +++--
 fs/btrfs/tests/inode-tests.c      | 111 +++++++++++++++++-------------
 3 files changed, 87 insertions(+), 52 deletions(-)

-- 
2.52.0



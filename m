Return-Path: <linux-btrfs+bounces-12446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97064A69F62
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 06:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A652460C83
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 05:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551581DF725;
	Thu, 20 Mar 2025 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p1qAnvVG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p1qAnvVG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17C2AEE2
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448875; cv=none; b=NZtvqa3j0F7GGhXPN6UKjjx59O6DwiEBbmJQOsGLRmiZJtvlHDwDh6dcVotQfQS6UhNrayGeM9Kl/pLVvzO4COSCMP9HKv51YlU9dELlzLfH9naJIElePxIoMJSxQ8eM+3Pub1OAIjHDYKhWjbZuz/s657luqbhfpveDEtTpBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448875; c=relaxed/simple;
	bh=Vc/YDexfUk/16hUOctLQJ7SBr2DwZuEGS/sgKA+MeCA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ab0FRfOT5PaYM9hrec2qiasQKh/A04Wxqz4jSUEpi0V9V/pEVd+bckmzgGkoAWOHdndVkYE/FeBs61KkjPXng+hdWbkuj7FGmr3WndyZBgEAPPUPsxMWXqP0v6Lb4hzQCG05WDkO+h/V8Tp0W9lMOgf+nzK5GesD0BFRsRxcnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p1qAnvVG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p1qAnvVG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A123521A70
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742448871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bMamcRWjFel5az5kn1zFGOp/mQtecTfJh0PZLv6Bupg=;
	b=p1qAnvVG3P7NLMXHa5cTLk3OBZooIxY872X5+8iYZ781oPlPz6vV6S5h+xJICEYib4o8XO
	/zgCpfxc/nIngX2G9hYOjp87hK/j/92dQeIta4kn16j0KNc4kwubdYhxFjfTOuFkLUzuvE
	IkDbBKP/mGKOGB8LgHw33/uoWWyn9BM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742448871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bMamcRWjFel5az5kn1zFGOp/mQtecTfJh0PZLv6Bupg=;
	b=p1qAnvVG3P7NLMXHa5cTLk3OBZooIxY872X5+8iYZ781oPlPz6vV6S5h+xJICEYib4o8XO
	/zgCpfxc/nIngX2G9hYOjp87hK/j/92dQeIta4kn16j0KNc4kwubdYhxFjfTOuFkLUzuvE
	IkDbBKP/mGKOGB8LgHw33/uoWWyn9BM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BF88138A5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gBX3Eeao22fcMQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs: refactor btrfs_buffered_write() for the incoming large data folios
Date: Thu, 20 Mar 2025 16:04:07 +1030
Message-ID: <cover.1742443383.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
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

The function btrfs_buffered_write() is implementing all the complex
heavy-lifting work inside a huge while () loop, which makes later large
data folios work much harder.

The first patch is a patch that already submitted to the mailing list
recently, but all later reworks depends on that patch, thus it is
included in the series.

The core of the whole series is to introduce a helper function,
copy_one_range() to do the buffer copy into one single folio.

Patch 2 is a preparation that moves the error cleanup into the main loop,
so we do not have dedicated out-of-loop cleanup.

Patch 3 is another preparation that extract the space reservation code
into a helper, make the final refactor patch a little more smaller.

And patch 4 is the main dish, with all the refactoring happening inside
it.

Qu Wenruo (4):
  btrfs: remove force_page_uptodate variable from btrfs_buffered_write()
  btrfs: cleanup the reserved space inside the loop of
    btrfs_buffered_write()
  btrfs: extract the space reservation code from btrfs_buffered_write()
  btrfs: extract the main loop of btrfs_buffered_write() into a helper

 fs/btrfs/file.c | 434 ++++++++++++++++++++++++++----------------------
 1 file changed, 231 insertions(+), 203 deletions(-)

-- 
2.49.0



Return-Path: <linux-btrfs+bounces-139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07D7EC956
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32ED6B20C53
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Nov 2023 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7838A3BB4F;
	Wed, 15 Nov 2023 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QzJ5XCHn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C52E64F
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 17:06:45 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE9A8F
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 09:06:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 9C2342291E;
	Wed, 15 Nov 2023 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700068002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Se9omE3w16zN6eAapRIZR8XyaIysfIDdBbQHJga8lTA=;
	b=QzJ5XCHnG5NsNlX8h/PTl+Y0unnFQgKvQLxSzAhvCUqQIznkHlLoXnPzJepNY0IyPbNXrw
	2MXC3pGOnldruSawwfPXY77R9nTDFTkwc5Q4WTuLrbcyG2gh6PdsSg8Oc+ky+fqufQLe1z
	jc+YVIjQ7Qe5HDqjFvl3Z78+EYGceHg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
	by relay2.suse.de (Postfix) with ESMTP id 7F81C2C15A;
	Wed, 15 Nov 2023 17:06:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
	id 9DF9ADA86C; Wed, 15 Nov 2023 17:59:37 +0100 (CET)
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/2] Pool for compression pages
Date: Wed, 15 Nov 2023 17:59:37 +0100
Message-ID: <cover.1700067287.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of dsterba@suse.cz) smtp.mailfrom=dsterba@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [18.50 / 50.00];
	 ARC_NA(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 FORGED_SENDER(0.30)[dsterba@suse.com,dsterba@suse.cz];
	 RCVD_NO_TLS_LAST(0.10)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 FROM_NEQ_ENVFROM(0.10)[dsterba@suse.com,dsterba@suse.cz];
	 BAYES_HAM(-0.00)[13.87%]
X-Spam-Score: 18.50
X-Rspamd-Queue-Id: 9C2342291E

Add wrappers for alloc/free of pages used for compresion and keep a
small cache (for all filesystems, ie. per module). This can speed up
short compression IO when we don't need to go to the allocator. Shrinker
is attached to free the pages if there's memory pressure.

David Sterba (2):
  btrfs: use page alloc/free wrapeprs for compression pages
  btrfs: use shrinker for compression page pool

 fs/btrfs/compression.c | 118 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/compression.h |   5 ++
 fs/btrfs/inode.c       |   4 +-
 fs/btrfs/lzo.c         |   4 +-
 fs/btrfs/zlib.c        |   6 +--
 fs/btrfs/zstd.c        |   7 ++-
 6 files changed, 132 insertions(+), 12 deletions(-)

-- 
2.42.1



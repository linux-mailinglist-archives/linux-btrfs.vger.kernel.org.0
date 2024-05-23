Return-Path: <linux-btrfs+bounces-5222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D76F8CCA55
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 03:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7092928277A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F051C20;
	Thu, 23 May 2024 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A3v25VPP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="A3v25VPP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF73EC7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716427201; cv=none; b=Et4sFzwcpgx/PHBa/RSLKAJveug12lVW29dfxTjbtSnCLsMGcGwkRYXI68kzJvbw6r/lC0cs7I5I/GXmrGrl1zA0oR9l86619Ygmc8Df4KjuS4YXFSdifFI7yirqwTMS33YNFe0jID1cZQuPA38raCLTYhuVEzxf6X/taojCT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716427201; c=relaxed/simple;
	bh=rcwU8Mosdqfke02EYIpiMHdcpznjTvAgmhwceqbtg+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WRTFcEThXPlQUc+d+QIgq0sGnex8vV8gYRw4okPSggW9X1ew6ykAx049uHY1QfM7HuLIBX1VkIrsR2564EwrU+WumFkGr3LbSB4HTunl0TF+J1ruKKvpQzfpR4D3Ry51SmRZrceGvP61QIc4nePoW4eJshOqXRS8oRSWEksEdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A3v25VPP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=A3v25VPP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 872A221E24
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716427197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FUDQf4G9cHNWIHgJstzKV2B0AGO3Z8rI07muBYTYerY=;
	b=A3v25VPPcA699Zn1pL1CU6PduCnT8sVI4CPRJ2OFSwoCPBe1BP4qawyKveZ8KOe5J7RwAl
	e+e2oXlBBMCh00J/MQ9JQlwYGnRGNAZrlSlkyeQGksyRGsAJCWjykZ0oNoZ0n5kQgiDhDO
	v33GmyslS+hK9WB7Fm5iLq2DQuIcboE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716427197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FUDQf4G9cHNWIHgJstzKV2B0AGO3Z8rI07muBYTYerY=;
	b=A3v25VPPcA699Zn1pL1CU6PduCnT8sVI4CPRJ2OFSwoCPBe1BP4qawyKveZ8KOe5J7RwAl
	e+e2oXlBBMCh00J/MQ9JQlwYGnRGNAZrlSlkyeQGksyRGsAJCWjykZ0oNoZ0n5kQgiDhDO
	v33GmyslS+hK9WB7Fm5iLq2DQuIcboE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 929A213A25
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Adu7EbyZTmYDJwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: enhance function extent_range_clear_dirty_for_io()
Date: Thu, 23 May 2024 10:49:36 +0930
Message-ID: <cover.1716427131.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.57
X-Spam-Level: 
X-Spamd-Result: default: False [-1.57 / 50.00];
	BAYES_HAM(-1.77)[93.61%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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

[Changelog]
v3:
- Drop the patch to use subpage helper
  For subpage cases, fsstress with compression can lead to hang where
  OE seems hanging and never to be finished.
  So far it looks like some race with i_size change but still not sure
  why the code change is involved.
  Drop the subpage helper change for now.

v2:
- Split the original patch into 3

- Return the error from filemap_get_folio() to be future-proof

- Enhance the comments for the new ASSERT() on
  extent_range_clear_dirty_for_io() error
  In fact, even if some pages are missing, we do not need to handle the
  error at compress_file_range(), as btrfs_compress_folios() and each
  compression routine would handle the missing folio correctly.

  Thus the new ASSERT() is only an early warning for developers.

Qu Wenruo (2):
  btrfs: move extent_range_clear_dirty_for_io() into inode.c
  btrfs: remove the BUG_ON() inside extent_range_clear_dirty_for_io()

 fs/btrfs/extent_io.c | 15 ---------------
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/inode.c     | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.45.1



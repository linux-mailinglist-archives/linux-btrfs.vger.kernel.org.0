Return-Path: <linux-btrfs+bounces-1494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C2A82FE01
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 01:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D125288FFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 00:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518E463A5;
	Wed, 17 Jan 2024 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TC1fq9wy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TC1fq9wy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE145CAC
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705451573; cv=none; b=fVxnW75dc+UG19H5WmiwWWshkNAFX8ra/X3LiO1EwjiE+3MVFewvqW3umD2Ifg9MXoDqVB9AUH8UQx/vl2BSYWHNIbWBzUlEytdiuS/zdH6ROS5U9ieM6mEAaC7LCa5rjJK/JTATC7txVEL4/zeXJEqdYIqCgiMmj4XF6WIDFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705451573; c=relaxed/simple;
	bh=w3D3LE3xtl9W9ZNj7QlhvRRJiN0JB2XR2c+d+vG3A90=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Spam-Score:X-Spamd-Result:
	 X-Spam-Flag; b=U69Cp+0T02/bkLUHJ4GC/6GOqNknYm7iiQ+CuMRtdb/7H2UoB50tZYSrf+6xQ7bZhYN1JgrpQ+POotuPqdBmIh1hw9zlWimMBU7Yc6/mm2yOOUDG1GTrKsdZYPMVa9ZowQaxvIF4eWFkCMT3wyBhchVUtEJLcQHc2QK5RJuSP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TC1fq9wy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TC1fq9wy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D9F9220CA
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705451569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lK4hvuxHX76Ix/7H9wH2rLdel8ZdPAKWzRF55vy/n6Q=;
	b=TC1fq9wyt/vfrkcrMlrOGWzfOFxltzA1P0x4r6DOq5Jqlfc6SvuufLcvyvNzsAEMVPBmiR
	87rjmgMwBxeZXt7ij6v6ED57w90XeAoiCzbEjEIZUyYdARwbbVtj6wRLGo374PUexnRj3A
	1/FszztMDCEp/wElKXBASNPP+OIpEtI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705451569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lK4hvuxHX76Ix/7H9wH2rLdel8ZdPAKWzRF55vy/n6Q=;
	b=TC1fq9wyt/vfrkcrMlrOGWzfOFxltzA1P0x4r6DOq5Jqlfc6SvuufLcvyvNzsAEMVPBmiR
	87rjmgMwBxeZXt7ij6v6ED57w90XeAoiCzbEjEIZUyYdARwbbVtj6wRLGo374PUexnRj3A
	1/FszztMDCEp/wElKXBASNPP+OIpEtI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B500E13751
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NI7ZHDAgp2W0GgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 00:32:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: scrub avoid use-after-free when chunk length is not 64K aligned
Date: Wed, 17 Jan 2024 11:02:24 +1030
Message-ID: <cover.1705449249.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[10.75%]
X-Spam-Flag: NO

[Changelog]
v2:
- Split out the RST code change
  So that backport can happen more smoothly.
  Furthermore, the RST specific part is really just a small enhancement.
  As RST would always do the btrfs_map_block(), even if we have a
  corrupted extent item beyond chunk, it would be properly caught,
  thus at most false alerts, no real use-after-free can happen after
  the first patch.

- Slight update on the commit message of the first patch
  Fix a copy-and-paste error of the number used to calculate the chunk
  end.
  Remove the RST scrub part, as we won't do any RST fix (although
  it would still sliently fix RST, since both RST and regular scrub
  share the same endio function)

There is a bug report about use-after-free during scrub and crash the
system.
It turns out to be a chunk whose lenght is not 64K aligned causing the
problem.

The first patch would be the proper fix, needs to be backported to all
kernel using newer scrub interface.

The 2nd patch is a small enhancement for RST scrub, inspired by the
above bug, which doesn't really need to be backported.

Qu Wenruo (2):
  btrfs: scrub: avoid use-after-free when chunk length is not 64K
    aligned
  btrfs: scrub: limit RST scrub to chunk boundary

 fs/btrfs/scrub.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

-- 
2.43.0



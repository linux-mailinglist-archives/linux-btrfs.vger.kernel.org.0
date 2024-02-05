Return-Path: <linux-btrfs+bounces-2132-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEECD84AACE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 00:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407D41F23FD3
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996DA4B5CA;
	Mon,  5 Feb 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OLodHDmf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OLodHDmf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551C1AB7E8
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176766; cv=none; b=Bat9+0HwS2r75dhvsDX2GilzgVBPMNLJttw+2+eWkgEm/KNrw49xqSyJzpcM+EKQ09PICrWv9f9DwcgquIYdflzK8pGefd9Azcnf5imp6EoYgs43zR2H6In5beGduaL0Np6sOjG0+zVvBZtFhKX/1CFbthjfMyvyJW830m+Cy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176766; c=relaxed/simple;
	bh=nHrPmSLhJZ9TkasCEub/KU2++5ZxSYmPeLyXY9cXJp8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GgX1sM6T1OlhonXxnhWRACz0H1DefTIm6+YU2Mbyj4rLncvNtgcPXfnTVHfa9SU5MJLJYCHlgcBn+qV58vgUkA7HDv2bs6lDufOfaCw85XAZ2KGevoiOWnqHw3IDhRkFdcudmcZ5Sz1Qgre1w213qDiiDHOEqW8McCx9+qy7hLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OLodHDmf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OLodHDmf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E24412212D
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VymNRTda3rYXRcY4A/W3nT+jEW2esW0t6eGgXENKzIQ=;
	b=OLodHDmfDupxtgxyn/wHtYJjLLDxSps3kNVc839Uh0eIHPgHkJFS+MWFoUVfgy0+jwTSwB
	zcvrGu582NEuFIQByrxrTj33BTZk9PYT3Uv5w+Xx4q9EKkzaUKJwATmkoC/4WTv5IQTGWD
	+Nh91mJzCiQgchKNvSQ7sBmLG/t175M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VymNRTda3rYXRcY4A/W3nT+jEW2esW0t6eGgXENKzIQ=;
	b=OLodHDmfDupxtgxyn/wHtYJjLLDxSps3kNVc839Uh0eIHPgHkJFS+MWFoUVfgy0+jwTSwB
	zcvrGu582NEuFIQByrxrTj33BTZk9PYT3Uv5w+Xx4q9EKkzaUKJwATmkoC/4WTv5IQTGWD
	+Nh91mJzCiQgchKNvSQ7sBmLG/t175M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 271D5136F5
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q590NjdzwWUncAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 Feb 2024 23:45:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: defrag: better lone extent handling
Date: Tue,  6 Feb 2024 10:15:54 +1030
Message-ID: <cover.1707172743.git.wqu@suse.com>
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
X-Spam-Score: 3.61
X-Spamd-Result: default: False [3.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-0.995];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.10)[65.11%]
X-Spam-Flag: NO

When a lone file extent (a file extent without any adjacent non-hole
file extent) is involved, it would haven no chance to be touched by
defrag.

This would mean that, if we have some lone extents with very low
utilization ratio, or defragging it can free up a lot of space, defrag
would not touch them no matter what.

This is not ideal for some situations, e.g.:

  # mkfs.btrfs -f $dev
  # mount $dev $mnt
  # xfs_io -f -c "pwrite 0 128M" $mnt/foobar
  # sync
  # truncate -s 4k $mnt/foobar
  # btrfs filesystem defrag $mnt/foobar
  # sync

In above case, if defrag touches the 4k extent, it would free up the
whole 128M extent, which should be a good win.

This patchset would address the problem by introducing a special
entrance for lone file extents.
Lone file extents meeting either ratio or wasted bytes threshold would
be considered as a defrag target, allowing end uesrs to address above
situation.

This change requires progs support (or direct ioctl() calling), by
default they would be disabled.

And my personal recommendation for the ratio would be (4069 / 65536)
(aka, 1/16 of the on-disk file extent size), and 16MiB (if freeing up
the extent can free more than 16MiB, excluding the lone extent size).

Qu Wenruo (2):
  btrfs: defrag: add under utilized extent to defrag target list
  btrfs: defrag: allow fine-tuning on lone extent defrag behavior

 fs/btrfs/defrag.c          | 68 +++++++++++++++++++++++++++++++++-----
 fs/btrfs/ioctl.c           |  9 +++++
 include/uapi/linux/btrfs.h | 28 +++++++++++++---
 3 files changed, 92 insertions(+), 13 deletions(-)

-- 
2.43.0



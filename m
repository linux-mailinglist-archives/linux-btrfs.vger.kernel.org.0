Return-Path: <linux-btrfs+bounces-19351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1260C87438
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 22:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DD5B34D97A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B12D23BC;
	Tue, 25 Nov 2025 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K7UpP9Ta";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K7UpP9Ta"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8571A23B9
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107443; cv=none; b=JdCptW0wxNu7Yt5UprXTsx2xj/cAT+XuVNmvQjVUHgvRvFS/22Fw/CyYy4DnKK6in/jPScyxoXfFF3j+aqWKajxxVLp+ZsxjMR6xSqcn4684ZhEWO5rjmNKdU/8P7q+KU1Ho21mCSXBFlxldt66aTegJKhqw/afptN8PEipOPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107443; c=relaxed/simple;
	bh=kRTGIv/nr5mwjbbRQZqXN9zyxEtluBB505iOdlV24y0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lUclzbmJ+T0PaeeXXUTgcuo2yQ4vVS/+t9vXk6tOa7EA7XPuJiIvI1pwLqGhyXhrMVbfyc9YSwe7aW45ej5HHM0DmxDf1iFExYNNpqThPV2rJpk/tNLona8P4pQnmddVSlTxi17OINM7cTtlUhyVOOHJUImFsAb/ajMUbcuVFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K7UpP9Ta; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K7UpP9Ta; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C53B422951
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764107439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8NQpm9KU2WPTVP1Sdv9+27jZS6anIu8fV7zeBqRQ3UY=;
	b=K7UpP9TawXdRcQQ/q0eRbihikVz9/wwSwD2KDJ+TsWOFQsicfAgRwYl6PJ+K8d9bMv9/Io
	zzh9FxgkM56TnwqvbYLNzIixEh+RcmzyVVA9CFqlPpDEwNLoSHdPM06OA8UBRp00EaXTbc
	CzAVZYoCQUxlDHf1Sx19gk8oJiWj+0U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764107439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8NQpm9KU2WPTVP1Sdv9+27jZS6anIu8fV7zeBqRQ3UY=;
	b=K7UpP9TawXdRcQQ/q0eRbihikVz9/wwSwD2KDJ+TsWOFQsicfAgRwYl6PJ+K8d9bMv9/Io
	zzh9FxgkM56TnwqvbYLNzIixEh+RcmzyVVA9CFqlPpDEwNLoSHdPM06OA8UBRp00EaXTbc
	CzAVZYoCQUxlDHf1Sx19gk8oJiWj+0U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10BBC3EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gtW8MK4kJmkoDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 21:50:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: fix an on-stack path leak and migrate to auto-release for on-stack paths
Date: Wed, 26 Nov 2025 08:20:19 +1030
Message-ID: <cover.1764106678.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[CHANGELOG]
v2:
- Add back an early btrfs_release_path() call in
  print_data_reloc_error()
  This is to avoid holding the path (and its extent buffers locked)
  during time consuming iterate_extent_inodes() calls.

  And add a comment on that early release, with updated commit message.

I thought patch "btrfs: make sure extent and csum paths are always released in
scrub_raid56_parity_stripe()" has already taught us that tag based
manual cleanup is never reliable, now there is another similar bug in
print_data_reloc_error().

This time it is harder to expose, as we always imply if the function
returned an error, they should do the proper cleanup.
But extent_to_logical() does not follow that assumption.

The first patch is the minimal fix for backport, the second patch is
going to solve the problem by using auto-release for all on-stack btrfs
paths.

Qu Wenruo (2):
  btrfs: fix a potential path leak in print_data_reloc_error()
  btrfs: introduce BTRFS_PATH_AUTO_RELEASE() helper

 fs/btrfs/ctree.h  |  9 +++++++++
 fs/btrfs/defrag.c |  5 +----
 fs/btrfs/inode.c  |  7 +++++--
 fs/btrfs/scrub.c  | 18 ++++++------------
 4 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.52.0



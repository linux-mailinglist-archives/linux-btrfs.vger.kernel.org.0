Return-Path: <linux-btrfs+bounces-5474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7454C8FD196
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 17:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1190C1F2570B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E744C619;
	Wed,  5 Jun 2024 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BJJAfbu2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BJJAfbu2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F119D8A2;
	Wed,  5 Jun 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601185; cv=none; b=eEAYKC79ONWyz6M5jIHl4jEBBiuxHhrgyOy903Th6+gdT2acEHYQhBOAGGAFhCxZXUxzR07qzYBCv4F0O8R/caPwApAmj5jjZLux1HsuFytIVT8S3bF8qwmdlndGrx13E74ffeRounMKBfmvNOsav7HPNwWWjXy6Ps5VODeRl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601185; c=relaxed/simple;
	bh=8XpyhZKSrc4bE8+XvtvAfYDllM78fVvoQxc/aBYNcsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAiLCuSvhhIc1n2qVRr/kCJDRcEZe0R/+NkjHaVFHhQKxmuusoufRcws7KmESbNi0nmwLIu+E36z2TKvxdkBfNlcUuLhvQXCybxgOa4yhkNjNdugJbNK5RZEVweVkbyV+wKxc9QU4PVk4ov8sfsio8Qvwxd5ORFrpJYJ0Q9rkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BJJAfbu2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BJJAfbu2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7787B1F821;
	Wed,  5 Jun 2024 15:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717601180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d8GuYH83WUVlQTRs9HSo1c88X0WQdTG14bgqNF4Wo5Q=;
	b=BJJAfbu2JD5bXRvgUHmTEDwD1sK2qedlKOYewz0oDcZ8oEffNBEE5IjLWSd5S+Ljh6Ds3B
	0UkWXCJdkW61og0hBjR6bJeS3bMhITc/SOdM82o5oTTI9g5AwBzvdygCaUvRN5Xhe+UKG4
	4aZlr/8+hUZoKG/93qn5PUu40yUUZv8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717601180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d8GuYH83WUVlQTRs9HSo1c88X0WQdTG14bgqNF4Wo5Q=;
	b=BJJAfbu2JD5bXRvgUHmTEDwD1sK2qedlKOYewz0oDcZ8oEffNBEE5IjLWSd5S+Ljh6Ds3B
	0UkWXCJdkW61og0hBjR6bJeS3bMhITc/SOdM82o5oTTI9g5AwBzvdygCaUvRN5Xhe+UKG4
	4aZlr/8+hUZoKG/93qn5PUu40yUUZv8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7048E13A42;
	Wed,  5 Jun 2024 15:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8+5iG5yDYGaiRgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 05 Jun 2024 15:26:20 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.10-rc3
Date: Wed,  5 Jun 2024 17:26:14 +0200
Message-ID: <cover.1717600881.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Hi,

please pull the following fix for fast fsync that needs to handle errors
during writes after some COW failure so it does not lead to an
inconsistent state. Thanks.

----------------------------------------------------------------
The following changes since commit 440861b1a03c72cc7be4a307e178dcaa6894479b:

  btrfs: re-introduce 'norecovery' mount option (2024-05-21 15:27:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-rc2-tag

for you to fetch changes up to f13e01b89daf42330a4a722f451e48c3e2edfc8d:

  btrfs: ensure fast fsync waits for ordered extents after a write failure (2024-05-28 16:35:12 +0200)

----------------------------------------------------------------
Filipe Manana (1):
      btrfs: ensure fast fsync waits for ordered extents after a write failure

 fs/btrfs/btrfs_inode.h  | 10 ++++++++++
 fs/btrfs/file.c         | 16 ++++++++++++++++
 fs/btrfs/ordered-data.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)


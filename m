Return-Path: <linux-btrfs+bounces-6613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA0C937CDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AD828236A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BD4148316;
	Fri, 19 Jul 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o7L+COnL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o7L+COnL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F538C06;
	Fri, 19 Jul 2024 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721416116; cv=none; b=Cvt580NzZ9BapxtoFu96vIoxdJxLUz5/LJtz3k1da51oOpgOyfBFBkAf5f9A32uCXbqw/ihYoHfDy16Z3dts4q84YpkSFrPePAhvmJXhIFytzeKNZgBZbP9rHHE6LEpGVCoRhyS6cyg1zi2oh53mywlRAyaD/Ljs52DW/kNotVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721416116; c=relaxed/simple;
	bh=xTIlvS5tf9lU/MO/CsctBhaut0pdlrJe+GPKcfsW5iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/p676m3X+j/7dF56ONGJEE/0sFyeEkqdxs3bc/Opu042ihpZFHTQuxrJHR2m6L+lBtsNMGgnDsykoDp7btwJlI09RMXjDAqygwhVCUDeVcG8fpc5uPZw1DF9XNQi9ra5n/l6jAMVKJ/1y7VezHY+WKSZ//+N9+I+a51mLQNfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o7L+COnL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o7L+COnL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AE8121B0A;
	Fri, 19 Jul 2024 19:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721416112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pDXcJFwiDkrbMBq5pF1V1sEkGtbK8k2qbp7MpOO9ZgE=;
	b=o7L+COnL5Txpcz+foSoR/GHgm7zvTBa47o/m5T8hGYyAYS/Dnt/MguIkWV1UwZG7aJ8FEO
	utHWLpv5V51UNylYTOXwKkO/DEcxDSDKnbFcxbn5b2rNrElN7cT0skxVIp8yk2NpxEVCM3
	IxI/aQKi4ptM0s04+oP8vUEvXO10o/Q=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=o7L+COnL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721416112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pDXcJFwiDkrbMBq5pF1V1sEkGtbK8k2qbp7MpOO9ZgE=;
	b=o7L+COnL5Txpcz+foSoR/GHgm7zvTBa47o/m5T8hGYyAYS/Dnt/MguIkWV1UwZG7aJ8FEO
	utHWLpv5V51UNylYTOXwKkO/DEcxDSDKnbFcxbn5b2rNrElN7cT0skxVIp8yk2NpxEVCM3
	IxI/aQKi4ptM0s04+oP8vUEvXO10o/Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34204132CB;
	Fri, 19 Jul 2024 19:08:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EmK0DLC5mmZ/OgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 19 Jul 2024 19:08:32 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs build fix for 6.11
Date: Fri, 19 Jul 2024 21:08:25 +0200
Message-ID: <cover.1721414023.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.81 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 3AE8121B0A
X-Spam-Score: -0.81
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /

Hi,

please pull a fix for build breakage on 32bit platforms. I misjudged the
severity of the fix, it first looked like a functional fix that could
wait but failing subset of builds should not (-Werror=overflow). I'm not
aware of any reports from linux-next build coverage before merge window.

Thanks.

----------------------------------------------------------------
The following changes since commit 8e7860543a94784d744c7ce34b78a2e11beefa5c:

  btrfs: fix extent map use-after-free when adding pages to compressed bio (2024-07-11 16:32:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.11-tag

for you to fetch changes up to c3ece6b7ffb4a7c00e8d53cbf4026a32b6127914:

  btrfs: change BTRFS_MOUNT_* flags to 64bit type (2024-07-19 17:20:23 +0200)

----------------------------------------------------------------
Qu Wenruo (1):
      btrfs: change BTRFS_MOUNT_* flags to 64bit type

 fs/btrfs/fs.h    | 66 ++++++++++++++++++++++++++++----------------------------
 fs/btrfs/super.c | 11 +++++-----
 fs/btrfs/super.h |  3 ++-
 fs/btrfs/zoned.c |  3 ++-
 fs/btrfs/zoned.h |  5 +++--
 5 files changed, 46 insertions(+), 42 deletions(-)


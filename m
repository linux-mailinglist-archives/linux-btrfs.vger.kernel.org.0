Return-Path: <linux-btrfs+bounces-3497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 809D5885EE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 17:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345611F22B2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5649A137764;
	Thu, 21 Mar 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bqrQpka9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bqrQpka9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F718AE8;
	Thu, 21 Mar 2024 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039773; cv=none; b=tNOIBuFeBL7u/76Blp4ST0bk777S7e6oUbAlJoeKV/8UzqZB+R9ZBNp6j/aYZpH8lAhQdWmVY6aJkk29SiQlx3hlo9jvXqgpDCz3Mpi0vZQ/QWDKsRpRhVwypIcsYjm1DTGSmYeb4SWdXo2c99NdPKdMYIUsPnGmJOHPMFYCV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039773; c=relaxed/simple;
	bh=msjSVfc4FMWJF0bIRPf2fnEnjPy6IJWQTOLnoiRoaB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FX/UrOmpVi44qW94p4WMwPUQvNBkMFr3jsTja37Ta0WLNBFE6T/1M7z6hsQhwYcB+X/iyHLtuy+uT9/pWqvkVfvFUbkWQI8HcPxUTDosyASfRm+EQEvAS+RsGCtxJHws+dPgc5j/OvSFhrUAbNTL88wnwgjd72Vd5UmUGc2CoLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bqrQpka9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bqrQpka9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B2C4B5D168;
	Thu, 21 Mar 2024 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711039768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SMjpEEFnZf7LG1TfNoc6vr0iLPwhwIh1iHx7zcmB9FU=;
	b=bqrQpka9k4u6l34nqgEzirIVf/wi4+I8uL4eQuJamrHwtjoAweiWgUBaJ1ydBLJgCj8VZ/
	Imuh7TPfvGKP1fY9tcYAxbIwUrGHOMV2px6rkwVC/ein6tHzsNGAgj7G9ei3I8amfcVkG7
	izy9NnAgcHFWpVWMvPHRkDW4WUFu/p0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711039768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SMjpEEFnZf7LG1TfNoc6vr0iLPwhwIh1iHx7zcmB9FU=;
	b=bqrQpka9k4u6l34nqgEzirIVf/wi4+I8uL4eQuJamrHwtjoAweiWgUBaJ1ydBLJgCj8VZ/
	Imuh7TPfvGKP1fY9tcYAxbIwUrGHOMV2px6rkwVC/ein6tHzsNGAgj7G9ei3I8amfcVkG7
	izy9NnAgcHFWpVWMvPHRkDW4WUFu/p0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC463136AD;
	Thu, 21 Mar 2024 16:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RIsJKhhl/GXhIAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 21 Mar 2024 16:49:28 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs fix for 6.9
Date: Thu, 21 Mar 2024 17:42:03 +0100
Message-ID: <cover.1711038961.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bqrQpka9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[13.91%]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: B2C4B5D168
X-Spam-Flag: NO

Hi,

please pull the following branch. It's fixing a problem found in 6.7
after adding the temp-fsid feature which changed device tracking in
memory and broke grub-probe. This is used on initrd-less systems. There
were several iterations of the fix and it took longer than expected.

The patch depends on VFS changes (bdev_handle) so it's based on merge of
last btrfs pull request.  We'll provide backport for stable trees.

Please pull, thanks.

----------------------------------------------------------------
The following changes since commit 43a7548e28a6df12a6170421d9d016c576010baa:

  Merge tag 'for-6.9-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2024-03-12 12:28:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.9-part2-tag

for you to fetch changes up to d565fffa68560ac540bf3d62cc79719da50d5e7a:

  btrfs: do not skip re-registration for the mounted device (2024-03-18 19:16:50 +0100)

----------------------------------------------------------------
Anand Jain (1):
      btrfs: do not skip re-registration for the mounted device

 fs/btrfs/volumes.c | 58 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 11 deletions(-)


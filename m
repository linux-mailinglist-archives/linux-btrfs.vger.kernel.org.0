Return-Path: <linux-btrfs+bounces-16892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB34EB813E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 19:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96654627BB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 17:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024FE2FE05C;
	Wed, 17 Sep 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ivnu0wEh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ivnu0wEh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46A235C17
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131650; cv=none; b=EeJkMZyDOqqQ0ywiFVW3WFgmCmpeYC5QLMdIJfGWf/Jqq7fGYApDgEgNjh4B/omfMYK4zjHt6wsSWTSKryOAtZG12SJ5c+89/HppFUdU3bRkeZTsK9xr/ki7ph1YFe4JoBHskbNf3BtBZhgizaJI56Q1qZyz7I+/9eZvUEUeSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131650; c=relaxed/simple;
	bh=JFWzh6XtY3eeraaWUGBL5z0+cU5/Lpn+VCsGoGGiXp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUnaUiS8ak2Afre3WJEErPOK8E7xHyVDCvYjkRHue8mnQ/SiFONBsoFr9BQEmcOoSiEJSDUKHND5Bz8iRNmWAzrfmEhFiOY9FITYmpfmgyj7f7AJLhsVDnwzs9r2PeSohr7n04jc6fi/fcJAMi3yIrKIhzVwn4IE3XSiUqgpkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ivnu0wEh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ivnu0wEh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4029821CBB;
	Wed, 17 Sep 2025 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758131646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n77Z4JxIVDNZjEURfI23+L5xQSwFcITHOMVClukLARQ=;
	b=Ivnu0wEh0cv1WxwVgwIPoT3/TpbxHgfZAntYnmQiyY0NxoFN1XJd3pwAgw0zSQ+lW39AhN
	jn+wSQp8mAbTk7mcGrggjDrIpxxhjKZ8190L18a4GFDBr7F4BuBnTZTYS4OVqRlKBwEIOq
	Kp6gUrNuMtsfN3sACGpGt4PHeZwbBKE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758131646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n77Z4JxIVDNZjEURfI23+L5xQSwFcITHOMVClukLARQ=;
	b=Ivnu0wEh0cv1WxwVgwIPoT3/TpbxHgfZAntYnmQiyY0NxoFN1XJd3pwAgw0zSQ+lW39AhN
	jn+wSQp8mAbTk7mcGrggjDrIpxxhjKZ8190L18a4GFDBr7F4BuBnTZTYS4OVqRlKBwEIOq
	Kp6gUrNuMtsfN3sACGpGt4PHeZwbBKE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A375137C3;
	Wed, 17 Sep 2025 17:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H8MtDr71ymiASgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 17 Sep 2025 17:54:06 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/3 RFC] Unlikely annotations for EIO/EUCLEAN/abort branches
Date: Wed, 17 Sep 2025 19:53:53 +0200
Message-ID: <cover.1758130856.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi,

manually add unlikely annotations to the branches that lead to critical
but rare errors. This is RFC as this has a big conflict surface.
However this would be a one-time action, possibly done now before 6.18
freeze.

The base is current for-next (without series [1]):

   text    data     bss     dec     hex filename
1650172  136289   15560 1802021  1b7f25 pre/btrfs.ko
1650934  136289   15560 1802783  1b821f post/btrfs.ko
DELTA: +762

There are differences in the generated assembly so the compiler does not
detect the error branches as unlikely by itself (sometimes it does due
to __cold function annotations).

I've used my prototype branch from some time ago so some of the
annotations could be still missing, this is more about getting the idea
of the scope.

[1] https://lore.kernel.org/linux-btrfs/cover.1758095164.git.fdmanana@suse.com/

David Sterba (3):
  btrfs: add unlikely annotations to branches leading to EUCLEAN
  btrfs: add unlikely annotations to branches leading to EIO
  btrfs: add unlikely annotations to branches leading to transaction
    abort

 fs/btrfs/backref.c          | 24 ++++++-------
 fs/btrfs/bio.c              |  4 +--
 fs/btrfs/block-group.c      | 24 ++++++-------
 fs/btrfs/ctree.c            | 66 +++++++++++++++++------------------
 fs/btrfs/defrag.c           |  2 +-
 fs/btrfs/delayed-inode.c    |  2 +-
 fs/btrfs/dev-replace.c      | 10 +++---
 fs/btrfs/disk-io.c          | 48 +++++++++++++-------------
 fs/btrfs/export.c           |  2 +-
 fs/btrfs/extent-tree.c      | 68 ++++++++++++++++++-------------------
 fs/btrfs/extent_io.c        |  2 +-
 fs/btrfs/extent_map.c       |  2 +-
 fs/btrfs/file-item.c        |  2 +-
 fs/btrfs/file.c             | 45 ++++++++++++------------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/free-space-tree.c  | 24 ++++++-------
 fs/btrfs/inode.c            | 58 +++++++++++++++----------------
 fs/btrfs/ioctl.c            |  6 ++--
 fs/btrfs/lzo.c              |  6 ++--
 fs/btrfs/qgroup.c           | 18 +++++-----
 fs/btrfs/raid56.c           | 14 ++++----
 fs/btrfs/relocation.c       | 14 ++++----
 fs/btrfs/root-tree.c        |  6 ++--
 fs/btrfs/scrub.c            | 18 +++++-----
 fs/btrfs/send.c             | 12 +++----
 fs/btrfs/super.c            |  6 ++--
 fs/btrfs/verity.c           |  4 +--
 fs/btrfs/volumes.c          | 30 ++++++++--------
 fs/btrfs/zoned.c            | 50 +++++++++++++--------------
 fs/btrfs/zstd.c             |  2 +-
 30 files changed, 284 insertions(+), 287 deletions(-)

-- 
2.51.0



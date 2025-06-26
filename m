Return-Path: <linux-btrfs+bounces-15004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B31CAEA08A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E1D7AD414
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF272EA731;
	Thu, 26 Jun 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c1s2hIy4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uN793+eO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692562EAB81
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948233; cv=none; b=ZPHwz0ziqtCe0I0hXj5KBx/9h3XtI99WvVNanvAcA463JnbyoFMVbOIdnslC1jJGr2JEpY5jAK7rY7zU3hqgCW1yJVGXSdre86l05S7Hs/RuEl9TLfGGne4cg/GW1zlm03UihaFXjWCGgrvP36I8Qhx0e6heza3Qz2R5GKMOEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948233; c=relaxed/simple;
	bh=/hqSlktrqOVwbYJ0EA7kyutJRlnekr7zHacy0puxf5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcSY9WKvGLY9zKXb4jyqxqqseShIulmfR/xDgDWWuVj8r5S1wtlYA/2mrR0WTFF8aJ1kNnfpTouXGRv83y1j9wiQWWpEWvrGf12gXd0XafoZ5BibtMo+kUdK76ytwbENL3gIWqHwFfLRAv0Zjg8MtewfPQEri41DRIryoulpuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c1s2hIy4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uN793+eO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF9862116E;
	Thu, 26 Jun 2025 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/Yjhqik1AKEtkySeFHR7k7W9JXiiCPV4Hx7LOkdPuc=;
	b=c1s2hIy4gCqTEw0vUtjC0pH1RLmyO2/z8GgljPhFM0FEqqfoMGZqkuA7J6oboM+t4heIVb
	hCHjykKkvgbuP82mtP3yrjxh9ofuRAbQhAsbltJCfPlKL7MxLmHMCuswOK4sZsYCxEoYI1
	nVWazC5hwhY5iy4klXRY0PVctHVWw78=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750948221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/Yjhqik1AKEtkySeFHR7k7W9JXiiCPV4Hx7LOkdPuc=;
	b=uN793+eOD/en+BDQT5v/uLBZQFXj3WIiiSJlH4hh8b1ujZ/fspjM9l6qsJxpATXmZFL8sF
	E7v9JYJ7Q6OPShzvNesypL4c6jUkIzX35Vf4TSmKfoEjHjJLaxUpGgvQ+HWvy+ARLE8juY
	FCceVlvvfyfUu/AKyEmpnmqQs0nr/kI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E87FC138A7;
	Thu, 26 Jun 2025 14:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zle0OH1ZXWgfLgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 26 Jun 2025 14:30:21 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: pass bool to indicate subvolume/snapshot creation type
Date: Thu, 26 Jun 2025 16:30:11 +0200
Message-ID: <f2afbd58ab13c3393fb59df405e955ccfc911ea6.1750948128.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750948128.git.dsterba@suse.com>
References: <cover.1750948128.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 225fc00311a4c4..8e90d4c9035e9c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1182,7 +1182,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 
 static noinline int __btrfs_ioctl_snap_create(struct file *file,
 				struct mnt_idmap *idmap,
-				const char *name, unsigned long fd, int subvol,
+				const char *name, unsigned long fd, bool subvol,
 				bool readonly,
 				struct btrfs_qgroup_inherit *inherit)
 {
@@ -1276,7 +1276,7 @@ static noinline int btrfs_ioctl_snap_create(struct file *file,
 }
 
 static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
-					       void __user *arg, int subvol)
+					       void __user *arg, bool subvol)
 {
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
 	int ret;
-- 
2.49.0



Return-Path: <linux-btrfs+bounces-11737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60CA41C22
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 12:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B15017280D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FEC2586E5;
	Mon, 24 Feb 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hUWX9m4r";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZfcGrq+h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50CA2586DC
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395430; cv=none; b=aHjCYLzKdvVopzcmMg75K5vCKY/pjqoQPaE+j1hkmv1L/xdLHQ1rNY5dALcmxwPX6HhFmfajvFDkefFPci8V7pJTmPx9A0XYszq50vtmtI4skWP8xUXfFSlKVaL9KYrxJ2KAhhk66ygBlsTkL25sfvsEDBwZa5EPqbG7UAsh43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395430; c=relaxed/simple;
	bh=MaK+9dzpXTdCxrrK95zGX5tmuTWvq7qwlKJ8ygzvM4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pshez05Zb3T9UEuyfyuyyDgHWo+nlpMRUCWO2aAqCAeIBZmjlLqO03PvYH8cyu9aydGrhw4bqZ5syAGGkP2BUbiGP3OehCgNp98S+jm6Ra+jnMwmZVnf2eUR8vE8p8ZQab11pGBUi7dLPMPXG3DvQ9Z3YSIzWlRRHDJxoCb5axQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hUWX9m4r; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZfcGrq+h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF07021172;
	Mon, 24 Feb 2025 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740395427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGP9p6hHUA44YJUqa+3WngVSQTioIJGu8qESyCnqfZ0=;
	b=hUWX9m4r8ThpWTlyc+xVTpx5fUGIEfGOeRryXffCwAa0WYiInt3g7TQHR71VFYu488n8A8
	Cn/uKRKDOJnv0PL+vGUBYmfNfba1ShdPL98/Z6ao6OXcrIpdt1QTUaREtPPjS2DMmSYj9U
	XYSOuIKlmVmpls3BR9/MnR9RTTbeHuY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZfcGrq+h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740395426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGP9p6hHUA44YJUqa+3WngVSQTioIJGu8qESyCnqfZ0=;
	b=ZfcGrq+hUrp06GvcDc9bEN/7ahRDIPo/VZNVG+5sys5oGjjSffyE2J6XvMGVT2j9+RxEWx
	KRWbyVLaosNNxo3Iu0DvdGSu17srYZ/kUWT5RGRNBx6f9qzJAck4oTiNShqbtWdb3lVJCJ
	5uwdPyXkD/oZZsv7ixOk6lnwYHnpdkE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D960613332;
	Mon, 24 Feb 2025 11:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hAtiNKJTvGeCBQAAD6G6ig
	(envelope-from <neelx@suse.com>); Mon, 24 Feb 2025 11:10:26 +0000
From: Daniel Vacek <neelx@suse.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>,
	Zorro Lang <zlang@redhat.com>,
	Daniel Vacek <neelx@suse.com>
Subject: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is enabled
Date: Mon, 24 Feb 2025 12:10:14 +0100
Message-ID: <20250224111014.2276072-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220145723.1526907-1-neelx@suse.com>
References: <20250220145723.1526907-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF07021172
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

When SELinux is enabled this test fails unable to receive a file with
security label attribute:

    --- tests/btrfs/314.out
    +++ results//btrfs/314.out.bad
    @@ -17,5 +17,6 @@
     At subvol TEST_DIR/314/tempfsid_mnt/snap1
     Receive SCRATCH_MNT
     At subvol snap1
    +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
     Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
    -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
    +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
    ...

Setting the security label file attribute fails due to the default mount
option implied by fstests:

MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch

See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")

fstests by default mount test and scratch devices with forced SELinux
context to get rid of the additional file attributes when SELinux is
enabled. When a test mounts additional devices from the pool, it may need
to honor this option to keep on par. Otherwise failures may be expected.

Moreover this test is perfectly fine labeling the files so let's just
disable the forced context for this one.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 tests/btrfs/314 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/314 b/tests/btrfs/314
index 76dccc41..29111ece 100755
--- a/tests/btrfs/314
+++ b/tests/btrfs/314
@@ -38,7 +38,7 @@ send_receive_tempfsid()
 	# Use first 2 devices from the SCRATCH_DEV_POOL
 	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
 	_scratch_mount
-	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
 
 	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
 	_btrfs subvolume snapshot -r ${src} ${src}/snap1
-- 
2.48.1



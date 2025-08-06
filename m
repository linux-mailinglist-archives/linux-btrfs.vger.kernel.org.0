Return-Path: <linux-btrfs+bounces-15880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B7B1BFB0
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B210F183889
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 04:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ADB1F3B85;
	Wed,  6 Aug 2025 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z5jexXTC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Z5jexXTC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF61EE7B9
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455759; cv=none; b=aOMqjQHbaS2INgxEKiR609wIsI/OMaCJ/fk6RkYuDcWTCnqiuCX1MZtuhD1nj6GGWYhiWCEhNgsxhv5Gtkgh2Y9TNscqADkg4cKTHllUFXHW/+hv/T6s411EmB/hUA5svTBsbxqHviH/i4oBRJasVfr0qZfwVuWWyYHpsz/L+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455759; c=relaxed/simple;
	bh=vPRsJvMdmy06CGPxtKNte9YLBeeWp00eM2tcq8w1p3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMKAW350H5LQgUr67rwMWlcxetNBIPtyL5StyuklrL89oMP0vK0/laT6R3g9ktqX5+mbR2NP3nMprtamxQ1W7BsBrfXPQ9wKUJT3ea4+VQ24hgKnbVfd/SoaExsPQulGU4QiAV2VUEANSpZDj+S8/TTEFGzOSbQE22W1qJVl6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z5jexXTC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Z5jexXTC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01FA31F38E;
	Wed,  6 Aug 2025 04:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wM0896T2wlwvJ3vHTeilbM9zkr56MSm0XibreHEYjGQ=;
	b=Z5jexXTCOkOwTxPAt7nAj3E5urjMFSM5/THuiZA3usUmM06zjyrJhPDHBR1mtYGoDLxePM
	u5CluPM14HL1DRdDBBwy2mJfsebyCehSujU5Q8xOA7ixMV9Hnu2JmTQ+knXjOoAZcJwBse
	Y78QEa5sRJ/e8k8yMpuuYaaaoF0f+IA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Z5jexXTC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754455755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wM0896T2wlwvJ3vHTeilbM9zkr56MSm0XibreHEYjGQ=;
	b=Z5jexXTCOkOwTxPAt7nAj3E5urjMFSM5/THuiZA3usUmM06zjyrJhPDHBR1mtYGoDLxePM
	u5CluPM14HL1DRdDBBwy2mJfsebyCehSujU5Q8xOA7ixMV9Hnu2JmTQ+knXjOoAZcJwBse
	Y78QEa5sRJ/e8k8yMpuuYaaaoF0f+IA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0364713AA8;
	Wed,  6 Aug 2025 04:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KbuLcnekmjFRwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 06 Aug 2025 04:49:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Zoltan Racz <racz.zoli@gmail.com>
Subject: [PATCH v2 1/6] btrfs-progs: fix the wrong size from device_get_partition_size_sysfs()
Date: Wed,  6 Aug 2025 14:18:50 +0930
Message-ID: <2fa034e287a0b7deb5a1b436915426a696a10e71.1754455239.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754455239.git.wqu@suse.com>
References: <cover.1754455239.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 01FA31F38E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

From: Zoltan Racz <racz.zoli@gmail.com>

[BUG]
When an unprivileged user, who can not access the block device, run
"btrfs dev usage", it's very common to result the following incorrect
output:

  $ btrfs dev usage /mnt/btrfs/
  WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
  /dev/mapper/test-scratch1, ID: 1
     Device size:            20.00MiB <<<
     Device slack:           16.00EiB <<<
     Unallocated:                 N/A

Note if the unprivileged user has read access to the raw block file, it
will work as expected:

  $ btrfs dev usage /mnt/btrfs/
  WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
  /dev/mapper/test-scratch1, ID: 1
     Device size:            10.00GiB
     Device slack:              0.00B
     Unallocated:                 N/A

[CAUSE]
When device_get_partition_size() is called, firstly the function checks
if we can do a read-only open() on the block device.

However under most distros, block devices are only accessible by root
and "disk" group.

If the unprivileged user is not in "disk" group, the open() will fail
and we have to fallback to device_get_partition_size_sysfs() as the
fallback.

The function device_get_partition_size_sysfs() will use
"/sys/block/<device>/size" as the size of the disk.

But according to the kernel source code, the "size" attribute is
implemented by returning bdev_nr_sectors(), and that result is always in
sector unit (512 bytes).

So if device_get_partition_size_sysfs() returns the value directly, it's
512 times smaller than the original size, causing errors.

[FIX]
Just do the proper left shift to return size in bytes.

Issue: #979
---
 common/device-utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 783d79555446..bca392568d1b 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -375,7 +375,9 @@ static u64 device_get_partition_size_sysfs(const char *dev)
 		return 0;
 	}
 	close(sysfd);
-	return size;
+
+	/* <device>/size value is in sector (512B) unit. */
+	return size << SECTOR_SHIFT;
 }
 
 u64 device_get_partition_size(const char *dev)
-- 
2.50.1



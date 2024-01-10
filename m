Return-Path: <linux-btrfs+bounces-1367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7182829ED3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 17:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E646289B09
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E064CE01;
	Wed, 10 Jan 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gV6SBmAI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cPDcq6Ip"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2884A9A9
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EA7A1FDA3;
	Wed, 10 Jan 2024 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704905677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RIO2/d6TaZ4oQPVXo4ZL6UPrZESRk44ZWGqUAWr6Z7A=;
	b=gV6SBmAIGqZjKNTjRaC4cm2OXV3l1UKi9HNdaB+nQWlY7dd4CpC2EBGiPumSILeMXdkIxj
	BOGBiD2PxcKVemWrUgT1J2ZH+bNj1ojZtsO5be5YZCjTJ2h7kJg3h3kF2C6lHSizpF/BAK
	8bEG4MgF4SvxYw5auDRbOHI0LaqQRYo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704905753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RIO2/d6TaZ4oQPVXo4ZL6UPrZESRk44ZWGqUAWr6Z7A=;
	b=cPDcq6IpvaN7UW0SrJZxt+4nxq4NpFqgaTf1O7Jp2pzXAI1ENPZWA49sjs4SzZ15G4edqr
	nwn0IQjS/9cHHh5c7Y6xhybHSxU+FA5ztewuf4i5ZC83cQmnbnHW+buAaw1vkNbkHIngrp
	t4k0xkO2XV3HsueDTY/Nq3VZ073I0WY=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 56CFC139C6;
	Wed, 10 Jan 2024 16:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KTQrFc3LnmVWCgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 10 Jan 2024 16:54:37 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: send: return EOPNOTSUPP on unknown flags
Date: Wed, 10 Jan 2024 17:55:50 +0100
Message-ID: <20240110165550.1701-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cPDcq6Ip
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 BAYES_SPAM(0.00)[28.92%];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 8EA7A1FDA3
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

When some ioctl flags are checked we return EOPNOTSUPP, like for
BTRFS_SCRUB_SUPPORTED_FLAGS, BTRFS_SUBVOL_CREATE_ARGS_MASK or fallocate
modes. The EINVAL is supposed to be for a supported but invalid
values or combination of options. Fix that when checking send flags so
it's consistent with the rest.

Link: https://lore.kernel.org/linux-btrfs/CAL3q7H5rryOLzp3EKq8RTbjMHMHeaJubfpsVLF6H4qJnKCUR1w@mail.gmail.com/
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2d7519a6ce72..7902298c1f25 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8111,7 +8111,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	}
 
 	if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
-		ret = -EINVAL;
+		ret = -EOPNOTSUPP;
 		goto out;
 	}
 
-- 
2.42.1



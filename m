Return-Path: <linux-btrfs+bounces-612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E942B8051BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 12:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44922817CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C456458;
	Tue,  5 Dec 2023 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gXYWMEHi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aCrmJYb/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9114129
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 03:13:44 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 482761FB89;
	Tue,  5 Dec 2023 11:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701774823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zIPdmK5LSiJzXjdEJ5LmmMcgDycjk37ibYVRrbZcY3M=;
	b=gXYWMEHitwa0fIMLK272ExE8jgrCFY84S2v2gEpt4LNv+B32ZdfzFTnCFiss4PKAkaxAya
	e+dOvDZ8wYyqOU/Gc0Csuqz1ZmLOnuWhV/tngBEb3o98hUjLDYUAzjzO722z+maS+fJvVK
	GZBIn3W/6iH/TC8+eiWUpVMtvt/v1Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701774823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zIPdmK5LSiJzXjdEJ5LmmMcgDycjk37ibYVRrbZcY3M=;
	b=aCrmJYb/RU6iyhhGxK0UpYk5bgOKM0F2MwL8a9xqnP+1O9CWLDfnzXIkGesLS1cbppNgHZ
	L8ASvvneRG6X6QBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A5C9136CF;
	Tue,  5 Dec 2023 11:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l53KAeUFb2WofgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 05 Dec 2023 11:13:41 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] btrfs: drop unused memparse() parameter
Date: Tue,  5 Dec 2023 22:13:29 +1100
Message-Id: <20231205111329.6652-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 3.90
X-Spamd-Result: default: False [3.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[21.24%]

The @retptr parameter for memparse() is optional.
btrfs_devinfo_scrub_speed_max_store() doesn't use it for any input
validation, so the parameter can be dropped.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/btrfs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6b51fb3ddc1e..75f3b774a4d83 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1779,10 +1779,9 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
 {
 	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
 						   devid_kobj);
-	char *endptr;
 	unsigned long long limit;
 
-	limit = memparse(buf, &endptr);
+	limit = memparse(buf, NULL);
 	WRITE_ONCE(device->scrub_speed_max, limit);
 	return len;
 }
-- 
2.35.3



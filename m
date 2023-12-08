Return-Path: <linux-btrfs+bounces-755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0665C809762
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 01:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDE52821B8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Dec 2023 00:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1703ED0;
	Fri,  8 Dec 2023 00:42:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4BC1713
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 16:42:26 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 544EE1FD7D;
	Fri,  8 Dec 2023 00:42:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D271113722;
	Fri,  8 Dec 2023 00:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U0rnGm5mcmWtAgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 08 Dec 2023 00:42:22 +0000
From: David Disseldorp <ddiss@suse.de>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] btrfs: validate scrub_speed_max sysfs string
Date: Fri,  8 Dec 2023 11:41:56 +1100
Message-Id: <20231208004156.9612-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231207135522.GX2751@twin.jikos.cz>
References: <20231207135522.GX2751@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd1
X-Spam-Level: 
X-Rspamd-Queue-Id: 544EE1FD7D
X-Spam-Score: -4.00

Fail the sysfs I/O on any trailing non-space characters.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/btrfs/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6b51fb3ddc1e..4c4642ef7c5f0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1783,6 +1783,9 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
 	unsigned long long limit;
 
 	limit = memparse(buf, &endptr);
+	endptr = skip_spaces(endptr);
+	if (*endptr != 0)
+		return -EINVAL;
 	WRITE_ONCE(device->scrub_speed_max, limit);
 	return len;
 }
-- 
2.35.3



Return-Path: <linux-btrfs+bounces-749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B811C8089A2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 14:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7258A28297F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 13:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221840C18;
	Thu,  7 Dec 2023 13:57:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA43133
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 05:56:59 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83FAC21CE4;
	Thu,  7 Dec 2023 13:56:58 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7243D13B6A;
	Thu,  7 Dec 2023 13:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sb1PBSjPcWU6KgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Dec 2023 13:56:56 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] btrfs-progs: scrub: improve Rate reporting for sub-second durations
Date: Fri,  8 Dec 2023 00:56:47 +1100
Message-Id: <20231207135647.24332-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [11.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 MX_GOOD(-0.01)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of ddiss@suse.de) smtp.mailfrom=ddiss@suse.de
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 83FAC21CE4
X-Spam-Score: 11.79

Scrubs which complete in under one second may carry a duration rounded
down to zero. This subsequently results in a bytes_per_sec value of
zero, which corresponds to the Rate metric output, causing intermittent
tests/btrfs/282 failures.

This change ensures that Rate reflects any sub-second bytes processed.
Time left and ETA metrics are also affected by this change, in that they
increase to account for (sub-second) bytes_per_sec.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 cmds/scrub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 4a741355..72ea3b67 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -152,7 +152,14 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
 	time_t sec_eta;
 
 	bytes_scrubbed = p->data_bytes_scrubbed + p->tree_bytes_scrubbed;
-	if (s->duration > 0)
+	/*
+	 * If duration is zero seconds (rounded down), then the Rate metric
+	 * should still reflect the amount of bytes that have been processed
+	 * in under a second.
+	 */
+	if (s->duration == 0)
+		bytes_per_sec = bytes_scrubbed;
+	else
 		bytes_per_sec = bytes_scrubbed / s->duration;
 	if (bytes_per_sec > 0)
 		sec_left = (bytes_total - bytes_scrubbed) / bytes_per_sec;
-- 
2.35.3



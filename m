Return-Path: <linux-btrfs+bounces-1204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE4C823926
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 00:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFC01C2484D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jan 2024 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D9200C6;
	Wed,  3 Jan 2024 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BS/MAECR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BS/MAECR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CFA1F926;
	Wed,  3 Jan 2024 23:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C52221ECA;
	Wed,  3 Jan 2024 23:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704324499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frgVRPdp70OVgJksCxSW6XCCaTKoGsaFs4KP1Eow2jE=;
	b=BS/MAECR5qZgfeBcU+viUNd2YXUBJYA7trmLUcWM4UZRKMTXMfLTCoPTsvcGmm9+G/WMJW
	7Ox/daEyCnaezMGFvJjjoYAn3sJ/UC9B+MYRhN2L0QsbN0TGA0LTl35v3URUUXqp7zCDLv
	5x62EnAjCPD4OTssaLQ+ODyIO58sqcM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704324499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frgVRPdp70OVgJksCxSW6XCCaTKoGsaFs4KP1Eow2jE=;
	b=BS/MAECR5qZgfeBcU+viUNd2YXUBJYA7trmLUcWM4UZRKMTXMfLTCoPTsvcGmm9+G/WMJW
	7Ox/daEyCnaezMGFvJjjoYAn3sJ/UC9B+MYRhN2L0QsbN0TGA0LTl35v3URUUXqp7zCDLv
	5x62EnAjCPD4OTssaLQ+ODyIO58sqcM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FD1C13AA6;
	Wed,  3 Jan 2024 23:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ICGdMI7tlWWXTgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 03 Jan 2024 23:28:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de,
	geert@linux-m68k.org
Subject: [PATCH v3 1/4] kstrtox: always skip the leading "0x" even if no more valid chars
Date: Thu,  4 Jan 2024 09:57:48 +1030
Message-ID: <9076fa9d3d2d3b2574386f4850a45f7902f6503c.1704324320.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704324320.git.wqu@suse.com>
References: <cover.1704324320.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Spamd-Bar: +
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.de:email];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de,linux-m68k.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="BS/MAECR"
X-Spam-Level: *
X-Rspamd-Queue-Id: 0C52221ECA

Currently the invalid string "0x" (only hex prefix, no valid chars
followed) would make _parse_integer_fixup_radix() to treat it as octal.

This is due to the fact that the function would only auto-detect hex if
and only if there is any valid hex char after "0x".
Or it would only go octal instead.

Thankfully this won't affect our unit test, as "0x" would still be
treated as failure (-EINVAL) anyway:

- Old code treats "0x" as '0' with tailing 'x'
  Thus return -EINVAL due to the tailing 'x'.

- New code treats "0x" as "0x" suffix with nothing following up
  Thus return -EINVAL due to no valid string.

But for the incoming memparse_safe(), the remaining string would still
be consumed by the caller, and we need to properly treat "0x" as an
invalid string.

So this patch would make _parse_integer_fixup_radix() to forcefully go
hex no matter if there is any valid char following.

And there is a also copy of _parse_integer_fixup_radix() inside
arch/x86/boot/string.c, to keep the code consistent this patch would
also modify that copy.

Thankfully for that copy in arch/x86/boot/string.c, it's only doing
kstrtoll(), thus there would be no behavior change, just as explained
above.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
 arch/x86/boot/string.c | 2 +-
 lib/kstrtox.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 1c8541ae3b3a..49750ef697bb 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -233,7 +233,7 @@ static const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
 {
 	if (*base == 0) {
 		if (s[0] == '0') {
-			if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
+			if (_tolower(s[1]) == 'x')
 				*base = 16;
 			else
 				*base = 8;
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index d586e6af5e5a..41c9a499bbf3 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -27,7 +27,7 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
 {
 	if (*base == 0) {
 		if (s[0] == '0') {
-			if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
+			if (_tolower(s[1]) == 'x')
 				*base = 16;
 			else
 				*base = 8;
-- 
2.43.0



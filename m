Return-Path: <linux-btrfs+bounces-1179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2930E8216D3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 05:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1AE281DD0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 04:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F1539D;
	Tue,  2 Jan 2024 04:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ew3wJR+A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ew3wJR+A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55546A0;
	Tue,  2 Jan 2024 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45F381FC85;
	Tue,  2 Jan 2024 04:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704168765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyETOa+ZPNwt5BzUQx7GY54PiItFOjBXBVV0dOwevSc=;
	b=Ew3wJR+Ayz0OXED0tGwcXI2y1Tc20jrvhUhK/ynmFMrMDimAFcYuPJHraN9k9CdciuEDo1
	jUmgSOHCzCrV5G4PBfkUZuD+W2NOVET8T91g5CJ+MmIOxtUDVs5SB95NcfZuKGAAXr7qWd
	dcGdh+F1tCotfK00pO2ViFeUB0J8+wI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704168765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyETOa+ZPNwt5BzUQx7GY54PiItFOjBXBVV0dOwevSc=;
	b=Ew3wJR+Ayz0OXED0tGwcXI2y1Tc20jrvhUhK/ynmFMrMDimAFcYuPJHraN9k9CdciuEDo1
	jUmgSOHCzCrV5G4PBfkUZuD+W2NOVET8T91g5CJ+MmIOxtUDVs5SB95NcfZuKGAAXr7qWd
	dcGdh+F1tCotfK00pO2ViFeUB0J8+wI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACB15136D1;
	Tue,  2 Jan 2024 04:12:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELQgFjmNk2UHQQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 02 Jan 2024 04:12:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de
Subject: [PATCH v2 1/4] kstrtox: always skip the leading "0x" even if no more valid chars
Date: Tue,  2 Jan 2024 14:42:11 +1030
Message-ID: <f905131c211685efa59dfa43ffb3a619a283f914.1704168510.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704168510.git.wqu@suse.com>
References: <cover.1704168510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.71
X-Spamd-Result: default: False [3.71 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.19)[-0.967];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[22.48%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Currently the invalid string "0x" (only hex prefix, no valid chars
followed) would make _parse_integer_fixup_radix() to treat it as octal.

This is due to the fact that the function would only auto-detect hex if
and only if there is any valid hex char after "0x".
Or it would only go octal instead.

Thankfully this won't affect our unit test, as "0x" would still be
treated as failure.
Since we treat the result as octal, the result value would be 0, leaving
"x" as the tailing char and still fail kstrtox() functions.

But for the incoming memparse_safe(), the remaining string would still
be consumed by the caller, and we need to properly treat "0x" as an
invalid string.

So this patch would make _parse_integer_fixup_radix() to forcefully go
hex no matter if there is any valid char following.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 lib/kstrtox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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



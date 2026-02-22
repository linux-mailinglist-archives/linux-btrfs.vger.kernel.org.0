Return-Path: <linux-btrfs+bounces-21827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CI7ELeNm2nm1wMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21827-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 00:13:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CC6170B6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 00:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10743301AB84
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 23:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2E35C1B9;
	Sun, 22 Feb 2026 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bmh6AJes";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bmh6AJes"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510B1A704B
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771802022; cv=none; b=tuhTlT3WVh3bQMBozlWxhlAxGa8mjkj6n2wXPVJWnKHGEBMXejK4mbKVKJiQG7w57bz5DDzTIaMCpdqL9rHrNG5PbGRMuIN/Rf3u7ZZulFr43GFeYWuC2OQTGQaJfdOnpUhyvYt3kJWFbwGPOAGMVZaAU+m6an9gpeq4q5U24WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771802022; c=relaxed/simple;
	bh=zvAqTl55h4Pyh4sPB5CbaOj+tMiIchTwfuBxIXoyvvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsrKIupj98zGO2+hNUOWj1NkYmVvIpZ6WhwXH+6tURzJFdBBaG1+8QL1FCW3BWxgL3cTrxVwXlj1zy/1oNkiSl7s+/B8Qrs4PBloEqiqyPIOqDc06lL9c4aGARcJw+kGWmPcN3hqchwS14St8JxYj3njB9p+QM5z1iAsPN+PJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bmh6AJes; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bmh6AJes; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B70F45BCCB
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771802009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPp2j8HzG7VF3AhmihNTKWuLFBKSqoDmRfM/j51QduI=;
	b=Bmh6AJesQFoa/9izxFZjscOphHz8LBydwfObBpEyvVRtpV7kMnAF3l5mq9j7uTgEjBVPBG
	661Hr3j031u7EAT0iQ7fS/1B9ohFcOgyofsLAj3KeKBb/LFr2OkP1n+HZX1kksQIC2lzYj
	cMNa5cN1CLwLlBIQxmsZd5g/zhLSib8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771802009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPp2j8HzG7VF3AhmihNTKWuLFBKSqoDmRfM/j51QduI=;
	b=Bmh6AJesQFoa/9izxFZjscOphHz8LBydwfObBpEyvVRtpV7kMnAF3l5mq9j7uTgEjBVPBG
	661Hr3j031u7EAT0iQ7fS/1B9ohFcOgyofsLAj3KeKBb/LFr2OkP1n+HZX1kksQIC2lzYj
	cMNa5cN1CLwLlBIQxmsZd5g/zhLSib8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E70B03EA68
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4BLZKZiNm2n0NwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:13:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: constify the @dots variable inside parse_range_u64()
Date: Mon, 23 Feb 2026 09:42:59 +1030
Message-ID: <0110c5e6cd740b78989ec6fdd06d0691a88acd13.1771801832.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771801832.git.wqu@suse.com>
References: <cover.1771801832.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21827-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: D1CC6170B6C
X-Rspamd-Action: no action

[WARNING]
The latest compiler (GCC 15.2.1) along with the latest glibc (2.43) will
report the following warning:

 common/parse-utils.c: In function 'parse_range_u64':
 common/parse-utils.c:82:14: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    82 |         dots = strstr(range, "..");
       |              ^

[CAUSE]
Although the strstr() definition in man page doesn't have a 'const'
qualifier, it looks like the latest GCC has taken the 'const' qualifier checks
one step further, that any pointer that points into a 'const' pointer
should also have a 'const' qualifier, to make sure there is no
modification into the original pointed memory.

[FIX]
Just add a 'const' qualifier to @dots.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/parse-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/parse-utils.c b/common/parse-utils.c
index 9e88aa844b44..4fc9ec865572 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -74,9 +74,9 @@ int parse_u64(const char *str, u64 *result)
  */
 int parse_range_u64(const char *range, u64 *start, u64 *end)
 {
-	char *dots;
-	char *endptr;
+	const char *dots;
 	const char *rest;
+	char *endptr;
 	int skipped = 0;
 
 	dots = strstr(range, "..");
-- 
2.53.0



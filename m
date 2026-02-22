Return-Path: <linux-btrfs+bounces-21828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMmxByKPm2lP2AMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21828-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 00:20:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E776170BAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 00:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED02B301465D
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 23:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347F35CB69;
	Sun, 22 Feb 2026 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rHubPijL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rHubPijL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236EA26ACC
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771802379; cv=none; b=j+tUWOCYgG4EoMPL1+Lmtr7c0QtYuUHsgEqweNdDsbQKamTEIQtDj//02fL/eaOomnJ07tLkea6z1ZC9PZp/at4MJFK5FbW+EQ6H5wkJ4GTQ9Br+uVJKasY/yLU42S0EyFU5saeALtu+TCO3e2odkgpZv+kAnQNBveODKKmyMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771802379; c=relaxed/simple;
	bh=6xaDiP6aReIzkfOOn8xil+y4i04LBcnw+X2ah+Y7cMA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZWfbMOlxUwFQ3rCd4DIceeDRsR3M8lTNe6paRIzWLsPcWrgWZms7MgMewjV62+Bw454+kcSw5OFUmCRZx9QNoYRv90nc5AissqN0/yndnAEcqCAD6v6u71FbyG0KCFKjxh/k9qKdWY+REyBbFf8iuxLRRtkv6qGVxhsxhwmIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rHubPijL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rHubPijL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78ABC5BD01
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771802008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQPZYOlkeHiLqQZzYuM5QoSl7InkR1K5z+q+xbiM+Es=;
	b=rHubPijLaSwJLkY0XtEShJOqrZVFoWjcL0GfG4dN69amp1qrT9+bLenv0qMaLiP8EYXPR7
	LQ+6nFo9q2B8tGGA3/J2yrUz7Ah3PwbuRV9AeygfdLs1XBmcZ1f6l4y1Mn2Bip63aXaBzj
	WW4qcW9HelhGcpgVJ2mplatZgwHm2O4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rHubPijL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771802008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQPZYOlkeHiLqQZzYuM5QoSl7InkR1K5z+q+xbiM+Es=;
	b=rHubPijLaSwJLkY0XtEShJOqrZVFoWjcL0GfG4dN69amp1qrT9+bLenv0qMaLiP8EYXPR7
	LQ+6nFo9q2B8tGGA3/J2yrUz7Ah3PwbuRV9AeygfdLs1XBmcZ1f6l4y1Mn2Bip63aXaBzj
	WW4qcW9HelhGcpgVJ2mplatZgwHm2O4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B06A13EA68
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8L5/HJeNm2n0NwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Feb 2026 23:13:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: enhance find_option()
Date: Mon, 23 Feb 2026 09:42:58 +1030
Message-ID: <4f0ee51a24d281ae387f01db510e825e9259f73f.1771801832.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21828-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 7E776170BAF
X-Rspamd-Action: no action

There are two minor problems in that function:

- Latest GCC reports dropped 'const' qualifier

  The latest GCC (15.2.1) will report the 'const' qualifier is dropped
  for the strstr() call.

  It looks like the latest GCC has taken the 'const' qualifier checks
  one step further, that any pointer that points into a 'const' pointer
  should also have a 'const' qualifier, to make sure there is no
  modification into the original pointed memory.

  In our case, @options parameter has a 'const' qualifier, thus the
  returned @tmp pointer should also have a 'const' qualifier, or we can
  modify the @options through @tmp.

- No error handling if strdup() failed

Enhance them by:

- Add the 'const' qualifier for @tmp
  This also means we can not use @tmp pointer to modify the newly
  duplicated string.
  Instead use a new @i index to access the new string.

- Return NULL if strdup() failed
  And make the caller check errno for memory allocation failure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/utils.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/common/utils.c b/common/utils.c
index 23dbd9d16781..f183705edb8f 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -375,19 +375,27 @@ struct mnt_entry {
 /*
  * Find first occurrence of up an option string (as "option=") in @options,
  * separated by comma. Return allocated string as "option=value"
+ *
+ * If NULL is returned, the caller needs to check errno to make sure it's not
+ * caused by memory allocation failure.
  */
 static char *find_option(const char *options, const char *option)
 {
-	char *tmp, *ret;
+	const char *tmp;
+	char *ret;
+	int i;
 
+	errno = 0;
 	tmp = strstr(options, option);
 	if (!tmp)
 		return NULL;
 	ret = strdup(tmp);
-	tmp = ret;
-	while (*tmp && *tmp != ',')
-		tmp++;
-	*tmp = 0;
+	if (!ret)
+		return NULL;
+	i = 0;
+	while (*(ret + i) && *(ret + i) != ',')
+		i++;
+	*(ret + i) = '\0';
 	return ret;
 }
 
@@ -600,6 +608,10 @@ int find_mount_fsroot(const char *subvol, const char *subvolid, char **mount)
 			 * requested by the caller
 			 */
 			opt = find_option(ent.options2, "subvolid=");
+			if (!opt && errno) {
+				ret = -errno;
+				goto out;
+			}
 			if (!opt)
 				goto nextline;
 			value = opt + strlen("subvolid=");
-- 
2.53.0



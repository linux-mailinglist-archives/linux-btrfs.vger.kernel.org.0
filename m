Return-Path: <linux-btrfs+bounces-21784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCFpKkYwl2kcvgIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21784-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:46:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7A5160565
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74E843024293
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 15:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467F3341AD8;
	Thu, 19 Feb 2026 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja5uhdbL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A326CE05
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515943; cv=none; b=U7Z1s4wU23jO2WSGtKgqOEDRpBhPXJ2e5eKgBrh0E85PYffRnsF7wM/khBqd15IxnMQip4tFiQidsw5C6ZHSuFGmUs62dRhe/hkvZvF4ZSJCZt1njeB67ffJVGBWykZN6MMleg1KAnH9l+As5HFiDDgv1bQdd0JkOnczgcO8qII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515943; c=relaxed/simple;
	bh=tjT4qqc0bXMyFSx1RkAPRj0QgppFHyB0W9k3sokn65Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=i/A1xFADeTYGQFL2UrZuNO6wMWgpNlozIAEmbWPTGhpe2SCLW14nx4o1Jj14hT69ZAmie1M+YG9/LNj5HFGrtnJpF7vdtOd4yiwnwF8ExA5xN67MNVgKm55ojqoymN7AM0I5VXEwNwJQTRzi4SdmId8DTXAQ1M0jxTtZUjpJAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja5uhdbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4863C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771515943;
	bh=tjT4qqc0bXMyFSx1RkAPRj0QgppFHyB0W9k3sokn65Y=;
	h=From:To:Subject:Date:From;
	b=ja5uhdbLkQ923xUrKWjtJsn7xRAEbhqHLWP5sPl8JRi/5FJ9KKdh5xyIbVmUFDdAb
	 g6HeuliwxhrCehCTmLZfA1banmF82ng7wupennURqbiu/qiI5G67cfjpthEykkQkjP
	 I4ls/KKckjQX1SWSQ/l+XXNUCNi636aBtlzHU45kL8pNpf/fDNjaMZHdrXv8EfZb9Z
	 auW+Aqm+Qkc31D50vV0EHa+bMtJydaHbwaIoo73WhBZJFAWmrhEqe+o+G+BpBpKRVN
	 0jugZ/+y70vdMa9URG8RUq050U7GY0IdDOMYuOwsbFOzeOC1n331y9Lj/fALBbFeoK
	 7vIHsiZPvgDNw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: stop printing condition result in assertion failure messages
Date: Thu, 19 Feb 2026 15:45:39 +0000
Message-ID: <9c3463215d864eb706860e7d9c853e34d4125408.1771515807.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21784-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E7A5160565
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

It's useless to print the result of the condition, it's always 0 if the
assertion is triggered, so it doesn't provide any useful information.
Examples:

   assertion failed: cb->bbio.bio.bi_iter.bi_size == disk_num_bytes :: 0, in inode.c:9991
   assertion failed: folio_test_writeback(folio) :: 0, in subpage.c:476

So stop printing that, it's always ":: 0" for any assertion triggered.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/messages.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 81f59afe4a99..17cdc14dc89d 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -141,11 +141,11 @@ do {										\
 	verify_assert_printk_format("check the format string" args);		\
 	if (!likely(cond)) {							\
 		if (("" __FIRST_ARG(args) [0]) == 0) {				\
-			pr_err("assertion failed: %s :: %ld, in %s:%d\n",	\
-				#cond, (long)(cond), __FILE__, __LINE__);	\
+			pr_err("assertion failed: %s, in %s:%d\n",		\
+				#cond, __FILE__, __LINE__);			\
 		} else {							\
-			pr_err("assertion failed: %s :: %ld, in %s:%d (" __FIRST_ARG(args) ")\n", \
-				#cond, (long)(cond), __FILE__, __LINE__ __REST_ARGS(args)); \
+			pr_err("assertion failed: %s, in %s:%d (" __FIRST_ARG(args) ")\n", \
+				#cond, __FILE__, __LINE__ __REST_ARGS(args));	\
 		}								\
 		BUG();								\
 	}									\
-- 
2.47.2



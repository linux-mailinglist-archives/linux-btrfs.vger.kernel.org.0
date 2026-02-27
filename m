Return-Path: <linux-btrfs+bounces-22064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJitAeSKoWnAuAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22064-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 13:15:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FB1B6FE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 13:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5742E3071425
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF913F074A;
	Fri, 27 Feb 2026 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1ROi8j2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7330DD22
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194524; cv=none; b=BKuXbHfPA5gfYmuQsXxQcr4UvBbl3M73lYOq9yO5AtM8+fKK3fvhlhSo1VAN6CaKY3FOtvzCXP63W/+3wG1LOx/YyQbRshZ5Qh1+zO8E3xfOF5220GnPcxSHHXGJvS1c+y97R2copzEJcUq1Y4i05TgUOzhHfBoGnYSkE+X9VOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194524; c=relaxed/simple;
	bh=+NUuDQ/ESQssMB6OL2Ja5kT8CpJnPzbFAtyBO+h9Wbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SvwGKnS/BulcuInfB5AUlBQZ4v6x0JBODh+uTD1kkWjscnQfO1L9b/A+IujbuuklzYTH5rXYGXE6hM6Thk5BfMYpj8uhXycCBw3vHIunpfCpBaXpsSnRaTbvlWx8QeMcwKjuvnr9WJeraOXm1C/1IWxudRdHEUkHYgU/sKm/m4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1ROi8j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62771C116C6
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772194523;
	bh=+NUuDQ/ESQssMB6OL2Ja5kT8CpJnPzbFAtyBO+h9Wbw=;
	h=From:To:Subject:Date:From;
	b=d1ROi8j2xf1Qb5ViJfnd7hFtlMzlZZ3aMgSu27T2fn0Ey1+qRWIiyXhAup+W8fHvv
	 PpRU3P8dWAwK4E+8iQmCJXmz3rbpynBLagEDdT8iRiQYsP7RjUP26PDVZ1WIHog6wp
	 xjWGR7jyG5YGbTeTfWpG/fH+0l+/5eIl8tI1cxPUdex44KljqWYUZyVMuieYyoDr1n
	 8aMEXQK2nHfv60Eh4uF3FZOufKoxJcfJXl6CiyXdayciT7EMLl943ClMKpEGW/yPxL
	 a+zXEFiFwkbeDKfmKV9W+MW1B5+eu41k3TY8Nt3M2tU8WL0dTwW6Xtp++F+ORyvzf3
	 p2bqRvw3oLaPw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove duplicated definition of btrfs_printk_in_rcu()
Date: Fri, 27 Feb 2026 12:15:20 +0000
Message-ID: <826d740b6c68bc0d503bcfdf1d45ba0f38872846.1772194240.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-22064-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 958FB1B6FE7
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

It's defined twice in a row for the !CONFIG_PRINTK case, so remove one
of the duplicates.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/messages.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 666b84751f04..556d4e79cde6 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -28,9 +28,6 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, unsigned int level, cons
 
 #else
 
-#define btrfs_printk_in_rcu(fs_info, level, fmt, args...)		\
-	btrfs_no_printk(fs_info, fmt, ##args)
-
 #define btrfs_printk_in_rcu(fs_info, level, fmt, args...)		\
 	btrfs_no_printk(fs_info, fmt, ##args)
 
-- 
2.47.2



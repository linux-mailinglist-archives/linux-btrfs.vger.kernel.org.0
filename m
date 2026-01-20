Return-Path: <linux-btrfs+bounces-20765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EQcC/VTcWkKCQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20765-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:32:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE55ED3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 23:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D450F684A5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B836428484;
	Tue, 20 Jan 2026 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp7r88ew"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC03ACF12
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911961; cv=none; b=IO0NjSAf3/iwBMB/np451GdrGAk6241MwSSZQcfMtp4yQYFai2mu5LKmhOUg6qTDf7VkhdeEO1NlLmFGo3+9SY3vywstxZBlQQG57fh3yWq9w8fmH8W7amsx02EiClzW/bHKI+Oi2joF333f4r63Ycxw9FjkuN2SqKM/8xMdBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911961; c=relaxed/simple;
	bh=3SHmHMkfzjn4E8PkSTW+SAnghoahYJgD4pDjBcToR5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pREKhvYKwoy6/SKDHTXqLd9U2EL/CyhofL51D4i0wfKuwzXT/4O1SiLWnLDnc9eaZ9WslBuWIeFJA3/s/CR+nQ5byfJAOhXnxZ4p+Yr3YchgC0YHtP6LJTAViBtGJSuPIsGydULOU2NTVMCTTCXiuFzifAHU6CZWRGlQu9aReE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp7r88ew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F99AC19422
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911961;
	bh=3SHmHMkfzjn4E8PkSTW+SAnghoahYJgD4pDjBcToR5A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sp7r88ewKWQQ/pzY1xTqL8Atpgm3EAq7LlwFpKCZginbbZB2ozkANTGiNZrmt7HTj
	 Nqm8hVkZDqQ09xr1jyUdl61eApPZbgxP3TYwecsRQjG91dMn73NsN/P8Lv+6CFJGW9
	 FTOLqDVGRA2fArE2VWfH8XuZW8KrxoV3kWbkz4Q+RkIVq2ut8BMiOpVb7heIIDCExH
	 Svo6sOqpOokJFm0X8398fh9Fa6Afa1Fb9qP6THD6wqHJi8WB8GEuuCNuAw/96vgFyp
	 xlMeVRxVgIj47OBUjWAWeIV7fpdu7skj7j9IIpN8BKVz38BlddKfJnDuaDEuhq6oxR
	 nUviOZHDuVRMw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: assert block group is locked in btrfs_use_block_group_size_class()
Date: Tue, 20 Jan 2026 12:25:54 +0000
Message-ID: <529715e8be7197b1a2e0b3940c2af811503f1521.1768911827.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768911827.git.fdmanana@suse.com>
References: <cover.1768911827.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[34];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20765-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: B2EE55ED3B
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

It's supposed to be called with the block group locked, in order to read
and set its size_class member, so assert it's locked.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 82c488a4b54c..2efeb5daf45c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4749,6 +4749,7 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     enum btrfs_block_group_size_class size_class,
 				     bool force_wrong_size_class)
 {
+	lockdep_assert_held(bg->lock);
 	ASSERT(size_class != BTRFS_BG_SZ_NONE);
 
 	/* The new allocation is in the right size class, do nothing */
-- 
2.47.2



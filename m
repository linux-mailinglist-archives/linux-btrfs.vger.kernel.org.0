Return-Path: <linux-btrfs+bounces-21374-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE8THvBrg2l+mgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21374-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:55:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E99E99B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 16:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73BE130209F6
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87F421A00;
	Wed,  4 Feb 2026 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDmu7+VZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD82421F0B
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220339; cv=none; b=U7YDuZ/GbeNmoaEc44ODqgBNkFOd6jKpb9onjzxkIjZMn93VrzrZq26F5Y6+flD9y5vGbUVIuKOe+z8VDmuPgqxmov2EqpqRdEs53K+1ChHHbehGaePHHSTe5nKL0QxB5ZhZuPgXnIUj/FE4ovohDe4xUNhqu1roD1jBfbmsSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220339; c=relaxed/simple;
	bh=u6rH/MA9GyvKxn+7d4Wd+vJMHeFFCuklJ2zoIwBHlH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gs7kvpXrhzlPzHXIU+lY3Ms2nN5z4XiCE18jE8IvC3jJvZCI/DN/Jw2lHn1Kg0WlMp5Ymfy5SjCWHrTreAQFOb0uk8d//2T1Onb70P9ViBixcl+7qE5CauopGYmddkDJghiuWf0sJSzCZ7ck3EHjE8nb/1oFCDjCKBk6WCDYvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDmu7+VZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4D3C19423
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220339;
	bh=u6rH/MA9GyvKxn+7d4Wd+vJMHeFFCuklJ2zoIwBHlH8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QDmu7+VZHUYHUJkLi5mWY3qcFoFRXaGJJG+X+rFbDKMAjqmurD3686WvqdBSH7owJ
	 72VLF/jGoB0Ya7TBH67k0IbcQ/XLzneiXna0r/d712gyaqeQWZeaSeXGPKCbLrw5hN
	 Fn8/cmeuFnakmoMYohH/gOaJcNk36N1+uogpk1YArHBycAgqUSFTHLrmYs3Vm9j48k
	 fIc8OjKx4Wcp6UGjuXArHyGJi4h8AQSQbCA6w2zBCl55UpVVor2a9jhR/ieW4CY4MO
	 sG+aXnKQyimvns1Ee6HzY1SJ7ut4IpEfplskp/Av4er8uNUlFGMB8wFqGB7FVR/1kv
	 CAszgBu/TySNg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: set written super flag once in write_all_supers()
Date: Wed,  4 Feb 2026 15:52:04 +0000
Message-ID: <ec91c8271e892894ae2d4918beff1e31cc3d6dce.1770212626.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770212626.git.fdmanana@suse.com>
References: <cover.1770212626.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21374-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 12E99E99B2
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

In case we have multiple devices, there is no point in setting the written
flag in the super block on every iteration over the device list. Just do
it once before the loop.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cf4ab067be72..e95c699a0bae 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4023,7 +4023,6 @@ int write_all_supers(struct btrfs_trans_handle *trans)
 	int do_barriers;
 	int max_errors;
 	int total_errors = 0;
-	u64 flags;
 
 	do_barriers = !btrfs_test_opt(fs_info, NOBARRIER);
 
@@ -4053,6 +4052,8 @@ int write_all_supers(struct btrfs_trans_handle *trans)
 		}
 	}
 
+	btrfs_set_super_flags(sb, btrfs_super_flags(sb) | BTRFS_HEADER_FLAG_WRITTEN);
+
 	list_for_each_entry(dev, head, dev_list) {
 		if (unlikely(!dev->bdev)) {
 			total_errors++;
@@ -4076,9 +4077,6 @@ int write_all_supers(struct btrfs_trans_handle *trans)
 		memcpy(dev_item->fsid, dev->fs_devices->metadata_uuid,
 		       BTRFS_FSID_SIZE);
 
-		flags = btrfs_super_flags(sb);
-		btrfs_set_super_flags(sb, flags | BTRFS_HEADER_FLAG_WRITTEN);
-
 		ret = btrfs_validate_write_super(fs_info, sb);
 		if (unlikely(ret < 0)) {
 			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-- 
2.47.2



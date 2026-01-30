Return-Path: <linux-btrfs+bounces-21247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGMUJJ/pfGlTPQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21247-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 18:25:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E17D9BD07A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 18:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD022309CE66
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194343559F2;
	Fri, 30 Jan 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TylqoIfm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CC3502AC
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793303; cv=none; b=gMsma7TDAUC1JnkH9gBLjg9dIamcRP6QRdsOqwNIdDf2Gpp8Qnr8f4tuoK/ELEzvXTaPHVmy6NCMBX5+SDSXj7nPBGCqkfHmfi1i2zvFP2Z1mOwOlvRqsdkj0ndO3xGqmxOIipK9GlC2t/VK8GzGGCc3xhOR4SS4Fsy2w/q76EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793303; c=relaxed/simple;
	bh=1oBVXBZa/eCpa/43d95zNa6dwXqvoPAjnbpnFpZ1odM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pQVy7GJhMemFTbqRPsFQMaomjkHqLt+7oOObSH65V3dlmuv5OjnLtQ3PK3o5/qZ3jNXoBeNx7rL9/TtcoUAWKveGKbP2nYVfXK9TO1q6VSC7nNjwiYKRflo0fXmNxjT3MV/dldOU1aQ7m3CZG890KYgeWtVmVM2eioyk/Pj+tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TylqoIfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69798C4CEF7
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769793302;
	bh=1oBVXBZa/eCpa/43d95zNa6dwXqvoPAjnbpnFpZ1odM=;
	h=From:To:Subject:Date:From;
	b=TylqoIfmz6CmYRK99ZinRN5kvX9Ttc1HPEUE3pMlZGN+UhL0mFf1r7vUcwqp4TS03
	 cdMpkTVCcO6CjQVEqfU2iiuJCNEiq4NZLaGktje6PsEORwwxo8mpqBo+Sxg2/tkaXt
	 ws+LB082PbQqCUJpKTBzNWb4tzARWjky5J3S0pgrXRXWUAoWCpA3+xQqpeRT1g+XeG
	 7aPdFX6KKT6ngh8khsY5jmwwGTu0CJZfMvcviU6PxIvq8Gg3vEcB4k8LakkblMqlyS
	 S/SiUKJt9lSZgv/l9xwXpYLfb+SvenB+Hc3o3LXsmkCW8Cyx9IUjmdWTGrlBwhk1tZ
	 8z58NecQWLTBA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: raid56: fix memory leak of btrfs_raid_bio::stripe_uptodate_bitmap
Date: Fri, 30 Jan 2026 17:14:59 +0000
Message-ID: <140aedc1e1af2866bb838d29b742c2015d55d91e.1769793280.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21247-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E17D9BD07A
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

We allocate the bitmap but we never free it in free_raid_bio_pointers().
Fix this by adding a bitmap_free() call against the stripe_uptodate_bitmap
of a raid bio.

Fixes: 1810350b04ef ("btrfs: raid56: move sector_ptr::uptodate into a dedicated bitmap")
Reported-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-btrfs/20260126045315.GA31641@lst.de/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid56.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f38d8305e46d..baadaaa189c0 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -150,6 +150,7 @@ static void scrub_rbio_work_locked(struct work_struct *work);
 static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
 {
 	bitmap_free(rbio->error_bitmap);
+	bitmap_free(rbio->stripe_uptodate_bitmap);
 	kfree(rbio->stripe_pages);
 	kfree(rbio->bio_paddrs);
 	kfree(rbio->stripe_paddrs);
-- 
2.47.2



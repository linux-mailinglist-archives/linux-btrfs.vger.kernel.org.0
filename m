Return-Path: <linux-btrfs+bounces-21544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIC0Gh7biWlFCgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21544-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 14:03:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0DD10F605
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 14:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD3A83010B99
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84933D6FA;
	Mon,  9 Feb 2026 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6dsitC3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B41225408
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642186; cv=none; b=YiudzZa6IfTIW8fgMeDq/WAUih+JJDxVGCwg/2o9a+KvieNWviaXxtI82wb7OWts4hBc87LGRUXC6KUYZoZQ28ZGO4a4x5pDv6pm/Ew7eMUHLY9wT+b+crtKsLOn/HkAAtbYCwWmgqIuezLyn2UfMLjc2Vec3z6vqHr/WwfJEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642186; c=relaxed/simple;
	bh=FiWmVFcw97TnyLbLpy9SFEFhDTwcHVwztNxpiFS1W+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nlk+ldUB4NImSV9fSgwGaCuziL45po50heApm34sZcoy6wBVqc+KkSrFOjzq8F/rf4lXY3aU8gUt9S1EJCjKlkWAl5PMqGfTnEkY+eSTde5CmCDBKyJuD/c68pvm0ecEoi+Di74fTwvRUz7olNSYHMC+XZSXwPhts6idk3Nr1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6dsitC3; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-436333dcc42so228679f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 05:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770642184; x=1771246984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8on40fHUNvh/0Rrfckhi0Mk6qcLpxRLxVjuPB8Kea9w=;
        b=X6dsitC34xT+O1w5tvIHcttLm3vMGjTWceu0Pl6qYReC1cc0wg4JVtEbUyN2ctWQyU
         Pk3IqAKOqwGqeIbv2ZhJB+yO+nwouTNJCnLHEefOQ/wIp0g29yFHLIma5d2qkuLlkppG
         OkF6ksQ8lFsrYgu8JaResAnvORE5m2YjpTUVYSHBe8TsksVoPcR2+9MJPBxs5+lTwp18
         41C4+AHZmmaBvYxJIuZPzPUb47WMHzbNhRz0yKGeOTnpR1plURDGUziPDaEByibfu7Oo
         Pt9MpAZlMOEmeVxBjysXR4IjSeDqnizQD5hhnX365HOp3R+2zV3tM4g7/MYD/3L1+srk
         wBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642184; x=1771246984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8on40fHUNvh/0Rrfckhi0Mk6qcLpxRLxVjuPB8Kea9w=;
        b=hYiH3kOM41YTQsT04TQ6E6wL6Kazq8UaUaL354DmafcLiTN9T9Pf0vB43UdancWltK
         k81sQyx6ScXg4QRhJCjcEZgFw+p5LyAK73eTd2uXwiIRdg+X1YTVBW/2k2X4vhQSgJMT
         juVtmWJPoFJPGgGz/wFPKYxRubSFW4+ENLVCKxo905lxvmmNxoLe0B3pT/WLGXIENVEm
         N5mdg76umpSa29MFSmkzr0zDIZRg1xczXeOm3JUC0Kgf/jMkWIyQTnp6JdT8yGjSeL04
         nuXHUnOesQ4Vsy10hQfxjXTPSwg27vhT/+kUB/0QfqG9onad/s3NjKtXur6hqpm+Fuw4
         KhdA==
X-Gm-Message-State: AOJu0Yw75aI1vmzD8h6JWSCk/s/0HjpGQSwEU/9O8piq+LmUF958ehum
	eCN5NKvM/gHCSV/XozpwSKFvKJ1lo1OddlEDT+fxmpxvbsN0kZrUgoex6WNGEZlZQy0=
X-Gm-Gg: AZuq6aJpm2cieq8yhsRUSpkvs7qiMbO1R4gxYLnu55N9+RkcoqFJ5HuFvY8xkdj1gTp
	lWUNReMp/tRFCg/XKD8NAHJ/sJ/FWBbQ7fOP4+2LMKoFS1IpGuddXZYjBJriVZX17DrCFjIgsBf
	MHkFj5mdkismLdBKAlzaAdmL8d/BF51me+QugmjYMMjZjrca6jHUi+Ja6GKAteCqS+hX3hEc3rh
	6cf6lnDLGUC5zv2O+340yAb4VZP1H55qzluRc49MNi33cYVk54zpXMhIVpJAR/TC78iV/D/6BdZ
	SYelmoT+I6R2MZUZyNxZXp4ba5dnn/zORH9yyX5875V2AMkCPiZ5bOn4f0wjq4xAdOzJD8qm43M
	Y+Ns32c0telh8f56xA4NC5e824GPAMSD+xRmSNxfA9D51FBRFgsdW8sh5zPV54/pZkUmf7leBlb
	Hj2lvheIV2cegiOq00l7fZqHGxY3MVEQuD
X-Received: by 2002:a05:600c:34c5:b0:477:a977:b8a0 with SMTP id 5b1f17b1804b1-48320210bbemr113218645e9.3.1770642184016;
        Mon, 09 Feb 2026 05:03:04 -0800 (PST)
Received: from SaltyKitkat ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320978108sm133668105e9.7.2026.02.09.05.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:03:03 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	Chris Mason <clm@meta.com>
Subject: [PATCH] btrfs: hold space_info->lock when clearing periodic reclaim ready
Date: Mon,  9 Feb 2026 20:53:39 +0800
Message-ID: <20260209130248.29418-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21544-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: BE0DD10F605
X-Rspamd-Action: no action

btrfs_set_periodic_reclaim_ready() requires space_info->lock to be held,
as enforced by lockdep_assert_held(). However, btrfs_reclaim_sweep() was
calling it after do_reclaim_sweep() returns, at which point
space_info->lock is no longer held.

Fix this by explicitly acquiring space_info->lock before clearing the
periodic reclaim ready flag in btrfs_reclaim_sweep().

Fixes: 19eff93dc738 ("btrfs: fix periodic reclaim condition")
Reported-by: Chris Mason <clm@meta.com>
Closes: https://lore.kernel.org/linux-btrfs/20260208182556.891815-1-clm@meta.com/
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/space-info.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1dd65fae6349..931f0dc02b95 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2205,8 +2205,11 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
 		if (!btrfs_should_periodic_reclaim(space_info))
 			continue;
 		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
-			if (do_reclaim_sweep(space_info, raid))
+			if (do_reclaim_sweep(space_info, raid)) {
+				spin_lock(&space_info->lock);
 				btrfs_set_periodic_reclaim_ready(space_info, false);
+				spin_unlock(&space_info->lock);
+			}
 		}
 	}
 }
-- 
2.52.0



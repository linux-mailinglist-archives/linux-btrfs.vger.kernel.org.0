Return-Path: <linux-btrfs+bounces-3092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430308760E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 10:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAAD1C21F29
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F6E53392;
	Fri,  8 Mar 2024 09:29:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4A219FC
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890154; cv=none; b=Ww+CM1OAVp6tPiJ8aY+ARewJxkGLRJWdeKxSCuPYXWoEr92T39p1EbBweYLQ49PbwQTdCoOT+IFVeQd+fBixuGqGsTNfPHoEhDqQeDNF5mpwiL4FFTJSoS+ODntxahXX2SseY3vZk7I4BS8RGG+mC6JWE8OR69ApifsVq0waPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890154; c=relaxed/simple;
	bh=kZ3t/WKGo+LI9GUwUx3iRhjkTH5PN0VNBXzwYLIFtic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KV/n5Y9oKYV26T0Nonv6VuunUiP2QP9uEp2i18CaZsxMo9AeBOYD6cHaYRzt1fThA+t11Spm7v16REdkXH84kVxtFzIYv5TqRF1D+y1aqiNPwnSOemPy46uHNI7yB9vqcmdR6RPsqQXMR0PiFCYv5nNpg2C2Gvwb+rBWAzCzbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso70334666b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 01:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890151; x=1710494951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nA+u06lFd9KNH8FZ/gYucFV9eLpZeIs4yRD6O7LypsQ=;
        b=HhYZRL+tI6cgUpIEdkG1cyZlwtGbFLmapSv3oRFprX+6iJFhjQmKRm10t9+uyv4XaE
         BdWvdl68bx6ABow9CTk3wXshwzLg9bp6WQ5TGcYFi744iskgSt7CRpuEGvUf5KQinyFQ
         Id9mfa4FYGoT6md+dVtc/EhZckhyx4Yt7KAge4pNKbgTDDDcL7YxfyNJwNEv72MZ/xec
         VtVEz6wCHC8NcVStBng8Hg1xXLr57q3MoRgMgMlTF/t9F1tnMGNmhZTRevUCxZegYu9l
         E6wqlccSDUiFhUiGmZDX20rerSotnePVTHC1kvVurXisKbgHDTiFJG89ZxtKeVQIpeJ3
         KYxw==
X-Gm-Message-State: AOJu0YwwM66Mcm+cZrKRayVYVJqYn/Z8l26eq5Hutq9QHMqdTqi3RZA6
	5rq4tHctOqKBlApHx32rdBCiHyPUotICspauZa6bNQ8aQGMpEt3ZpJfojjfXxFI=
X-Google-Smtp-Source: AGHT+IEU1LX6du9tCtDJTSxHUoVjSJ1elVE8bWS8xYsfhfiitOkvtuLM/LPpUE5NQNevLEZl31aXdA==
X-Received: by 2002:a17:906:398f:b0:a45:b91f:2f95 with SMTP id h15-20020a170906398f00b00a45b91f2f95mr5127397eje.72.1709890150649;
        Fri, 08 Mar 2024 01:29:10 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ef17-20020a17090697d100b00a446b6d3f80sm8372130ejb.204.2024.03.08.01.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:29:10 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <jth@kernel.org>,
	WA AM <waautomata@gmail.com>,
	Qu Wenru <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] btrfs: zoned: use zone aware sb location for scrub
Date: Fri,  8 Mar 2024 10:28:44 +0100
Message-Id: <4d3e8c5cd6ba3e178a1e820c318d96317ac12845.1709890038.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment scrub_supers() doesn't grab the super block's location via
the zoned device aware btrfs_sb_log_location() but via btrfs_sb_offset().

This leads to checksum errors on 'scrub' as we're not accessing the
correct location of the super block.

So use btrfs_sb_log_location() for getting the super blocks location on
scrub.

Reported-by: WA AM <waautomata@gmail.com>
Cc: Qu Wenru <wqu@suse.com>
Link: http://lore.kernel.org/linux-btrfs/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v2:
- Handle -ENOENT return from btrfs_sb_log_location
Link to v2:
- https://lore.kernel.org/linux-btrfs/75f3da872a8c1094ef0f6ed93aac9bf774ef895b.1709554485.git.jth@kernel.org
Changes to v1:
- Increase super_errors
- Don't break out after 1st error
Link to v1:
- https://lore.kernel.org/linux-btrfs/933562c5bf37ad3e03f1a6b2ab5a9eb741ee0192.1709206779.git.johannes.thumshirn@wdc.com
---
 fs/btrfs/scrub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c4bd0e60db59..fa25004ab04e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2812,7 +2812,17 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		gen = btrfs_get_last_trans_committed(fs_info);
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-		bytenr = btrfs_sb_offset(i);
+		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
+		if (ret == -ENOENT)
+			break;
+
+		if (ret) {
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.super_errors++;
+			spin_unlock(&sctx->stat_lock);
+			continue;
+		}
+
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
-- 
2.35.3



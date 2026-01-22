Return-Path: <linux-btrfs+bounces-20916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PNtL0NpcmnckQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20916-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 19:15:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3126C2AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 19:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C963301A286
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5435366DAA;
	Thu, 22 Jan 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b="EmQjrz83"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6932ABCD
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104422; cv=none; b=PGoeUv2V7GLd3CZKbpL7fp6v2yiKqnd9dm7UbM+oAvMBHsnCV1nVPdq9QOPQsQPCCnjMfFp4Bt7fJJwnB12z92TlwvWsi7S9P3E28rOTaJHU2VJcNaqPrVDojP9RWef3GW/tvs7HlFzuHMktuy0NyIjzCHm6YjqzTnAya6sfkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104422; c=relaxed/simple;
	bh=ph4MkrfFZiGgZwbqdYpLF8W0UV0KSIJFHPiJUAA4y+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkbvQ1v1Ww2t1OqnpqUJ+UPGHs5BuH/04E6DQOfdO3wNDQ06R8DeN/bl3OVig0P9xdeKeuDkLa6lVAhUfXG8ofiyQjH9l9ibR6tVfR15EcZGyd/cQ/2C/ZsrZA5gEoXiS4yQWCWrQNmGgzy5pNqvhmQOxgmutXhGP+bSfdcqg9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai; spf=fail smtp.mailfrom=jingkai.info; dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b=EmQjrz83; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jingkai.info
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ee974e230so12869225e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jingkai-info.20230601.gappssmtp.com; s=20230601; t=1769104409; x=1769709209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ur90bBaJJ7RVP4nxaqzpx2n8fKZZiH9BbjOGcg/AJQ0=;
        b=EmQjrz83C2hede5Z1QuQ2WX6uMXfLbDjUNpMPWZDxs90Sa49njc1yvzwQHK3b48UZy
         tJ57r6H0ZCUE4IP7OJGBoRbstg1CAe+8T/d1mKVCp8xrlPJipmlVkgLsBg+i879gi/Hs
         Ee6O7ipZfVxfqJ2/6DeckMgqeAAPy+q3JaWtXpF4Uu+rv/jUx72U2AV8g7CjA9hQBU84
         rrGtof5eubIyI2JyMnTc5aQQI1pFn4Ff7QdR9H6ecRpDHbx9EgYSqC/skokTV7m+Vr73
         t/BjzqUyAnuVGK/N9rwji8XPHNiw1gCL5997nJK7l5IEoxDWsomHxWY7PL8BLBKTmUO4
         zsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104409; x=1769709209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur90bBaJJ7RVP4nxaqzpx2n8fKZZiH9BbjOGcg/AJQ0=;
        b=jl82+XQkOit1OoaQxVV8SWFfeRm3Ey9RSBCE5+ouUbiVqL3iozcaGPGss4vYvjfepM
         I7NxcEr9yosNxSfczjYz4spkzZ9ZWf0Mc8ZQH5IILRHFlmpXBV8NLNM0LuVJYsBFYpcb
         7pxOGvtQVZwd7cfjJOtBfNR58Ue49VfpbRvmtdHsgW+hNgdPWCNmKL0/OysT7XtbtIu2
         PCVemAWy9T2W1+Fs6t4uWa2oXhsru1qAYGLen4vDgpync0rZBuONh8WPjGAqYTvlS99F
         vm53gLoRGFmO0u9Cx9dbHr4voutbc8LzuVJTPywhVZhPh32uRYqjf5Am3APpzl735oXR
         ybAg==
X-Gm-Message-State: AOJu0Yzh5tiHGGx2B5gW4PscLrSODsw0bZPEzTPKBaiGsMNuFCtgK/Pz
	e/6DuDwK5eF4ufFeokQ7n8r6OEBAHk6T28N+0yr1LLzvBouIMj8nsl+mYj8YR+pJTts=
X-Gm-Gg: AZuq6aKTQu5KQnClu4d/nTruJz2eYQ0EgVSuMB/7Gt1CjiLSzejXubhrfTsmwgvwaWd
	ae0HYkHeby5YhiI5xUNEXN5pI6Zu37soow7VPqXDN1/gpzyzcKegc9isRXqN7m5COQtv2xG6UDl
	qdXL15/iJiDZ09hVpEsqXZtAjaYjRg+MnBZz8B06iR5fVRQleaVAQLrCFV3m5gvbi99AlsscMDS
	9aoTFoLKiDJxs/u54jNVWZ57CjJkvJzi0qwmwGCsXu4I3BbNx03VI3Lj9W2UdQ3ljQMKWI3jvkV
	ztOT1vH/qXV36dLn7CAXseMEue9KO94Cd36i3hZJ75gK1diiwhG0DJlYp8xZs3n0hmdxQ55ZVEN
	vnmWWUAzwIFrugRJ3VQkMc/pybyQA6+yj8rO1Gw3sUZmTyZM4F44y4gXFV88Hs620g2uMPKTwf4
	8gXD0hc5smZbRbWZdYLi6Kx4oO2pW8vb5RfU/BkFBYuWwhLSgdoKPkoeACiXq0+FzwMHW4lddK3
	vTlQsFYBPeRWRa7Y+Dy7e6829FrXkkQ09vM3xr8e64=
X-Received: by 2002:a05:600c:350b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-4804c954eedmr6331635e9.15.1769104408857;
        Thu, 22 Jan 2026 09:53:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:b002:8300:6d4:c4ff:fe4e:6522])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm325725f8f.2.2026.01.22.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:53:28 -0800 (PST)
From: Jingkai Tan <contact@jingk.ai>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Jingkai Tan <contact@jingk.ai>
Subject: [PATCH] btrfs: remove unused return value assignment in btrfs_finish_extent_commit()
Date: Thu, 22 Jan 2026 17:53:25 +0000
Message-ID: <20260122175325.7148-1-contact@jingk.ai>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jingkai-info.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20916-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[jingk.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[contact@jingk.ai,linux-btrfs@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[jingkai-info.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jingk.ai:mid,jingk.ai:email,jingkai-info.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3A3126C2AA
X-Rspamd-Action: no action

Coverity (ID: 1226842) reported that the return value of
btrfs_discard_extent() is assigned to ret but is immediately
overwritten by unpin_extent_range() without being checked.

Signed-off-by: Jingkai Tan <contact@jingk.ai>
---
 fs/btrfs/extent-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4cae34620d1..0d69c3067ed8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2838,8 +2838,8 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		struct extent_state *next_state;
 
 		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
-			ret = btrfs_discard_extent(fs_info, start,
-						   end + 1 - start, NULL);
+			btrfs_discard_extent(fs_info, start,
+					     end + 1 - start, NULL);
 
 		next_state = btrfs_next_extent_state(unpin, cached_state);
 		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
-- 
2.52.0



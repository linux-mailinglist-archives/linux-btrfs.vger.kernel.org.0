Return-Path: <linux-btrfs+bounces-12182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065BAA5BA97
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F12188BC36
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4622423A;
	Tue, 11 Mar 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL3NW72f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5471E832A
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680836; cv=none; b=cQEroxyNvuwMsXUDWbyKj5VK9QKiiQWz+eX13HVTA5SL6Z5x/A1uhBcDRKwkOewg9nsIY3o36U+V7dyQPVb+ZhAowYoAK91w9qKVapPxNCaX9tCPno/+KODKTq6xoWSAvd2NIjdh27BNhrIhMd5RK5jjpEZwln4l42ctV4NaSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680836; c=relaxed/simple;
	bh=uH6+ZQAnJ7kdEAC4hIA/V5DAngBGxPaoUdHNBL3Mbyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z03StSzggLz1NKAFy6asr8nh3ubIgtjid5NoTkiqbQlKX7HpPrgBjdi9puJFLo7+1nuAmJ4lYrDbvX+mOkQ+SdEwMF0eXz5Ir750cmKgMOnsCtqGN0g/H0jta2QbVAgy/wCivNEG6DQhRih41WxGRjwki/PrTeqrB++LYi5gFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TL3NW72f; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1298626a91.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741680833; x=1742285633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwJ/109U/n0Sv/yg42g0BTFRceKEmZB90J6nZMQ0RQw=;
        b=TL3NW72fS1bAh5kLsApx1jNuLhQ7eOJXPfEp9X5ulyFtnThcAqZQiJKtHTfz1L5M8z
         O5rjdQKsS3iuMHi3iEr9IYxLfaOgJMxeS1BeFVNo9SDDUiIP19gSpAujYc0++JtTurRf
         u14WXs+slCChxl22O1RZD+abo9ZbMGAX5/Xi0fJC6E+hZulQMztcVJP/xSEVqWGWVG4S
         26SRQMTocLfdpY7gNIAJesvK6UXV2RRoX0nEEMm11aFU0T91YewyphS185obCA2kkkMX
         kNRWKlZruVX6fHMTzeAmD8W0S3kjGbzaVfx2KTwgsWNvTwEV+7n8v8Ln0yQ6y/mNK2Xu
         Im9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680833; x=1742285633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwJ/109U/n0Sv/yg42g0BTFRceKEmZB90J6nZMQ0RQw=;
        b=EygJ9AkAMbZnoBru0uw7ePBXf/1Faa4qE0bAoDGX527VtKCkY6CW2Zn4XR0KXaIgGN
         X+AFckS3Q1cAzvGSEG2XZkHlHZIfIG/BDL2O+7EO7uYmtqLG4OlA7ToBLiA6Y/bqBk1z
         dYW0DE8KKplWGqyCAAh60Vs83ogO7lAap75kAxn9IMYYtyBhjLHcmyCzKmO2xJ8jZPBA
         7uRDvTpb98RkxbptCDSN3kr1b6fjWnT8Ny8k+UNPMqJ14Tydl76pkwSBPnq11MeTSOBe
         /HCm/lxStSjzQ4D/6Fre2KE6jZ8msfkh6clVSGoei7hMyYXNSLbiUy2PqpQmIFh67OoY
         PWYg==
X-Gm-Message-State: AOJu0YyB/shX41lvPOgK9AeM8+ZY3nujOBZJYAud4yZuF/CeFs5M66XJ
	VDMYdmTHzQAPpAdX3OimAgswRqS50MtLdpFILNaLsNqP0lD/HzXjst2+tv079gv7XQ==
X-Gm-Gg: ASbGncspbUio2j/p/B3hw1dbUxVa36TZfGqzK+PaMdt7qzgcwBwAftek6+pYExECp9C
	P6DLTtOzGrwV/6LQEM0uvTMKeq9zTEooeB1FpyUKkeFkX2JTNyMEX2SYqcgmWcUP8fTWvo65iBh
	JH/f/dj4tUIK0nXiCDWGVaqEt9ZM+hMLuKDrgO3JUjGjc29DUOFelbIt4ZP2CAO7Ef+HMwg19Yq
	TeNjFZeGDv10njCX5MuhWxkNWU0Zx7jFNC1zb0B/VN4/y1ZTTfmRDK1RQ9MopqRA9hOBnsuuMRT
	pol85t/CbDCT8rNZl8tg5MIO/vzlJvBOKn0G6D5QIZ7INAo=
X-Google-Smtp-Source: AGHT+IHh0bTYZXBcP9pXRYqTsskPCbDYnw9wjVZyhC+vstbxyr3C2n31aHu7a8MGYEL1FBp1J8nXaA==
X-Received: by 2002:a17:90b:2241:b0:2fe:b77a:2eba with SMTP id 98e67ed59e1d1-300a2b6fb91mr7085668a91.1.1741680833399;
        Tue, 11 Mar 2025 01:13:53 -0700 (PDT)
Received: from SaltyKitkat.. ([198.176.54.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5cdbsm91203635ad.230.2025.03.11.01.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:13:53 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 3/3] btrfs: avoid redundant slot assignment in btrfs_search_forward()
Date: Tue, 11 Mar 2025 16:13:14 +0800
Message-ID: <20250311081317.13860-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311081317.13860-1-sunk67188@gmail.com>
References: <20250311081317.13860-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moving `path->slots[level] = slot` before the condition check to prevent
duplicate assignment. Previously, the slot was set both inside and after
the `slot >= nritems` block with no change in its value, which
is unnecessary.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5f7c937b0f4d..c982960d8a91 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4668,8 +4668,8 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 		 * we didn't find a candidate key in this node, walk forward
 		 * and find another one
 		 */
+		path->slots[level] = slot;
 		if (slot >= nritems) {
-			path->slots[level] = slot;
 			sret = btrfs_find_next_key(root, path, min_key, level,
 						  min_trans);
 			if (sret == 0) {
@@ -4679,7 +4679,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto out;
 			}
 		}
-		path->slots[level] = slot;
 		if (level == path->lowest_level) {
 			ret = 0;
 			/* Save our key for returning back. */
-- 
2.48.1



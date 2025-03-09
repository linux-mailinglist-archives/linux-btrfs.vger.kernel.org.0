Return-Path: <linux-btrfs+bounces-12116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F99A58168
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Mar 2025 08:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83883AE969
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Mar 2025 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CEF186294;
	Sun,  9 Mar 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1EAhJKd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C41552FD
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Mar 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741507147; cv=none; b=qIkr+Jb8jg861cy10HHTKIXWX11emO/LnQ4G23GAW0vpYDimoJ6kXIMQp+o+cLVRyBscQ/JU8EC3P5hTTs1FiMsfN0YnZIhNz9WEXRZxB13DXff6CKrn/6VCGVPKzx///MV9phwOSGjBNns/0m3OE/cyhYu4ZaeqOuBfmjollOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741507147; c=relaxed/simple;
	bh=Ve4s7aGiM8y4vcPYM7nCCtNbmOoIlthihAi6bgI9Dqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjS1Fi2RKN3GMd+H2JrSThQGY8mk7LntTUlFPTTA70RmDdBOT6mH8dyyfm3B7xL+rG9h9KlgRAKut7CNVMzs62gtF5CjrGksxGnfXr0Fsx2U/mLs8H1x8+Y7J0ohH9c2cpB+kgTBKd3J0OlAYwv7K0PryX+CxuUq2TC1n9DuoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1EAhJKd; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-22400301e40so7184905ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Mar 2025 23:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741507145; x=1742111945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuzpFf40Lq+lguSb2T2VEyHqSsW/EiN8Pjo0DRTVbQ8=;
        b=j1EAhJKd7eawrg7dxwuLikB7ouDGlJXeJQ+wM/sug4YRgGAY+G+4PPc56I4F3vbSa0
         OKg8ckYql/FL+zp2Ub16Eop2G/VRKfbyvo6qIHyRIixrnm4SGytxTtYOXizyS9KOTnx1
         JZmWAexGLP0dgScWY+BUJ+KW5E2FshBph31iZoH7JMrFtu5ZLQ4RO6kJdRwCD+4RsL1l
         vuVsUq4yIV+GNmxkFkMHSvENCDS5wtvR5FxaYwjxCvOZKhqPe7bMdVgozOsnHQtPdUM5
         FF5K2M+a2+2gwxtI45ElAsRI+sj8hScsdrZF0pYngimtHMiJm+9RYw53heUCdlg3oTZL
         Y0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741507145; x=1742111945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuzpFf40Lq+lguSb2T2VEyHqSsW/EiN8Pjo0DRTVbQ8=;
        b=Lhzqy0h3JMBa1JTzB7Rxs8842YVbPK+XjohDgkJkA0W/n1qOs5nyw56dfd66K3Ek5W
         AQFp51Wqx7B/R8x8J4Cb48pF9SX73sOKhul62CArZIhG6Q3B899yG9G4lQ2cgn3Xci0A
         aPSdLleI57p36tNwAjRbytmJmb/XIc9RG1iP+tcV+Ppu4BtupuCRygv8cu56aLWb8WZ4
         8Ucaph0Bhk/qR1EiVoTDpwksUcFdtmbKUgMG/me7PrDOBS4/RbClNoaeHJb0LqCxZPcM
         d/NFfpvWGUlcpX3We5m/7aHpxc+ImYVr2BACOiJlY5I5Oqc05vr9fzk12RPXRwQ6yx9J
         qXSQ==
X-Gm-Message-State: AOJu0Yy9YrkxQXte5TL7mtQeGuLspIqsfN0CIW5h7IneiwXCTvucbsVk
	DKV0GxpVpnRgv7SB0fJM+orlWMIlKYVq+hQPK9qUZU6opwSqDfL0tvDKYSkd82u1NQ==
X-Gm-Gg: ASbGncsWZEkVlFTHGDmPQfRvMjbz1E0jdvTEbJg/W5DcSxFdkvKfuVZDWPxpaRttDu3
	sdWufaD+FN8dlYsYqZGTdE72kXhEq9Xi2leEiYGi1CVoqQzqMDiZzaU4eB6EXxGA8OBvm8/RIq9
	IW5he70liBZc5Y25xcyh2Uh7ZxVoUzgg63tEwjLLP0O5uifrlUsTYNqXgVUeEIAoduuESZiZFk7
	VGt5ONojo6TBa+1nM5gtK5KiCrItlQlMHKe9sABdc2cTUy+eu9lQKb/g9jnah1qk0UXqNsUDnk+
	Gubq83EJRTTO7WZmWKiewR1QxRM0YM9IvQ5HAIjBES6Hnw==
X-Google-Smtp-Source: AGHT+IG5xuwqwgs3HSRrUBhKPoos9me43B7+6tMQM/57k57MMaTxVGC9i/9F5QjDhGmeRMUVEPv6Aw==
X-Received: by 2002:a17:903:40ce:b0:224:8bf:6d83 with SMTP id d9443c01a7336-22541efbc49mr30131095ad.8.1741507145101;
        Sat, 08 Mar 2025 23:59:05 -0800 (PST)
Received: from SaltyKitkat.. ([2403:18c0:5:3e0:98c6:7dff:fe56:ac2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd627sm57045605ad.50.2025.03.08.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 23:59:04 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 3/3] btrfs: avoid redundant slot assignment in btrfs_search_forward()
Date: Sun,  9 Mar 2025 15:58:01 +0800
Message-ID: <20250309075820.30999-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309075820.30999-1-sunk67188@gmail.com>
References: <20250309075820.30999-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves `path->slots[level] = slot` before the condition check
to prevent duplicate assignment. Previously, the slot was set both inside
and after the `slot >= nritems` block with no change in its value, which
is unnecessary.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1dc59dc3b708..7e9562a59282 100644
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
 			/* save our key for returning back */
-- 
2.48.1



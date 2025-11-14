Return-Path: <linux-btrfs+bounces-18989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5505C5BC97
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 08:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AACC3A8DB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCE22F5337;
	Fri, 14 Nov 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQLFUBPD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7822F290A
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105235; cv=none; b=tDlO3/7b28HZe9Z+jewrhVUR/6kI8dCiiv9GZfX3CvLfO6PPgU6DAHLuo5R0tdYaruuZH/qC5hj4akcJkhiQ8mx+JNh78JF1S6gzxvBymN5Q9Rgt9e6kWMWZ8+D5ks4lHkGsQZOhJfAcoMH7aBuyfkm77TIsJx4ZZ+1N6gtvZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105235; c=relaxed/simple;
	bh=Y05pS0QUZ/Bz9IjUdpYP318cSV/izEKuPmDxJCnBZ84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/QDD+AhWD1dUuYw+iPzfCF0DvQDjeWvOKEXCPK3hBB6+dU+kuFOqd6Zws8N2odMdY5hohZ5AGwhSAt8qXh4vSg6AHfgxj0H20/Ar9cs6uZLmS6njy0jGXmfqRGXW1Mpf5oyrRzb5PldVY2vumy6lf8jwkQ3Y45fkfWWoEJWs0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQLFUBPD; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-343e2e1a580so335835a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 23:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763105233; x=1763710033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZNpgRBe0ezzMSagZPSw2SSxqxKQS4NhrRuYWPhIc+0=;
        b=RQLFUBPDLO6L8M6tLftR3E5Lb/FLr89n0ZE2XLIMLzsB/S/dfkJ+8HzoLfYeJzjIAZ
         Utv9tSKJq6d0N+CH/5v4dMTL47yGDGfsTk/bI/GNZeBVd5yoek+w3HTQenB3prkLx4L6
         ID1Xvamdequjh/YlQr9Bf4J6tRi58PCNXmHdBTAT30kfJ3YOaHTkzujpR5CQ1xDvXSl3
         ewo+LacvYfRabDJ2JA0R4adcTrwxtmnYEc4/yW5Ylsf6LrarFpjdEpJnrTsAVROZagKd
         hcverHPeDjCnuvG7/ZnzwJY1hUitTLed5LS0CcoO8Pwo0ZYLIOvPcw5P0CfQDSrnY9E3
         r8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105233; x=1763710033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZNpgRBe0ezzMSagZPSw2SSxqxKQS4NhrRuYWPhIc+0=;
        b=G356yPIDfE8XhFeT4JpvQXTwCo1SgfeHA94nGaR05jFhHfrYzX6LoCQeniMHW8maiZ
         4qiPeuzsss0QHQypbksEe7a3kN9Nq7nKPZXFo9aMh8SnFQlFKDSi0EFk1GG+m8sPWDoC
         qmELq7OOTFVoEe59K6dPxHJL/1d/oaOBPJw6Py+V2YnEeMZsUzCO0tWtNE9w/IZ3QVxQ
         PHMHDe8cnI4ERB9AG7yllyQ46AgAH+SDtKSEew7cS8MlI0Q+BeDXOSno8KqPMz69NRKx
         mtQgL86BW0R6TMy3wUdp2BLxaTjyAz4GmdeQpz4qqyQDqykzjVrtymGsz9TexphZhy07
         N/VA==
X-Gm-Message-State: AOJu0Yyi9mYclg9Omqe45iho7xySoJfitYJwNEJsQCw1/QY+eyc+uhVg
	jWDPjNt4dtYnRzX3PDOYd59EVopp9JA4Ub09yhxFaKbsFwmXPYW0uSvv4atcLJBYS596/am5
X-Gm-Gg: ASbGncvsBrYr5T8n50WSagD4JfLGgTAhQ8oxQZ5erwnxmSzLm2G89kx2bLW+U39juHH
	emaAbUrLAzluh+XwbpKZBVczZaYZmo9Pcd96wwGeogO6rioprqDH9HLk0l6cN3fOauE32g8LsZS
	zoYHrdbjEyHcK3ZY8/BMK+6w6QvO4o16jnX2hnvssCh6o/OCsOaqSATrgVkFA3H847jav30ziBN
	LW/B1iBLA75a9dV7kJReWsRaLDLeiEUY+cim04nz/sRAbNLho/BUOe+xcB8SFGajVSqw6xfXYbt
	ZZkJlA6MHu8v5guDGmp5o1q7hngYdT35eyRH9rmjCxpG3LXEcpnL75MbkOb252HButbaxJ4KPPR
	1fp5oM8AS9QjWuCDscFDh3pEz7LyDwVq4vng4Z9UZqxbY97HRZ1vXIDbM/P8tuva354mpg2Sxp6
	dwkD0StZlxR0kEFgvaJ6clEZTsCWW+XdJKp9NrXN5kLK1CbqI=
X-Google-Smtp-Source: AGHT+IGvnvBW2mLycFwfFS4YWDJdrGxZepdhi9U9EnneLRp4dTIOaVBK3afV/XeumFqVDtW+rmk0hw==
X-Received: by 2002:a05:6a20:3946:b0:341:10b:da0f with SMTP id adf61e73a8af0-35b9fb7f291mr1636918637.2.1763105233083;
        Thu, 13 Nov 2025 23:27:13 -0800 (PST)
Received: from SaltyKitkat (160.16.142.119.v6.sakura.ne.jp. [2001:e42:102:1707:160:16:142:119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36f42eb0esm3947084a12.13.2025.11.13.23.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 23:27:12 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 4/4] btrfs: remove redundant level reset in btrfs_del_items()
Date: Fri, 14 Nov 2025 15:24:48 +0800
Message-ID: <20251114072532.13205-5-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114072532.13205-1-sunk67188@gmail.com>
References: <20251114072532.13205-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrfs_del_items() empties a leaf, it deletes the leaf unless it's
the root node. For the root leaf case, the code used to reset its level
to 0 via btrfs_set_header_level(). This is redundant as leaf nodes
always have level == 0.

Remove the unnecessary level assignment and invert the conditional to
handle only the non-root leaf deletion. The root leaf is correctly left
as-is.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0ef80f2a2a8b..3c4aea71bbbf 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4524,9 +4524,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 	/* delete the leaf if we've emptied it */
 	if (nritems == 0) {
-		if (leaf == root->node) {
-			btrfs_set_header_level(leaf, 0);
-		} else {
+		if (leaf != root->node) {
 			btrfs_clear_buffer_dirty(trans, leaf);
 			ret = btrfs_del_leaf(trans, root, path, leaf);
 			if (ret < 0)
-- 
2.51.0



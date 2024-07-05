Return-Path: <linux-btrfs+bounces-6234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE325928B6B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 17:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4241F229B6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 15:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88C16FF52;
	Fri,  5 Jul 2024 15:14:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EF16F0DB;
	Fri,  5 Jul 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192446; cv=none; b=S+OmoUisQfjQ2459SW+VoauE4GH6VmRaL28lRlF8hZlA0cfP8VeFsTeitv3i2AW2HR+7bxsXDXwc4XiP7S+LkkR/euz9gGqlCHAyEqizmNMe/fqSA0LQr0pmqb6zC7LmJ9WelNYzj2wtW6D9KjTH3AqIdrLBgrAo2jhK2PfbdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192446; c=relaxed/simple;
	bh=ekFx6/UsvaA/3yvaH2RA9a1JPfgBUUsMZ08ssWsFV38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSiBpwJtqzMZVRtFs5pJMow4DoDkhFk/2nJ62pR57dMMQ6JLElbCwvU8grBOi2yIt/2jCNJLDItG8gEBryI6Jf0kFsDgISo1X8MDzrdhF5TeP/d4MqGTgc/0XgTPbUr6MkTAv5O2/Av/BqKIQJH22JO4miOpOV8vSYLU31CY/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77bf336171so255800866b.1;
        Fri, 05 Jul 2024 08:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192443; x=1720797243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f892GFCIKQxBKmRhb+6kTPzjH25qhEZtsnNdHLdYsBk=;
        b=hNPQLW6bfc6Meovcbaisy7lKiaJsyl43iNqr1hEs364LV0o0gAyXnJEhSmyVsLj7Qq
         BVujgty32WfRCPzr75k7hOZC3BadoMYByXY4tM+Xg/TM6n/w4JUMIStXE3Yj9WTkxQM9
         Eidm3G552mQYjUM6dv5ShwKV9Z63Pp5B6XNXxNExP88KNeNnDM+r9MBUqrQlc/x4dsul
         lLK/7Et0WcEf/ISo6pDGmxyF/55sEZJET6Ai9cjJQlnS6uCFT91QahaCOxUi2Dlf+kaO
         qfHD1wyKOrmN3NO/gZWHFxiwvVw+ZmbOEabxAqOGBytZsH4fcn31RJdvTC60ZrlaZxAX
         WyVA==
X-Forwarded-Encrypted: i=1; AJvYcCW4ct/XBNDckBLJx07p6bDzgQ2nQCOoxwhPHqxVZ7tUShF0AgPB2PobosVhXjyZScsvqtx1JRT1pUqaShmKE0UY692hML3Hr8lGyja+
X-Gm-Message-State: AOJu0YwX6SMhieEdTxzKNJ0DKI+0A+Kq0KUf+CVMbtOH5CsTN+B3GLnc
	4O8LjLi2E7QpFqRcYcGGTUCX59vWE/vvgo853DMSaXwMFem9QxbCVwuq9w==
X-Google-Smtp-Source: AGHT+IFVxUY4sS9mTMtIhBvzUNkhz102rbCJKUOBFxcXi3a7FVoUIs9kA/GosIGgRyTTCvjRWOTCfw==
X-Received: by 2002:a17:906:32c2:b0:a73:9037:fdf5 with SMTP id a640c23a62f3a-a77bd99ec77mr405247566b.6.1720192443334;
        Fri, 05 Jul 2024 08:14:03 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6336csm686226566b.70.2024.07.05.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:14:02 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 05 Jul 2024 17:13:53 +0200
Subject: [PATCH v4 7/7] btrfs: stripe-tree: also look at commit root on
 relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-b4-rst-updates-v4-7-f3eed3f2cfad@kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
In-Reply-To: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=jth@kernel.org;
 h=from:subject:message-id; bh=8UH5N1FhZ+1tzlRwIIfBMRwnha9ThVa7PaBu24T5R78=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaR18G6aaVT5qmB3rMWtWr71v6d6vzI5fvzh11/zc+duP
 Sso+W99X0cpC4MYF4OsmCLL8VDb/RKmR9inHHptBjOHlQlkCAMXpwBMRP8zI8MJt1MrUhbx91Uk
 RkxjWZdcGv1eK+OFwfkjX3Yfk/K2FLJgZNgybWXVX05LZf2Qm68evWLX1J333vf4nqJVLLdrz69
 ivsgDAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When doing reads on a raid stripe tree enabled system while relocation
is ongoinig, also look at the commit root. The data we're interested
in could've just been relocated to another place in the current
transaction.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 5f36c75a2457..948509ac343e 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -679,7 +679,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t ret;
 	int error;
 
-	smap.commit_root = !bbio->inode;
+	smap.commit_root = !bbio->inode ||
+		btrfs_is_data_reloc_root(inode->root);
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,

-- 
2.43.0



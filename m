Return-Path: <linux-btrfs+bounces-5024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055008C6C4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378141C22157
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796E515B0F3;
	Wed, 15 May 2024 18:43:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2D158DD5;
	Wed, 15 May 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798595; cv=none; b=m2xz/u2r7UJGoM08YWsZVsaD+8pV86tohSLZXSdZpthn2GX2uEU17P1sfE8prgpapvkI8X5MEQqSg/RXEcr+ezVVp4g86e7GPH7+4Q7OoOeZGAyS1e1/K+zP3SbeTKS6FnUYu+kqRbZckQ+LLjFE9mr8KXiql3fbJyyRoDlxZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798595; c=relaxed/simple;
	bh=I30Vhpj8EVIl5JthiBQGyCxsDgNZC8fbrcCKCLmrHo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXUAF6KQs47o6Db72QlVkEBPLXw1fe7Qawz+l9nKR1zi57Y8Z/hTG7bzmwztUWYJoa3+AlSU7V3oENATYzOl/9/fFx6xzHBSMuDkdNzqbBN7b2S/l3LRghB6bTiIOKxT4kGljHtRwzp2ccVKGotLCymfGHLEtwz5VkqQtr+Uw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so2445801a12.3;
        Wed, 15 May 2024 11:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715798591; x=1716403391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEAE6xbDs/+0Eq9mSk19zWnTmnU0CIS1H4H5SSEeI1A=;
        b=Z2CuHLLOmtUKSQvTvkeDH7EMOs1AbSIqCMxmQYsprTp9oL2i/8w9s/hnAm4a7cJsoG
         qdoD+s/fMLlQy5vjV8Aaw+g0ZplANmCaLm7BGFG8SmHKnfggvPyLRVVH4mJUAihotEjn
         ajgGU/TfAjzSWzC12TUh2ROpbvNG8yfAM8X0XJVjP/PbQfggIoZnxzr+PMnCxFnekZ1S
         RewCNDRtdc/Qqv8SvRtYBcsZqaAPmTdjolf246d5vg71yI6zWUZqzKU8g6EtxmWwIjX+
         PHlnKZXYGxWqbSKq5mYifwKnU29tGdhhCOKNDr2PI4mt/w7eBqJRKFjswCbcD/+QexsD
         LuQA==
X-Forwarded-Encrypted: i=1; AJvYcCUiZV1XlKQABsO+TKAbOgAEiPq3zD2zRCDaF+1Ab1KQGmjHhquyAPdxajvZkXUR9ZlRrRUpEmYIq3knmROcWIFHLsUNhhY8spqb0SiWYDHIHUfua1VHb9cWXdO7BVWwcyZsx4qPCokOSjM=
X-Gm-Message-State: AOJu0Yzd2rkObmkAh79CGdAxMehXnxYuODOTJaf6rMkJ3BK8oEgOUOuU
	U9FoAxEbSm8e1W39dw30pHFJ5LuYJjA7y0imP7wxDJOLty3AKn+7
X-Google-Smtp-Source: AGHT+IE9ekF0QPTVFFMIrkv0XfgC4mUGkWkHGEqUtFReiObq7KlsVHL2ml7FKiVgPfSIWZO6mNMT9A==
X-Received: by 2002:a50:9fa5:0:b0:572:a14b:2d2d with SMTP id 4fb4d7f45d1cf-5734d6ef9a7mr16686267a12.31.1715798591407;
        Wed, 15 May 2024 11:43:11 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f4a6280csm1724340a12.52.2024.05.15.11.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:43:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 15 May 2024 20:43:07 +0200
Subject: [PATCH v2 2/2] btrfs: reserve new relocation zone after successful
 relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-zoned-gc-v2-2-20c7cb9763cd@kernel.org>
References: <20240515-zoned-gc-v2-0-20c7cb9763cd@kernel.org>
In-Reply-To: <20240515-zoned-gc-v2-0-20c7cb9763cd@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

After we've committed a relocation transaction, we know we have just freed
up space. Set it as hint for the next relocation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8b24bb5a0aa1..19ddb0f6fbaa 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3811,6 +3811,13 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 	ret = btrfs_commit_transaction(trans);
 	if (ret && !err)
 		err = ret;
+
+	/*
+	 * We know we have just freed space, set it as hint for the
+	 * next relocation.
+	 */
+	if (!err)
+		btrfs_reserve_relocation_zone(fs_info);
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)

-- 
2.35.3



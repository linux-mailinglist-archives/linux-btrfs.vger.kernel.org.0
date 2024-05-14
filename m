Return-Path: <linux-btrfs+bounces-4993-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4858C5CB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 23:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1EB22753
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F1B181D17;
	Tue, 14 May 2024 21:13:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF2181B9F;
	Tue, 14 May 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721209; cv=none; b=K0T66ILiZDLYgDQXx9BL3HR0RWSviKbNvjDfrcnZxOFeMXefrxIpwYaU6bBqbWX8ZxZQzBXWZlezr7rPojPjKYXNfRrWWZVaYfBjSi4ziUBlKnI1MO3NzXiMMjtCjNMRKPKzwpTDFy7ZNxKIELSMCBKvPRyZFucI4zAHqNCKV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721209; c=relaxed/simple;
	bh=ATU2S6O+geTsJNLo31fAURuI/xPsoz4iJgfbeBm3unQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHbp+aWoR4Uyml5RDrqnC6HgCUhRWlSv59W+MVwlPDh8Zp03rUokAUUPdtLukg8+FExh4KuhSspKsq0kx1B+Uf2qfG3G1dFUpSedh16k3eBzd66gXpCxUmlFC1IPF7uscR6JDwVBeye79hgNgI+Eaaz0xbZcdnymQ4/mEpunzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-574b3d6c0f3so863369a12.0;
        Tue, 14 May 2024 14:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721206; x=1716326006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJqWd7hRdu3vwGC2M3wXyvFbPBuQNHh/4xDSO54NfEk=;
        b=pkjwdq9yPHYQGGpQoXekqV8TKcVbKsAAf/+FYOfluoIavDjhdcz+BaU59vgUk6M78O
         gw0K88aYdpxm6JGbhUlSbDPiKgGsAxQ05mtmz8nwEDOThu/qy152VHjUvkh8ViI2xewN
         DNijjNdthXQO9MijzQ9WAbAbIQJqEwKZPBpEqqB6JnQSw3ezGWyf6I+T0AcSf9YMgwEJ
         mj9mg9InnZ0JC8TzDXFlAK7Vuywcvu6P0frzr67HuHm/tRti9bcSS1Pplt6sUt3pGB9/
         fk1ldCRd4ZTpCv6Sq0YjT4ueBFbVv53c2BfdnreMS7wGIP05mHJBSwWmuqy0cMH8QUjz
         IBkg==
X-Forwarded-Encrypted: i=1; AJvYcCW+hyIAV9uSxdvtC0M38cdnCo+zFI4pSVtzzFd4sPLI0O4C5obGD+OQzSjTMNur3V/ETzn5OCofuh32US2i34ootEWOmjPYuF2Na8TqZEkFfAIljrpR9GSXvW2Xth77Mp7nSRpd+nf7m/k=
X-Gm-Message-State: AOJu0YzrYKAqKJi1vwBEf8va4WA7iCpN8CCBFim6xybM/S9ZHHxVa5kU
	8V2qnNVMkv0FiNK0Z2QN23exc8v39zZtvQ7nBoMjnVrbV3a79l2W
X-Google-Smtp-Source: AGHT+IFpV7ZGZeDVkBJZ7eaqU9QlSGuYXKp2pxmFrGrJA57g7SkleXtRHcItfTLGC3FGxh+mzkVX8g==
X-Received: by 2002:a17:906:5655:b0:a59:8786:3850 with SMTP id a640c23a62f3a-a5a2d681266mr932535466b.72.1715721205747;
        Tue, 14 May 2024 14:13:25 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a178a9d73sm760229766b.67.2024.05.14.14.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:13:25 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 14 May 2024 23:13:22 +0200
Subject: [PATCH 2/2] btrfs: reserve new relocation zone after successful
 relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-zoned-gc-v1-2-109f1a6c7447@kernel.org>
References: <20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org>
In-Reply-To: <20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

After we've committed a relocation transaction, we know we have just freed
up space. Set it as hint for the next relocation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8b24bb5a0aa1..d943abf5cb33 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3808,9 +3808,13 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
+
 	ret = btrfs_commit_transaction(trans);
 	if (ret && !err)
 		err = ret;
+
+	/* We know we have just freed space, set it as hint for the next relocation */
+	btrfs_reserve_relocation_zone(fs_info);
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)

-- 
2.35.3



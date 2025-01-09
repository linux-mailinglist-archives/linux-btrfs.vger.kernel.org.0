Return-Path: <linux-btrfs+bounces-10850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AABA07B88
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4371166339
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85B21D5B6;
	Thu,  9 Jan 2025 15:15:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8721CA17;
	Thu,  9 Jan 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435723; cv=none; b=fw61xq93LPKnkNlzLooHF4hh5lYRBjXHcM+xbjCIE/xAxLHC8kBoLbX0tpLJVgVc5gOogNE+SnxrQ7yZhGiXl/sEUx+OyWkdHi2l176eGW9uTt/noYGqfr4HCnve4AxI/3OOVa84gW6I2GKAII0exjhmKoeoID3zYMC1iUhYmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435723; c=relaxed/simple;
	bh=7m1P2WMNKMiLMgmu1jXxFcDWxTXkJUpg1PzMqMBDVEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6Q2dnNs73fXYYhNtuAkw46raNUURyYtpv+bbzca5T/I2USE6GTs1mTruoIK640XtjFd2bk7i3/wJjKXQwvHRjVipnJQHXkE/p6f4RP5DpLLrktx4MsnJbAX7hSTR7WyNmw5zW1F4ej+2sVLLpbVTYs9qKyVvWyi9neqH8hwQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso211569466b.3;
        Thu, 09 Jan 2025 07:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435720; x=1737040520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZsPMEezMKhEZXtJ3m4i/eKlU2y6sEdgUqz8mk4+cE8=;
        b=O5xf/p7X64jnWUWsdorRQD2Vkbthj7M2qkaYTk28EHO7HBXYspuJIBMW1byldhbNuR
         8X3mna4h5hACpm9ahCtlqvq7IiBVgNuH7B8/kj7jDx8ZfirlsL91uXXo9cx+eCAeJWnI
         TPyc+XpLPBYvxK6lDtYwo5c+UKMsbgqlJmVCDkv+uM2xHWopz5hm/VYtEw/RVqewzCHe
         9GKf8S8U3hQ4tr6uttfSwklx3EV9sfcK6KyHg2DYoqfyYzG0egWSB7S4mlV8RiyA0fDx
         Ta0WApUc1xbFoCrAIeYqfNf7UIA8XU+IwFxl5BUDNRAh9FU7IpHjqhNr1LB+xeFKa/EL
         rgTw==
X-Forwarded-Encrypted: i=1; AJvYcCURWWMxiz5eIaJXDfnynDiCOU7AMVUy149dfCRdurF2OgdIvMrJWZfGzFX9BshtisrA/+HcNitC39eifcbI@vger.kernel.org, AJvYcCX0uV24ELkwtzrpQf6zMWa1sR4B1tVb55d/LzMj7YQMsWSwq/tMYosYzYH7jxXmAqn+driuRKJBHifsYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpupAWXFA5J84q127i4vGHyWSejsvctoDBwZwP07QKAV6HQOV
	lneAFMneOB1G44HBAij2/fINmrkLi092NhtqP5+1RIg01AiEdJt3
X-Gm-Gg: ASbGncuFDXgiawT6r+v9rHZFRAvc8Njq0hbxNZ1MSAc6xtjJmF/QG+r+jfK/IExfSbk
	s+W78Y3Ydq2Bd0IAgTpc5Zq8a8eS7nj3+7W/cVCDQjhUX1mlGuV+uRRU7h/398M6xfsyyfWtZvB
	+7pVRc/BPBK6bF5So2ApA0gip6jYpMbPeIFFv1wmuoXxFXc8iZxBuo5L4y1y2JbR8UpucA0GsQm
	+oCcvUCgPhrRXLmVYxF32gmJ+mOSNG+N+zDoijwkiBXEAEX+hcbW2Njl5rDPFl+3vBZmYK1Dp9W
	+eD6iv/ckyfzqoY2WaIAVXNcPrht9P9UOdi1
X-Google-Smtp-Source: AGHT+IFLIS04qqyGqzlRZ5P0W194aznwzcHcQbxiQS3JxGmT2PGbdCWZ6vCUfMt+OWVG2KHiq8wlVQ==
X-Received: by 2002:a17:906:c14c:b0:aa5:2575:e75d with SMTP id a640c23a62f3a-ab2ab6bfe61mr656555466b.2.1736435719534;
        Thu, 09 Jan 2025 07:15:19 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:19 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:02 +0100
Subject: [PATCH v3 01/14] btrfs: selftests: correct RAID stripe-tree
 feature flag setting
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-1-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=jth@kernel.org;
 h=from:subject:message-id; bh=602kjni+87ScGLTTRcJreyPkEJNwSWrWWrRwoSU1jmQ=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2B+7379917fqToaP9y88gS2BTJ7n5ReNeVOpoTmk
 5PGdzMXdZSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEAlYzMtw8u2UK25VpJb/+
 qaRocJz84nM72v3HRd/HPXc0+qe384sw/Hdqk1XYtuDwL3ZRHpuuB5tU2Kzba6ev0vmoVvFsEkf
 HSnYA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

RAID stripe-tree is an incompatible feature not a read-only compatible, so
set the incompat flag not a compat_ro one in the selftest code.

Subsequent changes in btrfs_delete_raid_extent() will start checking for
this flag.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 30f17eb7b6a8a1dfa9f66ed5508da42a70db1fa3..2e8083f1d0d184a23317facbb566ef949639a8a7 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -478,7 +478,7 @@ static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
 		ret = PTR_ERR(root);
 		goto out;
 	}
-	btrfs_set_super_compat_ro_flags(root->fs_info->super_copy,
+	btrfs_set_super_incompat_flags(root->fs_info->super_copy,
 					BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE);
 	root->root_key.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;

-- 
2.43.0



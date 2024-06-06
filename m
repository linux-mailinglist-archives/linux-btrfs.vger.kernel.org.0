Return-Path: <linux-btrfs+bounces-5493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD68FE10A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F951C24654
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DF13C9AF;
	Thu,  6 Jun 2024 08:35:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1B1328A0;
	Thu,  6 Jun 2024 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662915; cv=none; b=cdIQdiVmnsY3IdM7g3lmRZmOPNQeqj0SHvocgJogZ1EL4KyIcYyEdQQ8HA4pSv9T9/Ae2vCO6WjpREB8cQ2d07K/tS7T12jB0rNFjjWQkujeKrfijFcANVoo13af8TGaLd9dBCnyB+EvKKQ9Z5b4bgCFQV9TGuqy6+GJnzL+d5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662915; c=relaxed/simple;
	bh=nrPlPu+vqctIKgQjjWQn/wmT8cS0gnl9RdBb7sSooyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwBNFgeLMnzc/th9RUdkJobNPe7mqngHMsappdQwn8AZwTRr8w0b0R1CWa9WgKxIBfAg7dsE0vj952OkwW8JcAX/QSIFNblgLCjwuvX7JMiu4Uo+A2ZEWxIejwQtvNFhflCH3OxHBvdQz75+qAjWP58YSebU9oPt4XTzYZZsEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a68ca4d6545so119933866b.0;
        Thu, 06 Jun 2024 01:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662912; x=1718267712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajaptr92AkTMxF9DLUxB3pN3cxARsrkqoOMgRin2Hos=;
        b=pPpBdtEj6+EgMPiUtqsbSuT9RqO6SIMC8RkVh6SaoW0WMwpbFFiC5J9JIhk8W9Iwk+
         NOQv/BKXOKs0aYrGxUbtlJiBaXsScpOLQqfKNu0zLU61gUJvmK8uE3SfgMe0G1qu0flO
         z6Oxl8EysYaRppTtxsM2trppAvK2gNen77zvkEquVcZDp1VrJtHpZHY35SlMhrbhQjU0
         mVZcta3bPAt77vpcPF3wxeuZQk7qI9DtWqn5mo6qKnCRFpSrDDXgGPbscQwRzWR4YeWK
         4YTraMb2KVG5SmAggp8QmYRNVcYo9mp1b5nKTdYJKb/Gj6Ufw96vMHWwaQMWfJyEAi9n
         qHtA==
X-Forwarded-Encrypted: i=1; AJvYcCWrPTwLSUwBoWh1n+VKtmcMUH6/5ULkOA6vGvuN7BExO2C6h2YyEG+BmWcIYyz7SKDkzYSL2EY8hZpSiOkTdFFI3F57UX3eo1akRf1c
X-Gm-Message-State: AOJu0Yxskmowga9P4A1WOANHNO8o+I36esHoCDe+5bbNW/cXYwOJkqmt
	DQkFhnq6ZHlE5rnxYixtz1kGe4hi+FGGX7yKd6P0/AhsHTOER4waj2qeCA==
X-Google-Smtp-Source: AGHT+IG1k2A2nEo+eAd2B4yK1AFmD2j1FXdphTIeHn0SRBTaiBBtAONnXsbr0g2vmV0E1y+HItTcaQ==
X-Received: by 2002:a17:906:9a85:b0:a68:f2b3:b075 with SMTP id a640c23a62f3a-a6c75741c2cmr185824466b.0.1717662912336;
        Thu, 06 Jun 2024 01:35:12 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e99asm701338a12.17.2024.06.06.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:35:11 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 06 Jun 2024 10:34:59 +0200
Subject: [PATCH v2 1/6] btrfs: pass reloc_control to relocate_data_extent
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-reloc-cleanups-v2-1-5172a6926f62@kernel.org>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
In-Reply-To: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=jth@kernel.org;
 h=from:subject:message-id; bh=iosbNk+jKEdT/C5EFn1R+Rv4UY+ilsoTJw2nsGDr2tk=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlluy1vz8v5s5M17vHtummXOyMbym/9Hbmqbu8xR0Ns
 2MuJgcHdZSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEJocw/LOf3MRSuU1P3mxn
 99aMiDumRU5sM9bocdvyS6amzNaqbGZkeNu4RJhltx6rUuWiCJvXKhkLTNyCfILXPu8y95hy+1I
 lKwA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Pass a 'struct reloc_control' to relocate_data_extent() instead of
it's data_inode and file_extent_cluster separately.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 81836a38325a..442d3c074477 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3123,10 +3123,11 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	return ret;
 }
 
-static noinline_for_stack int relocate_data_extent(struct inode *inode,
-				const struct btrfs_key *extent_key,
-				struct file_extent_cluster *cluster)
+static noinline_for_stack int relocate_data_extent(struct reloc_control *rc,
+					   const struct btrfs_key *extent_key)
 {
+	struct inode *inode = rc->data_inode;
+	struct file_extent_cluster *cluster = &rc->cluster;
 	int ret;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 
@@ -3745,8 +3746,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		if (rc->stage == MOVE_DATA_EXTENTS &&
 		    (flags & BTRFS_EXTENT_FLAG_DATA)) {
 			rc->found_file_extent = true;
-			ret = relocate_data_extent(rc->data_inode,
-						   &key, &rc->cluster);
+			ret = relocate_data_extent(rc, &key);
 			if (ret < 0) {
 				err = ret;
 				break;

-- 
2.43.0



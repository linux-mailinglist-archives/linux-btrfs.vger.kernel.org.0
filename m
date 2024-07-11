Return-Path: <linux-btrfs+bounces-6361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5592E003
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 08:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 351E9B213AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 06:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D420145B0D;
	Thu, 11 Jul 2024 06:21:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB912F386;
	Thu, 11 Jul 2024 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678905; cv=none; b=c/v1q+fmrEoUiMRGG9J6aD0vixXwO++8dxAaTlejlnUJDJ8pyH4d+090/tiXLLR3j9LAXUDGmlUaYAUJEDpR/QFww5k/4a5PHdJTWCOBQ+WCsGTgEi5TOd9uvnf72DEP29I9xfhSMVGX66zhI9O28dxZPeMjL8gHEGRROSkxTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678905; c=relaxed/simple;
	bh=9ZfoQLUEkfJZeB5uHQoavrcYrJdIFjhKrR9D66YuQNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hz5MsKt97ceP7MSXur+XN43usxJSuG1yfTisdAFz3xEpQpsxamAuthwxScpR9eR3ziIv7cniA7qIEriLq2EeW6XpxK2u+OV0FOdwcX6DhmeKIJRzTP0GHX/T9ACsYM7gwE89J0/5o0wzX3WWZCkwACmPgbjnfhavwmURbTQLEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77baa87743so55090466b.3;
        Wed, 10 Jul 2024 23:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678902; x=1721283702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9/IGYREW0Y/xsMMiSEi/qtroO70B9dqqK8GTXc5ZaQ=;
        b=KcYfH8/xwUc1kSZq7gdt3r4y1D1YkMKIPc/cds946vmD7xPsbBf+jqm2UOQDVF0cwU
         h57D/enyzOEM4gEjW5ESpzIhg9wcLguOZ+ff1peuvOqTB0PDgraEo/x/XKBevibfe62t
         19SPHxYC/2kj+VBYl5hyZB4yqDs6WtuL1t9Gly8+L7m40OCjgdW3qW+UwR93Xe1eXNeV
         3VC0RD4Kv2esYpQkUhTqumUWWcrX4P5rwciAgG2Tx0PMmKQetpmS7CxP+qUSh2XE+Nw7
         TTL2bV6O3p5txv/D1ZS6EQ2lXL8aI9m34DScwobyLJfU2XMWYORf/njIWaJBdxyKH899
         EbsA==
X-Forwarded-Encrypted: i=1; AJvYcCVe8bxGh8tb0FaopU5AihGTFvBNEc6U4wNhGKQr75jA65NpakQiTovMd99jHNZR8bG6ZlCPKaMVsm7mdHWDpUsHL9Gf9HpYuxIWn37t
X-Gm-Message-State: AOJu0YwJON6ZHUhnmspGXwzNImKWWRSngY5jGVbxvJNG5rS9lhbOSRW8
	TdHgQ1zdpo3SV+mBBDaBEH0PXlkKiH0C8nsGR4PX91R6t/+2+onwbXMQiF7a
X-Google-Smtp-Source: AGHT+IH42bY/0ZiYAXnh/QNDFpgVMSC5RWKOd6+mds2gtkswNxe/3+ESeyFvZron0W5A5+YupWYqVQ==
X-Received: by 2002:a17:907:9711:b0:a77:b0a4:7d88 with SMTP id a640c23a62f3a-a780b689270mr798924566b.10.1720678902623;
        Wed, 10 Jul 2024 23:21:42 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff73bsm224815266b.101.2024.07.10.23.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:21:42 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 11 Jul 2024 08:21:32 +0200
Subject: [PATCH v2 3/3] btrfs: update stripe_extent delete loop assumptions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-rst-updates-v2-3-d7b8113d88b7@kernel.org>
References: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
In-Reply-To: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=jth@kernel.org;
 h=from:subject:message-id; bh=/hPivgzVrBaHts4c6z051kDKm5XB367suNlHH/JAm6g=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaT1V35KiC2+1WRSWi0yY535Uqvgwy/KXBxZzgdM/r1hs
 /VcDt8JHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjARh7sM/703aAtLZtT6nnjv
 3Vjef3V9kNju2euv7Nj4k8lnE/8ZdT5GhjMNjTeTHlt/nbw2ZuasXmOH6lPOVwsn1JtX3lnP6RS
 +ixkA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

btrfs_delete_raid_extent() was written under the assumption, that it's
call-chain always passes a start, length tuple that matches a single
extent. But btrfs_delete_raid_extent() is called by
do_free_extent_acounting() which in term is called by
__btrfs_free_extent().

But this call-chain passes in a start address and a length that can
possibly match multiple on-disk extents.

To make this possible, we have to adjust the start and length of each
btree node lookup, to not delete beyond the requested range.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index fd56535b2289..6f65be334637 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -66,6 +66,11 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		if (ret)
 			break;
 
+		start += key.offset;
+		length -= key.offset;
+		if (length == 0)
+			break;
+
 		btrfs_release_path(path);
 	}
 

-- 
2.43.0



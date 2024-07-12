Return-Path: <linux-btrfs+bounces-6415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E7A92F67A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 09:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C601F23ACD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 07:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0E7152500;
	Fri, 12 Jul 2024 07:48:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DB1422B1;
	Fri, 12 Jul 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770529; cv=none; b=s9U/PmDQg2unCrO1EOq1V3y2Uc2sTAkfwIAdtSh4RymWZBRyiU97z425dl4QxY/m5oDtm0xCRD6FXINqolrD95jhXVhMRahH/RWMQjf3aiXFAgIfvBzDRidRjynfTapd9kX8+zvD15wjv1av06xWHSArMiQqlPZckp0n4n3TEGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770529; c=relaxed/simple;
	bh=Pv3ReBbFDrRzKBp0pYyoWKmnUJmOhSx6MpxIF4C+hpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mp80OsA5MTuH55TTUTZtzwBCfiKbfiQ9fz02T9cigXsku5ygSs8IMgAPE88LxAyXyo453rsCOKWsQfDRKsVXzeZFBO0uN/p3yasTw4njxmB0VMp4T9NcK8xbB+vdP5lLr56FdRTO1bbgPJnzi+Ff5LTDLDJY0Sv1tIx+xIx/Mpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266f535e82so11111475e9.1;
        Fri, 12 Jul 2024 00:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720770526; x=1721375326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FU/sAo9QXGocL/MbdLgzEi6X9hN6Ia2DdL8qs9+GIJg=;
        b=qyUMuRqMXR7RDwEHEdwPUkFMQKvNniINnzTLQ7gdiPGOmcby8BogFvzjQA+A4Xp/T9
         RtdkutX9VrwDnrycdTsNGi3ezMYcMQxmTicb93B56byoM2kHMPlM19KKS7oXFv8dWW8p
         d6niVr+2xDcJ9S8yN4H5m9KWe5pv61E8pXHDIVv1m+Sc56//fPVx+/gMeJRIPGPPBoZA
         R0heq3z+mh0aqzyDq1ul8YrRzpOpx72lmsqqV3Vlkb/OTSnwlYiyxZEPcSXuEWeTFLui
         Ltk8/1l6u0XxakY9G2o8VNeC7/CML+uTWhUm+Cg7dmigBnRdZOMhCD2/p2tUG7l2Luyg
         jbCw==
X-Forwarded-Encrypted: i=1; AJvYcCXL2sprZa95+zHC+GCCReR+DE8p8scURwInXTQ0ytBOe0ZxDtzueF45h3AEtvA9yiygZbTHEtTi0hCB3fkSz8oeL+CjW71K8RRPYgk9
X-Gm-Message-State: AOJu0Yw6ntm8ipbFu+t/xtjkD1ybt8m9W3oJziJjJN6jzCvgkmvUdop3
	BlFn12rkpA1W0BRIzbJinLjil7ibjtpSfEiIKVuygg5gbJdocdhR
X-Google-Smtp-Source: AGHT+IEg/QqLkAdxijfiOX8BsO14Gs84p/1C+xuD6t83ahgeXqp7lD6CFmr7NDaqwTvE/2MQbzfvTA==
X-Received: by 2002:a05:600c:4c15:b0:425:7796:8e2c with SMTP id 5b1f17b1804b1-426707d8b58mr76198545e9.12.1720770526078;
        Fri, 12 Jul 2024 00:48:46 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d74d5sm13532115e9.46.2024.07.12.00.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 00:48:45 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 12 Jul 2024 09:48:38 +0200
Subject: [PATCH v3 3/3] btrfs: update stripe_extent delete loop assumptions
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-b4-rst-updates-v3-3-5cf27dac98a7@kernel.org>
References: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
In-Reply-To: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=jth@kernel.org;
 h=from:subject:message-id; bh=84BxxsaozfQOVybRl0+FKGjleLtGfNGJKDIsOaj3c0M=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaRNuH/rk2KGq53r6f/b9+xpcj/iFvRg4W2t++xNJib9n
 wv1F4ee6yhlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJKHozMuzQXr3y9OxA9i9F
 fn+7nKJLwhIXm1465v3u2/Hp85V5epYw/K9x8ukJOWTa17RrwhUh3q++iobq2Zx7XiizVNhPsLt
 wigEA
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 53ca2c1a32ac..684d4744f02d 100644
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



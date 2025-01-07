Return-Path: <linux-btrfs+bounces-10766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25218A03FB8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469E87A28AB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38E1F2364;
	Tue,  7 Jan 2025 12:47:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22901F0E31;
	Tue,  7 Jan 2025 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254076; cv=none; b=Rag6AbRFnHMAb+52l76iqijAN7x/bhfcvjGdgVOA6kWiBw4J6RrNulpIuElas9XKsQq2DDi4qyqr+OopbBuWCjnLjXL0vhRJF7UWJ5WhBzPZ6nQ4BjtlM0AqMxo4r6TWB8zGB0DhddnmJRF8HZy1GDlt27i+vCi1BDjUZqYINhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254076; c=relaxed/simple;
	bh=RTbvXSoM1H8POFrhE/4oLSdcSX1/P8nRSKULuhMcw74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tP20S+imtn1l0eFYEnV0zFo8V8H7pJp7iqVV5sSnNte+nk5ndKPCm2r8r4l32vcPeiwgocecyfjJ3kTLffqLSEdKNYm7iWeGXR892d77pGyWQOrwYB9s6sKGuEMboktK5sm1cHMkEgRHWjc1/go+6SS6wBB6kGJW5hx2QVj+4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361c705434so111938555e9.3;
        Tue, 07 Jan 2025 04:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254072; x=1736858872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSYpPypGdh/4KheFCajssO/QgOBFMd+r8ioOCQO7O7c=;
        b=rFq4d5vQidPYQVh24GvhaTn0fGNxmXt9jhAvSHWY53DKP8oL4tGNzu3uVX35zLzE3K
         kGFueA7Qo4CnDg6tk1laSjd+cEMyhMSz2/G85jbBinlKOLHhThpRqDJGsH2lnCWyWFaC
         ZTKrzt0yd18sANoiQ68XnzekhnKovvslmjoF8U10chE1CQoZOZV7QS01qxkcQlh7cXvQ
         SLEx1wzLaZiOGhy/KGfzi082tvN+iPlEgRmoxafWhqfQ/LTkbQ9ufoHrTDUTBmNFPfy3
         hzqDDgfPNOZh3Bp/mUj/JBvixGaxKDJ7LrHPXIcM+1Fld45vYgz94xVSv8sIHwV/g2P4
         pt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo45LhZSVvuWgpqKCxNDOU8ECbaRehKjMzwc5jiX6J/cHJmE3uEfbXxVykMERa5/k5JOJz3nYx2lJxUq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/nyF07/NpvoMd8dexJtSkMeY1ndJq1ZOuWQcjeAvzi+RzZA+
	nbxbmsRkMCt+8RK5gFQcFMtcDn2lp3l9VdG32H+MZANCaCPYpLXwrqA/5g==
X-Gm-Gg: ASbGncvEUZ4my5awKfRBNqdF4EyZXdNqD+nozgWV8w6QNChA16KXhc8Jp5Y+tBFEtKK
	wkAMWV54Dy9zbFMh2r+5iNCdnmEA9UUUOUl3BStVvk/CXhXbjkwXZUUvz6yVl48kR80/IA0wNMl
	OBYm5ZzjeSXEhf8JcJlwN0H9gNmvJr+8gO2iFu07FI4MJNmaewfb06IbyH5saSOuqMWW5r8Q2Gi
	C8cuidu95T0vZ4g6T4mvG/Vbx2bfikOmJskHEGzmaRKUJuBNkLFLJuE80C8c964+MRr03Rz9olr
	fIdMrNsk+qoPd7P+e3UY6uzwtZ56R/UtmIAg
X-Google-Smtp-Source: AGHT+IHwahq+KsImSfG7F4SZ05t7hQYbpjuOuZfAOUwg94H8959glRPG4BvkMr8VJbQuKsB2IMfqiw==
X-Received: by 2002:a05:600c:3554:b0:434:9934:575 with SMTP id 5b1f17b1804b1-436686461d6mr541436855e9.16.1736254072127;
        Tue, 07 Jan 2025 04:47:52 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:51 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:35 +0100
Subject: [PATCH v2 05/14] btrfs: fix tail delete of RAID stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-5-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=jth@kernel.org;
 h=from:subject:message-id; bh=ldy157oU5ZbR1CUQv8mzWFLdMoj2ibd+pxqwLCsNhKs=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhUqeLrMkP236O/lrvnup2Oul2en3TCuYj2WfKxBR
 IPRea51RykLgxgXg6yYIsvxUNv9EqZH2Kccem0GM4eVCWQIAxenAEzELoyRYabqZuZiju3mSZa/
 VINMpazSPyXO+ZCzSMB9amqY/HSNlwx/eBLYpze/ZKlmf3Lz4C6GNcfYHn7Q59Q7a17OtHLntK/
 53AA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Fix tail delete of RAID stripe-extents, if there is a range to be deleted
as well after the tail delete of the extent.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 7fc6ef214f87d480df27023816dd800610d7dcf0..79f8f692aaa8f6df2c9482fbd7777c2812528f65 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -123,11 +123,18 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		 * length to the new size and then re-insert the item.
 		 */
 		if (found_start < start) {
-			u64 diff = start - found_start;
+			u64 diff_start = start - found_start;
 
 			btrfs_partially_delete_raid_extent(trans, path, &key,
-							   diff, 0);
-			break;
+							   diff_start, 0);
+
+			start += (key.offset - diff_start);
+			length -= (key.offset - diff_start);
+			if (length == 0)
+				break;
+
+			btrfs_release_path(path);
+			continue;
 		}
 
 		/*

-- 
2.43.0



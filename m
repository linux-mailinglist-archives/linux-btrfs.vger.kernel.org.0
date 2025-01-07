Return-Path: <linux-btrfs+bounces-10768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2AA03FBE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E9D3A6345
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE71F237A;
	Tue,  7 Jan 2025 12:47:58 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B581F03FB;
	Tue,  7 Jan 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254076; cv=none; b=CsXSucb1a/joZIt5CwjrOVC8LVAVqI0fvol0t2SXObp6EnGUIMJqP0fwE3FA2HzxTycNsJnCUPTN0xF/TQTfYfgSKRvFzbPS+JbLSahYSiWQ4uLGgF1sWMW47woWQKuzCOXd8n8KVc6Od8lkvhD6cW0yw8D9PRougDs46rkbVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254076; c=relaxed/simple;
	bh=vvq1v6mp8BvbKnZZYDSASKecH1BwwpK/VfSurMQRQaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EylVUtWhIEqUDvNI85OghLAnEvDo1twVQxatoMi2er3ktq54gwxAXUGiWFHTY5AVBGfztPWwnMwzc6Udz06nZXaFZdQmyaYD1wLIYQFNzKuKw3aWl0DIjpUmm6HsNGU1v2e4PR3Wqs6GJ7tcgO+32/UcuXr5dvPhwK6w6U1lHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so153874465e9.1;
        Tue, 07 Jan 2025 04:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254071; x=1736858871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJ+34kt1gEseDje5K63RAt8/DsV4tsL9QDJbvq9xVwE=;
        b=EOs6r4dem22x/WCugGZx5jjaIjSm+/Q4O4EfIGWw+7VRZFsNfl8wR9XKc3kb1+L171
         TUoYpcqJickbmoNRkn6M5LYvSKmpiKccv4jmtxCQZGMOS7EQJUt2ds99JV9cFk1QPdTR
         0n/PdVaM4j3wmxwc+BLA1VfBf87LgP7ILhItlmPiVJZ632R0zIFAeJOpgz20VopIo/UF
         d2eTA5ARfRcJ8gSFF74Xuxk1T45KHSpjVjvTlVZBLC+2r/yNCIKuCaSeZL2GVyDMF2T6
         af1eLTxjUX7WheLh0r0Wle1AITvrJ3R9Y0Hvt2GBXV0v5ZryxXXFK7F74vYkAUYuwJxi
         XIyA==
X-Forwarded-Encrypted: i=1; AJvYcCX/NNzmtSEDPCIGxaSC+WZmXU7F1pfnUQljcZJmk+ubBgdF42fl4ETekvREMYAvIfOQKcdoxigJswId220=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEjI889LsVwh8Icr3u1+PDjVvhcMjJPZOs+bFcwHzbDLtb8SF
	kMBsIBD39Sl0s8Nes3C7pwBlnE1z3mgb7Az2J466pDzagVdrsVp1kd7MSg==
X-Gm-Gg: ASbGncsoLloft+kV+WSCBfKGlIAEwkyCWr1qYAU88FJ70NU1ZLPyqJHsLqX++owrjOx
	h149UihvLrDRek4GqmdMflUZr3WXx53ljONgZi60CbhjotcrxYqaWZ7LJOV284PdxINMqDY0JMv
	+dAqLaJbhDTeMITaDCCq79gdvRwwVBJXoJdcjZzaopmXrMI41AAWaJubnEjgRgKAwaZZOfc+Kzx
	TAn567cYmflhvlQzmkt5VRd77RULhb26LE2P6d7o/GPVVEijgavpmahydpAZLiobEi28HCRJ++z
	/pSbrDQGniu3gDQ9xDgn1oeO0S0TdohLe0Yh
X-Google-Smtp-Source: AGHT+IFipoVT5TS0n2tfz0gbCHD3ebuwGudJhTyHd4cQMOaj5fplF1z5j9viIYSSZYlRcUXfhUGzOg==
X-Received: by 2002:a05:600c:35d2:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-43668646335mr528896695e9.19.1736254071122;
        Tue, 07 Jan 2025 04:47:51 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:50 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:34 +0100
Subject: [PATCH v2 04/14] btrfs: fix front delete range calculation for
 RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-4-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=jth@kernel.org;
 h=from:subject:message-id; bh=VYTA66hDlZ5B7qrLFBNCdOMUx1quVhlOJvFShrWXqdM=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhXeSf967FpZk6HZK6ap/xSNnNTWVSwVPrRn3ks7I
 45GHiGejlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZjIdV1GhsdfL3c1/JVcsONi
 gfuHxQUbtj8+sm5JiraU+Zvt09dtnqrL8N95kYpxEtvMje5sx8x2f+6On7S3h3350o/eyptZwvp
 yM9gA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When deleting the front of a RAID stripe-extent the delete code
miscalculates the size on how much to pad the remaining extent part in the
front.

Fix the calculation so we're always having the sizes we expect.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 0c4d218a99d4aaea5da6c39624e20e77758a89d3..7fc6ef214f87d480df27023816dd800610d7dcf0 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -140,10 +140,12 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		 * length to the new size and then re-insert the item.
 		 */
 		if (found_end > end) {
-			u64 diff = found_end - end;
+			u64 diff_end = found_end - end;
 
 			btrfs_partially_delete_raid_extent(trans, path, &key,
-							   diff, diff);
+							   key.offset - length,
+							   length);
+			ASSERT(key.offset - diff_end == length);
 			break;
 		}
 

-- 
2.43.0



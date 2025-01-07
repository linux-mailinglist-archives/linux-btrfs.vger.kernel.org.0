Return-Path: <linux-btrfs+bounces-10765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7FFA03FB5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343A01887372
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEE01F12F4;
	Tue,  7 Jan 2025 12:47:55 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4B3B1A2;
	Tue,  7 Jan 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254074; cv=none; b=LCC0ebm2+3dlEB60RwDhRdrwm2/QmoVGxFoq/wms1ZbNV0DS1X+ogqgj0apjkHK0weavoJLD5yE8f4AhPDz3Zoe4uUfZ+APbmItMZhHt7DjuRzJxHanLdmjaaUttqb6e7eGEdSVhPh83HNjpXzYNhiyw5IVD/xcLNEOgRfXDoZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254074; c=relaxed/simple;
	bh=cmg/e4DtS1x9ynWJmvbGGFXWsmwYnW8bG9f4O9YhOfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLfNNNbgbQy8/CjCAcTPO2v2hwBVaNmFiTZf2ujXWQWHl6wVWiyUlJ8Os7gRaghnhTh56WPV8GxDS8W4G5LEj2N70GIZJCFsYMukvZ8uzeZWXsFZ7e1ARrrjZq6zm0ldoPWwjbxUV3kt2R2OLop4GNdHgg3cHkYyMv9A+zLHkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd730so110830955e9.2;
        Tue, 07 Jan 2025 04:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254070; x=1736858870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+5ggwxdRaVoBFgMRpwyGAE5qeoDuhmi7L4h/AtgZWw=;
        b=B2RoXdynMSL+irdf6WDqXlSleGSXXGNPkwFI05uIMtFMTGHQaUia7xBE4Zk7FAI+ag
         2QhDfD7OnJObUiHlrAzpOmJ9Rbs4duUhC5Oz5HOQzMCVfWSop1L6F92cTBCpzt1Mz7Ui
         m0jcchNftqHLKs7oXepnX2kFWLe7IRDQFvyaBgcYmU0LJtDoe1n2b/+7WG927CNd7e/f
         n3vnSHPyvO9D/pHGTveeQD2Jwpx23uSKo3FRgW0fWM1IMnBM/j6CljgNFpRphtvaGWdb
         K+JF5yKk+eFf5k7bAhpfwLA7pI+hhyL3GMFcj2iPJgLk12euHbs0zrkPJAsb1UMD1X0m
         PPCg==
X-Forwarded-Encrypted: i=1; AJvYcCW/W1WlNISMBRiE4X9G+qZ1uabJjTTwvlksnj7Bm6k4EFBw8RxaALn4Kr5cLJwNRqH+Al7rcsaayvyGvPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnMcFb82rm+/wpPISnfYiQHuXt520zoOIGyU5kiuyLZXvOlNR
	vXWLm31CRv+ifcc+KlrhqKgyPoDmJZC8tlZhfXhYGN+L11MmQVetTr2gzQ==
X-Gm-Gg: ASbGnct5x9FOt8HcJsB5WwVRDUBVEzb5KmlWwn2New4gxAakWfrDIXVV9WsgNlra/X3
	c0/Wct5J1LwApxzN4wG796KQ1m2L/GHqE520zu2Tgjm1cT46omo9CfRuGOUYF84kEG7k96AwaJU
	bNPeanbCat8zNbLLKXIxSgOnxNsoRXiJwc1ZXyqXqJGbWapAXoEKtZ6N+Uhb3A2t3OJUWimSOeZ
	2Cx0jQUjWo0TfRUhHohyk7ynSNc4wayEeZDoO91eAf5OYx7fxYKGlOUzhHv4Kyz6IODhIsx2jRL
	PFflVcwy+IhjIO6gJ8HofPEnQvouU5zXHjsK
X-Google-Smtp-Source: AGHT+IEOXRbkPy0EW2A49aKoYlrWYgfDug3484Nq3lYm/Z08+eF8PnHOxLw9IWkFkAguT5G1sKJohw==
X-Received: by 2002:a05:600c:3c90:b0:434:f3a1:b210 with SMTP id 5b1f17b1804b1-43668b79018mr455123325e9.32.1736254069460;
        Tue, 07 Jan 2025 04:47:49 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:49 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:32 +0100
Subject: [PATCH v2 02/14] btrfs: assert RAID stripe-extent length is always
 greater than 0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-2-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=jth@kernel.org;
 h=from:subject:message-id; bh=FKo3jsLA2NKrgavCYnmk4JrYWKFLwngM3O7N654ylk4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhVMszHYp3W/xO+o6wlr+fywu4ndW9U+NHAszJ5gY
 rOsfuekjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZhI5mqG/9mXvq4OjsuT3Do/
 +0tFsHfd7Oy5DlMz/0yd/NFtsdOOS9cZGXZbt6uESVv9O52/npMjLSw9LM3xErPvdsXV7YXnQk0
 XsgAA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When modifying a RAID stripe-extent, ASSERT() that the length of the new
RAID stripe-extent is always greater than 0.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 757e9c681f6c49f2d0295c1b3b2de56aad3c94a6..5c6224ed3eda53a11a41bffdf6c789fbd6d3a503 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -28,6 +28,7 @@ static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 		.offset = newlen,
 	};
 
+	ASSERT(newlen > 0);
 	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
 
 	leaf = path->nodes[0];

-- 
2.43.0



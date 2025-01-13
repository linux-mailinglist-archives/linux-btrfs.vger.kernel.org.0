Return-Path: <linux-btrfs+bounces-10948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E2A0C187
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C4B1882D58
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC31CB51B;
	Mon, 13 Jan 2025 19:32:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A941D5CDE;
	Mon, 13 Jan 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796722; cv=none; b=EL2SpG46GJmNCuC/cb7CKexE+l/AvRQxCwnonh0f1+zYqlH56ZS85LgPyHb+o48V4mEv3Ate3zkeYD7Knx6SMx8j++nscmKDv6ZGAf/Uso5fZ2w7VB/3dKHvzdiqteBQ1MyVUn55ohKLXT6viEt8wos1gzgkwq5vrQMiBGEdie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796722; c=relaxed/simple;
	bh=Mb2mbbxV3p+EXpECpOEJS4xSGbFakF+RpCzW4AqCEpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syu1t4wXKhBn+XpR8gBxtSejBMu3m1r9r3JmiiBfcdIlaBjrQVNihrrcqwfPH9AxgXnqZdEmaFKl2Poe0XonpShomlH5UiI0B5WljiaFaXY+xQ3Xurlx3siogLa8nT5Cl6xMWO0URf6ieEsMO88HrbngU62OFrJ4+jJOL56kGyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436a03197b2so33125045e9.2;
        Mon, 13 Jan 2025 11:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796719; x=1737401519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu01/icAOaMKJQ1N8bi/iPhOqWnpeONyNRPo9uS0xA4=;
        b=FQSt74INQhbDmCSb7Tg4crII1wRXduy47v4vxQeqld/pA011u8L874ZEqNzb/a01U2
         I5FNcfJK8GETzkrjzKUFdku10UmeOzwzxuiXJ+hce5KvkzItCPJIo0YnQmZW+VTv0EjD
         Ztz4UpbH/nb5SIYT/0xdy01M31yO5a3GHvEd47dB8klQrSCwZWCt+W8l6dyrcr2XXr1d
         P1U+zqdZQaIM1chRFKS1Mj0/BfonOa41298UOEaXsJ6dHWCR7p+6M6KCKqt12m1NM0N4
         EgDXdSOO32TCZoLiZxjnRA9JOcLRQ7rjwvN2owLCS7FpgwKbGoiPZ1/qXRWX6TQfbLmT
         Rk4w==
X-Forwarded-Encrypted: i=1; AJvYcCVNLprwYRs59PiTAAHrZBVsE0HQF0GsrlfT5GDLzBu/w6Qm2SsCToiR8JSq5wHwbrA0HekY2B/JR5+dpw==@vger.kernel.org, AJvYcCWy7CUKi1KP7Xgrb7Q0rnM1OnBFs5q4et6VZtaPu4iWgc6AtzOA4MzfFXlB77VU0xMnfU91znB75E3nxWZV@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzXMgbvbYP5kEoE90Gl1b7XtfB0nPacU12bXq3uoAX3Qi0n+a
	ciB99+b60TFSLcZBUCv4eJU5fFalKkORoB06Y9QjCMSWlBXPEYe9
X-Gm-Gg: ASbGnctDsF8Le5rke/TFYM8SwuXkjIRnczVhU+A30SYFNwXBlDEDEepVJFQjU256C42
	WNGmmGDfE4buS2hl322luVKpZ71ryo5ymfapT3C011UWBwlfPBNbU4qxoS9TiAdAUhdzAAigx/4
	ONjgMwpErjwKEY06T6iPGkQ3BAUkOWrZzPBJ9qvW98WVznfUvCpXzx6XBWNFSsyoxsJ/JTXlcLN
	sbcM0n7kjydf28F6kkKamFLfa1zGJ8NTsNUsWYDYhyPp3lyQ7VevmrXqJsb22TogyriCjpecKut
	4GDG2sEYlgC9ydlNqDJdkemlNovPTkluwmts
X-Google-Smtp-Source: AGHT+IGin6n2+s5a68qbfJu1G9jQI5x/io+CmyqjHLcafBciIJVm0mlEuMgJ+5HzQrTH+UkG2M14OQ==
X-Received: by 2002:a5d:5f44:0:b0:38a:864e:29b1 with SMTP id ffacd0b85a97d-38a8730ddf8mr20939700f8f.41.1736796719181;
        Mon, 13 Jan 2025 11:31:59 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:58 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:50 +0100
Subject: [PATCH v4 09/14] btrfs: selftests: check for correct return value
 of failed lookup
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-9-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=jth@kernel.org;
 h=from:subject:message-id; bh=3NmorNyjCFrz6Eu8D9jlOv96RRP7GYjFuh5kmtTr2Bo=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqnaMl4541XN5ri/LGemUeaD7b9So1nCj3H8mNRdf
 WWSyqGijlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZhIjSEjw4kl+cu6l/qYvQq6
 ln1B/y/rqXDZU0yv31Z9/d25ZoP3S2VGhkdhhda2iz/qfrk9ReCAaXX4edcO9/l3jBk22weKdJT
 PYwcA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Commit 5e72aabc1fff ("btrfs: return ENODATA in case RST lookup fails")
changed btrfs_get_raid_extent_offset()'s return value to ENODATA in case
the RAID stripe-tree lookup failed.

Adjust the test cases which check for absence of a given range to check
for ENODATA as return value in this case.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 5801142ba7c3a43ea075a1f7aafe704c8e1e075b..446c46d89152a5a903476c5ab1abef81978c2aef 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -125,7 +125,7 @@ static int test_front_delete(struct btrfs_trans_handle *trans)
 	}
 
 	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0, &io_stripe);
-	if (!ret) {
+	if (ret != -ENODATA) {
 		ret = -EINVAL;
 		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail",
 			 logical, logical + SZ_32K);

-- 
2.43.0



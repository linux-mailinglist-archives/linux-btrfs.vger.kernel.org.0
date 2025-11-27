Return-Path: <linux-btrfs+bounces-19371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850AC8D0DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 08:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5FE64E72B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C21D31A7E2;
	Thu, 27 Nov 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7RRzrF1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A131577B
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764227672; cv=none; b=eo61vstzoHJc9P07i1za0gl4QvWTwvBQjklg+n8aEbPO7fekElrcLdogj0qEPZzu8JnJf7u8Ftp7V9Ni9vP/ex/p4Ukw6yyWeWhS8MS87VgzR9x5ljbDIez+uPNW3rJfmSjSFt/Zv6SX7K2qQhVoc/wzr9YRdiU9KHoEQtidCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764227672; c=relaxed/simple;
	bh=mdkoxkxeU7ykpNuyFLBJbdhmGSBV6NdlT9B3JjTOWAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Lzgkj35XMqsvcfJrZHPDSV/P6vo1UvCKzfGFlr40uIsSZLkoNOUwjsVot3NYboF8lEUgocUEX5+nc732yrpkVREBOzMgVGgputQ4ks3oaGMmI8j6pnZjJ4WQL+VmDPpZIx/Y/2jwn2IdAa9H+N3vTfVB4jGqVbxCZG/OuPPDxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7RRzrF1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso274899f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 23:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764227668; x=1764832468; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GplCav842hV/Nvc763gp63uharYZd9oV29bPvsaZ7c=;
        b=Z7RRzrF1DP/kyTLJyQihox71sYsTsxGr+y4FUfFwngM5VNogfL4D/kjTOiNMB3FnAI
         BRkbK3hSnJu9TevRN/MMfY6xEiT9G4U8/LIPCoHhb/v1J4FCCRJJ2EeHo7f0CXtOg42L
         7VMyrPfAPEsF9EFlU6C5GWEuANmzAM9SLz5t8K1OrVHGIlkyTKfcIzQJjxuVemJLKze7
         WQ+zIVgfcbUUcXnxXFBQhP9NLH1221DAycwnLHsCIrJQKLZSxqu+TupGa3Lio6H+C2Xx
         4f94hLnOZ8MZuqFT0kczmHO2cbqSqaDWA/Fa0u1mBy6erkyF7YWLoIMlUy4OtTlpmCMS
         ZQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764227668; x=1764832468;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GplCav842hV/Nvc763gp63uharYZd9oV29bPvsaZ7c=;
        b=eULZeh1qL/TeFrlaJpLIR6lGC0QFMsRtgW+1tmJItzKprSn/u3rHr+pAWMwkyVMMw1
         nKLzsVSBDzppb+9YoEqWFYdtJs+REibV3IWw4qErlgFeusxFKGLTIaZF4ajnorS2NKaD
         lssyKaaLj2g2bPY55l3l8LJ9H+tBtgtXplnhehOsGjJLpMqkxaZHnXdy0Ip2ownxM6lV
         AI4zRWPFnJhYu2u8tS83c/kD/7hKYLndJz/iQP/rRJyc2Kagjyr7j8HDtI9G8ePHcokC
         rhvdCBw6Et91zcid6jKCyQuLXfKLan5A+q4VKC/bby58kjr19zmpbc+RXtFUeaAI4LH5
         xPBw==
X-Forwarded-Encrypted: i=1; AJvYcCVwac6fVRR1tVtmGRujJG/1ysDdWeLX2OdK2s0RK1kXZ0N5hCQCgz4g3E8BVPtrifjvEAJCC+vYd1xU4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1K51bLjejGWiuEaIrd93Ht469Bxic0AHNLprwfE5GUgdWWrxh
	K8oNbau8PfAjYvNu0B0gNVlXTxJO2vOJL4dOlZpxdWGslUo4y22An2NLf+4tUJ4TsR0=
X-Gm-Gg: ASbGnct1C7zfCjgP94avZ+j3Wz9bVaHVxztfjuy9cHX/AZcHwB3o2PBs2amal0BxJhj
	WkzmdG7FTKhsblrKp9PY44Cp0hauuzWWLiAzxSTounQWGV+p/KWxWcxLadcD8Y5gw2i8B1QOH4e
	QgT45n0X9QZ/se752OnMiq3aCwXqDXug6/tk6qj/buSwX+WLD+Mb19gXCZOht9XW79ROjuTM1+n
	3k6tkLtkS2eWOo5ahx2zjOe/tL+pJm6OnPJsITcyEDqbbHfcOUn1pyVCU26Pxm9QZaFhn1caRs8
	gw5sy5LvWjurZqj4t55TPYyguhfEve+KAdWQZrG+hkb660qGtjC8yTuo+rhs30SXwS30oHPfop2
	ccZs26Qo9I8xhXHr9hOT/wkxBK0S7p45wBvYUtr8vh+Ewo0diUYo9flT6hWZGfWlDU4PgsZmic6
	F1z8g96jeA2+h8MKYkoSbSCjo0wa0=
X-Google-Smtp-Source: AGHT+IFZULvedfdDJQMjNfZ7h5QuwFdTyPL+YRqIWRICCEohX6Tw2SAcEoIQp1s4lv6cnwQOhiZ5aw==
X-Received: by 2002:a5d:588c:0:b0:429:f14a:9807 with SMTP id ffacd0b85a97d-42e0f34fadbmr9794453f8f.40.1764227668370;
        Wed, 26 Nov 2025 23:14:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1c5d613esm1899470f8f.11.2025.11.26.23.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:14:27 -0800 (PST)
Date: Thu, 27 Nov 2025 10:14:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sun YangKai <sunk67188@gmail.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] btrfs: tests: Fix double free in remove_extent_ref()
Message-ID: <aSf6UHCbZrgZCQ1L@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We converted this code to use auto free cleanup.h magic but one old
school free was accidentally left behind which leads to a double free
bug.

Fixes: a320476ca8a3 ("btrfs: tests: do trivial BTRFS_PATH_AUTO_FREE conversions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/tests/qgroup-tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 05cfda8af422..e9124605974b 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -187,7 +187,6 @@ static int remove_extent_ref(struct btrfs_root *root, u64 bytenr,
 	ret = btrfs_search_slot(&trans, root, &key, path, -1, 1);
 	if (ret) {
 		test_err("couldn't find backref %d", ret);
-		btrfs_free_path(path);
 		return ret;
 	}
 	btrfs_del_item(&trans, root, path);
-- 
2.51.0



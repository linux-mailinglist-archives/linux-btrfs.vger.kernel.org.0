Return-Path: <linux-btrfs+bounces-10091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274509E6E11
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 13:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5252D188333C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 12:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0C2010F4;
	Fri,  6 Dec 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fok0m7qZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB71D63CB
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487982; cv=none; b=W00GFrttrxeanSLfobKlbt2vmyIEMlzVlLOAuUBBseBR2au/0K1sIuP3yNOLYHV02N1PaVwAYabEo9PiEMDRmffgnjylKsbcizCWnxMunCaIONmhMSAQq2fkEtHxtM739nupGEmjqtCcnEuH3Vo2AwFNc4N1rkV5v62tLxNgRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487982; c=relaxed/simple;
	bh=2Nt5Q7V0Xrx8PqChQJvODk4GCGZmN+SZXxjzZ8oJuiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oC3J4k1GJFbjl0lkpVuoa7NW0IOvU6JCNmyG5aYIM3WK1LIexhAiheXUsKyeGny2KRFSzFSm9HmwjcPMGzbvG9OZkWT+KpSiTVxh7IDhaHLRmTDS4lvd/IxQOmMuM1IGrd/Y86A/NP5CtK4HaTgqFv6V8QXu/Pjrta9Xxg5tLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fok0m7qZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a766b475so19799105e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2024 04:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733487979; x=1734092779; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=139JWvjbvQfyaDWDN/+ggswjzUv6DU8daYnwOG4IOSY=;
        b=Fok0m7qZvEwWWcwDpCR9CPFZgW8zMEyQodnWNN7sAtnSIjiYjwABWlVCHO0+b5YN9N
         0WXuKAsE6HYraFJAO0FsPoEm+pR/PzxRbd9n79UlNYy9rm8pKTz1sSpIEHKZz1lETlWC
         +2puDMoQxcFuMndXZ7nLUv6iukx74+bq4QMPTC0XAYR3xw86Uv81irDTy9fNJs9Kr7Y9
         pCEOdUaIq9ItzK51tS83kYEWFmEZjWIxMlk/9252IxmPvkORIU5lSuj7S5PSt6H8wsJ1
         RRT77Q64DbApjmsk8kfX5Xs2VETFhS2qSvAEULYYIDMN6s8UgOUANmjnOCB59j3Oc18i
         bFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733487979; x=1734092779;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=139JWvjbvQfyaDWDN/+ggswjzUv6DU8daYnwOG4IOSY=;
        b=KzwVEeVMbv9ZSB9V644O3h3GHACSuTUZZqJWfrKvtB0CdyeeUivQRxfW0tyem5MbO1
         gTJ3GJSVTPElYslCWxDKjZuVBTtBGmm0Qkp/wYuFcMvaDzm69nHEJOCey36kGbUsf305
         mkrr8tZgKvAjJxYxN5n0iwPAe/wrpenRCVITM4oFLO7V3mykxjFb7HhnK7U8cGWPVHLb
         AAYtVjKm40EK+M8OYirzcIvIIZdu8pAet2P/UT5Ep5YkVzSna9hPRs/HJeErQDC2cdgx
         V/Gt5MCKaqrD3SA3TRklX1K7RiyB+1ZuT2tZDlA0c4pV+wkZ4rCiBYH1xuvWkrWYPXxU
         urCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQdkSYSx/C8JML+rzz8VtRfB55eQv/+IfAhL6wyyGoGudrjOwgxfQJ7HjmkOxPM6JjW/ydFLyAakQGOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4VN0IW7Aa8dtNkaLEtf5MuTny2yNUSBI0r2ELcoX2PjmHq5c
	N8LwBm3ZwQhMPUOdI+V+nmSFDTMFf2u0Vf59cnD0hZ7zrkUFd8qHf3EUkxSW2gg=
X-Gm-Gg: ASbGnctCu/+TXmH9r2wc26RVqq2G8npLq2ygaZ75Q6EVDLsbPgOEpcctgiErs30NkLj
	qG3zlcnwTrFPv+pLjUQkTSX/MXCol7q+oXWWZ2NBK5sw7WNFmpNS81wdXGNZHg+mZWMoD+aPm8S
	EzBtPcZIx55VU8r5WAwd/9fLZUM08uOMx6LwBk4s9CjbAZuo8a8kSl1g14cY8x9bc+5ibsNmcDV
	x+gZMQtuhK9aik353/J7FN7p31SzymbIjV/3OJoWIwGL4Cuyl/d/O4=
X-Google-Smtp-Source: AGHT+IGtb7sPWicN1pitCSG4R0t0J/VIyKR5s2Be8L85VmFQCMoKV6CGaPtuCeDdRvl6uY47SaBe6A==
X-Received: by 2002:a05:600c:1f87:b0:434:a10f:9b with SMTP id 5b1f17b1804b1-434ddeb4488mr25066915e9.14.1733487978876;
        Fri, 06 Dec 2024 04:26:18 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46cdesm4472889f8f.57.2024.12.06.04.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 04:26:18 -0800 (PST)
Date: Fri, 6 Dec 2024 15:26:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] btrfs: selftests: prevent error pointer dereference in
 merge_tests()
Message-ID: <85027056-1008-4beb-addb-0bde7ca1b0f0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Passing an error pointer to btrfs_unselect_ref_head() will cause an
Oops so change the error checking from a NULL check to a
!IS_ERR_OR_NULL(head) check.

The error pointer comes from btrfs_select_ref_head().  If we
successfully select the head, then we have to unselect it.  The select
function is called six times and five of them change the error pointers
to NULL, but one call was accidentally missed.

Fixes: fa3dda44871b ("btrfs: selftests: add delayed ref self test cases")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/tests/delayed-refs-tests.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/btrfs/tests/delayed-refs-tests.c b/fs/btrfs/tests/delayed-refs-tests.c
index 9b469791c20a..f9b5c4f07a6a 100644
--- a/fs/btrfs/tests/delayed-refs-tests.c
+++ b/fs/btrfs/tests/delayed-refs-tests.c
@@ -406,7 +406,6 @@ static int merge_tests(struct btrfs_trans_handle *trans,
 				 PTR_ERR(head));
 		else
 			test_err("failed to find delayed ref head");
-		head = NULL;
 		goto out;
 	}
 
@@ -457,7 +456,6 @@ static int merge_tests(struct btrfs_trans_handle *trans,
 				 PTR_ERR(head));
 		else
 			test_err("failed to find delayed ref head");
-		head = NULL;
 		goto out;
 	}
 
@@ -590,7 +588,6 @@ static int merge_tests(struct btrfs_trans_handle *trans,
 				 PTR_ERR(head));
 		else
 			test_err("failed to find delayed ref head");
-		head = NULL;
 		ret = -EINVAL;
 		goto out;
 	}
@@ -662,7 +659,6 @@ static int merge_tests(struct btrfs_trans_handle *trans,
 		else
 			test_err("failed to find delayed ref head");
 		ret = -EINVAL;
-		head = NULL;
 		goto out;
 	}
 
@@ -747,7 +743,6 @@ static int merge_tests(struct btrfs_trans_handle *trans,
 				 PTR_ERR(head));
 		else
 			test_err("failed to find delayed ref head");
-		head = NULL;
 		ret = -EINVAL;
 		goto out;
 	}
@@ -769,7 +764,7 @@ static int merge_tests(struct btrfs_trans_handle *trans,
 	}
 	ret = 0;
 out:
-	if (head)
+	if (!IS_ERR_OR_NULL(head))
 		btrfs_unselect_ref_head(&trans->transaction->delayed_refs, head);
 	btrfs_destroy_delayed_refs(trans->transaction);
 	return ret;
-- 
2.45.2



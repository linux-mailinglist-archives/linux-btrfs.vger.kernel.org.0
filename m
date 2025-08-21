Return-Path: <linux-btrfs+bounces-16226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8DB3067A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7367AE803D
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D9A373F95;
	Thu, 21 Aug 2025 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3FnSnXr2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56C373F81
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807655; cv=none; b=jmArKEIypach8dCfUF6+aAUKYmY3BT9HngoNMbB29iMWHvxWZ/zBwpNj2od8m+u0IaPrypNtOP1HO4w9TwTBrXahwShdtX/5jQcwZ5i55H73/rEVMbiAMLlrBMTJK11RcTHOQGlBtfh6Ns8QU2hn98bq/BA98mw04tUvvcYfqFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807655; c=relaxed/simple;
	bh=0lJmklD4oxs+QmY0EdOdZ2TKHxQWMnxFR9kZzYDsLSQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMKxEy1JIZp71YMoQiuzXAWBVbQDUdzQw6xWcD/NHYRWbrowHMNrxuWAMnpnC3ZIB/uZaMEPH6lI/zWs/m9Xm/S6iFD34WwTqT9PzxVnehnxdD0W6rV1gBq1yaxSUgWCNAxllvUBmgfh2kZj1N+UrxHY1E9K7QTv/9x9fySZZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3FnSnXr2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d6051afbfso12420617b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807653; x=1756412453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjkT2Nr/N4rw5SgF7OU0ePclbgK+JFKERg5adjLRg54=;
        b=3FnSnXr2Gj5yC8LL+E8khTsGRxQamoR5vf1dQWNL4hxgzLoq/lAjbNhEDY+7v1VghA
         hpnXAwgQ/zOa/dK8jd5kYbjpGbKaojRnnoOaDQFsicvONuE77VBScYZiX0x1wkYQcwP+
         /9AhsJDlL6L+2+b/E/BHisu5fzYxOPuQpQvAsOpCmc2rwO9ClErZtv1MD0chfwZMcut6
         NVZ3y0AMCblXREB/tHmAAPERlFqUrw1Qbw2hMx33CoksEQutGTjBXAP8QfUKwT5Ze8N4
         72noxgyDc/0S0dGpqOqnechN/3lyTkk2ODALTSRMOuG7JUENrIlz2pXVS+6UP2Q/SHcn
         YuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807653; x=1756412453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjkT2Nr/N4rw5SgF7OU0ePclbgK+JFKERg5adjLRg54=;
        b=EX0KnhTDUoxJC5BZTA1j8CsVtVgUJ6+nGBh0cFjSxAoWe8SBoaxiVQ3I2DXObrSVKF
         RF19bMJ2AVrj2mQA+5AEyhZO5hCE8rqQCd/SHSVl2AJazNc2r9qojPHzjyjlgzF3TJQj
         VwSFrIf13yDecpkcOD6Bid50gyTtLmf+x3tu8tZ5wGcuIcuHHC5UTWpzpgmv+Yd/3gM/
         y4qiNL+CwbHeIqLeRdWUyjBdn6std7+HdT6tKM8eFuHeWeURcJbEJ3Brt2PwDVP9kBxG
         jXz0jMdH5OhtOCGNLrZReLL6I6nr1r8Yoj/1K6T+/ybPlOS8Sb+bI9WfKqzW2zlCSdwN
         07Wg==
X-Forwarded-Encrypted: i=1; AJvYcCV7cJH3M7pH0kS5iAsKdzcgateNet/n2Jn4og/oTZB5LL/V5/k4I+1EDLuloxJQT+wS7Mr18eyljTlnRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgH1QehO02m6A5fGepznaeAqgnVxoytGK0KLZe0lfvqcsQ2/8J
	6hOgicKJVI3bbqXlChxPqNLl/s39E0lY1o9msV2z5rUpVAggkoP2MTRmUrHSO8aWpe8=
X-Gm-Gg: ASbGncuuV8V4sEo6f7yiDV2EsVN96lCokteMcFrbMlq7/8ptQndKkkFK1xbnbrX6mRF
	j4AAZTbQiBlZ38S8YIUr0zmSfBKTM3mFmIhQWUT7FGhGKbWlDRUZBMpV+YqLuL8wyI1vhdK28Al
	i8Ybi9ur3fCunHObti3yxXdBpkbhaCNqySvFZNlpvPnrR/GG56TXGceOc8iQj3xFKxubnLLRjkU
	GDS57LrCAq7OVO2lgLb8CSlKTXaAQJmAC+v1FkWJeb1rE1MTowHL2NUKVFxsQ2VRF8sOtLpZ7Ws
	GXqfTcMSNfOAtfhhhj1RgkPRt0Gv9mEwmrMAAccGBiyOIkFmBNAJc9Ssp4IVZ/AoD/yZEBrzdh7
	kHsSruBO1ZRU/o7wY3qAh9GARUfIjnMnwFxje0THO8r82x9Jbyyu2fR/Hthk=
X-Google-Smtp-Source: AGHT+IHkbsShVmVIQwfdIh0hUjUE61OmSFNVWODMerAHLv7/HcdmGwNwtKO6+Co21rSFectU4cHp5g==
X-Received: by 2002:a05:690c:45c3:b0:71c:44eb:fae6 with SMTP id 00721157ae682-71fdc3cdb12mr6675767b3.27.1755807652956;
        Thu, 21 Aug 2025 13:20:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52b903320sm54724d50.0.2025.08.21.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 25/50] fs: remove I_WILL_FREE|I_FREEING check from __inode_add_lru
Date: Thu, 21 Aug 2025 16:18:36 -0400
Message-ID: <e42de7e9cd9b5fb17d159dda3de200b1800d671b.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only want to add to the LRU if the current caller is potentially the
last one dropping a reference, so if our refcount is 0 we're being
deleted, and if the refcount is > 1 then there is another ref holder and
they can add the inode to the LRU list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6b772b9883ec..c61400f39876 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -613,8 +613,6 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	lockdep_assert_held(&inode->i_lock);
 
-	if (inode->i_state & (I_FREEING | I_WILL_FREE))
-		return;
 	if (refcount_read(&inode->i_count) != 1)
 		return;
 	if (inode->__i_nlink == 0)
-- 
2.49.0



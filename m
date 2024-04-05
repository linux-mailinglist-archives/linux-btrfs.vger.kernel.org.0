Return-Path: <linux-btrfs+bounces-3979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E089A546
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A82B1F23057
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BEB173347;
	Fri,  5 Apr 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="LvduprAs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A681173342
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346986; cv=none; b=X2vOxemWyHFpSvi7fHKnbC5O6aTIDwdrGyM9XOArwPK7cjhWtMDnCdWANNliXdyF9a0BsKpIT2h4LHTLd9WhMf7EoyuVOyPGpGHv5Q6JvSPzarPqcrh3uQu6qZXiMtOMxCmeBBtV17Oz82nOVwesv9OlKVkXy2oTjzSC6pQvdz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346986; c=relaxed/simple;
	bh=IftFNAyGMW0+PC4UaymkIiJKu1SRGfJ2M7zYBEQQiOM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GmH7r5tdamHtXPHAONPL1SKJPCqzMXXQolnlXs/nOBUcolJOpSorN2teHCFGnQspVD1U7AYS44M5RCk9UqzLsYZ52V7mfwFo+iEXHjioZAg0LamBv2SFk6znHR1CVArCckiXH9Z3dTeGq98LYeJd7cmBl9Z+aG6nNE9ktbLwI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=LvduprAs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-699312b101fso12275836d6.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712346983; x=1712951783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDCIjcfLg5/A+ZSk8y5tQbAFPHorahyNXBBJAhi7Wtk=;
        b=LvduprAsB6e40uSX9dSMtQZzTeVoq+oXuTIBaKRnmz/Zpl6dqiehuiKRrzlcR9VyjT
         HClxRXAsssBx9NDGHtHjAoH/BHXEOqDihJxeiCKMd+h4S5ayKscaUz6uhMIeTcWl2F7P
         CdI+s/9CuN7axlIFl8p8P92IWd5tDRe3RiyW1eUlk7lyUw8mH8JMI/Xr3ZBIWTxy6401
         OTU7QmGyvLdqKrcG/ABPWPTExBJGSkibtWT0rx/Zx+R6nY0z/2JZPy/B5U+EsW2TeR8i
         l7qwwgfG+6LAFkT3B8cXvRo8iINm8vqGRQ3Bq56Gvb3H5YlQebWkxPo4Y2hgeEbc4i9C
         P7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712346983; x=1712951783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDCIjcfLg5/A+ZSk8y5tQbAFPHorahyNXBBJAhi7Wtk=;
        b=RN7tVzzjF9uEAGuCk8B9P3U07QNw9ARtHSv5F4veURfoyfIrEAb9CNzdWFImrjrBx8
         UJ2wPqjAd4/y9SePFje0qUEuMliQ1UXZGnj0NxizbXq8l0c1win7uwGc12Yd9GgD0wxp
         qOGsf/BYiIr9L70516UCZLz5xwCn5KBPzgwGvHw7d2fSPXSMSQXQQ20jwvZOoP8q52Wp
         iN5FRbyXOfFdYZVfG5GR2kp6zYFJaLasNb81gw+/j6aBB+3r5VbYzb2LrtwQ0wZMetsy
         AxJjWVDmrWt268BzW6ywUh+bqexiCkqw9RiwMg/eVgQqO4eT7BR4JAlpN3CtgMkfifML
         AVeA==
X-Forwarded-Encrypted: i=1; AJvYcCUcUvQVEP7hO/EhwNDKJlxrYgEFyLJjAPffJfUm+2g0emBjbP7n+NCIG1+lPb5Aq1vY7v7H5LwRR4R8InkXTiGxKaNpYJ1CGZRePyQ=
X-Gm-Message-State: AOJu0YxB/clakl+jFYHFSGCSSrvnP/4Pw0C+CfKAqo8CY3d6IOfSa4JA
	yTSoywEM5uJF2rxn93qQ+ZYCBJxxqQrWje5kSQhZEClV3k/tlteyexd8VChT//oa+fpVrrGmYvU
	I
X-Google-Smtp-Source: AGHT+IFn8EGoGAx6UlDJiFtZmMVsPPatBp/kAQ3QgwLYF/mxCjpgwHtlmNbejCmRRXx6ZdN0n4QSRA==
X-Received: by 2002:ad4:5d6c:0:b0:699:3025:566f with SMTP id fn12-20020ad45d6c000000b006993025566fmr3384305qvb.38.1712346982873;
        Fri, 05 Apr 2024 12:56:22 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f2-20020a0cf7c2000000b006991a92642esm876550qvo.138.2024.04.05.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:56:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/3] fstests: various RAID56 related fixes for btrfs
Date: Fri,  5 Apr 2024 15:56:11 -0400
Message-ID: <cover.1712346845.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-btrfs/cover.1710867187.git.josef@toxicpanda.com/

v1->v2:
- Reworked the golden output of btrfs/197 and btrfs/198 to handle running some
  of the RAID profiles.
- Added a new way to require RAID profiles in the tests, updated all the
  different tests.
- Changed btrfs/197, btrfs/198, and btrfs/297 to skip any RAID profiles that
  aren't supported by our RAID profile settings.

--- Original email ---
Hello,

While trying to get CI setup internally I noticed that we were sometimes failing
raid56 tests even though I had specified BTRFS_PROFILE_CONFIGS without raid56 in
them.

This is because tests where we require raid56 to work only check to see if it's
enabled by the kernel, not to check and see if we're configured to use it with
our profile configs.

One test needed to be updated to skip any configurations that weren't in our
profile configs, and then a few tests didn't use the 

_require_btrfs_fs_feature raid56

check in the top of their test.  This series fixes everything up and honors the
user settings which makes my internal CI runs clean where we don't want to test
raid56.  Thanks,

Josef

Josef Bacik (3):
  fstests: change btrfs/197 and btrfs/198 golden output
  fstests: change how we test for supported raid configs
  fstests: update tests to skip unsupported raid profile types

 common/btrfs        | 29 ++++++++++++++++++++++++-----
 tests/btrfs/125     |  2 +-
 tests/btrfs/148     |  3 ++-
 tests/btrfs/157     |  2 +-
 tests/btrfs/158     |  2 +-
 tests/btrfs/197     | 17 +++++++++++++----
 tests/btrfs/197.out | 25 +------------------------
 tests/btrfs/198     | 17 +++++++++++++----
 tests/btrfs/198.out | 25 +------------------------
 tests/btrfs/297     | 10 ++++++++++
 10 files changed, 67 insertions(+), 65 deletions(-)

-- 
2.43.0



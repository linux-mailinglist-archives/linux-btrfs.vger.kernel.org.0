Return-Path: <linux-btrfs+bounces-3425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A068802C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856F01C22574
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E53F17556;
	Tue, 19 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NxLvbpLI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABB107A8
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867369; cv=none; b=fQ/fhcjZvS5u3f7CwkB+AMGthTYiuewOdk6A0E9Yg3RPpMCCA5EW0tO89kchn2rc49LqJXzATjpos7hmTi5Nf6GJ9J4EPgFcCKstGD60nkYvB/V1rcA+d1q1E5cW3fgz0RpPzTvmEJuveRFNiKUn4gEAPVq+kVp4qlTjqjVH3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867369; c=relaxed/simple;
	bh=DEQzuGdh/RFV3KyLDUUjh92Ui9vcGc8EmPhCgoj4mGc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lnMuY2psb0KBYDRm4wQcGkianJHkZZlsW+wtkAUr78E1xplhm1Hufmz+JB5LnvcA3eRGPOx9HsM7N/eaQVMzhoAWPcgtR/jSm7KxaqHIpYylTo0CObUaPBAbsYDE9RXMKnFGLWO3f8ZnAkj0KrNyWSuNRF7a5h3mcPEjhGSOsxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NxLvbpLI; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6928a5e2479so17454376d6.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710867365; x=1711472165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOHEs5TMclfhBIu2JgoX4uMTBWl5ctndV3O904uCrs0=;
        b=NxLvbpLIigTXLfgR02X86MY6L8IoPOa8m3+KQgA1FrGsDoUncyd2sEt6WDKkYCV0EJ
         ucVh/V9rgegXmj+Hf2sF8SJQBBAORM1aVCl+gAORGmUjoq6iCkYjnYTx26rZ3NKrPcAF
         RWzTH1UMd7QG505hrDDJH1s+OErkc7I6GKc7DUgKhnXrSfE7IWLdBHQbQoKYUcW0FzY+
         tEDKjhKpMdJHCx14hUpqGO/t1J0dGHNktobp2tlvGhp4/yGB3rPoxCCIbFJL0XOkt6yg
         0H/hIVE6aL+WmpkCiCiPYUpcxwtYNc8IH0ZBT6dSY5uX8ENw3xSzXK2dah7n8+g15yyu
         sveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867365; x=1711472165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOHEs5TMclfhBIu2JgoX4uMTBWl5ctndV3O904uCrs0=;
        b=ZcngIMBA/tlBset+z9T/Ssan0Wra+Xwhcf8nxhRSoRTEjz6g15yHLW0wn1UhGvoiMJ
         Pg1RPkJcfIAoaImIhu2xSRgeRvExn78UNQLI2B1cf+eoNsUw/+IYIbMl4ZtVG1P5CD2c
         Wth07R7LXvOhUS/PEGOTN7C6f6RjIX80i3gnUKYcadsW8S4wBRemZHNbk3Jumc1uv6Gh
         9eyS9HzZpq9itAqqvieG6kb82HIGjxBNLpGUT4tmSOFzyjLj3y/f6K81oPoSyLAhWmi/
         oJLgWPgVIelFo7f7cUWaojRYI831hTFeFTyLbUwtV5yMzNX2+WeszOgdEvhzp8RuSjCF
         ICvw==
X-Forwarded-Encrypted: i=1; AJvYcCV+udXZQ5C1ZCs+PVliLzCIKC6gsf0Y0LBHRgvrWAxIWX+pz925ViSmJWEmsb276T0C9vsws6p0mSi38c5V5HI8trRkoRncr/+tqn8=
X-Gm-Message-State: AOJu0YxGt3TRqjSa7FuXfvlkKYS/4NbYI/DSXR1YS0exuzqJTCFuQfJo
	WHTQ73kO5uWV4kdtBnUqUTz1Bvgdq34lCoP/YXKYiyly83KWId1y3RxNRDDSJcg=
X-Google-Smtp-Source: AGHT+IEzk+DigbjcpG9d8BJ5EIcnJJVJ5oYqSA39ZdGY3sYvR65ocN4W0ZZgZWPW2lDAnFHdDbKzqg==
X-Received: by 2002:ad4:4682:0:b0:696:315f:55f1 with SMTP id pl2-20020ad44682000000b00696315f55f1mr2918852qvb.16.1710867364690;
        Tue, 19 Mar 2024 09:56:04 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id iw14-20020a0562140f2e00b0069154e0670asm6663090qvb.90.2024.03.19.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:56:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/3] fstests: various RAID56 related fixes for btrfs
Date: Tue, 19 Mar 2024 12:55:55 -0400
Message-ID: <cover.1710867187.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  fstests: check btrfs profile configs before allowing raid56
  fstests: btrfs/195: skip raid setups not in the profile configs
  fstests: add _require_btrfs_fs_feature raid56 to a few tests

 common/btrfs    | 8 ++++++--
 tests/btrfs/195 | 8 ++++++++
 tests/btrfs/197 | 1 +
 tests/btrfs/198 | 1 +
 tests/btrfs/297 | 1 +
 5 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.43.0



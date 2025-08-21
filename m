Return-Path: <linux-btrfs+bounces-16193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7457B2FA1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 15:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122463A7DB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4468334396;
	Thu, 21 Aug 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXc7Tsxn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3138334391
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782191; cv=none; b=cent9FA7akaqT8GG0BQ7ipPbNHZmx9KYjfaUoyDOQD8vLaef+lhuiB5tjGJbXnvgnY8cnsZlu4lYa7l9k/NpxYsGqOpPP7DLNZMonivSi/6gea+e59h3yB9uRnwKXSXojbEa+P+KxJ/UaoNdN4obwQxYEJGbcz9s0xlaupFkYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782191; c=relaxed/simple;
	bh=kXpzDmdhKnYQ2KskS/wkiWPNZ+oW8BcFF+03NLILh3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APOC2BLtg28tX0tIwBNdsXkMoHpp2dEBU9ohyTdvfYEgJQ38k6VYTxB84JXEqShGhV9TmYQKJnk27F1jlCC1x4o2M4tvyQhpWn49YLch+N8Jz+FdYpaz9lypPScJiRIk4RxmvBtrkqT9Pn/bf9IOqpmb+qh4TLzbIJ5ev1GC8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXc7Tsxn; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2447d607b70so1441515ad.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755782189; x=1756386989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CaNqi5s03EKgxSpEbGVq/nNHInI97KGlNMf+J9iIyH0=;
        b=KXc7TsxnLrBwopq091jr/nVNsGbLNXH17Ap3DudRROaRPmFiASRAqFklBx5MI2yZva
         TNqmB/N21LdpTVzxiKcVtbEqUfPlk7GvTZkmi3lXi8HrfAmP4WKOfRqL7+doO6aJSYup
         eldoTYqmAGToI4Xnu5p6nmTPqSGJPmKAhudzUMW7CfDYyqHtk8yKzWKB8pRM7DmA2c8I
         2y3pydREfLafqMkVik1Ms0EV6hHCveyQNw/yjUAywPa1EuBzbMLEA1yIt1HsUYkl9Dps
         51ChdToyiQO520TN5he/rPmJkv5UE6U5J+6uDhjzF+5QtThpT/ZEfdb9LBSje5CFo9Lp
         5XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782189; x=1756386989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaNqi5s03EKgxSpEbGVq/nNHInI97KGlNMf+J9iIyH0=;
        b=ITRk8mORmrqG9SPBY/nDAf/GldBYwU+u/7dhSHwD3oHhKtEhZ3fvANu1RW3kqClyJV
         x5H5EHCUaohfyDapwkVlKc1+kW0m2Kj1LprMdHQeG76QwZV9gBLF1C1gBoyGKhJ0y/Ai
         YkKjjHqLCB59s6Q3CYeMczt1BXfCqtfpL0SnntRVedKXoJE43fN6JWE0uUzjYzhmf7kA
         b7KFnfL2gx13RGlhndx3TC1hncLoiRMRDMdRD2DwlMaY9vPng/0d7UDoZg8pq9BAln/5
         jLVdfcDWivwuUIg9MVYoBBsDkM1IBmz6WhgsxKvcZ866jrhKg9vFQJR+QbFtV4uyso7i
         L+4A==
X-Gm-Message-State: AOJu0Yy20zE3lwfY/aJ51dlHWBjzYsqBlxDY7gtk0jO5OirKrXsPWTKk
	dDDqDbUG82srFB8iGTxOYCT0TU32QjwbrM07bGXf/dH1XqIc+HzBO0S7ja8bJlMB2mcyAw==
X-Gm-Gg: ASbGncuvUENCIleqqFtL8IlCGfyEEzMkW0Sogkq239VL6h8ct7seEcDqN5yxXJkgZ6y
	08aNWAZi/lEw1r+WKIrcXlBnDfel9EdFYxG4RAOs2MDzhe0iWt0iaJmagSG738uttvDnOGlEbiv
	+tZywgzjceTM01NwOs3Qx3in4AjLlnkfP+cOcCAcwnrq06m0zznLySKXXn72loQpXFk2Pfm8KJT
	53iNsAGalL0IykV+fKAMoZxkWEpS9i0geJj7wgPpPLK8TiRqP5Z5arN46lxDG0zuzGgtSOEOJ1v
	BdEP5SiOLoHZ0JinpCYRAh5mpcJaSzwyed7MdKNGQwCBD5pOoP9yaVxKLggdTUhK/UOsOuqqied
	wqZM+0xMgFzLlFT6hRZ/llpOzv2feslyydhUCpTxAqAiCAQ==
X-Google-Smtp-Source: AGHT+IG8QeQCjQL9XK5riyxKoER3NK61MzysEVe1t2F4LIQBB+1hM0rLupQ+ddLAiP9Xfn621Uq2PA==
X-Received: by 2002:a17:903:1a6f:b0:234:a734:4abe with SMTP id d9443c01a7336-245febd9aa4mr19155225ad.1.1755782188891;
        Thu, 21 Aug 2025 06:16:28 -0700 (PDT)
Received: from SaltyKitkat ([2602:fa4f:a30:6b83:f365:7bd1:5b7a:f317])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33df68sm55884335ad.21.2025.08.21.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:16:28 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 0/2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Thu, 21 Aug 2025 21:12:22 +0800
Message-ID: <20250821131557.5185-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trival pattern for the auto freeing with goto -> return convertions
if possible.

---
Changelog
v1 -> v2: check NULL info parameter early in send.c:get_inode_info()
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

Sun YangKai (2):
  btrfs: get_inode_info(): check NULL info parameter early
  btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions

 fs/btrfs/raid-stripe-tree.c |  16 +-
 fs/btrfs/ref-verify.c       |   3 +-
 fs/btrfs/reflink.c          |   3 +-
 fs/btrfs/relocation.c       |  66 +++-----
 fs/btrfs/root-tree.c        |  49 +++---
 fs/btrfs/scrub.c            |  11 +-
 fs/btrfs/send.c             | 313 +++++++++++++-----------------------
 fs/btrfs/super.c            |   9 +-
 fs/btrfs/tree-log.c         | 124 +++++---------
 9 files changed, 207 insertions(+), 387 deletions(-)

-- 
2.50.1



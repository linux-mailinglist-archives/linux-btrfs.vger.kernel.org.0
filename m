Return-Path: <linux-btrfs+bounces-16028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4F1B23150
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 20:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FCA1663EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 18:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF02FE587;
	Tue, 12 Aug 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2Mp7V2O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F62FA0DF
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021623; cv=none; b=hLKaRDMRc+7vVTAhYFWCy2Kpmb+WQ0v0Ro9gjd7CW946oiDIzUN4rbjqkr3xW+dqWeF+afsYfQ7BTLqpy3BemuyirbwbxZHfIk2actmJki8CYGx1R8JlA4M3OTfWXTngK2/NjhcMSRwJWBM8hmg4fZXmvX7k6EOU3K94VJewdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021623; c=relaxed/simple;
	bh=7OZLnFQ4LoKlgQOFBN6Nost/Aw0ROD+31ME+liinh6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPzSLDBYC6pb+AwmDXWpiVfAlOmSS7fM3zfKqssY1NsOFlFhFyo6zQVgVyI3InasVhCpKn8T1LSsXT5qosO+rH8RI6vCKcasjdFbmrF1NNVCm6tqSHMYtEn61gvZCBPLzVCvyHQhfUMAg8ow7iNvnGvEUVNV1P9NiJZxwXnp6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2Mp7V2O; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76b6422756fso8093625b3a.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755021620; x=1755626420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yO9o7QGm7JF/7UBXByDSZY9CAPWBbdc/pvWtsm+T0Us=;
        b=l2Mp7V2OXYuCZ1uca14AZElnwLyH9gZuDkX8ZaIpZhoF2qBe1rIEW9qvPZL3jMtl/p
         FJzRb8KfCLJK/ATstCEJ5ADNcdE1b1goHMK93WQ9wIks2n2RhX42B63HjS4t1ExeKQKS
         clZne2dsVY9RQ4U0exq186ZbOcwknQindv6dkli5UWrYnPc2BvgniL7BbnFLpL6sTvHB
         tziSMMfPMtjq7BEj4Aqqwc3p4IHus6RG7jAjSmpSnMJ/BLJx+ZlBnok0Gs4yCuzqThqv
         B5DX4LtcXSNVkK6Q1zua7jPlv7PezJzVUia9Trrl4jhGchS6erCNQ+KYK7ST+8RO26nS
         XZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021620; x=1755626420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yO9o7QGm7JF/7UBXByDSZY9CAPWBbdc/pvWtsm+T0Us=;
        b=Skja5pRq6evzcVHUokXXDhq4lJOMTyjFFZg9TG87FU+fWhlmQiXJDIDunW9RLUUxsP
         kcEia8IBqkL8FW1F0An/8l6OrZhPOdUiwiKlM6SsClmLC/WfY2YcDBUFirHecl32JwTE
         PgO64yF8YV8VrpjkxKI/4+aHg9skRNNaVQDwk0yUNBauY9h6LLTfdzDSYojapivL9BLI
         xuqbn00mXJbjtGyGIP2/rEi5rJGr4mwjx67WC1+HjLd3caBv8yPjSUGkPdLBs1Gg7jN6
         GwOhPe7nhCKM+1YMFlldw4qYhctjRvzLcPjdFYNzAO0SpABKVU9CmfJ+V1nDr7OoBE16
         Ofrw==
X-Forwarded-Encrypted: i=1; AJvYcCUDapGxamQVu5GJi5wJrMTsp7JxTaucT+slZaYGfFS+wUu0lvmvco8NJautKQS7YpJ/ojlbznbc6iR5EQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZVdvCU+0Ag8hSkquCT/cTCH1boAkl0dtow5S/wqbakj6Hvgc
	Cckxz67sCP9WFPijkQ0LuRKYCscDd/8v/c+io6q+hNishg0c15ZHzCXI
X-Gm-Gg: ASbGncvdvYTem/6Mc3WM8NISQm1MtKoh6E11o0zaLsHm7TTPiLiYccF5Kvg9AtFgkxR
	DdU1Vh3kaR+TXQZHDGbNTvWFfBsaq4SRVPIuPO3yrK/UWwioNOMgWT3XOUcMpdn7hWTJQ42kcXb
	qRqlmO924ce4hcdkzyiZoMZQZJmVZ75mC/BHhAZJ+hc1TI5xwJ4Zn36AlWnTsIkCoE/ZWnSqo/v
	/oSRYhwX7kVr9WiR08y8zdI97hiixMSisSrQK11XfcOawqEeiYJt6UsOwUbPo0Q2jtlVWWddswW
	Pr1E0QYI5l+905iAXjG4nYavRxtxo+zAlEtKdm22fI3yPMNYW/c0rAfwKHQWBjhUM3VeOcBihYU
	tXcc3m9/sLdkG0RrxrRhAKxFRmaKqsDoo8XSoWUiW2UPQbyefeMQ=
X-Google-Smtp-Source: AGHT+IEGuAzO6WwK4itIGH42IgnRgllM24fgJxuXinEDFjgxrX3xTQofiNxhraeRwSU7QNrfuG9qvA==
X-Received: by 2002:a05:6a00:8c1:b0:748:3385:a4a with SMTP id d2e1a72fcca58-76e20fe6334mr118722b3a.23.1755021619359;
        Tue, 12 Aug 2025 11:00:19 -0700 (PDT)
Received: from fedora (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2ea6893csm15793073b3a.104.2025.08.12.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:00:18 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	brauner@kernel.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] Fix and unify mount option log messages
Date: Wed, 13 Aug 2025 03:00:05 +0900
Message-ID: <20250812180009.1412-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

This patch series fixes and unifies the log messages related to btrfs
mount options.

The first patch addresses a regression where mount option messages were
no longer displayed during initial mounts after the fsconfig migration.

The second patch unifies the log messages for NODATACOW and NODATASUM
options, which were being handled with the same logic but had
inconsistent and duplicate messages.

Thanks,
Kyoji

Kyoji Ogasawara (2):
  btrfs: restore mount option info messages during mount
  btrfs: Align log messages and fix duplicates for NODATACOW/NODATASUM

 fs/btrfs/super.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.50.1



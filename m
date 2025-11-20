Return-Path: <linux-btrfs+bounces-19223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011AC74890
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 15:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4592931372
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB4033A6F6;
	Thu, 20 Nov 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL8hDvHg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324E337BBA
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763648409; cv=none; b=S9FyjyfMNq3TlF0b6xsVpDD4cXyvSOgePfqB5FQPqytB3gXpkhQObuW4xct730o3PLaHEeJcifO9MT9o+T4rLk1IYNT6ztuZRF4n3wsfroCDo4cSk/MYm9uUDw4uKeBeD3ZkuSnegOEVKjulTvscE42CvWYa71A0E8q5OKo5R/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763648409; c=relaxed/simple;
	bh=e9wtoiLEVxXvEsOvNJOWWpQsksJUCRMWXsU8xi6I+NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZ81Qqoul/g55ob7jD6DsIJIA4v33RMl/nHh0I1okq204POfGx7cmZ6vslnW6Fjn18io1w8tMBbg6dGp69ZzXGx/QjDnJ8cvfyT0HZi2oGvZs4C5L1F3Z08GA306rvbsJMb+5qlRJX/tIh3AcnIAGbXTH2ICpanHAETW82KvEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL8hDvHg; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7b7cdcdd8afso40435b3a.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 06:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763648407; x=1764253207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22O38VwMsd8mbyQud49yrZnW17vBFdqcc8w89ylx5QA=;
        b=nL8hDvHgdzqKwxOfneStSKjjrELPbMiqFtkGrAxTqn62s60daMzd0zN5e8wj1JKTsi
         34g9yZoYYpwElEUCrRVGUA2I3FbpX/L+z3HNXA1c/Ko1tEe+p2ux6ZanMi5bWaBHrMf8
         hLhsVjMRRrkwEoXKSVMDCnK7YSDBI0BarhniomOD2una7gvZQ851U9+sdIjE9HmaCVBq
         iYA1E7ObVl9hp/EKS+DKyfyEHJDavLWDnmXPRYDL1wlHbDA0hd+w0hHpHSHOgTgcP+qq
         q9kmpw+6K2YuTT8t2l5fl8nFeSyZEzUZkRTWlhxK+rnm2Obb3ckplC92Vd2NtBKQKjhH
         e/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763648407; x=1764253207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22O38VwMsd8mbyQud49yrZnW17vBFdqcc8w89ylx5QA=;
        b=N9RL56eQ/E6cw34MI4SLlj82y7VtJVOuTcH+0O6guVVWAvNHNaz3VrlTotu9bfXh2Q
         x00Vuv57IAKVbU0K3A4hxBZoU8w4SPJR2vxGqr95QYBv1x3y0s8l9W29lMirAWoq4RbA
         MyQGoi7/qaQwQrO+cCurb9hWTuOw/qiReCQRUCe6Sc4dZmJ6/F+U1LSaabHL4LdFinvO
         BvLGxx1kTXEpOvKMCLwXy57jbLtwYmQWe7Yj0mSBQOUQ+oUmDVMrE2GgesO7NjUe6xSp
         9ve+F4IKoDQ1r2fzo2FFefF5lyZBxJY7SY7002TnTisrAJ4jnAIhKzxhStMCo6b65nYq
         BIEA==
X-Gm-Message-State: AOJu0Yy97fnf1CvMdZ9AT8uxX2Jwm1mWh3QgtPMguWjR+D474HC6GpiZ
	B7uHumacSbETN/Il5rtF208l3TT2GVKSh41laGMMa9RV5J4cIJPL0+EHFQ7Ltqzu9/k=
X-Gm-Gg: ASbGncs3JBGCnWtqJbFsajjjKA8NcJZFC8CuXYZLV7rorCcKYF+Jfcbq+cuJ3urrGcK
	n50giEK4CNTGw05ry2jCnoawcmhr5fCOBoEAD0vfmud130ltQoqDzUY4dKdqcdURWL3m7h62WiB
	SLuN1GUC/hSeAvgtTwM2lrvpGxQk3JkGmR8qhnE54H/zf4J/eLXc0+Q2isBxcLb/PiAWgY1fzhG
	McLM9aa2ftLunVoSOj2b8wweRvz5d9p+tX9Kk3lYjcrapjq7KpfX3ZW4Opzs6yfnbQTAQqd9lqd
	2Sa+2qiYzzNNmr3A71KTXOV8qL7YjaugH8uRgtigQ1J5knLmAazPkp+tEbktb6a4RCQ4dEBXk3q
	Sip46F3OWrEOEUJgRlI66/KbT9+xdMEbHPDgJQn4aUJmJs1MoLLi2PY5D6iJhfON6fpab3A/eOP
	eUAq1nF0A9DLQw/i+KuVIo
X-Google-Smtp-Source: AGHT+IEY4RAlWNqqz1COcKy1AJPmoFtyZH/tyCtTurpfk7qN/Y1MnWuPENgq8PzwrL7/QC08K6qf0g==
X-Received: by 2002:a05:6a21:32aa:b0:35e:11ff:45bd with SMTP id adf61e73a8af0-3613b5f0f59mr2422647637.5.1763648407436;
        Thu, 20 Nov 2025 06:20:07 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75e4ca0casm2781600a12.10.2025.11.20.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:20:06 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 0/2] btrfs: use true/false and simplify boolean parameters in btrfs_{inc,dec}_ref
Date: Thu, 20 Nov 2025 22:19:12 +0800
Message-ID: <20251120141948.5323-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tiny series removes the last 0/1 integer literals passed to
btrfs_inc_ref() / btrfs_dec_ref() and replaces the open-coded
if/else blocks with concise boolean expressions.

Patch 1 switches the callsites to the self-documenting true/false
constants, eliminating the implicit bool <-> int mixing.

Patch 2 folds the remaining if/else ladders into a single line
using the condition directly, which shrinks the code and makes the
intent obvious.

No functional change.

Sun YangKai (2):
  btrfs: use true/false for boolean parameters in btrfs_{inc,dec}_ref
  btrfs: simplify boolean argument for btrfs_{inc,dec}_ref

 fs/btrfs/ctree.c       | 33 +++++++++++----------------------
 fs/btrfs/extent-tree.c | 21 +++++++--------------
 2 files changed, 18 insertions(+), 36 deletions(-)

-- 
2.51.2



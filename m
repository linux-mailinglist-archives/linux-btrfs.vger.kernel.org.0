Return-Path: <linux-btrfs+bounces-8047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8D979F16
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1451C23258
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8314D282;
	Mon, 16 Sep 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7nEnRb8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D5482EF;
	Mon, 16 Sep 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481788; cv=none; b=T2BGIqzJIQXO1GzL88SCYAKIeBdTwiwQbXTqOxCZQyWI0ouKP0c7iv7qxzNmNZfAixGef209dQQbhEP/8ozN0iAEc3viBZwklqiccLPbqKj0R2yZrnhEqMJhgC+rR2N560rvKWoCHa3Gu569RW0E/w/joLcHO7rs/N5F5yWRGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481788; c=relaxed/simple;
	bh=3PmXEbvBwZ5AbWNH/b5CsVXpSiXv4PAu75LGPqoGkr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eilCWMjzVQwcsPH+4PIB9o4ajuRpjDkBKmrOnOeDTWLmwOXNKRC8KolruS7ufJcsTgxfPxabU8/vu/IJmZY4v4YzxALjq8hV9mc9XvB7ROl4YIM7lCfvRdkyI6rmEAcl3V/azsioZVoiucK7ineiQF9j5zf4NMZtqxCov8Xgxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7nEnRb8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso40628585e9.2;
        Mon, 16 Sep 2024 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726481785; x=1727086585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ubr2Tf5MwgkTisbIHjcv/5KCFjGzBhTy/uqy94EsX0=;
        b=e7nEnRb8fg1vss6l66uQ3/N+/UsD12zJRD7fnHjLZZnYnpMMuirfD9csJ0RlT2Wfk6
         MlKa1kuE3tRxzerFYW28GeYG7IEKa7DWtMeNjIJNMlUJvoMDyXe7kTxYcrQDCK/9yx1n
         H1UKd/NYXY3Twc8JfGKTF88tF6I0w5UNxWEhKC3mRtM98htKEb6chK0omYfuuy9pyefa
         OGLjtv4jApz24FRWjLwH9PFxPPTGs2Amy1Ld4tY3M061KMUJwAMUfMotPTEWvZ4mzUeD
         yMicpZxcxKJuolJU9JzFRM93h8VisTNaSAwOUH7QixHIebOSeTqC5jUX/yJivTF30qb/
         imNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726481785; x=1727086585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ubr2Tf5MwgkTisbIHjcv/5KCFjGzBhTy/uqy94EsX0=;
        b=ffg7uTVYIaGDRVG1gW99zV+rS6qjKSwimFlFhqWQLjW46TQKiZF8xuh1PgPc2YjKof
         bwVNOLk48s4r7Xfn60x8/1LpXpmR8WxYSVvxX8+AfDApMaUOgBvOC0hOsxad1r5wV0Wu
         s60JJErmqO0OOERaYGfxyrhw+dgJEk18DaGSWQZ7afxGfD6zPqqn8MdWU239UVfqyRnJ
         ItvpAXdEswvIOMHxpIt2lLJcVG9vbSiCrzGE2Ca3c/5XA6dQMakfysqLeBNZsHEVxNyI
         rtWMWkJ89W1sDJMy+/DRc+VhLje50J2OnUMf6hUwSN9NXPQKRKM6HVVXxy0dDGNms1SR
         D2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU/NelkMxcTO3YNfSUFOwy4Z1bhtFgmZW9YMApF/OoHY9Wt+5+5zrnGK+aWVqyYlVzqU8cFUWMckSg3Sf94@vger.kernel.org, AJvYcCXZ4qZWb0oVv9FfAwrqDUJpuq8enQz/tru4IU/BTh8uzrkz7jNhurzpA7TGUqGwQKXiRQ7VKSbm/ZheEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1YPKfoDWeqMirzawSLYdVcwCQF348BvhPyWDM6gxx1pLBH0+
	9kkN111YvfbzOkKRRuiyP6HKapsgjj380CqJSUpjA/+RTugxO3B5
X-Google-Smtp-Source: AGHT+IHtEMrW+hVZzph3jggyzBYxyIzLuJ0tA7ui9amp6DJfSCqCLpPCH26uG8zGhduTj1La709dHQ==
X-Received: by 2002:a05:600c:350a:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-42d964d76ffmr109567105e9.26.1726481784313;
        Mon, 16 Sep 2024 03:16:24 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e780015dsm6814201f8f.69.2024.09.16.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 03:16:23 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] btrfs: Don't block system suspend during fstrim
Date: Mon, 16 Sep 2024 12:16:06 +0200
Message-ID: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
* Went back to manual chunk size

Changes since v2:
* Use blk_alloc_discard_bio directly
* Reset ret to ERESTARTSYS

Changes since v1:
* Use bio_discard_limit to calculate chunk size
* Makes use of the split chunks

v1: https://lore.kernel.org/lkml/20240902114303.922472-1-luca.stefani.ge1@gmail.com/
v2: https://lore.kernel.org/lkml/20240902205828.943155-1-luca.stefani.ge1@gmail.com/
v3: https://lore.kernel.org/lkml/20240903071625.957275-4-luca.stefani.ge1@gmail.com/
Original discussion: https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/

Luca Stefani (3):
  btrfs: Always update fstrim_range on failure
  btrfs: Split remaining space to discard in chunks
  btrfs: Don't block system suspend during fstrim

 fs/btrfs/extent-tree.c | 47 +++++++++++++++++++++++++++++++++++-------
 fs/btrfs/ioctl.c       |  4 +---
 2 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.46.0



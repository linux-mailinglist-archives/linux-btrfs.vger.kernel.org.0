Return-Path: <linux-btrfs+bounces-15623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABFEB0D61B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 11:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B8C7A8B0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558192DEA9D;
	Tue, 22 Jul 2025 09:39:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C42DC33E
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177166; cv=none; b=f05140LuAPU478IAzlwHvHg2Gaa3b3bX9tz8FPE21h0Q1E8B/nhfG7PAWygwLrCZB8j4UPIMP2+VAzvWR4EJjCyOLxaLWgTiZmCv4tXW9caTksV07QLub4Kn0w1mMn58/3IiSal2FXXqzNya7rML/q5s1dGDF3uBzglZD6PuwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177166; c=relaxed/simple;
	bh=+sdgVNUh3kRQL1o7X3Ul9Zlcw+8AQfZkUFA/qHiFfcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+q9aNAjeAwX/hJmVGMeLLelF3BHFuLyLWKEXQejl87seKvrsp70zYG51nYahq97UUNTYwkhNhEVIvu6ZM/mudWFhQRwrMPvxg4B7N+OXEcaRi3+GqSrH3+dFKwTWTWi2DNBwCOAxXV7gQfBx0bInTLhHvR5w8+UIaho7fbeOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45629703011so36259565e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 02:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177163; x=1753781963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orFe0Pue/uKQ9Gv26kqzihVDeqac6OsqqmcKmCKlwr8=;
        b=FxRKKQiUSkmCOtWGVRbRsmgE3sN0ERPEFcF5tkeI1mrl0Z3/14+6Drops91EdJOvIp
         qb8K1aUtqfGDj4Ti+b100j6Iav4XpJbrd4zt7++8Ge7O1RIypIdHIkBnPzvO42ykJBN1
         uKzcrh3wxJohYaLd2wXEHeJ+JkTx2P/NPDHIdSt4gewq91lmMpyv+pf7J8M2NIIyfjFo
         xd9GakOColaRgiaPjxSJStRsm2na3Rle8a7+Ts5ctqAmW/VdOmWxM+uECCZqqY45Cike
         RosBK/seyHct73LAAV0s0iim7iWL1vCjWpDLGAg2j9sVWCpFD4uJdQQENFIn1o1c6Fkl
         J9CQ==
X-Gm-Message-State: AOJu0YzymWHtpzK4gj5D/9X8vmdR9F16v/cpZc5Y1HZ//QWhPMdPw6+p
	1mJT337k0YurJbuOPio1Z+IiUjI7JlrQE8cGWhIrXXTiVyGFwZxg0xNgRfs4E5SR
X-Gm-Gg: ASbGncslkV37jsxtkgvGNEh+VlSjrPtEkz/PA1h6JNOoh/DMZrbDCOjWJtzriyE+g6A
	qV7YCTHTHe6GJ/K0fJwVRL6WQqsQoRb5KBkWGwzopYE7ec1AhgKRSTAw9huKZJ7vVIBx022FExd
	+MqGcTFDmITPzrDdoFty8IpJyGLoB3YWqAPg/QJf0gRthdsAqWrzX9QchaXMvc0Nt7ocglwWb7h
	X+hnmVvEJT4aH7WnB9uzi9VB8M9axGg3nVteqaVA5O4Xa3BSfBCXqPucw/ub68y2hRwpq80bpZ0
	HIG9+dFm1lQx2t34+jswL+LYhoNnI9n7gZS/ILof2E7/sfRnDiYwJFpvpvBfSx1G0A5UPn7m26L
	FjSQyFQrnsH/lk4eyZBSh0BCSD0/gjPn0XcF2S2jDcn6RPIRoYMKlnKcIu3HdwP7JzDxxMlyDZx
	vhpQzK/zU9YA==
X-Google-Smtp-Source: AGHT+IFIQVEQbnvd5CRf14FBxU2+PPQpwDz2P+1w9s815FM5fhL/pBoImuH3PK9iv4NSOy0q8LEJkA==
X-Received: by 2002:a05:600c:5289:b0:456:1904:27f3 with SMTP id 5b1f17b1804b1-45633d0d082mr186310065e9.18.1753177163064;
        Tue, 22 Jul 2025 02:39:23 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5c7e8bsm123225895e9.14.2025.07.22.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:39:22 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] btrfs: zoned: two small style improvements for zone finishing
Date: Tue, 22 Jul 2025 11:39:13 +0200
Message-ID: <20250722093915.13214-1-jth@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Two small improvements for zone finish calls. The frist one changes
btrfs_zone_finish_endio_workfn() to directly call do_zone_finish(), as most of
the work done in btrfs_zone_finish_endio() is not needed in this context.

The second one adds error propagation to btrfs_zone_finish_endio() so it's
caller btrfs_finish_one_ordered() can do error handling (in case the chunk map
block group lookup failes for some reason).

Changes to v1:
- Remove stray bg->last_eb = NULL setting
- ASSERT() do_zone_finish() returns sucessfull
- Remove stray {}
- Remove ASSERT(!block_group) after if (!block_group)

Link to v1:
https://lore.kernel.org/linux-btrfs/20250721070216.701986-1-jth@kernel.org

Johannes Thumshirn (2):
  btrfs: directly call do_zone_finish() from
    btrfs_zone_finish_endio_workfn()
  btrfs: zoned: return error from btrfs_zone_finish_endio()

 fs/btrfs/inode.c |  7 ++++---
 fs/btrfs/zoned.c | 12 ++++++++----
 fs/btrfs/zoned.h |  9 ++++++---
 3 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.50.1



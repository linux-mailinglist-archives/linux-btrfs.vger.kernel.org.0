Return-Path: <linux-btrfs+bounces-4828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724088BFC53
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA7B2419B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E3082D7C;
	Wed,  8 May 2024 11:40:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B1823C3
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168431; cv=none; b=rbPqoKy82BQfB8oWpjyfX4UoVxl3OdaRfHusY7yfPWoGZlzhBg40SaGjS5OcgfH35Wu5sWYBYKljKpMa97p/om96bSdcn8IpCJ8eI4A0w7C7XHnMr19ldr27gPZ5HK84Xx2s6CLIP58n+u+9VSsfmeTunQj2697oTxbG+Ovvr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168431; c=relaxed/simple;
	bh=QCRgHD23DaiUdNVGlGp+m3FTNUDZ/OGtfMsRmTHjfa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pSNS7NL2JFeHRMxNdvw40zuac9nC1zdib0J+4yTBaA87Y3QHZdgycrBmN2Uu59gg0fUTMkcxsnZz1Y17u8E38B9Dr0uqcOwn0LTjYauc0tQUeFzXF9NF8WalmKKwy3uVn3+B2cn2ydc5j8oPkagZ7rtdDDEbx70oKULygm2beUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso995370466b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2024 04:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168428; x=1715773228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voAZA6+xS0EincowHjLOT5zTo22k5ziLtHt3Y/yNjjs=;
        b=KZtrFzCzstRZa3UeWaxLL5NVRLNwopm+H6VizxPccJMGyI75ojjV8mm1b20jYOHfEd
         DNy4fUImyPa+eCQIsdy/Xw+siEKhRfjtT6kZSqgO8Nc9aEZx9Aij5SQHEZiO9KGvxmqF
         7wNopBO7nx2NIB5dfgdLkXjq0AWOkBIcger34BpmyrZPuf2kKa6R5xJPp0oCzkKDaASy
         2y1wS0dFEZ5IfW2Scpg1i5ycnQDqzIVidaUycBgDjF2LQUTX74ujeNER0eVrl3JoC20i
         flyXCOXcytdfAozq03dYz/2kYo5E7o1esb8sGt5h4ot66dYMddTPUHGrDvxTvi810o4p
         G+nQ==
X-Gm-Message-State: AOJu0YwkQWx1WxceqvNJHxJaiLqLvuoASiGXadrO4Cpi+nmUrCkoUwPm
	gmMfkR4//TxRYO17o/nRgs6/bE7HFBP2uORjbHeBPd7ywnYQmGOSDG2O5g==
X-Google-Smtp-Source: AGHT+IHmQzuCpDKYwyWE+bWjPra6J47aN2q42LY0flyJvebaj4b2ey5GMf5fNEiNYtF2v0PHmAHMpA==
X-Received: by 2002:a17:906:81d4:b0:a58:ef89:d04c with SMTP id a640c23a62f3a-a59fb96a322mr146343966b.46.1715168427865;
        Wed, 08 May 2024 04:40:27 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id x2-20020a056402414200b00572cf08369asm6710380eda.23.2024.05.08.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:40:27 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] don't hold dev_replace rwsem over whole of btrfs_map_block
Date: Wed,  8 May 2024 13:40:14 +0200
Message-Id: <20240508114016.18119-1-jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This is the v2 of 'btrfs: don't hold dev_replace rwsem over whole of
btrfs_map_block' sent as a series as I've added a 2nd patch, which
I've came accross while looking at the code.

@Filipe, unfortunately I can't find the original report from the CI
anymore, so I don't have the stacktrace handy.

Changes to RFC:
- Incorporated Filipe's review
- Added patch #2
Link to RFC:
https://lore.kernel.org/linux-btrfs/2454cd4eb1694d37056e492af32b23743c63202b.1714663442.git.jth@kernel.org/

Johannes Thumshirn (2):
  btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
  btrfs: pass 'struct btrfs_io_geometry' into handle_ops_on_dev_replace

 fs/btrfs/volumes.c | 52 ++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

-- 
2.35.3



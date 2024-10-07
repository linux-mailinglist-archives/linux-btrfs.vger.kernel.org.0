Return-Path: <linux-btrfs+bounces-8584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC6992AD5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 13:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2781F23BE4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA91D2223;
	Mon,  7 Oct 2024 11:53:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28B18A6AD
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301987; cv=none; b=hveAYYCdLNeQs2ewmBipCO6ym1BgLz4u3IJcNSftMfJHzPyCMgDKFb2jOk/h5F5a8uu7okBNLYf8shS9YyOUqiz4RriVZdGPQQHzsXI/V2CDFGyLCw8MDtQuFF1UR5Y1Hxxzudkuhj107YUiZsWbq8k1oH2IB7kgGtxqijN39lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301987; c=relaxed/simple;
	bh=Z3vl418UxYCnJ2Bxry9haiajhx9HrAJSlnB6eWQMWP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQePyFUzDw1M4Vn8Kxni0fVcbCBZNsmY1vlOvEETaZMsY4xKa/l3YSQD75hZHjyxtXnNRyhxtxqRRNVmDmZgxL2gxgVlMWO0ZQonZr12AwNs3nRQY1QWIgAjpnYwwzaWIxq/yJSZ28debTcM1ckl1m95zgAw7XaVq7Te6CZ35WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so4071039f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 04:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301984; x=1728906784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsRQQBEvbrWmCk6C8HtACsyRrvw5oKPa9Bvkw02/jhs=;
        b=I5kGuyWU9PJZ+z1QeYcbj6tPBPLzFoxNKSmpJUk9lH1OjFM1+wXf/LXU2WYaZoTNxT
         guZgWU3f7GiNxS40q/9OUROxQDE331QEzzcIPsz55PzS5CBGFioc9EFoyijCf8v9VzTR
         0JRJRxDxFkG1N9Nykk8XDXx1AsGEjo8arGCGGia7gdcinc1j/xKlHGgpiOfcfvqA6MBi
         aHG8i6sgtkVkF+CgC+OoV/56vP/6kDvl0LZ7VakWJx7xUrvU5JIXlgOKRc6MIwwi0KYs
         uIvc+eB9XCXYZb6UvVEicxmjLbQplfFznWg6m1F4VDBAaTu6bFOW0Ojzt3RXWXfq1A4J
         5/Nw==
X-Gm-Message-State: AOJu0YwvaOQYJoHJqNNsKA5MKyicyMjWwEUi+H6WrqNbKzuaajbFzKUx
	vJpPGQshbDOk1I8sQwgXkrTPjI0/eqJ31ABN8BqlAh3MWzBeGNN2
X-Google-Smtp-Source: AGHT+IH/drncg/raiTvvcJWhpEGMuBV0IT8eliG5P8BrYfvuK1jaeWS1gqfPM1KsRazG7rr27jKLvg==
X-Received: by 2002:a5d:6448:0:b0:37c:d123:f3bf with SMTP id ffacd0b85a97d-37d0e6ec0ccmr9621253f8f.3.1728301983454;
        Mon, 07 Oct 2024 04:53:03 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71aeb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71a:eb00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e36dsm5570238f8f.85.2024.10.07.04.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:53:02 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] btrfs: RST scrub fixes for prealloc
Date: Mon,  7 Oct 2024 13:52:46 +0200
Message-ID: <20241007115248.16434-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When scrubbing a non-zoned RAID stripe tree filesystem, the RST specific scrub
code finds false positives becuase preallocated extents are not backed by the
stripe-tree and so the lookup failes.

These patches address the issue by a) changing RST lookup failures from
ENOENT to ENODATA and b) skipping ENODATA on RST mapping errors from the scrub
side.

This aproach was suggested by Josef in 
https://lore.kernel.org/linux-btrfs/20240923152705.GB159452@perftesting/

Johannes Thumshirn (2):
  btrfs: return ENODATA in case RST lookup fails
  btrfs: scrub: skip initial RAID stripe-tree lookup errors

 fs/btrfs/raid-stripe-tree.c | 6 +++---
 fs/btrfs/scrub.c            | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.43.0



Return-Path: <linux-btrfs+bounces-5591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8C901D1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550BE1C21132
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100136F30E;
	Mon, 10 Jun 2024 08:40:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FC55C29;
	Mon, 10 Jun 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008835; cv=none; b=AH6zgIliRWnsUQzynUTosIvm/ITnjwPFw2kBCcRdWJNZokQD+GmiYvFkRhDLiK64j93sDi7Y5+0cKNkZscBVWYiTxArChY80Qs0/PSewjPQx3YTo4J1ZPPdwwT30IiLkn8+qFR/b837F46YUx6d89hfjWjo6ltZALmBrlu7VDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008835; c=relaxed/simple;
	bh=Zmv114EE1FOd23A5JjLfzLhyrXS0dKcLrY2NVj3+FjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=otiMwVPEKttJeFPXiWWrvCv+P+ug6eCs5PTkeL3WIh6d9R+TU8DFsD+0xDphqjWaQoJKTC1Mphxz8pCsbsY2R2aYDzN4dp70QmGjP8JF7tWXhTvAR7SJjdQhOQr5A3XDjs9xpI6GLarY+flZwtCv5egVPnL0NnLAElxP6cRSCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e72224c395so37818111fa.3;
        Mon, 10 Jun 2024 01:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008832; x=1718613632;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NqjyfBj/3bEXpQj/CSZPCC3+9p3CaSBCTajT4uJgQU=;
        b=Z2DcXleDHcgSV3IFyA+o2uJy8Omu7udwlBd3/5EAQW4Vv2fWflVtKU18V8nd4kR3tI
         tYW+3BMgHine8HDu3V/HhoWCTvVaOqJlakxSSFCfRdSmZ1Bs7lc3Tqfx8acPyYdu5xU0
         G/jOSXuXbyGmcm1hNRiFEUMAyGFqpDY2kojtYF7LqYPiKkvHSVh08I3SBs+t8ioq1cc6
         Pzsy22JKFhiolTzyY00CpIIrO2RCRKM6GmoV9xief1ck92ZhbfMZTfVMfLq5EmCC0Gjh
         3v9RoeiDPEeOqbQOIfjJkp07VtCI+rPixkVPZF9749u0rk2XB4HMbl3WTHVMq6EOn6TK
         bjRg==
X-Forwarded-Encrypted: i=1; AJvYcCVNEeU3qYs5SjQPk4OPUgdcGXKcS0xyqwfddi7lebqjVWnoiPQPohwSAit7k3nZ1KJcJV94w53qq2ZP6qWAj+WflkTAciNit7m2berD
X-Gm-Message-State: AOJu0YxLXmeu5NAJSF6Wyx8ISCLspxSBzedlMr8PCyR7deiOqJb9uN7H
	FXHZIvlsp8mIehkmDAjs3VWwVMc+LHjsW919gc8lD/z3HiYltCO/
X-Google-Smtp-Source: AGHT+IFgRAFNKYxdwICh/5RazhsJFvZ9ZWh37SOr11W7BiO2P2u0P7+yfulVV9aGARHb7iB/ZewYfg==
X-Received: by 2002:a2e:9e59:0:b0:2eb:ecbb:3ad9 with SMTP id 38308e7fff4ca-2ebecbb3c14mr4353881fa.52.1718008831855;
        Mon, 10 Jun 2024 01:40:31 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c72efe054sm3259581a12.66.2024.06.10.01.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 01:40:31 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/3] btrfs: rst: updates for RAID stripe tree
Date: Mon, 10 Jun 2024 10:40:24 +0200
Message-Id: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPm7ZmYC/x3MMQqAMAxA0atIZgNVtKBXEYfURM2i0qgIxbtbH
 N/wfwKTqGLQFwmi3Gq6bxlVWcC00rYIKmdD7erG+cphaDDaidfBdIohOyLf+dBxS5CjI8qszz8
 cxvf9AMkA0OFgAAAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=jth@kernel.org;
 h=from:subject:message-id; bh=Zmv114EE1FOd23A5JjLfzLhyrXS0dKcLrY2NVj3+FjI=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaSl7f7Hx+irnhL7IXr20c7Taix9NdOvW4TKunFOYnsze
 a2F1wPPjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZgIOx/D/7KobRG/udTdJGa/
 rgm8tej2BEFV3STdidFHVetW8bW/5Wf4ZzXD6Wjcp0N7nLgyJpYud5zJelbjpe36jDVJjq+1RdI
 K+AA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Three independent updates for RAID stripe tree.
The 1st one removes pointless space from the on-disk format. As the
feature itself is still experimental I'd like to get rid of that as early
as possible.

Patch 2 replaces stripe extents in case we hit a EEXIST when inserting a
stripe extent on a write. This can happen i.e. on device-replace.

Patch 3 splits a stripe extent on partial delete of a stripe.

---
Johannes Thumshirn (2):
      btrfs: rst: remove encoding field from stripe_extent
      btrfs: replace stripe extents

JohnnesThumshirn (1):
      btrfs: split RAID stripes on deletion

 fs/btrfs/accessors.h            |   3 -
 fs/btrfs/ctree.c                |   1 +
 fs/btrfs/print-tree.c           |   5 --
 fs/btrfs/raid-stripe-tree.c     | 148 ++++++++++++++++++++++++++++++----------
 fs/btrfs/raid-stripe-tree.h     |   3 +-
 fs/btrfs/tree-checker.c         |  19 ------
 include/uapi/linux/btrfs_tree.h |  14 +---
 7 files changed, 114 insertions(+), 79 deletions(-)
---
base-commit: e361635b966fca48f92263277ff38cd5a1971d39
change-id: 20240610-b4-rst-updates-d0aa696b9d5a

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>



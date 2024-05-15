Return-Path: <linux-btrfs+bounces-5022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767A8C6C49
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1C42848FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB8C15920F;
	Wed, 15 May 2024 18:43:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A35B1F8;
	Wed, 15 May 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798593; cv=none; b=cKOVRn/nbp3h13MNRUCzph7bykSiNa3GG9+Xt483YPMuGzS+RzjEj1ulXoH9esk4BDhpQK/NYKwV/y0ZHkpaXGH05RJuNU1hs9Sd//7WdHHJtxEkIzVjXUTIyURIp7+aiBAljJ4lFsUZ/GB/TNIKdeKla5tiIWWvY1mROIKMz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798593; c=relaxed/simple;
	bh=ZME+MN7RLbjJQdXafmg8X4d3sQojCV/y8dHf1/Jomz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rc8JQlJiC/KEeGk1THWipqr1NcJXZAyuCLbMF7At6YipHStA3diJMte+QhU0MXnOtrrv+jDLmGlfJMZZVzUNZVVVHe66gqPfayZhrlGYkveVfZ6RArlIrHL9B1VaRdrDB1d2Er0KpQ+l0vSsebbZaeOmBF606pk44/wzf77Rebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so3054410a12.2;
        Wed, 15 May 2024 11:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715798590; x=1716403390;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+x9YbbXZGKes3m+Na4YkHDoAmHUGifUPCswllvzoGM=;
        b=BzcW3fIu+A41luIWpoUuTnA6DjoBK5WmIFHgNyb5n6fgTMV8/aNQD5ONMEL6w/KlnW
         U/47Whj6DRHFKId5Iwp7mE6GQTRGhYViE31atlneMowoAfMp6GCCmg/906IqDs8rk+6r
         Mgd2IAwLYWT0LxPX1MRLV/U4vaSOb6fhOMyGQ313yXRRySg0HWO8k0SS5XmVMwJXrkGc
         jF1Dra0ysrep8Mg9IUBc+N2ns0kacQ35k3DvvKM805DR1qVGCx5y/PYGfB/5S4Jqe8Ms
         jpb5HcLGsoIialNHzcuocrbbWOCJ9yDUkhaChrgAk9U34kj8YJpVKzAIW5u8RfCPCNXn
         KmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmlPfkPuXU1facCT741dNS0tz6ZbVdn4y1PpheUzCXbhDsAPzLvL0+jJGVgLOSbN8bzcVQ2MugWmgcwbQvutA+MuXojwEe0M80goGa2sylcUEBPWbN0ATMItXn7c0MHuvPpzGrZjvMN9Q=
X-Gm-Message-State: AOJu0Yz5zddHrEeViVgesWq6RzlKQsMHNk78tND+/rxry8AclG1tM9mV
	P2N7fAE7LEIWYu94KP0o9/5AP74sih0PT3S9pC4gSXR1aiE9OpYS
X-Google-Smtp-Source: AGHT+IGA3orfXvWXtZCs7z+SRgTCM3uCGXJCFDi1U3sSvoKmND3e4H8h5QvYIaOuRvNCIi7HSLJ61g==
X-Received: by 2002:a50:aa94:0:b0:56b:cecb:a4c8 with SMTP id 4fb4d7f45d1cf-5734d70603cmr17407606a12.39.1715798589490;
        Wed, 15 May 2024 11:43:09 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f4a6280csm1724340a12.52.2024.05.15.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:43:09 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 0/2] btrfs: zoned: always set aside a zone for
 relocation
Date: Wed, 15 May 2024 20:43:05 +0200
Message-Id: <20240515-zoned-gc-v2-0-20c7cb9763cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkCRWYC/23MQQ7CIBCF4as0sxYDSCW48h6mi0qndKIBMxiiN
 txd7Nrl//LyrZCRCTOcuhUYC2VKsYXedeCXMQYUNLUGLbWRvTLikyJOInihPVp3ML3Dq4V2fzD
 O9Nqoy9B6ofxM/N7kon7rH6QoIYWSblbj0Vtj7PmGHPG+TxxgqLV+ARLXKUGhAAAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

For zoned filesytsems we heavily rely on relocation for garbage collecting
as we cannot do any in-place updates of disk blocks.

But there can be situations where we're running out of space for doing the
relocation.

To solve this, always have a zone reserved for relocation.

This is a subset of another approach to this problem I've submitted in 
https://lore.kernel.org/r/20240328-hans-v1-0-4cd558959407@kernel.org

---
Changes in v2:
- Incorporate Naohiro's review
- Link to v1: https://lore.kernel.org/r/20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org

---
Johannes Thumshirn (2):
      btrfs: zoned: reserve relocation zone on mount
      btrfs: reserve new relocation zone after successful relocation

 fs/btrfs/disk-io.c    |  2 ++
 fs/btrfs/relocation.c |  7 ++++++
 fs/btrfs/zoned.c      | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      |  3 +++
 4 files changed, 72 insertions(+)
---
base-commit: d52875a6df98dc77933853e8427bd77f4598a9a7
change-id: 20240514-zoned-gc-2ce793459eb7

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>



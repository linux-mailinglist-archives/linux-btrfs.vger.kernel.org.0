Return-Path: <linux-btrfs+bounces-5281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DEF8CE8A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477261C20BD4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8412EBE2;
	Fri, 24 May 2024 16:29:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA347126F06;
	Fri, 24 May 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568161; cv=none; b=a9Jb8MSK3h1kjqvziE7VXfBOLQSlTRNLZivOfViooyMMcAgksyX5qAraIem5t2Tl+2V0di5//a4SsJF/sHw7w7otEGhrPXtsCQB5koQnMcRKGTZQZaDIUgYTqsahsX9rC+N7Zrp6CxXVIiy8gUgW1hyjX+mJcLYGomIx9VZbBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568161; c=relaxed/simple;
	bh=gXyxBWibeXUwqcMk4+uZivGUqGgkuPH86sT5M7vg9lw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GIc5/0Ly1Riq2aU4NkDEaKMSekazQmzBz8Ng2cdXnGy1yWRLHBHPp+pyv7SoXuEtCUd/V/9XukR7EwNIc0o/pU3lfCVgUEKxnhpSR+EwVoMJuNHyPn4E+AMquwB3N+trMyWofGdZaXl5wLhAeB25y855oZfTykz1y1YOwQWs+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a7d28555bso1343660866b.1;
        Fri, 24 May 2024 09:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716568158; x=1717172958;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+YAuHdOZVCtb+ZmWIiRbLMqGayfxaS/iCjW3hjDnCw=;
        b=i5f9Jk952XhiTqHVTkQKT1TC/HPMbM++RiLdbTKvihcPajQxeYGAPTF1iEx7HwwuMq
         uiOq7qENUOuRdchdjpTFwMRvEPt/V7/EPn38RHm83AaeWfEeHRIJW2xtkXp65rnAT0pt
         034Lafc8CDRpQa1kpkx8wRBhGH1DzBIk+zTa5uDS9JqpTSLHdNX70csTGWhUFonmBt4n
         XA7Pnw63rfWiLPUIuEpeSZ5O525sihe/+FYkfS1cN8xpVSnJNplFVJjg6vs0QMO6VSe7
         lPqGJjjxPrkU4IdJzGjXC+obG7pshgMx7AXFLK5sFq1FBWYM/MRXT4mGC3In/IiGbF0g
         Uoeg==
X-Forwarded-Encrypted: i=1; AJvYcCUdfdYk9AE7hSpZKLDnp3LwLF7xWEkj+/npyRLB8FtZRBzr/8uqjCdh/aeXa7+33ygryfCT/PBktugJVNhEnvhgoUaQOVz8m/atyMipy3gK5Ew68Ku+OiRLJxImT0LWimhCLJZm4my4Pk0=
X-Gm-Message-State: AOJu0YxPtL69x02SgYa1KOGXBQzMJ0/oaCcByHesoVYBSBpzlkddCOY+
	EQj2MqYv4eHBsMEa/9cwsZV31E3GgGUm/7E67EFb5Hsl1bEMj89d
X-Google-Smtp-Source: AGHT+IFEYEIkAL41P2xHZ5ahUJbQKypTmQHKStTHVyJKBNsRaKOORgXztWudtth5IXRZUpNrcNsYmQ==
X-Received: by 2002:a17:906:12d8:b0:a5c:df6b:a9b5 with SMTP id a640c23a62f3a-a6265128c6dmr186503166b.59.1716568157869;
        Fri, 24 May 2024 09:29:17 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8dcb2sm154137066b.173.2024.05.24.09.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 09:29:17 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v5 0/3] btrfs: zoned: always set aside a zone for
 relocation
Date: Fri, 24 May 2024 18:29:08 +0200
Message-Id: <20240524-zoned-gc-v5-0-872907c7cff4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFTAUGYC/23NTQ7CIBAF4Ks0rMXwM5TgynsYFy1MW6JpDRiiN
 r27tCtMXb7JfO/NJGLwGMmpmknA5KOfxhzUoSJ2aMYeqXc5E8EEMMWBfqYRHe0tFRa1kaAMtpr
 k90fAzr+2qss158HH5xTeW3Pi6/VPSeKUUc5Mx5vaagB9vmEY8X6cQk/WliRKqQopshTMatsaX
 UvrdlIWUvBCyiy1ywwEKLD7TSilLCSsmxKd6WredA37kcuyfAGi4l0lTwEAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>, 
 Filipe Manana <fdmanana@suse.com>, 
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
Changes in v5:
- Split out one patch to skip relocation of the data relocation bg
- Link to v4: https://lore.kernel.org/r/20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org

Changes in v4:
- Skip data_reloc_bg in delete_unused_bgs() and reclaim_bgs_work()
- Link to v3: https://lore.kernel.org/r/20240521-zoned-gc-v3-0-7db9742454c7@kernel.org

Changes in v3:
- Rename btrfs_reserve_relocation_zone -> btrfs_reserve_relocation_bg
- Bail out if we already have a relocation bg set
- Link to v2: https://lore.kernel.org/r/20240515-zoned-gc-v2-0-20c7cb9763cd@kernel.org

Changes in v2:
- Incorporate Naohiro's review
- Link to v1: https://lore.kernel.org/r/20240514-zoned-gc-v1-0-109f1a6c7447@kernel.org

---
Johannes Thumshirn (3):
      btrfs: don't try to relocate the data relocation block-group
      btrfs: zoned: reserve relocation block-group on mount
      btrfs: reserve new relocation block-group after successful relocation

 fs/btrfs/block-group.c | 11 ++++++++
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/relocation.c  | 14 +++++++++++
 fs/btrfs/volumes.c     |  2 ++
 fs/btrfs/zoned.c       | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  3 +++
 6 files changed, 100 insertions(+)
---
base-commit: 2aabf192868a0f6d9ee3e35f9b0a8d97c77a46da
change-id: 20240514-zoned-gc-2ce793459eb7

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>



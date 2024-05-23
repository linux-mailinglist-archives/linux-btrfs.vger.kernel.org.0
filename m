Return-Path: <linux-btrfs+bounces-5250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2CE8CD6F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 17:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225731F24BB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA092156E4;
	Thu, 23 May 2024 15:22:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06712E75;
	Thu, 23 May 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477727; cv=none; b=DNK0PISBUssqxGX6q1/Q4JnuXhV/+3mziSCxUISQkR2TnMbGQuWYUVHMbUj9dVmWSFPfnKU+WvgMz4vasVZwkHz/T6GNep3ISagEm7GhDM+a883X7eG51SNjnp0GZsp2FyIJdDw2hsZXVxdZNuW3PHHCU352sbnJY6zCf7L+704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477727; c=relaxed/simple;
	bh=iS0Vl2feg6YGtXGGmql9J3e6wkSn46SBJ6MyC9QcBq8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iaScLIEO8AM+jlpEFXoFOL0ZET72VyxJlqtO2MJHNp9hAANKip91nFEhdkPjDObVEFix+wB8pG7W4WZgtNDMjtBBMC2WBaqsEDxmtcAzy8bYhNs9Yfzhbai8l5IHp1N43jIBy9nrXrrrutB2liVAc/Y5IwG3S20/WPIpoehw8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42011507a4eso18340925e9.0;
        Thu, 23 May 2024 08:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477724; x=1717082524;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Omv3CE4JTKHJNJ7ViuB1yqlPVYiygq8Tk4jGwl0+1EQ=;
        b=c1CwmOlyz1cEwu2C0TLcSwFaeScNrR7SkcFdMkS3LMLFJufYAoBdZSdE6F+PalSz1o
         GXvNhCc+M/0JHF8twTfp1Gft0utLie4fOMVdKEF94A8EYRdb8b//BzCaVTR71SD2EPE4
         4jqd3xnLnfG162fEvLSJS5BSFELY3AP0DzUeWIL/YlYBvHhPiiio+aDLou5wkHUuOY27
         WDbVzreJgDVTnBbo18SumIQIbazleINIEhmajdbk6OXUAOcZCFG5L5IzyrJG7vac1ylK
         kgUmICTc/XgrjH5F5J1mEhQUQZwbYr7KwBPR2HultB0/PpPM26kIcyTB+gopAAN9OiH8
         fqIA==
X-Forwarded-Encrypted: i=1; AJvYcCVMkiAHSSFhvv4PDx7CtT0pl+Cg/3X6zaiBhaKSZ4y/12p69KAGXGNwUUCENy2DZrE4kNPh9BlzwuJrjRKZI75UKXp3MKCGvpsva3f4kmhy4PLXyOMA41cha7zeOI/2BF0Un6tqDHWD4UI=
X-Gm-Message-State: AOJu0YzUeM2cHQ3VD6HhEZeq0XD/1a0WOOwgyDdvgPAymN6ClK58Dxvq
	98ntzv9B4n158fXDKGsk+EwKOnMV/RCQDK5Kz7fk8V3Z3TduOidWavOQIxgY
X-Google-Smtp-Source: AGHT+IH7jWOtyc5S7XmVT4dMDlGuK/DVj2PtEwDpjEUm/vsgwMhkSFg5alW0wVlEhFYRFL6GS3sxAg==
X-Received: by 2002:a7b:c355:0:b0:421:ad:f104 with SMTP id 5b1f17b1804b1-42100adf195mr22738175e9.10.1716477723562;
        Thu, 23 May 2024 08:22:03 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f709b700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f709:b700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421010ba0f6sm27536015e9.47.2024.05.23.08.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:22:03 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v4 0/2] btrfs: zoned: always set aside a zone for
 relocation
Date: Thu, 23 May 2024 17:21:57 +0200
Message-Id: <20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABVfT2YC/23NTQ7CIBCG4asY1mL4GUpw5T2MixamLdFQA4aoT
 e8u7Qqjy2/C8zKThNFjIsfdTCJmn/wUyoD9jtixDQNS78omgglgigN9TwEdHSwVFrWRoAx2mpT
 n94i9f26p86Xs0afHFF9bOfP1+ieSOWWUM9PztrEaQJ+uGAPeDlMcyFrJopaqkqJIway2ndGNt
 O5HykoKXklZpHaFgQAF9vvPZVk+7Aw6oRUBAAA=
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
Johannes Thumshirn (2):
      btrfs: zoned: reserve relocation block-group on mount
      btrfs: reserve new relocation block-group after successful relocation

 fs/btrfs/block-group.c | 17 +++++++++++++
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/relocation.c  |  7 ++++++
 fs/btrfs/zoned.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  3 +++
 5 files changed, 96 insertions(+)
---
base-commit: 2aabf192868a0f6d9ee3e35f9b0a8d97c77a46da
change-id: 20240514-zoned-gc-2ce793459eb7

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>



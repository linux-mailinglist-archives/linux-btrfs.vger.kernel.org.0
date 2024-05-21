Return-Path: <linux-btrfs+bounces-5162-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFEF8CB0D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41351C21F18
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C88F142E71;
	Tue, 21 May 2024 14:58:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF61E87C;
	Tue, 21 May 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303493; cv=none; b=Z55epLVsv9RFCY3z/Cii8/VlmcxTV17oG3tCK6sCmzaW+ncFLMIT0pqlTAm1l5NtNkCb8yBvhBOrF2cE3nDMG+PXKsp1SRdOE6+Qp4GXGyeZOSr9dwewskIifv3VIksIgtar2wCMSZ61xH7WSyD7fRpKGEhkR/kumqJxGPmMvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303493; c=relaxed/simple;
	bh=qY9qPo3NRmBbi/V8Gj0FAiIWKBBNAyjG++HDaNkSY/I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YGG/ffn8R68WwwyaBNXKoIEQDrkJCD3HcI4UNWg5S8wr81tYV0WIxd+KSw2SMlvG6zjXWCYkGZiltSdb+Tf5bCnUDwzLRQlZYZMl8c056b0IeZXs8yVONwv1erYIgWQ/u7I6vpq/XGP8aB0MOMXVTxxSNWNPVi6f9JpB/YWAVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so5984506a12.1;
        Tue, 21 May 2024 07:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303490; x=1716908290;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FXxkD2/lKUVaQGuLAgx7YvHLe5+oUAHOSstP23vnTE=;
        b=cYVab177OBFkqdoWVkXypjhrmwnuvcAZN69rKL6AjCi7jR1+JBcIfkQExVJsQPIm1c
         zRrzSaM1wEKmjz1M/SW7mFmvN1zdVNqlBXlvlPIIa6pIR8NVojAwebCyHSQwZRsWU3+k
         IeIZIYj5GhxN+8wVVY7ABT94IOPugKPLCJMmONp0iuv72sYAuaWPEKVBJjXc1JjD0kBd
         XeIeuIsWWiHw6LbymIL9WMSqvAW7/x1essgEzLFt7vSdJO+rL6lIAiBMnOX+pyTFxjje
         Q9oDCp2uuhIGz6aHVaJWkdSf26PkufZm794RF77rm+jYtFBYzM9iDJuVuTwKHMQIQFAw
         pSmA==
X-Forwarded-Encrypted: i=1; AJvYcCU3d9S4Wd9nrcn/1dZuTwkaXGIxjIRqhlLUeTsbmk68Yu9VjVjD6PTctFUu1MYfMPprualmcfCFs3KVX8Sf2RQClEyH31TIK3pfX2ixH+zwQ5WvZqbd/XMP+oDnAAt53dbGj1qFfd2Rry0=
X-Gm-Message-State: AOJu0YwgS+oRLUGtR5cm4BHw1BYBQYpFSRU3xeHbwFP3hhYcG/13XVhu
	XKHXVDzrAx4bvirZBHdNtz3mnbajDDAsJhag1CRdIvZyThrqiTlizF36fI1s
X-Google-Smtp-Source: AGHT+IEtyGFPtFYyY/s/Auqg8Nw6iVcaLWz0FzqpSJAUsEZ93QNpIlcZajRQf+Ro0YsF6bCOvlwh+Q==
X-Received: by 2002:a50:955c:0:b0:572:a16f:294 with SMTP id 4fb4d7f45d1cf-5734d67f7edmr22248777a12.30.1716303490296;
        Tue, 21 May 2024 07:58:10 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f709b700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f709:b700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f6b8b9d7sm8912502a12.82.2024.05.21.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:58:08 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v3 0/2] btrfs: zoned: always set aside a zone for
 relocation
Date: Tue, 21 May 2024 16:58:06 +0200
Message-Id: <20240521-zoned-gc-v3-0-7db9742454c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH62TGYC/22Myw6CMBBFf4XM2pq+oKkr/8O4gGGARtOa1jQq4
 d8trDBxeW7uOTMkio4SnKoZImWXXPAF1KECnFo/EnN9YZBcal4LzT7BU89GZBLJWKVrS52Bcn9
 EGtxrS12uhSeXniG+t3IW6/onkgXjTHA7iLZBo7U53yh6uh9DHGGtZLk3650piyk5GuysaRT2P
 +ayLF/NBAlp2wAAAA==
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

 fs/btrfs/disk-io.c    |  2 ++
 fs/btrfs/relocation.c |  7 ++++++
 fs/btrfs/zoned.c      | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h      |  3 +++
 4 files changed, 77 insertions(+)
---
base-commit: d52875a6df98dc77933853e8427bd77f4598a9a7
change-id: 20240514-zoned-gc-2ce793459eb7

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>



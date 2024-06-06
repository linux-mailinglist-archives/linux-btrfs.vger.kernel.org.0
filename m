Return-Path: <linux-btrfs+bounces-5492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652468FE108
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5418D1C24490
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 08:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF0313BACE;
	Thu,  6 Jun 2024 08:35:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6513BC2F;
	Thu,  6 Jun 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662914; cv=none; b=GT6aubz9aZZmZ6bcKEAMHZUocUCYO18HqTnyeO0a4lXprntGq8IjamjRaugOCqZxnBHp7AK3JoFXb8f0p/PD3edfMr7fBg6jivmFNpYjPJqQWU3ZklAj/FIAN97L6odwknwnToXUvqH11f0VsFcDNz2TclrEnrunCP+JJsB053g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662914; c=relaxed/simple;
	bh=TXm5Rn4o+rJZYlLBIt4sQtqoS81jWIqw10LqXHO60y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cnDYFfWWbcr1ZP3pZ4Gh2jba3IWPIzdB5D+spZWBxRL6kwJy1D0FRav5JdytJFGgP35EA4sR2chnaGEA2zx+OtNak8MQgHhJk2DpNWrJyyRHGM7whg65/oqQbt3YCviQlCWZm+LaX2XsAc2+OoRX+XCMMBCX47Ymg6uX8gmceHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a9a3bc085so839766a12.2;
        Thu, 06 Jun 2024 01:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662911; x=1718267711;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhkLa8Is35kxvEuKftKHPbnUS0r8TBOQ7OxAVXbphFY=;
        b=KCDj/HwuQaBCkJBkd+BoyUkIynsYflOsVNqB3jQe80KE/usqsP/2eSARlls/yBirkd
         nPdAMfmjl7BAznLgVSFouiMLKVufjMJh6FgsplL05h2+3Kb8zsqPdHxoF3Vygrazlma1
         iwz9Dg79omH57uMO4NHpuNakQezktGXKjP0zeaTBCRl+NMaeA4k69kAVIYMnRsJTSebU
         AmsZq6sBHnUOjIBQpJn7sECxykkLiEUI3zxyzWQNFpItf1BFC4+VY8DEjFvX8/cl4N92
         2lnMxd0/Ry7YHArkaVnw/rp0yRWwEiWtMXHwV9Ke/M/YU6Y7av3Bq7uiT9ZKXxwP5xUc
         ClaA==
X-Forwarded-Encrypted: i=1; AJvYcCVUXdI3n7EFGsrHNpINEYFpLHdX2yvU2X6g9oz1mFYvsPHP+tY097W+sZnKIX3MJD4pae51kvsqlEtNH8Cj9TenEArHFOCa6D1vLb+P
X-Gm-Message-State: AOJu0YwNO1vJ2s4nNuCF4WLFdzMy11a87DMgUkBw0BWsgB2BNi+18pY8
	38KoYzJaLi7JaUBEXVCqJOxtzBKzanMPfsxaodDfcvqqseG/IaLf
X-Google-Smtp-Source: AGHT+IHxAkaPJCjPMJEVscA3veuvLkeE0Fh3vnt4XDTwvZLN3abKwLH352E5X36LuNzs9hGAc939yg==
X-Received: by 2002:a50:a6d3:0:b0:57a:215a:5cba with SMTP id 4fb4d7f45d1cf-57a8b6f0dfcmr3688005a12.19.1717662911256;
        Thu, 06 Jun 2024 01:35:11 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e99asm701338a12.17.2024.06.06.01.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:35:10 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH v2 0/6] btrfs: small cleanups for relocation code
Date: Thu, 06 Jun 2024 10:34:58 +0200
Message-Id: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJ0YWYC/3XMQQ7CIBCF4as0sxYDFGl05T1MFwjTlkigGZRoG
 u4udu/yf8n7NshIHjNcug0Ii88+xRby0IFdTJyRedcaJJeKa35ihCFZZgOa+FozE9q5qXe9Vnc
 O7bQSTv69g7ex9eLzM9Fn94v4rX+pIhhnZ1RGWTUg18P1gRQxHBPNMNZav8KejtGtAAAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=jth@kernel.org;
 h=from:subject:message-id; bh=TXm5Rn4o+rJZYlLBIt4sQtqoS81jWIqw10LqXHO60y8=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlluyN/n67y1ya701SyMucnJg1RXE6BmnmzecztCbfy
 lltItHZUcrCIMbFICumyHI81Ha/hOkR9imHXpvBzGFlAhnCwMUpABOxymL4pxH+U8466MaCqcm3
 LXgexu3Z+zvm7R7ryILbU+seb/Sz/sLwT/WB8/Kpgo5TU/9qleZuP/Tda///NSytmnOi/1+IyOq
 +wAYA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

Here is a small series of cleanups I came across when debugging
relocation related problems on RAID stripe tree.

None of them imposes a functional change.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes in v2:
- Collected reviews
- Added two more cases I came across
- Link to v1: https://lore.kernel.org/r/20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org

---
Johannes Thumshirn (6):
      btrfs: pass reloc_control to relocate_data_extent
      btrfs: pass a reloc_control to relocate_file_extent_cluster
      btrfs: pass a reloc_control to relocate_one_folio
      btrfs: don't pass fs_info to describe_relocation
      btrfs: pass a struct reloc_control to prealloc_file_extent_cluster
      btrfs: pass reloc_control to setup_relocation_extent_mapping

 fs/btrfs/relocation.c | 66 ++++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 32 deletions(-)
---
base-commit: d18729a15cd2ca4b71ac14727c33b7da87359b70
change-id: 20240605-reloc-cleanups-16ddf3d364b0

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>



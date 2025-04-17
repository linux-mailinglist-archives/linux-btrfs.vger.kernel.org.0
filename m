Return-Path: <linux-btrfs+bounces-13129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6437A91B94
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6D97B0634
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322B24503E;
	Thu, 17 Apr 2025 12:06:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615824169B;
	Thu, 17 Apr 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891581; cv=none; b=qJLH0lk8lw/B0KZiciMN0zELv5+S//AKl+9uBAsl1Jn94TMpSAzILkwbcVC6WepaEOb6FpSIAsTYtwhmpQJ1x2FD6/9f7pPqlvgHfDQEmZ7EcF1VE4twFiVtMPB8/nOpA9X1rvburCAWQzyKnuvifqLXmiZbxowQ7EYdbaZrbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891581; c=relaxed/simple;
	bh=NoN3l1saU3neKY0XP3F8VajDpgXuAOJxtYmRZWDJ3Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gcp/HODQP3GbfcBHUqXkO55MwN+I/wmvFA0Zgza4ldtl59ov753MhlJ9yna9Kjc6tkidKDmd7cSyecY9qn6klKlzKD5SwGhXus5djN+JRfbg/UccY+spZXFJOOSR54vJHYjPapBCrHtRVvFPLjp/KSkW5AHDd9zFZtSVkhYfZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so1284320a12.1;
        Thu, 17 Apr 2025 05:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744891577; x=1745496377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBgxbremaMO37oGLN6JVZcbMmw+anTSlUb+Wmhg9Itk=;
        b=rZRBv/tS1P7avDVAR64yQl6TYadKy14IHWoLNORTbdC8XJ/E/QuyKqPriwC43AB4Tw
         CfoVSErEl5xUAyzUWWL/9adEmXahIT9/O2rRASN4i9MnbeEm+/ecWqcT2eKhTRmXmSVF
         K9w/O2uzZTWZPrIxT9AHDWLxcGEt7G44ELNzAabtSKUfUbquI496g10fkbNCJe5jc7pv
         HjVpWDH8rq/iEIk65//W23Op5b6KyYWKxL4h6U+/69FI8G7fmEt8j1V3K8aZ1oW7ueKf
         503ajzXCvQQPzkUkTkCIdjH2zKeXjpjrKocDEplniLMpxmha2s+4cWJg1qBpLAzlm3dd
         bkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6vcwvJIhti8tLcPTKXhGUvBoPJ4qUIwAiVN/DXhd4B7OKJoauugjibbjkv3V+jj7Yy44mUp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAN6fDIOMVxl0IMReMhq0nMqXiKplVNBFCvXK8BLK+IfGfkZF
	o8bq2avwmAv0D2TYMe8V+kRnSaT7msDVdnIkIyx0rrq3jQgZMtq0
X-Gm-Gg: ASbGncteWYmEBV2w48pK69lNgqi3h0snrMagOTtHKVc1MMjaYPJXMmJgGUI4AvGVxrS
	3tczlgUvjO5YJD1mDIwto941b8tS37HMw+RO6Px71Sxko1525STcWmXdf17qf+uNBe4A5pIqhWX
	3yZz4GM0zqUWmZwp5q4+SCh3Trl2228ndW7okZg68PkJmoI6mH+sLYXjrIKA5ywqi/GvA8mv/u9
	N8bXmqdcKqR83Y0RqfRSvSecm61zMs88si1CAEyFVMkeJIiNyFWyI5qp/3UHIoROZvS7fw4DGU6
	weqMB/Au/HJmnwegnB0is8yyXoXsnpjWv2qd24SbLOGFFBhvXq8ihrvNXuUJ+G8dmzbCgYBWuxB
	grWTfQuuHbso+YWLoww0+73Q=
X-Google-Smtp-Source: AGHT+IGxaoWUjxdOoShg4sfZhTM59k/jHqe/eyFQmshq/BBl/PLDKFpan26RZK7BF7rhoupcWEMJ8w==
X-Received: by 2002:a05:6402:1ed2:b0:5f3:fad4:fa75 with SMTP id 4fb4d7f45d1cf-5f4b76e9035mr4731938a12.32.1744891576946;
        Thu, 17 Apr 2025 05:06:16 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f710db00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f710:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f06bf0fsm10202345a12.46.2025.04.17.05.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:06:16 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v6.1 2/2] btrfs: zoned: fix zone finishing with missing devices
Date: Thu, 17 Apr 2025 14:05:59 +0200
Message-ID: <6e7ceb08075b17b16898adc2b1add98c5ca58473.1744891500.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744891500.git.jth@kernel.org>
References: <cover.1744891500.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit 35fec1089ebb5617f85884d3fa6a699ce6337a75 upstream

If do_zone_finish() is called with a filesystem that has missing devices
(e.g. a RAID file system mounted in degraded mode) it is accessing the
btrfs_device::zone_info pointer, which will not be set if the device
in question is missing.

Check if the device is present (by checking if it has a valid block device
pointer associated) and if not, skip zone finishing for it.

Fixes: 4dcbb8ab31c1 ("btrfs: zoned: make zone finishing multi stripe capable")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 46aadef5a463..1dff64e62047 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2055,6 +2055,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		struct btrfs_device *device = map->stripes[i].dev;
 		const u64 physical = map->stripes[i].physical;
 
+		if (!device->bdev)
+			continue;
+
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
-- 
2.43.0



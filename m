Return-Path: <linux-btrfs+bounces-7591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E51961A17
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 00:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A171C22A41
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 22:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3B1D415A;
	Tue, 27 Aug 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+KmZfYW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C281714BC
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798527; cv=none; b=EBHVguX7HtUt+wMwLhdAr9fJ2MTmKGplW05IXbTebqBri6hWnjgfsEG4WvU9PZVfmoSe9Bc14zcBPEBtlyaVKGKj0wk6nfA+k5siOTxSeEcyhIdHvViJ7X9l6jzoPSgMg0oHFio78Q1EpnVnT/h1Po+mfLhSnAxYHHxoXv1tlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798527; c=relaxed/simple;
	bh=ZhN5vt284t/UHxWaOuyaUyqNDE8ElEPIAfOBggDjXLc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jg9AZphC3Vkq/S4dIcugv/CTnsgnJIKCeMWJcV5dbMmRBQZSY5mf6Nk0yjBkJQEKGbyAKWfcu/yuzMd9oVSHfNHDQ8BmBLW++A2RhVaimgKQM59rIq8gY9KcuUFX9MVBDu/r9XgHTek7OtnO2s0w1FE2K45LIxEt5y3BTLda8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+KmZfYW; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-2701c010388so3572227fac.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724798525; x=1725403325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjqsjT1Xp8+sFZpoDnJqkoI6gpVu39vVwwA4wlozZIw=;
        b=X+KmZfYWqecOviJ4HUOOLY+5kxSC+HMI+jc0QKOG2drUlPZ0S4UR6k4JjLVgf/UPIe
         8x7TtbY8eDDJbAu+5gcvuAiF0uxh/fNG6RGcT4gr2t9Wt5qEHZikvtccZbTsOvSwsfv5
         FcO4ZoLInKJj24OawHjC0yamPktIVhDjy8juYWaKkTVO89+EULsiFbygkD+sWY/vgB8f
         3ZejZZxR5i/jDhn67zgddmBv4kNdM60AHnLTEzTG/qJaeVdtXDBZF+aoepPyk2/t0YCB
         U8T8l7Jn+1CMBveY1Id6HtVgfh/8eLvZLrYaDBEnypJ4i/MHTo6YtWKTiVmxkJrO/Yo+
         oWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798525; x=1725403325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjqsjT1Xp8+sFZpoDnJqkoI6gpVu39vVwwA4wlozZIw=;
        b=PYenXucUwlFa8JjDwK/1lM2OR/ubep05l+B1WVFQnJRvTJPcElL93ycW1Dgy8UFkxP
         67y1nOW1VFh3yd3fKno1xxKud9oyQzvsrPQweECgrr2/lEx2xLtrIcrOMNyWruypeEf8
         OiRViiH2EJQrSb4GBTBcuRJ1CuD8vtwTCzE/5kLbWbw3PRraoW874wdRo//nAG0KVwJ1
         3oxPH/5MTEKV0qsc2oB0i2KJ8CzvHvQcmd5zVCCVMFlWomjxIrGBfdLCc3rPrUZ7Gk9r
         b6/7dVhkxGge2ppPw8X6J7FwZKqGcn0f5XKeACszUWA8JqXmgP2/bSmaRAF502oZc9j3
         gsOg==
X-Gm-Message-State: AOJu0YxXZ7I7NjGc0v/1HPkEFgYAUswFiF6eDzhneoXmBiWxhmSShGb2
	z0M6LUWZDzwzztsOvyVZgqYHmuSFW/InsY+FLHOaha+K2y19KIbWW2CxOmQx
X-Google-Smtp-Source: AGHT+IFiKPtEE/I0y9pIXZBumsnLOmh2BLq+Dxq+cajQ8koFLNwDyfe8w4bFUXd1qKf37i6T65UiAQ==
X-Received: by 2002:a05:6871:1c9:b0:261:52d:1aef with SMTP id 586e51a60fabf-2777d363652mr21246fac.49.1724798524734;
        Tue, 27 Aug 2024 15:42:04 -0700 (PDT)
Received: from localhost (fwdproxy-eag-004.fbsv.net. [2a03:2880:3ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03b60235sm2580656a34.61.2024.08.27.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 15:42:04 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 0/3] btrfs path auto free
Date: Tue, 27 Aug 2024 15:41:30 -0700
Message-ID: <cover.1724792563.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DEFINE_FREE macro defines a wrapper function for a given memory
cleanup function which takes a pointer as an argument and calls the
cleanup function with the value of the pointer. The __free macro adds
a scoped-based cleanup to a variable, using the __cleanup attribute
to specify the cleanup function that should be called when the variable
goes out of scope.

Using this cleanup code pattern ensures that memory is properly freed
when it's no longer needed, preventing memory leaks and reducing the
risk of crashes or other issues caused by incorrect memory management.
Even if the code is already memory safe, using this pattern reduces
the risk of introducing memory-related bugs in the future

In this series of patches I've added a DEFINE_FREE for btrfs_free_path
and created a macro BTRFS_PATH_AUTO_FREE to clearly identify path
declarations that will be automatically freed.

I've included some simple examples of where this pattern can be used.
The trivial examples are ones where there is one exit path and the only
cleanup performed is a call to btrfs_free_path.

There appear to be around 130 instances that would be a pretty simple to
convert to this pattern. Is it worth going back and updating
all trivial instances or would it be better to leave them and use the pattern
in new code? Another option is to have all path declarations declared
with BTRFS_PATH_AUTO_FREE and not remove any btrfs_free_path instances.
In theory this would not change the functionality as it is fine to call
btrfs_free_path on an already freed path.

Leo Martins (3):
  btrfs: DEFINE_FREE for btrfs_free_path
  btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
  btrfs: BTRFS_PATH_AUTO_FREE in orphan.c

 fs/btrfs/ctree.c  |  2 +-
 fs/btrfs/ctree.h  |  4 ++++
 fs/btrfs/orphan.c | 19 ++++++-------------
 fs/btrfs/zoned.c  | 34 +++++++++++-----------------------
 4 files changed, 22 insertions(+), 37 deletions(-)

-- 
2.43.5



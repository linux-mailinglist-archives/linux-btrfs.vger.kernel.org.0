Return-Path: <linux-btrfs+bounces-7796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E497896A660
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 20:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0813F1C24176
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914421917D8;
	Tue,  3 Sep 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL2ZeW9y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C57E19049A
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387641; cv=none; b=cfEcsQ/KYF6QL4ZgzEalJoy0/CW4BWclgHv/EI31kGe/2d6KoCcyrI+Gs8yPMMgv3i2I99u8zlHcsXFRU6ZiF2/leT4zyHsKAbpz7+lSHOZtKBr/WnkIdEWEdbyUtoTPBI4ex3TOP0f4aMyqkjMSyAPoreNl9aCeO1QPLLDTXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387641; c=relaxed/simple;
	bh=pbkQqvfJHriYTCR8HPx7MnIluAaEcfvm6D93bGD59a0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y40EJ0PKlLKu+zx+yQAFG8NDG3tjoIk8rpPKjfJR1DSAyB/8CTUewgqZ7qbuoUm7Yk1mRXsngfzGINBMIX7Dzg5jqyjoBGo99SexAqMd6VTyLurWqngMY6ug5WR+U2lfOeRLxZTYYhsQXo4PdHPOsKF41ac6ZDrQN74VR8HQ6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL2ZeW9y; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-5dca990cf58so3567553eaf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725387639; x=1725992439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wzcT7eBJWjH7Qtu3/HbNNuKnoF3qjwUePgWHwH99iM=;
        b=UL2ZeW9ysvkpAaGM7GT7+jkcbWgRjqJpbCCmZVtxYrlyfIQhlyUiFbiGkw8uS7Lpqf
         PRjcx2qLthparA3T9s3Kx9o/6YYIBPsn3LICLwdy8Jnmz8lSuqXUtjFqtucUp3/a8ARw
         upENSoBKgOTmiZ8n6+A//NIzGffRcyCdXn8/wcI1FjE884y5MRw+Yey/0TtRRC0Lcz/x
         FXTBNH72v2WoB8ucYwH700lRqdYMh9d5+MIh8xDkvFKg/YQpG6FKvyV3Ivs6mw3J7ntI
         VuPmR/7WAVL1JSSvmCRReXRIbzmdbcz5CC3cKSahxZeabFufgAw4gX+JuScisSqdpJ72
         7wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725387639; x=1725992439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wzcT7eBJWjH7Qtu3/HbNNuKnoF3qjwUePgWHwH99iM=;
        b=PxYtYjRjqO1oI5kX/8fU/5dp0VNWHZENmivpGrJUqzvT9A5LGrblWwK+P8n1D2Mcsy
         pAS3s1mfgd8uDdFDwdzLxxkNkUsU0AuO5n1tp78TDduZO6hIm+KNkpZz90h+k3+ihzug
         Y/NwJBASLKl9GcxHA9KxpR7yqoeilHucWNA5msF6edfJSkBvutf1wVH5ySMPWeabnSiL
         DPHLPkoeSzBdFTlm7iwEspFvG8BBYwfHFFEYFcLEN+MQunrbuSERE5j8gBfXHKFRLszB
         wwT5g3cFzx9rOwUt2GR7TmQ6iEELxCPVMbwEdN352PMxuYyQjg4/AbOQimKAT4hU1V1h
         MPjw==
X-Gm-Message-State: AOJu0Yw2Dcy1RPQJb2wprepiTGH7IeO9L0mL1KTzq0/7ACC2mXwEj6iI
	ybY1rnOn4emt2mdwrUBy3ESeAJdwUEG2G1bUAD5p74t374f4NR6v8XIMnYyw
X-Google-Smtp-Source: AGHT+IHVvOYgGuqkOfxEzIojWGD76wOToBaboAHBpyhHx0i1mf6T/8wtqMLC32lHO5l1FwsO4PC0Rg==
X-Received: by 2002:a05:6820:1609:b0:5c6:9320:53a3 with SMTP id 006d021491bc7-5dfacef8a5bmr15331315eaf.4.1725387638925;
        Tue, 03 Sep 2024 11:20:38 -0700 (PDT)
Received: from localhost (fwdproxy-eag-005.fbsv.net. [2a03:2880:3ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dfa047b658sm2116106eaf.3.2024.09.03.11.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 11:20:38 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 0/3] btrfs path auto free
Date: Tue,  3 Sep 2024 11:19:04 -0700
Message-ID: <cover.1725386993.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CHANGELOG:
Patch 1/3
	- Move BTRFS_PATH_AUTO_FREE macro definition next to btrfs_path
	  struct.

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

Leo Martins (3):
  btrfs: DEFINE_FREE for btrfs_free_path
  btrfs: BTRFS_PATH_AUTO_FREE in zoned.c
  btrfs: BTRFS_PATH_AUTO_FREE in orphan.c

 fs/btrfs/ctree.c  |  2 +-
 fs/btrfs/ctree.h  |  5 +++++
 fs/btrfs/orphan.c | 19 ++++++-------------
 fs/btrfs/zoned.c  | 34 +++++++++++-----------------------
 4 files changed, 23 insertions(+), 37 deletions(-)

-- 
2.43.5



Return-Path: <linux-btrfs+bounces-16175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE861B2D5EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 10:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4A0A03A7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ED92D8DDD;
	Wed, 20 Aug 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6OIQQg6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BF2D6E56;
	Wed, 20 Aug 2025 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677744; cv=none; b=ACMI/Mm060uKLL5K3tiMZNqpoIcdJMaoqUFpN/sCn22jlfUGdq5VkWXxv7uM6IcWcuYklD26ANfoEDSse9h07wnDBgDqg6qy497U+Y1JIbp60KlvegqOgM29PUHBUhNrtZZ0CJpedXwVjQhS0HJ8RdKKT9K8hs8NFAZYxPvl6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677744; c=relaxed/simple;
	bh=zzWKCuN+OBu+bj8Q0yrsgQuI3w5w+z+EK7Di01kMqcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MycHmpvNcVpmoOilQdzQPj/ergrSD1GMfC7dLdAeMjLPSHuyrYmaMyge+vTGVv+3N52sI8zDiAKCPQN1c8Af1U8GWCEayHy4t6IZ4Nz3SXFV9Ti+Nnx4cgwRehS89Yfx6WzZ+UT/1h5AkGlUlRyyUJSZsYG0VAyylwX76LwV7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6OIQQg6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445826fd9dso73553885ad.3;
        Wed, 20 Aug 2025 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677741; x=1756282541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iucZr7+YrtFtBdKItVuvJENQM1HVBlFQMUEfkXfIbU8=;
        b=K6OIQQg6YjMNP9oovyqk+SYmx6Vcrisl6rRYi8hW40UqlctdMM6fjnP3MNzVtNZM/K
         v4RSBmeR1wOtdHiYUrune3PG+6cPMiTNVvEwVjQ1XiJhiwsjjjY87pCNUw+hGuoKqQBJ
         4Na2+PWWpVUDRFApLkREDfovQXsm9uDIjjchUFXHTNKCfdTqUNqJy2bC1wILzKxYkp/u
         l6sKx+3OqbwTYa/WbTF6FTys5UWvgYvqU521wnCOu0g+E4n7bUSfl17o7YJYwlic5IIn
         6rUm+cJopqwCeJMxqkf74XKfBrAFhHRhPrDUcLUTjdyk0OgAt5WWojRA6kpcWB0bswX7
         y3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677741; x=1756282541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iucZr7+YrtFtBdKItVuvJENQM1HVBlFQMUEfkXfIbU8=;
        b=LgMeeqjK8KRTIsFTPHxOtsWmO39y5JNNLNXqD9dxqXwg+wT9K7hzvhwgTw7dlGwI6m
         T0DKrZGsZbXTJY4QJJXsQOigrzmCCuF90RafyUTWKcC4mMWtWxeJejEtBppQxyYy15KW
         mr7BGF/+zvKrWrryuSMfc7wffHwCRjJHZB9QHnNeYom9zck3LaETGkhJ7WUFauU6jNmM
         JTjMuf0IYbaTEgh3TVTnfaW2j1N5MizfARSV5Jn1qlmLlXA/pmVsCJr1F7YqdzTtNYCq
         BlIYWYia34EtGpWoZ5RvPOy+Rn3s9L4qSQgnkmloQtx5tMJorj3B0aNFjdn+b3/BfdrP
         DcgQ==
X-Gm-Message-State: AOJu0YynWZjAsL+JVI3pqLcsJsKetG5zxgAr1/EO28uwtHBdw0Qamxp9
	IjAMU70YZqFKNQHabxuf05OmMI9kXIpLpiyGaGoN5t4NsDkEUuEfFuIPVCy0MA==
X-Gm-Gg: ASbGncvcX2jYg0j5T4QD4n7qaULWLmCOO5tu0nFlA7osPPHfVXrRnfe8y3aWF6P0C5T
	ls/PiC0iTjbVm4jFah3W4v/D1gk7soJKfLyN8LOyNYV9sxnaLJ5gltpWweIoQ8vkYiQnbxZ0qyG
	lz+YLB18g9y/lYFxEeKvziXWza0P20ONML2WaLcCgzCOHClR+uMsZG5r9MXPQtWyrV9NWfnCGsM
	lOpxVdjTxeB4AglkdRrvpzvdLXSL2dYhAycqTVOJaB1kyJBnW5WUD5KH8EyCRJyaslHD6H8NPYx
	PCtp0by8GDWdVkw6TZ6E2bmsvlBHdWctuEuMeGEdQhCOJXGScsXjitZBqsHx+zLJFl/dUrgGuKm
	dZXUurYWcTTjpXmNeW5qLVjWkfA==
X-Google-Smtp-Source: AGHT+IFQj78FlSW/HEoU/THsGHLdpOYvdhjdkY07koy5mnvDPP3ij/uQCcH+oAe6bDrrAvPxGPsUWA==
X-Received: by 2002:a17:902:f64d:b0:23f:8d56:b75b with SMTP id d9443c01a7336-245ef25bb5bmr23966385ad.41.1755677741464;
        Wed, 20 Aug 2025 01:15:41 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517beesm18848935ad.134.2025.08.20.01.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:15:41 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com,
	quwenruo.btrfs@gmx.com
Subject: [PATCH v3 4/4] generic/563: Increase the iosize to to cover for btrfs
Date: Wed, 20 Aug 2025 08:15:07 +0000
Message-Id: <7e337d30307b293b30c6ad00c1fc222bbeed640c.1755677274.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tested with block size/node size 64K on btrfs, then the test fails
with the folllowing error:
     QA output created by 563
     read/write
     read is in range
    -write is in range
    +write has value of 8855552
    +write is NOT in range 7969177.6 .. 8808038.4
     write -> read/write
    ...
The slight increase in the amount of bytes that are written is because
of the increase in the the nodesize(metadata) and hence it exceeds
the tolerance limit slightly. Fix this by increasing the iosize.
Increasing the iosize increases the tolerance range and covers the
tolerance for btrfs higher node sizes.
A very detailed explanation is given by Qu Wenruo in [1]

[1] https://lore.kernel.org/all/fa0dc9e3-2025-49f2-9f20-71190382fce5@gmx.com/

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/563 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/563 b/tests/generic/563
index 89a71aa4..6cb9ddb0 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -43,7 +43,7 @@ _require_block_device $SCRATCH_DEV
 _require_non_zoned_device ${SCRATCH_DEV}
 
 cgdir=$CGROUP2_PATH
-iosize=$((1024 * 1024 * 8))
+iosize=$((1024 * 1024 * 16))
 
 # Check cgroup read/write charges against expected values. Allow for some
 # tolerance as different filesystems seem to account slightly differently.
-- 
2.34.1



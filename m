Return-Path: <linux-btrfs+bounces-16324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B7AB33625
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8132A3A7698
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477B27D770;
	Mon, 25 Aug 2025 06:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDr+95lO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842427AC3E;
	Mon, 25 Aug 2025 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101884; cv=none; b=YkcHkTMQe11GzWtVef7xFNZ4xyi0bv3HctXA5z7+1ecV4B4ibTXosGrqTKoG7h92Ik1WjQOQJg4F2P4Og0dGovuVv6Yi32fQr9/aqEY7GYi/FTOWtOuoyo1ytfWz9oVLimc/wcYei+lxEISOtNckHWCiv0j2ABJNp2FnG7ZzFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101884; c=relaxed/simple;
	bh=zcdAaKA4HzKUZOnAFjBpCdo6j+n7ymAnQhnvK/x98/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sZwtczcmtRAwoHwQOpRIiR3JHDYD7p18CDflG3KYv3xQDQEr1yCNBoFiI9IK9YdUSxM/Tf4xhM5gHGgNB6HO/b5tbelc6JZOfeJCWuD6MGrD052njDldpdAqLK50pBOOiR1ZD3pl1AJ0yLhTDah60UQLaiLnWETeY+IAtsexPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDr+95lO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e434a0118so4682103b3a.0;
        Sun, 24 Aug 2025 23:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756101881; x=1756706681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plu47KxRwmDgRoHKWFfGBl+qKoo6LlrXSTkEUz+1gHQ=;
        b=PDr+95lO0pEdyG6CEXoEelC00nNjFWO/Mt5na327O7ZizoGgnBy8BmeCc/2chv9s8X
         b4CNzhsaN8uS177F2g2JACAzR1pzoDO9p5bw/5C6gsImTd7ZZg7DvpkozP0G5HS+cefS
         OCCZCnQfzul1boXj02lV8DhI+EiUTYQwpypUpGOAAZsrkdwh6UdawH50z0y4Cp+Ob6ae
         AFOAjGk1ajDfn7taHNxwHGxvx2BnPUktPwTmprhk+RM7nJyCrtDov7X1KuSL8+lL/lwx
         2tgHS9TD2Odz4zmRDNhF7p+bIbfvdNNNA+dn/KzujXOOhqnYYVIuDZmI4r/wAsByYH5c
         9DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756101881; x=1756706681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plu47KxRwmDgRoHKWFfGBl+qKoo6LlrXSTkEUz+1gHQ=;
        b=f2ARNm0pqvxdQzEXsetzn8xUbqWrMj3B5s4WfL3D/c5p6zWf7qIuoxyxdvMaPdpwCl
         JxaOCYSk+9cNP2EUM4YfDxgRlRLY0XggxpcOn/FlMlRwOKznKV8X/kB+xG7ZpaK4HnNp
         3Brwox7jftMCD6QeOb6y5u73D3PogHkM2nsD9ePLJ4bZFXlKV51snkLnPrPB2WB89GVH
         PP2jAz3hk74a/sOJQUWZYEIZisZ+kcGSGYblPmXp/O/IQdh2Azs+5/sqC60/txf7Lny/
         zbVRgfdyT/92GKOQhrqY6YmJl6B0fiRlGP511QaH9tFVkQk4ctedWqGzoXqnMyP6R3cL
         JlsA==
X-Gm-Message-State: AOJu0YzihtwnsiN3nvjxXq6G0qS4a6+0sLtVin0ytWv47GcrDqqxWFwa
	lrBrBDt4MyZ6n3gT6baHEOuhiebyYd4Az17roIuhp1G9M+hYuDK8Ii4uC49lAA==
X-Gm-Gg: ASbGncsPbMINtlK+1jkecnJSff+QRJJ6PiigXCse+7a7caHZSWlqyYwV5pix/qsfwSn
	t8sx5UHBszaXZ+pJjML9OJv+ESfP3hpU1d2/wKu2w2L3VQeYMnbPaHu+DwARK4XogHVCKLZ1ccJ
	QKFBIVMnwSJUPJvnYzgEvIDYa/1Wk3rSlzwMWLIQ3noC7h/79LxLQJTfRWCbVTFkg5+6z2lw4P2
	LhybkuE9rjHEyUUwDk55ohVuhnUPOFu+yx1+r81PZneF7vFwNE2bLUAgNiOmMCgtq9DoAEGyVLp
	9WQc6VldMkmEWohPkVqZAIeJ3SsLRKgkIJ2f5cDnUcuQnCQTPejLp3ILMObBnsqri5MckKmWg1W
	zp4miqGyrhcM0IytJANqG+/mh5g==
X-Google-Smtp-Source: AGHT+IHZmgFoEfkSoTxusXF8NxBS74udCeT4Sn/A8NfI/s2MdAkFalfT0PQvR1VtHnwy4dwESiaYwA==
X-Received: by 2002:a17:902:f70a:b0:246:d703:cf7f with SMTP id d9443c01a7336-246d703e121mr33748435ad.5.1756101880727;
        Sun, 24 Aug 2025 23:04:40 -0700 (PDT)
Received: from citest-1.. ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a59b1sm58202485ad.42.2025.08.24.23.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:04:40 -0700 (PDT)
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
Subject: [PATCH v4 4/4] generic/563: Increase the iosize to cover for btrfs higher node sizes
Date: Mon, 25 Aug 2025 06:04:11 +0000
Message-Id: <befd84b21531f589a432bd6b9600113936551b63.1756101620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756101620.git.nirjhar.roy.lists@gmail.com>
References: <cover.1756101620.git.nirjhar.roy.lists@gmail.com>
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
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
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



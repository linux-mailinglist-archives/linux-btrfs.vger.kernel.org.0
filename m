Return-Path: <linux-btrfs+bounces-16320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D274B33620
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF47481251
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888B27700A;
	Mon, 25 Aug 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPzz40n+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C2267B90;
	Mon, 25 Aug 2025 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101870; cv=none; b=suo73WfT73bb2Zpv7yoZvYKNFy3YmXDtnfnP5T/5eWGMphqK38w923zkyuKKAHJcvWfAAU4skYF7zdS6Z73soaUOO34jMDe3sR/N700hHriLeNw1Zhb/4PVKhnoKl3cAEdDCB2OyzeiWhlFxRpH25cKqUVDHVLFV2P9bqNaQPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101870; c=relaxed/simple;
	bh=U8/HDeNu4CVKXNu5itDbQWmBAiBoqeeu8kKxwUL1uHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9i0u5HQJLrk1VGe4mq1OqjgN0n+qr/BjZbsAss/1iXGCGfJKhmiem/ZGn71SZhBLdaLFH99lmQuC3PmZVq22VYbnKfZK2ltXjuuulMXi9PcRrza1RqIMJHd7b1V1/QAH/cIrarAZQkO5RTYOoKbRnSp1mBifqq0J+LA2QjeLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPzz40n+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49cf21320aso1637351a12.1;
        Sun, 24 Aug 2025 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756101868; x=1756706668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+91YQUK8oOlYf/6IkwX9cdo/fKGiFLG2xH50vJ+/GA=;
        b=KPzz40n+X9R3PM7iZrUjhlYhm5sV6jWCYNkvyCx0c36hL4u4iSyugbY2zs88LjRqtN
         iZTl+GowJXk2bTMaZ9vmwzgVM52Tcb2Bt7Rv8SrMyV5e0xvXOOlXEN7NMnIORAzv3W2I
         b4BVgYIQqX8FQy+5OWu7haRcUMA1Ock+LlM5LbFSWsotweCxaV9VrnqCEQ/BKFq8CVv8
         sbw1EaDKYpag/J1eHvVHR6ZYFlul2HwQ8+TNuJVA4gzU5vtvR8IauSine0QFAntonC1o
         rKa9H1tzj3TCvT1cpuZ5426bw6HhwgO5Wu5DQRK7jPHdH8rRK3gTzY7xkG3aIp0vgqP+
         yd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756101868; x=1756706668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+91YQUK8oOlYf/6IkwX9cdo/fKGiFLG2xH50vJ+/GA=;
        b=cdsIvM6OH4jVtxTbx7cB2ZtzrzwFFtOwXxs05FoT+FNCIy3HwuOBUrdAhpOCI3tsIf
         mS1PJ99HEGbkkYVDcvMljyj+/MyCxHsVOvLWzRpYBpp85NmZzMZ+CX297Wl8F5PYSYSf
         ApDj3I/C/YP3E5TNcogVntq6hZzkr26D8hpw5yIlaOObrFKxWT5kFF10c/OGOyKCaqUJ
         9bL7bn1iekClH859pvO6pu9CcK/s0EYZgnJnLFMNDy6scPtrlUmwGSTf2SZ4auQMgNp6
         nY9I+oRu5MRc2AQyjucPI7IHf+xGXxpTUca1yoLLAaDw3xiyIJpwwTu6ULNJen6k1Chn
         l5Sg==
X-Gm-Message-State: AOJu0YxgAtbxen2FFnuC37XVV/5kPkGMkLUl67/ixSO261mtUZwZiUpY
	VOW/qjBFmoPPfmXQPzxuHxIu3ab9VSxmNUnyk+jj7HdPFuw+7uBF6rtY6+lxuA==
X-Gm-Gg: ASbGnctCnt7x3/7Uv638hCcqWMkJXC0kpYW0iFhFiHrk1/w9pA57J6X3ta0LoIS2JIb
	Gi5LzN9r5VpVQe0jP8/uFTNCR3uTP+g7yS5i4jk2hNY0AilTdEazZYAHzbkqd9e8FFgUOHtB2Qz
	368GAIZOp/bNjHceAAiWSIXsxHmXq2gXLnBoNHk6nN0aPv5FEXc0Svmr6QjHYOUsUxZdFK9L7KE
	I6e6y1jZmH3u9eLvBJD/lIdOeLVVqlDOUWX6o1Y56pmLT9goxoOJtMSBKnc1OwFq5wUKWUSFxg3
	Rt6y30nIFrbvjC4QjsuQ4qZQwa82M7Q+TdMEASfNghCYFnWmGL/TcgmbbdjZHfcZitrAJ/QwcH/
	aI+TvGO0VFC5MVCRpqksB3Qqmob+GqVCt3YOf
X-Google-Smtp-Source: AGHT+IG7e8uDCHz400ldjiLiy7s8AytvnzWFwB5o22SXFhnwASXHeXRQEtBblPYf8ypXS+YJKG9O8g==
X-Received: by 2002:a17:902:e945:b0:246:b157:5e01 with SMTP id d9443c01a7336-246b157697dmr42905795ad.61.1756101867573;
        Sun, 24 Aug 2025 23:04:27 -0700 (PDT)
Received: from citest-1.. ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a59b1sm58202485ad.42.2025.08.24.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:04:27 -0700 (PDT)
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
Subject: [PATCH v4 0/4] btrfs: Misc test fixes for large block/node sizes
Date: Mon, 25 Aug 2025 06:04:07 +0000
Message-Id: <cover.1756101620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the btrfs and generic tests are written with 4k block/node size in mind.
This patch fixes some of those tests to be compatible with other block/node sizes too.
We caught these bugs while running the auto group tests on btrfs with large
block/node sizes.

[v2] -> v3
1. Fixed commit message typo for generic/563
2. Added RB of Qu for generic/274
3. Added RB of Ojaswin for all the patches.

[v2] -> v3
1. Added RBs by Qu Wenruo in btrfs/{301, 137}
2. Updated the commit message of generic/563 with a more detailed explanation
   by Qu Wenrou.
3. Reverted by block size from 64k to 4k while filling the filesystem with dd
   for test generic/274.

[v1] -> [v2]:
1. Removed the patch for btrfs/200 of [v1] - need more analysis on this.
2. Removed the first 2 patches of [v1] which introduced 2 new helper functions
3. btrfs/{137,301} and generic/274 - Instead of scaling the test dynamically
   based on the underlying disk block size, I have hardcoded the pwrite blocksizes
   and offsets to 64k which is aligned to all underlying fs block sizes <= 64.
4. For generic/563 - Doubled the iosize instead of btrfs specific hack to cover
   for btrfs write ranges.
5. Updated the commit messages

[v1] - https://lore.kernel.org/all/cover.1753769382.git.nirjhar.roy.lists@gmail.com/
[v2] - https://lore.kernel.org/all/cover.1755604735.git.nirjhar.roy.lists@gmail.com/
[v3] - https://lore.kernel.org/all/cover.1755677274.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (4):
  btrfs/301: Make the test compatible with all the supported block sizes
  generic/274: Make the pwrite block sizes and offsets to 64k
  btrfs/137: Make this test compatible with all supported block sizes
  generic/563: Increase the iosize to cover for btrfs higher node sizes

 tests/btrfs/137     | 11 ++++----
 tests/btrfs/137.out | 66 ++++++++++++++++++++++-----------------------
 tests/btrfs/301     |  2 +-
 tests/generic/274   |  8 +++---
 tests/generic/563   |  2 +-
 5 files changed, 45 insertions(+), 44 deletions(-)

--
2.34.1



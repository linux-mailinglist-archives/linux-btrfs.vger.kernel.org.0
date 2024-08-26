Return-Path: <linux-btrfs+bounces-7509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202095F6BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 18:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE101F22AAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E70197548;
	Mon, 26 Aug 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IIWk++p9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0F143C7D
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690255; cv=none; b=HdA0AUmZFDtR9bJVAYM/yKSKxjEMsJjh6IqvBu8ZhVT4yG35OS1XrsUtUN5QvafJdxgwIUTKVAYxAOSTEjkcC3oPgbkFpVIS6ycbaorZLoQovUNRXDdTtqQcAsZPidkZ/C3yT2ACO1MvVAgKl95RVZnLoa9QW8aNpFTUUAP/ieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690255; c=relaxed/simple;
	bh=9FjipFGtyfWNFl//F7TDhqdgQpCTgzW1fhlgwCTvZvI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lg6tY03zxJEBKaFFPl+YxRTe+MZU34sTLlTRIQWwx9jdG4JjhxeJfu0taZTtI3+0pwkQdntiTvjOEUNoxhHybVtJ1c6IBwygxAeowxe6Ng43u8r6Hr1cM9R41puEoge9gDMDy8HzywnPLvn9DBItax5vcP6Ov12GD6Kmn8j6S9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IIWk++p9; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1df0a93eeso274433985a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724690252; x=1725295052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vC4ag3QkwAdXIxfEr/1lN6pLeS+NBL45/EBBHGVfnaI=;
        b=IIWk++p96DBJYRllYdmkhG2HL7HyItqAnJFrVAIZDyORKxIi1WvzCOrq7OmdPAWY4a
         Jt0Vl8iIx7iEN3Smp1t6VAzdCLTMyUr6t5j7pQis26onDv14J5Kciv/KFVYfZlDwdfFs
         vtvDL3lLAWXdsKF/hILp2AjMz3zq3VE2QqNetskuA4FyicGadPIJCqCDQmVQ8E6alESZ
         rfZ70vThGVX9BgV+8mp8UdhuhpUZu1OLDB8foQGVHfVB7ChNg8CRycqZq616rkL7lybg
         WIbj3ZNfn4hmAtfIjnqJhWNDWRqEBwQ70SII50TeZwDivfSwi9qQIur8T1fDGakVW+6s
         6GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690252; x=1725295052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vC4ag3QkwAdXIxfEr/1lN6pLeS+NBL45/EBBHGVfnaI=;
        b=VUEl+Z++KyzrdAB1keGWk1GCRU3ysfrg058LhD4TIKiU43SpzE8qye7RfGIeV1FZU7
         APY/rW2W3VJdOzKK8TaE575M30MVEhGvSQC9SbWFG0TvHZiWqRk58lhzarQOVXQFcOod
         sh8G/1T+PuSAhroktYZVCIhr5XxOvma6hHKfObWu0ejbG8k7NB1Tw+azZmmjx7RtMlhw
         yUbKUr8wGCC2imTnn26p+nmXX+lz90zP09RHOGERWCXE7t03bZ1W7onrDnPL+UoMKvPA
         gnX0dTj7quVJdVhISjy5mA5KMbc3qJD+A7W7RloP21VCNd8hUavFnKrcDcYJut6FSJsx
         N/nQ==
X-Gm-Message-State: AOJu0YxVUVOzG1LONniaYT1O+8rCYp/Lm1NtBsZI+mGYZJ6fag1+9GvB
	znx8MlFjc62gNkeGFUp2MbC1novhcNKPy15Q+0g+Z/aDIYnD/QEl0AVnHixmg9SctyM6fTLk46v
	k
X-Google-Smtp-Source: AGHT+IEKjzEW7mwwpGZNgq5ChqLSlrqftrhj+omh2Q/OGcWunG669/MWk3Hn9muQzZ2pLCRID5DZpg==
X-Received: by 2002:a05:620a:2908:b0:7a6:4a55:a626 with SMTP id af79cd13be357-7a7e4e4b88emr19060285a.51.1724690251737;
        Mon, 26 Aug 2024 09:37:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb2ebsm467993685a.79.2024.08.26.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:37:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/3] btrfs: no longer hold the extent lock for the entire read
Date: Mon, 26 Aug 2024 12:37:23 -0400
Message-ID: <cover.1724690141.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-btrfs/cover.1724255475.git.josef@toxicpanda.com/

v1->v2:
- Added Goldwyn's bit to move the extent lock to only cover the part where we
  look up the extent map, added his Co-developed-by to the patch.

-- Original email --
Hello,

One of the biggest obstacles to switching to iomap is that our extent locking is
a bit wonky.  We've made a lot of progress on the write side to drastically
narrow the scope of the extent lock, but the read side is arguably the most
problematic in that we hold it until the readpage is completed.

This patch series addresses this by no longer holding the lock for the entire
IO.  This is safe on the buffered side because we are protected by the page lock
and the checks for ordered extents when we start the write.

The direct io side is the more problematic side, since we could now end up with
overlapping and concurrent direct writes in direct read ranges.  To solve this
problem I'm introducing a new extent io bit to do range locking for direct IO.
This will work basically the same as the extent lock did before, but only for
direct IO.  We are saved by the normal inode lock and page cache in the mixed
buffered and direct case, so this shouldn't carry the same iomap+locking
reloated woes that the extent lock did.

This will also allow us to remove the page fault restrictions in the direct IO
case, which will be done in a followup series.

I've run this through the CI and a lot of local testing, I'm keeping it small
and targeted because this is a pretty big logical shift for us, so I want to
make sure we get good testing on it before I go doing the other larger projects.
Thanks,

Josef

Josef Bacik (3):
  btrfs: introduce EXTENT_DIO_LOCKED
  btrfs: take the dio extent lock during O_DIRECT operations
  btrfs: do not hold the extent lock for entire read

 fs/btrfs/compression.c    |  2 +-
 fs/btrfs/direct-io.c      | 72 +++++++++++++++++++-----------
 fs/btrfs/extent-io-tree.c | 52 ++++++++++------------
 fs/btrfs/extent-io-tree.h | 38 ++++++++++++++--
 fs/btrfs/extent_io.c      | 94 ++-------------------------------------
 5 files changed, 109 insertions(+), 149 deletions(-)

-- 
2.43.0



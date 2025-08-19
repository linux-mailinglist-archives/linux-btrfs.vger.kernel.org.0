Return-Path: <linux-btrfs+bounces-16155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B9B2C295
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 14:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D41F683992
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856832BF29;
	Tue, 19 Aug 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLf5DlDD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E1265632;
	Tue, 19 Aug 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604908; cv=none; b=inaJ4Cb4l+V0/YueaykrU+Uu8YnQLABBBRLXtc7PHs12Uwf6paGMiwXVTZVAKrKIkA6MIaR0EmPDTt4yMgsgaoX8M3vZMQSi+L9+m2zjOwFrxXO6tURCxz3PC7DQVsvIjQ2me7hV9iQnEtSaQoSfahdJhKRI+enJZDR+jEThMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604908; c=relaxed/simple;
	bh=JZ+6nrayxFkx6XLmKTDPgxDxysxpugI8I+Iiy2fSm8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kshQxk3R73+Q0AKsmmOmEOiCPesKQGgjWFO/rURBNwtP2p4myhpQbsDfaPhQArI3AwRm8bLB3YTCX05JPI97kUxnX4Zfs5CKqGMDoISvGX1HBMEPSEaw39Wm/+ifMJA4jXPMqOFg//0LCXAgEX4uLZkmcqHk7yT7SEJgbRDLIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLf5DlDD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso4515060b3a.2;
        Tue, 19 Aug 2025 05:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755604906; x=1756209706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxlmDv7vXmL4SD3L5/KJC4R0kpuGphw5I9k6dh2zXsE=;
        b=YLf5DlDD9aqbf5V3vr6aZoAuwCdF8s+zudchzGIfyOI3LqMsF7waYVswTjJyh6eBAQ
         VFdZTWsHRHyBUecFIj4P1xfDR26lL8IWiMP6LcKdTeR68RipJOIsO0klKe/VmpGezuze
         Xq5r4G6qncLQA5dYOguQT05Pf5PVCnZpB9DBHscYIoH8NeFn816oUjwj5biQg6E6GSOl
         dBjmUHqtl6OxA+kINmXWyy4NUWzkiVoNcyr0dOdVqBGnRcgKkPl6SaV6CWaQgHawfXvC
         0yDP+pt+MtzvgffYgqfmSvoLeIgMpLwO5sS7qsS5DI0cJng84D20k7/yqwaAAcR0sd9y
         EOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604906; x=1756209706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxlmDv7vXmL4SD3L5/KJC4R0kpuGphw5I9k6dh2zXsE=;
        b=ZKGq7MjwjyTeDHSw89VRsfm8nYSm+6Rh84lelzEgLkah5kX/qhCPEBO8cnsKT5iCRu
         usy5yIPpPBkWq9KTnOzsRxMF6WKCqxZUvnXNQawNjKY0KNjZeP6cxcxo7gZRdCG+Ku7M
         +Bwqr9qnV3a+nqIcrPquFPOqcFAD0CctpwJTslByzLV5Bn4jsJd2kFLzuc2nn6NS2YTE
         fWD8qwC/mxEJo0VBqomN8YRiaa5kmppVie4AIBPan3vfT3Y44XVWSRzCrzS5BaqgE7v5
         PNLmRAY13lC6OTpWaSTwBCCG8Vi5Pq1yU+G3hmoSiOTC4oVzzSJsi/AOHbIuf10ssAh1
         Mq/w==
X-Gm-Message-State: AOJu0YwrM1t8RnVJQgEtejjtMM828ZUubPMgOu/4dTQ3u1KNvc9fuIqp
	sCqhvuHQaywtFdy2MxJijKDTfnp5JW0jH3oxoAT3+nIaqWOeT0sd5Vrr6U5qPBwK
X-Gm-Gg: ASbGnctIWxgPGjAWiTmb95x6OTMn3WPRQhyojCmZKC10J5kzdpzupFUDd7pJI+xR2Os
	m0pZmousTEsB8YBkWL6QFyaSywja8bVJUm9lMfHlGQfGXh6TWheV6I1pGDk7UoLstgW1QgJopZO
	rL6IDsen4K6ZcG2peOdWwcFuPUMh6wwMECSId92X9ktbR5rUKTgTmXw33P/tqsM/QDt1hAlQP39
	DjTqlsHS5DtrVONbPfYrEgerO/dkbcEUopqJjq2amCMmw5WtlOXU2N8Kq374tbVFK9lbT8zGald
	mXE49yfDp8bXErwA5bR+0MFCFu7zqjRw3JMEs51i0u1ye0sOvRcrHHhQFxjjTSFXSjXZBv6fWLV
	3XUqOlCvwU4kUDVtQp8qGj4DWQA==
X-Google-Smtp-Source: AGHT+IEQABBWgwUi+Gj6PFYG5i/Ns1no4/fc6g0mMKpL9f96wL24eMDAKCJocmqSfll9PlNfhH0hqw==
X-Received: by 2002:a05:6a00:2409:b0:76b:ffd1:7722 with SMTP id d2e1a72fcca58-76e81140cd9mr3051639b3a.24.1755604905699;
        Tue, 19 Aug 2025 05:01:45 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d122ad7sm2331999b3a.36.2025.08.19.05.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:01:45 -0700 (PDT)
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
Subject: [PATCH v2 1/4] btrfs/301: Make the test compatible with all the supported block sizes
Date: Tue, 19 Aug 2025 12:00:33 +0000
Message-Id: <122da7535db9470515980b765ebbd05f6dd7d882.1755604735.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With large block sizes like 64k the test failed with the
following logs:

     QA output created by 301
     basic accounting
    +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 168165376 vs 138805248 (expected data 138412032 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
    +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
     fallocate: Disk quota exceeded

The test creates nr_fill files each of size 8k. Now with 64k
block size, 8k sized files occupy more than the expected sizes (i.e, 8k)
due to internal fragmentation, since 1 file will occupy at least 1
fsblock. Fix this by making the file size 64k, which is aligned
with all the supported block sizes.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/btrfs/301 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 6b59749d..be346f52 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -23,7 +23,7 @@ subv=$SCRATCH_MNT/subv
 nested=$SCRATCH_MNT/subv/nested
 snap=$SCRATCH_MNT/snap
 nr_fill=512
-fill_sz=$((8 * 1024))
+fill_sz=$((64 * 1024))
 total_fill=$(($nr_fill * $fill_sz))
 nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
 					grep nodesize | $AWK_PROG '{print $2}')
-- 
2.34.1



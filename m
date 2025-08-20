Return-Path: <linux-btrfs+bounces-16172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ACAB2D5E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 10:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197ABA02059
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CF2D879E;
	Wed, 20 Aug 2025 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx0Y3ezA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992F21B9FD;
	Wed, 20 Aug 2025 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677734; cv=none; b=pNwRNcbp4WWi8gOWDObWu3gu+EGHD85+dtHFuiccwGhdFhkN8ctCzCL1y/ibkEUzBN5SIFVts4UL4MUUS6se479L+exqKgBux+OO6HL6zB3QkQXEXaQfYm2YIShnNRS1Ow1C66G6FWAa2QOo82JRtLha60K7rN7cCcizHx4Tr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677734; c=relaxed/simple;
	bh=W6nAxMgfkv6/yQq96haMmKnoxBuHu3F9hFwDPbmjWFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLya75e8Hr83q3sQd2u+IIxOrfuzppa5yy/2bwhWDtB64dImS7EeTH9EthllVmhLS2d0nlASdUzo9SsQz+1kcbgr5vj3njdOoR/snwdYW1gGemEbGtAysBqlJp0FbSlyXuZZJnq0g+7o31g+sMQPNuSqsDDIwYct6o8HId8KptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx0Y3ezA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b472da8ff0eso3462980a12.3;
        Wed, 20 Aug 2025 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677732; x=1756282532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVrTRGUxl5rqpqzmWTET6Wx+rW4pnOk/cLByJXzWY8Q=;
        b=fx0Y3ezAiqULWbRvTKVVntcVUDsZidGsVScFbCMTIFQXOOI5l1xbISZW0LgrxsJuMB
         4T8BZ/hizqbZXMz+B5hwWd5micbKn+5ItOlBkbBp/LVCMVTDrtOj/p5xFtP+zcaVpV41
         HNyBc89SuNG39xUJWKpbNljrqv0LknY2hI4y2oyMbCIQ3uSsEV44aSUAuw0TzIZZjxId
         oLMnoq/JpnqYuHAq2RjFWBc/196p2Gm/HKu/hTDdtZ+xZdhMBcEHT8p5lx6SBUVkqn4n
         VwaK1k+w4tSxhrTDpC+wGos6q96M6juZBZg4uOQ16Y7RjUtlabjiAnvk1tZ5E0H/oMGT
         98jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677732; x=1756282532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVrTRGUxl5rqpqzmWTET6Wx+rW4pnOk/cLByJXzWY8Q=;
        b=TAsqUjZrk3SwU9W6XYtdkcjf/9ht85TWj54MDwqaA/3OClvmqeBPzK7KRB47woTs/O
         mZL00J5eL7oYd+YS/yTNpdd3H5B498MuabuGxs/L+bFSBICQ25PNY9ngRxVSfXJlRhHz
         iMUZR1oJmLIcN+0Um+hiMtwOmamXdQYy8vRtX8R+P5sxPiaLslKOpNne/YwzdTVFLEnA
         42PKD3kXQY/l+xbyDwbnBO8lgdwqSg5wOE8f7GvkwTf/P/WHN9EMJHAcFJnlIY352zhi
         aBA8iAvildRMO/iGeDu5UiYFT8ZRwnHOErPxy3cC8m+/KR8XQik9dp9jYdoGOf8DGqfY
         WuzA==
X-Gm-Message-State: AOJu0YxXbZY0Tr1x11NnARVvgS8EVTAi9ynummwnKa7DSjSdQ7O48aMd
	dLLWY+WI+jMra/4SNwVpSWX+4CKJbmbDf4fZo8u+/xGFoHaS2P7HQQ6aHZHKKw==
X-Gm-Gg: ASbGnctZOgd85pGsAKb/V05XdWw48IO93qM9CxZuUUlMKzovNJ1GGN36kkHDinaf4vr
	SBuvJjKPoNImZiXBJFNPh+dxLYqMGpnYx5+r7F5ahgTXBB0OokDBrFv+57i0s4quQJYG0EaEy79
	lY74kiuPES/jN5o+Yjp2ir2ngASs6PrvZBtgKaTyxI8MIBQrgDhgUbr4Wi8f/S7aSEPp/zdKmuE
	x7TEo1W06G7mNOkgUqXq129BW5aBqXtC6+erK6RXkGHbV7YEkfAhtkzdvO6GmdDp9TD0RQNMjAo
	QvRPsvzRaufQQdVUvwiP8kkp67YNanKtSxJ1HvGhXXYmc4dZ70sKNXOdLGLT2jgSGDACNscKwWY
	/6mrALeSTL4uM7E/vKEKyJpQ04g==
X-Google-Smtp-Source: AGHT+IFqwClmgcNAFjiw5lXt2YZE/+QDdTHYwHjtGMxJ2+3wmxqrO14P7ah3h64lE79tYFjhUIJVWg==
X-Received: by 2002:a17:903:41c6:b0:244:9b69:c920 with SMTP id d9443c01a7336-245ef14380emr19447235ad.14.1755677731981;
        Wed, 20 Aug 2025 01:15:31 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517beesm18848935ad.134.2025.08.20.01.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:15:31 -0700 (PDT)
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
Subject: [PATCH v3 1/4] btrfs/301: Make the test compatible with all the supported block sizes
Date: Wed, 20 Aug 2025 08:15:04 +0000
Message-Id: <83e91ed9d2b55bdf6e63f9607267d36e31548f07.1755677274.git.nirjhar.roy.lists@gmail.com>
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
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



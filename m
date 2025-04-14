Return-Path: <linux-btrfs+bounces-13004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6276A88BF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 21:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F3F189ADC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7728BABD;
	Mon, 14 Apr 2025 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PdVdeXP2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD87E9
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657707; cv=none; b=PYgUjLuPmdR0O798A2cnqSPuBkVvTDyMSGRkqYNn46Ohn1ADNfS8ImouPVfpNGMshB66mgICHIZO4hyAR9bIV/Kxhv2FLvZjpbamyc4w1nljMrrxy342RmJwM84DiH5EevAvOBdKBz/vBD8+mWUdn520EAZ+bnbWyn+5RAXSg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657707; c=relaxed/simple;
	bh=3aagCQrXhl/MNZAH77UCJOuTXZmHO9aKEGMGwqxQF4g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FNdgTgM3cCYD4Eqk0jcTVPmof47JA4HEaWn0CMg57RYpRJ2kQbheVxsH+9sgBGHE1S9qPfb6ky98G/tULzOBjacAFXc6u5myKUGundmkeuR80rhxb9+vpO/Ynh8X1NhEYisxtXNS91+8PFxh8hqDreqaErzn22v+4x+f9VNj4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PdVdeXP2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff1e375a47so43055617b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744657704; x=1745262504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrOaiCPjh32k0UW8/1LJ7UGycuyuFYRgZQnj8W95tZ4=;
        b=PdVdeXP2pu6+8wLAS7O4NYg+54PdnMIsIb/pSpyWEc4iAUyZW0gAJOvOKjHUyWG0TP
         jvQplYFoHuXHgAM2svdYIKUaA0U00Mlj6J9wgFuHbx+uFab0GYs3NVxduxwDY0sgybZP
         KYM0cBSgDo0vCzJEdCwyi7Tp3Gleo9tfRySC7KwCaHKRhxYKq8ed8+Q0/l69jOQSDN+M
         jV/2q3PC5jxtcQKBCUyfkyTd9WrQY6r1tTz8bhae3Ffams1IrJS0iw/Uws7MJlaEFp3Z
         1un+runbw6AHnpLGNzX+/w4I7QXIpczelasw/0hJLDE9izhvXdVicpTgwxqm33IEhv5q
         F6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744657704; x=1745262504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrOaiCPjh32k0UW8/1LJ7UGycuyuFYRgZQnj8W95tZ4=;
        b=QFGt2h9qlQ9q2sgzYooZoCPpUtx6IadLSAi8y2wGA2QZ8etcnikf6lX+bUBiilgXN3
         a6IAUB5X8DOGbr7cFgNQbJXXMpwwoekfBN3v65pxyeZYkC9l8AC+qX575vJnOTyAH7YQ
         hofqiZtnDkJRRee5OxJgOCAgi7uNFcyR4HlrDUxSsM1k3QNdtR6qD8QzvjMnuwEun3sK
         Y1ANN5BIS8tq67ActIWgr+xH3xR+KFQCK+16CnQ3vLRPOEz1a4nZIFjsUe5FWj5adyWp
         WznuYeONrmkb7P48tYRH9p455nEqHRvCvXuObkb/k6ISuFSdq4D3WkBkh1cquIBp5So8
         sdoQ==
X-Gm-Message-State: AOJu0YwHiQFnGXe31a65zTGu7ej8aAEuaye6tLKOMPRpVDjFi/sCYqK6
	kCGHYSIxMdV81TR9U4frFQtSwjXaJ/I7dX/EeWLxpPNkIulYBxmZ+IxoQESmTaz54nW9NoXDh1L
	c
X-Gm-Gg: ASbGncs/k6MR28Atd0xUHcsxzIBalcI+8F5yhmZlzKfs7dGoGXfD6004TpUCDEoTaZY
	CbjpfpvY/ByRcpkBkws/Rvgkt86pQqwsuOxhlOBf5Ijiy/wkbdQqDKSlZGbFiNas3QlkmtCEu1y
	xtN848Qj7mX1Dx2s3JUHCVRerXLKjIa9/ahazWgF20UcnHtaUXmV6zE9+y8mYS3rspch2xsNPzR
	xjhwqx+QcQgwPqR6IDuBgYIB+RUg9D9VEb75LQYH0QDwVa0IEfI73D0RHrVKBWJriwjmzTnMLcJ
	FPYVXD5J1BZNp8kzmN9PmQ6VaLTWCM2HlwawTje2WaUSwqlpQ2cTFy48EZw8oFYeJbTSoI16XNo
	AIWpMjhUM2LTp
X-Google-Smtp-Source: AGHT+IEcNp4mK8rmKue21TWPtApbpSfF5vFBrcVgXQsw4KJrHJ2ScACa5Yhlfr4NBtBqI6RUKNcRzQ==
X-Received: by 2002:a05:690c:660a:b0:703:b278:db3b with SMTP id 00721157ae682-70559aab9f4mr219935357b3.30.1744657703553;
        Mon, 14 Apr 2025 12:08:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e130ba6sm32977327b3.49.2025.04.14.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 12:08:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: adjust subpage bit start based on sectorsize
Date: Mon, 14 Apr 2025 15:08:16 -0400
Message-ID: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running machines with 64k page size and a 16k nodesize we started
seeing tree log corruption in production.  This turned out to be because
we were not writing out dirty blocks sometimes, so this in fact affects
all metadata writes.

When writing out a subpage EB we scan the subpage bitmap for a dirty
range.  If the range isn't dirty we do

bit_start++;

to move onto the next bit.  The problem is the bitmap is based on the
number of sectors that an EB has.  So in this case, we have a 64k
pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is 4
bits for every node.  With a 64k page size we end up with 4 nodes per
page.

To make this easier this is how everything looks

[0         16k       32k       48k     ] logical address
[0         4         8         12      ] radix tree offset
[               64k page               ] folio
[ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
[ | | | |  | | | |   | | | |   | | | | ] bitmap

Now we use all of our addressing based on fs_info->sectorsize_bits, so
as you can see the above our 16k eb->start turns into radix entry 4.

When we find a dirty range for our eb, we correctly do bit_start +=
sectors_per_node, because if we start at bit 0, the next bit for the
next eb is 4, to correspond to eb->start 16k.

However if our range is clean, we will do bit_start++, which will now
put us offset from our radix tree entries.

In our case, assume that the first time we check the bitmap the block is
not dirty, we increment bit_start so now it == 1, and then we loop
around and check again.  This time it is dirty, and we go to find that
start using the following equation

start = folio_start + bit_start * fs_info->sectorsize;

so in the case above, eb->start 0 is now dirty, and we calculate start
as

0 + 1 * fs_info->sectorsize = 4096
4096 >> 12 = 1

Now we're looking up the radix tree for 1, and we won't find an eb.
What's worse is now we're using bit_start == 1, so we do bit_start +=
sectors_per_node, which is now 5.  If that eb is dirty we will run into
the same thing, we will look at an offset that is not populated in the
radix tree, and now we're skipping the writeout of dirty extent buffers.

The best fix for this is to not use sectorsize_bits to address nodes,
but that's a larger change.  Since this is a fs corruption problem fix
it simply by always using sectors_per_node to increment the start bit.

Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f08615b334f..6cfd286b8bbc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
 			spin_unlock(&folio->mapping->i_private_lock);
-			bit_start++;
+			bit_start += sectors_per_node;
 			continue;
 		}
 
-- 
2.48.1



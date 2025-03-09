Return-Path: <linux-btrfs+bounces-12114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB43FA58166
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Mar 2025 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D793AE9CB
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Mar 2025 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7824186294;
	Sun,  9 Mar 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMo33219"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7929A2
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Mar 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741507142; cv=none; b=rd58TgDKmHgC4MztpNX1VlEfhhmRS6zVtHB0JlulT0oLcWK5/QN2ZBo7Qs393Ko3b0yKcthl3Jjc584wX7qH2jS8NvyRAAP5SixNsw7L7iM00108oshNAUEb8Me0JdBI2kzt0iYCCA6mg8HGSuekU1FxjL923vnaL24RFDRM8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741507142; c=relaxed/simple;
	bh=loI+Cphyh3PlcPMx0t6wqeVaRgync/nNbxkiCd0+Lf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt/5THu2ulAbK/wZNa3jInwU5Uf0qVIL6ioZg+alpdqXtWk+DR5Of7gIjog1SBbB3E8Pkg0DZMI7U5NVa9Engshhw8NEDtCglPmghSM5wreiTFANmgA4NqUn06ll3Cs8xj89ES9mxgbRnua0FxedtvkoHxa5tgWerjNspv1qDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMo33219; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2ff5f2c5924so918434a91.2
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Mar 2025 23:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741507140; x=1742111940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VG4cllT9GxwwDjosIsQmh6Zfd083Q7kQdZwoy905oc=;
        b=cMo33219guC9DLT77pVxFrEXCW72ShHRfazqP6gKMqO8bZZJFRKvfi0vcnlD1/crC+
         wJ79hdP0kISWmiXlHruaO4H1UjBQpa2hU5LPi+sU7wmHyE6Qolgm7r/qCz9adX/kax1t
         u/dI3wXzZS5hxN14xuiA4m2nKLMz5HRVhfV43uQsNIo8WfT+BKmIDCWnXnJdti4AU5k7
         mQMQzpDVpCxYjszoJ/Y81q7pBdw8sblzCVEDbn/7MVqaSDfvViOlhUQzUHY7TuhR1zvy
         jUr1WrBna8HXzpSONtjQUuo+dqHLayuz6Qozdfmwfw1u13Roku6J0tzjAyAW/mcsMQUe
         Impw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741507140; x=1742111940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VG4cllT9GxwwDjosIsQmh6Zfd083Q7kQdZwoy905oc=;
        b=c2Ui8UJilWLfD/Yi/SUqIE9rxdu0j8CRCL3atl3P2/hO7H/Rrgt7GeuB2EGjyIAtpY
         y48ZusJG/Npu7dzf/lGKm8C0J62P2oMZV+YaZwvEeH89J2oiGwStAxC0bK3LZZQaumBc
         ysfOXL2lIXisK/1TwY0p+nkUFPeUgUa6CX00MGxaQ460eEoenrm/nGybEQbNCPqR+Dsm
         gCSYN1RvU2U1MJHHyDbXN03QC2iEQgFSQ81xbVFt4wVS6RGHIS3BH/1twTZhPngdPEf7
         DjRwCHf1cO8HjePHwYqnVFuulxKqfhkNg7HTgj1w937jPos+6D7y6LKwyGC8LuajFX9n
         44ig==
X-Gm-Message-State: AOJu0YwZfXHDC7hk7I9eHVRs0Kzj/1WQLLt/fPs7P3p+Mj/4q0NQ0tOx
	DhEggJWrWrToAw+LUks2CIjw/NOxp21Xx3dzr/ja5MU4MhhcKb9N5C4Hl8iwSlnqKg==
X-Gm-Gg: ASbGnct9vS3M9B5ilDh7xXuYAxebJYFhC/YPv0m2o/XUQ3+yhoHDFfUsdy71hUH0OpT
	xXtGBM8/Lj8XynARi2xKnL/e62MCafxCkwaJwbo01t1TpLS8fFguDFwsdPw5XTJFojwkxMcOp/Y
	2sv+5Ub+BIrYmsB6zq6GkNo7vlhENpCexc9lKuCpW+BCwxuZ+jsnXnEX63djir/wx6sruZapzdA
	H16gCXyRTQBHLCO/uogq2qttRtVxv3cN7wZv24oQRYfqtgykO6QeYGUnEKa3XOXioYY5WjzwTJS
	WXrVTAagCcIZuqj50MMeTa3vDUkJyvDYm2qrBchrBl9thg==
X-Google-Smtp-Source: AGHT+IEiYm5hQ9mj6OI8wQU7+fw9gfjEVC/fiybYx3jljoh9E8GtcL2HzpfXVGuAWIhwrgAuRMcZUQ==
X-Received: by 2002:a17:902:dac4:b0:223:5c33:56ae with SMTP id d9443c01a7336-22541f92259mr28885145ad.11.1741507139793;
        Sat, 08 Mar 2025 23:58:59 -0800 (PST)
Received: from SaltyKitkat.. ([2403:18c0:5:3e0:98c6:7dff:fe56:ac2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd627sm57045605ad.50.2025.03.08.23.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 23:58:59 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/3] btrfs: improve readability in search_ioctl()
Date: Sun,  9 Mar 2025 15:57:59 +0800
Message-ID: <20250309075820.30999-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309075820.30999-1-sunk67188@gmail.com>
References: <20250309075820.30999-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit addresses two code issues in the search_ioctl() function:

1. Move the assignment of ret = -EFAULT to within the error condition
   check in fault_in_subpage_writeable(). The previous placement outside
   the condition could lead to the error value being overwritten by
   subsequent assignments, cause unnecessary assignments.

2. Simplify loop exit logic by removing redundant `goto`.
   The original code used `goto err` to bypass post-loop processing after
   handling errors from `btrfs_search_forward()`. However, the loop's
   termination naturally falls through to the post-loop section, which
   already handles `ret` values. Replacing `goto err` with `break`
   eliminates redundant control flow, consolidates error handling, and
   makes the loop's exit conditions explicit.

The changes ensure proper error propagation and make the loop's exit
conditions clearer while maintaining functional equivalence.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6c18bad53cd3..bef158a1260b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1642,21 +1642,20 @@ static noinline int search_ioctl(struct inode *inode,
 	key.offset = sk->min_offset;
 
 	while (1) {
-		ret = -EFAULT;
 		/*
 		 * Ensure that the whole user buffer is faulted in at sub-page
 		 * granularity, otherwise the loop may live-lock.
 		 */
 		if (fault_in_subpage_writeable(ubuf + sk_offset,
-					       *buf_size - sk_offset))
+					       *buf_size - sk_offset)) {
+			ret = -EFAULT;
 			break;
+		}
 
 		ret = btrfs_search_forward(root, &key, path, sk->min_transid);
-		if (ret != 0) {
-			if (ret > 0)
-				ret = 0;
-			goto err;
-		}
+		if (ret)
+			break;
+
 		ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
 				 &sk_offset, &num_found);
 		btrfs_release_path(path);
@@ -1666,7 +1665,7 @@ static noinline int search_ioctl(struct inode *inode,
 	}
 	if (ret > 0)
 		ret = 0;
-err:
+
 	sk->nr_items = num_found;
 	btrfs_put_root(root);
 	btrfs_free_path(path);
-- 
2.48.1



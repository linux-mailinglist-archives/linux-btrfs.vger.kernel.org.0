Return-Path: <linux-btrfs+bounces-4419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0608AA6E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 04:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1FBB21A58
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 02:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6E5CB5;
	Fri, 19 Apr 2024 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="15H+RZxc";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="15H+RZxc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F115BB;
	Fri, 19 Apr 2024 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493389; cv=none; b=l3JKdw2X4H8ZVVDNYVQO4LQIveMYTvti0pZwtJ465S5FwkjLy2Lce5RR7kYc5Fvp6XyUXZQ4McKwMEjB/HsqlDv/vWd4MK5PgcYKNUx62sGMP+nSFlZD+t3dHTn0KDjfKWGAM2NP1Bx4u1iFh+Wosg0ExsKOkcEkzZL4Ys+dsMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493389; c=relaxed/simple;
	bh=YWIvHmwPsFjnECnsYOTQPHTSsM5bF0cCK0ua+j7JWK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Tj453N9WwNzyJQBffsT6fJb6mAmGwWybm9tzLCPcjsbQaa4u5viemTiwMYq7Oh5Mv/vUOVQL4qq9sF7e8R5frAT7oL++nVIeW4xD5YG0CJJae9ySfuWrH73A0A/P5LO+hlvHnbcHRN5fJXZ+xJ1HTl7UeremkoLxXB++9EPsk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=15H+RZxc; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=15H+RZxc; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id F1620C01D; Fri, 19 Apr 2024 04:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1713493385; bh=dey0f+0Jtz8lFCvTxKq0L2AIbLXAE1Fp/uaRIkkiwPY=;
	h=From:Date:Subject:To:Cc:From;
	b=15H+RZxcUqlMFX7ZV4nDUoE56YYNSddgeUhKmYR3456zpIQoHRl1FpeLnsr3voRns
	 YSVzjF/yzMR3o+OHi2GoSdzC4Z9vNnRHA+baMs5ScAmwpv371gAZk8WuUPYVHARLCG
	 HkI2ZC6O9ZtpV/7ZiXSL7uLDkGqvB7QDWD5UGVfd8QQXLm6MjZYhFKILJ/RJVFc0Bv
	 XdifIVWShjQMpbzbakh0aNcgdP2Wf+jF6uDSirjvItimmTSZpyWCvgiQy8Vsd/kUNh
	 NQolSc9m2IBQHmun8juSGKkGVFZzVmEJDtuQvPUgpfLm9+1Lh2umMrFmN9akuDFs76
	 OmK8CL9W14UHg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 38679C009;
	Fri, 19 Apr 2024 04:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1713493385; bh=dey0f+0Jtz8lFCvTxKq0L2AIbLXAE1Fp/uaRIkkiwPY=;
	h=From:Date:Subject:To:Cc:From;
	b=15H+RZxcUqlMFX7ZV4nDUoE56YYNSddgeUhKmYR3456zpIQoHRl1FpeLnsr3voRns
	 YSVzjF/yzMR3o+OHi2GoSdzC4Z9vNnRHA+baMs5ScAmwpv371gAZk8WuUPYVHARLCG
	 HkI2ZC6O9ZtpV/7ZiXSL7uLDkGqvB7QDWD5UGVfd8QQXLm6MjZYhFKILJ/RJVFc0Bv
	 XdifIVWShjQMpbzbakh0aNcgdP2Wf+jF6uDSirjvItimmTSZpyWCvgiQy8Vsd/kUNh
	 NQolSc9m2IBQHmun8juSGKkGVFZzVmEJDtuQvPUgpfLm9+1Lh2umMrFmN9akuDFs76
	 OmK8CL9W14UHg==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id cb34d8c8;
	Fri, 19 Apr 2024 02:22:57 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Fri, 19 Apr 2024 11:22:48 +0900
Subject: [PATCH] btrfs: add missing mutex_unlock in
 btrfs_relocate_sys_chunks()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-btrfs_unlock-v1-1-c3557976a691@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAHfVIWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0NL3aSSorTi+NK8nPzkbF1L01SDJONUo1SjtGQloJaCotS0zAqwcdG
 xtbUALEvZuF4AAAA=
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 Pavel Machek <pavel@denx.de>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=PQDfb7YN93UFq1W9UaceWw4qYGbjxHk52DSUfrpslKA=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmIdWBHt6FPFqgoCOFtFR2ZsfKECrOk7B27Plfd
 qu1WHsMxTOJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZiHVgQAKCRCrTpvsapjm
 cIUBD/40v1L0o/u1aYX/jSbe1+NO/6Hbl3Iw2V/NsLUs2zkHWnKC2cnwgRALEVz7XBouNh2tSdm
 hHPBL9lR6TbSYQ0DUrpTGh67QGRLYYCEirEi+hgQtWKTXQn6kc3UCJbEaYmA4lIKgJXzEjSjRry
 2itAEZUNjvtFcViRlDZqFSGK6mNhPGQ/m99n4V+Lmz4kMa9YFhxWV9NtNeqPOm0CjgCzbKtXjZf
 inYgEiFjGGGGLNsd+UREqXtyqH4lwtqFNMb6XpeEJGhtD0eQedMrAPfQZNJuHkfU5y+uxh51FZv
 DPH7Ykw3LM2gcRMumAwVTHtZIj+JCEn2u4RpARUZmti0+oGSQKSMb1LckCiiPCFXH71A0u9lbrA
 ALmfr6cwDvrZhiW8OIJhrJi8nedTXaWuGtAUHOstN2FO2id4owqS3G++/YcEWRzw5GNu1Y9jF3p
 pGeEg/gWixBnOkxFt4Yg2D640PJb99Qkos7YXYSKzfipgBQoShr6I26DRR6LyRH46A4JysYHbNb
 yCClerECFb8xgwHz5amZqBqi4HvVTUde3+0QGTddFynXixiohMDImHGeDvW7q8f0E/nTdqn24RS
 FcefkWy1l/DAo6/uxYZBMV0WUo2T0GDgo0ZFhc8seEeKGX3WVEyZOMskHChrDLyI6Lu3K42Xzr+
 8y5kI7xk+7spAKw==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

The previous patch forgot to unlock in the error path

Link: https://lore.kernel.org/all/Zh%2fHpAGFqa7YAFuM@duo.ucw.cz
Reported-by: Pavel Machek <pavel@denx.de>
Cc: stable@vger.kernel.org
Fixes: 7411055db5ce ("btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()")
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
Note for stable: the mutex has been renamed from delete_unused_bgs_mutex
in 5.13, so the 5.10 and 4.19 backports need a trivial rename:
  s/reclaim_bgs_lock/delete_unused_bgs_mutex/
If required I'll send branch-specific patches after this is merged.
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f15591f3e54f..ef6bd2f4251b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3455,6 +3455,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * alignment and size).
 			 */
 			ret = -EUCLEAN;
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
 

---
base-commit: 2668e3ae2ef36d5e7c52f818ad7d90822c037de4
change-id: 20240419-btrfs_unlock-95e0b3e2e2fc

Best regards,
-- 
Dominique Martinet | Asmadeus



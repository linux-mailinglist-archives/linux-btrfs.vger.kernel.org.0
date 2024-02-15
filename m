Return-Path: <linux-btrfs+bounces-2418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C9D856205
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87416287AAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AE12B16F;
	Thu, 15 Feb 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e05V8upb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D612AAF4;
	Thu, 15 Feb 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997634; cv=none; b=t4K+a7ajaWA2C3vuvFeHJk5gUd+oOM5ff/6oS5pvbFvhDClzOf2844fGgaLb23fiRBBaLlvOss1sqOJs4bb7MEVNhcMZHMJa2cg05K7UeGDFWLwadkXM/VWhnbVZliGPCCP6FCXICOhwKwx2pgu/Y5JJ7aUGxNOFpMH+hF91nOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997634; c=relaxed/simple;
	bh=YMPebLD6MMvH6YOxwWD2dlU27sq8q43dhhOqdaoKwJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOuzh9J87kqgpBq6Hev18aO8GFiPsZHwdzp5fBr2FAEWFppAHDWf9n8l4smI0WM8IFYGZCFceZXJBkN8cWA92EnGEoI3A3DuP7S2xjXFJ052EiaICxMKd5aN4zVwtdBUk6SvLQjPO/G953wG700djyMY8BK/eofyEXvSko8mdl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e05V8upb; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707997632; x=1739533632;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YMPebLD6MMvH6YOxwWD2dlU27sq8q43dhhOqdaoKwJI=;
  b=e05V8upbTN6ce4Gnb4G8RN9UqBYnBlxn9zJXw3IlPHq/WnGyu75eqTIy
   cuwCMOM35JykTHKVSTsA8oRhfiuLkH1VysdfWurvl53VKyumVI+jXXaFs
   HNxi84LoGQeGJaeMDTAVc38V2eu7GyX8R0QzXlomM1EubRZo6SQ4T0UMP
   PHLcktbcBpYY4Mxu003ZlVWnLZwNc7HIdpm5KqvX9Jktn/Vwrw6Oz3rPU
   swisYDm2CUBcKOANWWFkEUgcwfampouHJMGjQ63ii12urB7EAuyPk5DcZ
   qG75SFLxuVMAdgEci6Qlb3zUwhyZ/9J96XN5nHOTGinsMb9Lq0rC+bSRV
   A==;
X-CSE-ConnectionGUID: NAByAfOJQ6Wf5ftSjAiBfw==
X-CSE-MsgGUID: ZXU2fwbvRNaaeT8BXeYY8g==
X-IronPort-AV: E=Sophos;i="6.06,161,1705334400"; 
   d="scan'208";a="8967200"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 19:47:11 +0800
IronPort-SDR: Vfs/peU3/GksZp/eFwGH/hYXPN/VyfyW/Wx2BlT2Qa3zD+2ArVr42XqSPXHrLYgNyw5JOR+zLj
 NRSRZ9SuzabA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 02:56:45 -0800
IronPort-SDR: vYV5JL2MzQaXZTHmo0ak1RKYdXoUvSuOPQO5pcafvHm8LOxwrRMKrTRuwxmTfqR1CeoAxb2xzl
 NQ4T7I2HCBwA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Feb 2024 03:47:10 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 15 Feb 2024 03:47:05 -0800
Subject: [PATCH v3 2/3] filter.btrfs: add filter for btrfs device add
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-balance-fix-v3-2-79df5d5a940f@wdc.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
In-Reply-To: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org, 
 fstests@vger.kernel.org, fdmanana@suse.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707997627; l=796;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=YMPebLD6MMvH6YOxwWD2dlU27sq8q43dhhOqdaoKwJI=;
 b=NHwOg+0OhiLR/s6ALvd/8bsv42q4kY2cNW5F8979H1u2mVm4SLSZQ4j3y5yZyvH9E43GBT75+
 qUnyeEHqFriCr5B3qooSfrzxqJz3DukdMn5hU586xFfqIAvvUsI/Mtb
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a filter for the output of btrfs device add.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/filter.btrfs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index ea76e7291108..a1c3013ecb5d 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -147,5 +147,14 @@ _filter_balance_convert()
 	_filter_scratch | \
 	sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out of X chunks/g"
 }
+
+# filter output of "btrfs device add"
+_filter_device_add()
+{
+	_filter_scratch | _filter_scratch_pool | \
+	sed -e "s/Resetting device zones SCRATCH_DEV ([0-9]\+/Resetting device zones SCRATCH_DEV (XXX/g"
+
+}
+
 # make sure this script returns success
 /bin/true

-- 
2.43.0



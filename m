Return-Path: <linux-btrfs+bounces-18899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91474C54116
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008AB3B11A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9B33BBAE;
	Wed, 12 Nov 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="AON2eK7/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="qfmc4ERz";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="bU5gDKsc";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="2MTf/o/z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender8.mail.selcloud.ru (sender8.mail.selcloud.ru [5.8.75.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A934888E;
	Wed, 12 Nov 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974469; cv=none; b=ZGeH1zd2Ks/D6R/jLnfFzXaktB+5xk3lvfwfXNbD1gQ3BMozdZlTl0OX9lFLLcPzEefNLrzZvBAc3yu4533xk58onmkTkR6rrU1P7wD2NsU/J1rNWBRkJ5zOa0/j4wn9GF87X4IdQbzmpJMTKUaCNhNfIVkW28wNW9tVK9wvV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974469; c=relaxed/simple;
	bh=onFtvHF637PkHfokYGmMMhhMnra8N2YkWhTjb4IwbhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlIwem7zjWbOwoBIfHBLutU+WWlo5Ee7IrJVKIIx5NvUXbkGB6jXN0T9Kbm+t5eu1OyjPVTK2N+ecdzOlbTiMu1glwsI/MtfpVLJ6n9udz6elONh11RLDRdxOleUMHacvAGuriO42aoigRo+bct4V/3HuLEWYQwmSppllwmv6ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=AON2eK7/; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=qfmc4ERz; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=bU5gDKsc; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=2MTf/o/z; arc=none smtp.client-ip=5.8.75.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=om8sf8stEkxllM3ntHfWOkinWEynYIsowhngY8eZid4=; t=1762974465; x=1763147265;
	 b=AON2eK7/BhFNG60+PVnMj+De+IymPmCZWx7bOvHc0r8bnXF0Gdo8/Cdz1PhUxx2OziRdaAjDqY
	l4ChkdgvOEygpFTlcmFNj3HbuHnHOShMWkdfGuuljR/UhQNPQlYM4niuIov8gj08XDMSJA18rYOF5
	4xG3xVXE0kpEAVWAWD1k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=om8sf8stEkxllM3ntHfWOkinWEynYIsowhngY8eZid4=; t=1762974465; x=1763147265;
	 b=qfmc4ERzZ2P9TfIaVsJZFY6WEc6eln5f51TE0mNnEuV8su8hXxrWSziPxT8jUtD4ieaB0eFfUc
	F/HhnibIfVpQC1GXhYAk6SFSnhea9UPxCLmSco51hpkrGJYXo+nxiKToEccgmPWrO9imk2cZliHZO
	K0S6GcBQ9mW2CuUXS0/M=;
Precedence: bulk
X-Issuen: 1428244
X-User: 149890965
X-Postmaster-Msgtype: 3849
Feedback-ID: 1428244:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251107.120132
X-SMTPUID: mlgnr62
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973418; bh=om8sf8stEkxllM3ntHfWOki
	nWEynYIsowhngY8eZid4=; b=bU5gDKsculcs8v3vKqFw0Afw+hnvhS2luuDKGls2snVuqiaydm
	7rrmKqbS6UyuMSGIe2AU4fcKVDJgTAP30/SJIIuW67AxeP7WZVPwQXr12kprzjrZuVmcryLZC0F
	ZPAjkvbfIjWNLiENV9OqGLSRhyEj9gXSSicWXMWlRMkHCNBAQeULcUFC/goGfETtnwOYI1nWZWO
	cjVxDcFLVHPrCNZjGYRVpNoTP5PSkr1LrAz6EkougAXgZL79SccmN+2qQPQNO0r3znknqxtj1Ln
	Pc2Fo2hE0SDD2zDUIa+1aiFgpjHeDCEXS/IUcFXbeZICe3SCuYhwxf767hKPV6InKYA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973418; bh=om8sf8stEkxllM3ntHfWOki
	nWEynYIsowhngY8eZid4=; b=2MTf/o/zVzkWKZf5S66bhosjObwo8Tb3T3OG4Wb7bZIuWKVydX
	O/u9d8ezEMgk6At6dHLpek5Nl0EbtDpgeeCQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/8] btrfs: remove redundant label in __del_qgroup_relation
Date: Wed, 12 Nov 2025 21:49:37 +0300
Message-ID: <0893b79051c610f44757521a42f410ebdcf48282.1762972845.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1762972845.git.foxido@foxido.dev>
References: <cover.1762972845.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'out' label in __del_qgroup_relation only contains a direct return,
with no actual cleanup operations. Replace all 'goto out' statements
with direct return statements to improve readability.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 fs/btrfs/qgroup.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 31ad8580322a..9904bcfd3a60 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1600,10 +1600,8 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	int ret = 0;
 	int ret2;
 
-	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
-		goto out;
-	}
+	if (!fs_info->quota_root)
+		return -ENOTCONN;
 
 	member = find_qgroup_rb(fs_info, src);
 	parent = find_qgroup_rb(fs_info, dst);
@@ -1625,10 +1623,10 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 delete_item:
 	ret = del_qgroup_relation_item(trans, src, dst);
 	if (ret < 0 && ret != -ENOENT)
-		goto out;
+		return ret;
 	ret2 = del_qgroup_relation_item(trans, dst, src);
 	if (ret2 < 0 && ret2 != -ENOENT)
-		goto out;
+		return ret;
 
 	/* At least one deletion succeeded, return 0 */
 	if (!ret || !ret2)
@@ -1640,7 +1638,6 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		ret = quick_update_accounting(fs_info, src, dst, -1);
 		spin_unlock(&fs_info->qgroup_lock);
 	}
-out:
 	return ret;
 }
 
-- 
2.51.1.dirty



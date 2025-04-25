Return-Path: <linux-btrfs+bounces-13432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9EA9D4AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 23:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828EF1BC66BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 21:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CB22687A;
	Fri, 25 Apr 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Iqr+ZPnk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAwCyEwG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3F32192F3
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618270; cv=none; b=C5/uj5wYXDUSO5iVv+iR2n8DrS8aXPx2JlKR17nrkvPncnbrRkKU2BsZGf48ARwX4Ye1p1n+m9GAKNDfGqnTnCZCjvpHSUdcD8iVH0mOZyqMnxRxDzTpip3LfKAh/GLcTrQL4iHSypAbcdpFdMJxtA8m19c6ev427tnKGTScVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618270; c=relaxed/simple;
	bh=nmPW5nzJzp+5rflE/JfKTQVawre9buedalMh38TQvbU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iJlaTcdagkU4K5CypM+20eP6axdSJy6vWFJzwk5A/FoLeu4RzoXoi5m0hPuZXdPZTVJ8qlLa1Z4hBxQ+DZSLuMW9CmNlapIUGgGa6pMnMhkoUrJwE4m5I3Hwf/ngAe+mrq0sN8OxpqfkUZWv2aRpI3mtQZoI+QNf1RuyuJaK3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Iqr+ZPnk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAwCyEwG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9D301140092;
	Fri, 25 Apr 2025 17:57:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 25 Apr 2025 17:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1745618265; x=1745704665; bh=hi8cilIRzrqFqyCjErjic
	BILyg270zB2h8a5IBcPWHk=; b=Iqr+ZPnkG1zLoOsZw06X4D8BaDyJBXAzLz1tH
	c7MFFQIXIRAeglHw2Xocs2BiGbPEIs++BD41ZJ69olP4ifY031m0ONUBL7TUDOkv
	dtx8g091nyXZYb89KAO3ODovzwbjlF8Cnll0bmGJkQafoO8tpWwbF9QTCcj+ro2Z
	sfAg0104r7Lul5pnbOwQO0PFvhqRzBDB6XlbWk6W9yKfaQwHr+zrFGuQ4X1m4wMi
	JWTAHMh5Y2GYAr7eZKo9ReHRNaJMPvWWk0EEAPWn/PYX/jTGxpWjuj45DtFxrSiF
	ABL/9hLJNlcYMK/USd8Z59nDcmyenz5rlMWQ7vdGF+Mndr+iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745618265; x=1745704665; bh=hi8cilIRzrqFqyCjErjicBILyg270zB2h8a
	5IBcPWHk=; b=KAwCyEwGMXPcVQu9sRilkjnh+YjTw/wWC+PVt/NVx/8TSXWum4h
	XHXHAVAEHLDzOpsLs/o8AwjbAKA0xqUsZPGsvysl0/PwJs+MpXQl7VOw7mB9XEIA
	cFP+pyVPJqK5tjNyNvRwVU/NAJ6Pso58+2bn2E2I2m/+Txf4hY60l1jtSqRJ3gLF
	2GavdQ8xQs/nZ8uGpvRWdSxNCZhFHmhs72qQvHKgLwH/AgroRYah7/4obefwZ6w3
	v1a13lnnFxQ2pVm2I5/0KJ7vdgTsKF19SoHNl3w7aoDdmOLrtNOnsYZaSSa4K/LV
	DH8pUiLJZm/XaGebmhgmen0xHpB5VbuFKSg==
X-ME-Sender: <xms:WQUMaNPxw8QBZUWB13kfMDObyOiHtkPVzucBaWzTIbuNNOYX2IhFXA>
    <xme:WQUMaP-kKwMMdzFKiZd_DVafKBocodQ7NCZ8p32pzeYWg6x0n_R2MjhsrJVtge4v7
    kyENsjMzn8oI8MSVTs>
X-ME-Received: <xmr:WQUMaMSyRsRseamLS9cVEWTpLyLMjIgCrkZXF_lQzeIcfoHyZ4NgVZBHnTZ2QgqOWjXMjOmHSVgQm2JcBeRvBr43LEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelff
    evleeifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:WQUMaJuhSSCMFp2-beOB8MjaLoLBupLCaixxqximGomM4CSuI8KfHA>
    <xmx:WQUMaFfVsocsm06JP3jQrxvsCNN1M5jwYmcKYSxVLFSb8Fm0Z6bE8g>
    <xmx:WQUMaF2c6xFef6QT64jlWiGoNhnnP9k7-Rh8nym5o32-kUUyR2xMGw>
    <xmx:WQUMaB-zJo77yzrHpewHD_7i6Op4pOHHt_N4R-a8f3js3YWSnB8iNQ>
    <xmx:WQUMaIywwhJvPv6NAa1pkS4HpETNI-Py0wzHG-VQr57nMbU_FZrJvxAC>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 17:57:45 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: handle empty eb->folios in num_extent_folios()
Date: Fri, 25 Apr 2025 14:58:38 -0700
Message-ID: <a17705cfccb9cb49d48c393fd0f46bdb4281b556.1745618308.git.boris@bur.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

num_extent_folios() unconditionally calls folio_order() on
eb->folios[0]. If that is NULL this will be a segfault. It is reasonable
for it to return 0 as the number of folios in the eb when the first
entry is NULL, so do that instead.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9915fcb5db02..e8b92340b65a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -292,6 +292,8 @@ static inline int __pure num_extent_pages(const struct extent_buffer *eb)
  */
 static inline int __pure num_extent_folios(const struct extent_buffer *eb)
 {
+	if (!eb->folios[0])
+		return 0;
 	if (folio_order(eb->folios[0]))
 		return 1;
 	return num_extent_pages(eb);
-- 
2.49.0



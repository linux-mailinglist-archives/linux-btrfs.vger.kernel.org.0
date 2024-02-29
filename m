Return-Path: <linux-btrfs+bounces-2938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6927886D269
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADC91C22013
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263E712EBD0;
	Thu, 29 Feb 2024 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Bm8NQJ7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWFM9qME"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7617D08C
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231750; cv=none; b=je1aVQbPvHjcT8S6CeII/fPs0gubsEloq9xJtOQMpKaJ8Exchts/0RU23bv0oEqPCdi8pROPv2kyAAHcx/fo9TB7AOQT91MOqIDfQiefhAkzmBYWCqveaEv/3iGoGA3LCUeRk9vTzyP53atMdrdi6d+Jhs8ZiWXcwNo62tajrFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231750; c=relaxed/simple;
	bh=zJTuLzwBsc+GktzAV2F12LWbXkN7rb4zoGHEmGmIUyA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X93yRNLoqzuTgXVcO1S4LS//RUkOUB6nyJsldz2X6zrCNaUX3952BUNtBmU5CoOKHukB0I/gZcmnJX0yOxirUeQ+wXSvtcBWskXU5jD1IVUSqNGsVMJVdu3j5ZDjYBVL7ziAWZhTPsFxGn+sfxtbz+qOuBiqLGLXOZu+H37oJKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Bm8NQJ7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cWFM9qME; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 8DC843200A02;
	Thu, 29 Feb 2024 13:35:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 29 Feb 2024 13:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1709231747; x=
	1709318147; bh=uF7DrAP+uQKfMQxckXDW7DyCs3jNrR5H8RK6ew28bZA=; b=B
	m8NQJ7vTZDqFowDCH0tDxR7JRNl3dssiRXXxi7NnwkUOza3MnApqunJoF383XN3o
	Q7vBmzvbai6OKxwrr2745v+FT+mNh93TxRLEu194Bt5Ndwm/59P3AbyxiL8d9OLe
	OhiJHVDlLV96rtnIXaVpwGDX0YaagmUQh/lT4Rehbru/m5rDBlFLxpHvtITS1p0u
	2BVCak17HQspH0eXGJX3OgL1EUPNo8zU5NKc8n1o82KPrjV22LXumA8ljU7/xMoM
	IjyExMV2mJxy8rFJVNZlq91FqdI3br3firZ86HB18jgmgjP9fngzprJmaNXIuLed
	jl67Uriju7jOvd9+BamTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1709231747; x=1709318147; bh=uF7DrAP+uQKfM
	QxckXDW7DyCs3jNrR5H8RK6ew28bZA=; b=cWFM9qME9g2k/HJthky8Zx0jSdf/f
	TE2AbyHbCyevjVUJ8x0TmMIUkMmmXRekRpKPbWi898sWJ9Tw30wjzWny9UHWviZT
	7jWPWXVguTcuvmqpriscyeaQ5fRc7sbesRKm97ATOO71srvBCwIDzItVM0GddMwS
	2wT2/oL5B1P16viuJZViKiBZwt47wBdSSlJPp6IuGbajbv0ZGNJ4rVU42u+U7wDB
	DatYIJ7RWQ0CyS+DvNBrScrstqnv3/RC8lzEfjk54GlX1ZaudTylnYPoywoFjHl4
	HDxZulwV12n62S0kgstsJVLzU0ajUbbRRHO8bWf5sBzb+yTZyHKwUSn+g==
X-ME-Sender: <xms:gs7gZcYC7On0amYGnO_wQuT4n3MOTh3gcpbqoYCk5vfIOSCouUllKg>
    <xme:gs7gZXYueS77RxxD1di46ZYziwmImpjYwXmXSa0WYShYbmEHDPPAImUDy08t-rm7F
    Bf_fDT3zasPcsLk0y8>
X-ME-Received: <xmr:gs7gZW8kf8nksnDMTwjPMXLdgICcMLg8cBhdqo8xUcwZjhEjG-iFZXQeuFDEMTou3F1AEKlmTXEaGvFgVvy7fsrzCC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:gs7gZWqpFSOpi-ga7rn8XRqL9d2OezWO6-zGGUck45W8QY76esLUgg>
    <xmx:gs7gZXoiarzhj7C29Vt8YHvPlOlTRKPQrF2ex9-v_ejFoe6rciUk8A>
    <xmx:gs7gZUTmiKmmfg1xxkYynSyIl9NSXUB0JHZRB7at--_qrdL168MBkg>
    <xmx:g87gZWTAXE5sDkKUeqj-0HlFg1nyOjupth36YHkallCNSArNqyAFmA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 13:35:46 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs-progs: add udev rule to forget removed device
Date: Thu, 29 Feb 2024 10:36:55 -0800
Message-ID: <80545243dec10a48562bf8a9b5d10b8ba6f16983.1709231441.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709231441.git.boris@bur.io>
References: <cover.1709231441.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that btrfs supports forgetting devices that don't exist, we can add
a udev rule to take advantage of that. This avoids bad edge cases
with cached devices in multi-device filesystems without having to rescan
all the devices on every change.

Signed-of-by: Boris Burkov <boris@bur.io>
---
 64-btrfs-rm.rules | 7 +++++++
 Makefile          | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 64-btrfs-rm.rules

diff --git a/64-btrfs-rm.rules b/64-btrfs-rm.rules
new file mode 100644
index 000000000..852155d28
--- /dev/null
+++ b/64-btrfs-rm.rules
@@ -0,0 +1,7 @@
+SUBSYSTEM!="block", GOTO="btrfs_rm_end"
+ACTION!="remove", GOTO="btrfs_rm_end"
+ENV{ID_FS_TYPE}!="btrfs", GOTO="btrfs_rm_end"
+
+RUN+="/usr/local/bin/btrfs device scan -u $devnode"
+
+LABEL="btrfs_rm_end"
diff --git a/Makefile b/Makefile
index 374f59b99..eaeed9baf 100644
--- a/Makefile
+++ b/Makefile
@@ -271,7 +271,7 @@ tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadat
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
 	      $(mkfs_objects) $(image_objects) $(tune_objects) $(libbtrfsutil_objects)
 
-udev_rules = 64-btrfs-dm.rules 64-btrfs-zoned.rules
+udev_rules = 64-btrfs-dm.rules 64-btrfs-zoned.rules 64-btrfs-rm.rules
 
 ifeq ("$(origin V)", "command line")
   BUILD_VERBOSE = $(V)
-- 
2.43.0



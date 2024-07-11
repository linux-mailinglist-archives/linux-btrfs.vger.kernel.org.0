Return-Path: <linux-btrfs+bounces-6401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6192F105
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 23:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86F71C22A68
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 21:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E919FA6A;
	Thu, 11 Jul 2024 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="o58LGTNu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+z5vey0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733D19F495
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732781; cv=none; b=fIQ8nWrmK/pc/B+v63BKumDxX0pKupYpxhWVHZZ0NmKf2u3C0YK2w2wyilbERWXKC68wxvu+PXm5gBInuBJtjkV7BpzeBMm6LXGdGchh2B29N4mNRpIOCqtc4Mqo3PoSE+yH8DK/pfSPzLtPTIO/6XV8KVL7CYdwXhm/lhPPp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732781; c=relaxed/simple;
	bh=xMgFMFskfJn12g/h9hoA3bpDkoj45ReCXgDBmB8OK6A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1m+yELLtu352oF26q/JhJyYXSv89iRN7z9Xv1cVT7RrP/VK73YnBzFcU6srWIeMqJ7WSNiesAZe7X5or8uVmyxi5x93gUBayzv2MQ3nOc+XcXMnSV5iuPTkzE+11nHenp8tAwJbPDhWHe8SygG66hSioJILNVA1q9bdhrx1YZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=o58LGTNu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+z5vey0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id EADB4138844A;
	Thu, 11 Jul 2024 17:19:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 11 Jul 2024 17:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1720732778; x=
	1720819178; bh=4a5EDw9UKuuIQenBbZm9oqKLja4k1hg+VQfwFBdgc6U=; b=o
	58LGTNulzMmBFF7gA1kyFsu6dhi9cEypCv8WhY6D3/TyWm6az4RwFd8pl7HfhYmB
	x81mG7cPfzkTfIoSmMyu92smXuBA5mXjvQl6wY7DUf5cBtH20GQBjhynCX4pPa67
	sfKszszlFLJxVtFQXXuAQW2L2FNAyHS6doicOKIz3uSo/gqMlN50hSkRO2CYhicV
	UBayt+Qe4uHfFIJuTL/JuEzwqGMzrY8rUGqig6cdIwhpc8vCIcMrZ3BgEXX7E4d2
	7gDSGAodN1kzbkZsIFI1ZKB7V+qXl5g4swmyDsawKCRoGaxx3Itk4oaEqN4AObIK
	9ZjvI/nAqp0epTXKv1JAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1720732778; x=1720819178; bh=4a5EDw9UKuuIQ
	enBbZm9oqKLja4k1hg+VQfwFBdgc6U=; b=b+z5vey00vKDgfSainU1VV93BMEvy
	/7KaX5qaHu2jna4UKhd2svwUia8ooDC+drFNt1jCD4vvJZ8Jo1Jn/w84TxC6GyCh
	50kgE9zJZZFJZuvhaVtXFZ7qRPkyD1oijITHIOQOVHpXGqnQNnwamSMlPn3/+5CN
	bqlgK70iD4rijdg5hRY1/CrQgwcPdGCPLBC3/pWmAySg/gd2EFsrhhaF2N3/baFD
	oqr3RN6J63y3flkIUUbtJFv7nwC2W4bFQn+jR+0vTCHi4yJUhYSIg7csXPpKMs0y
	1j0xPvUMlaze9sj5oHVHtb9rSutryTg/wMlvThk/g5lQn8zu8GXeFwbKA==
X-ME-Sender: <xms:aUyQZnRLNGRnSWnwc6ZZaE3ljjbKVxmvuyXxlIFy_THJyMpxzd0ZAw>
    <xme:aUyQZox09BTv1ANlfv_oRlkzRRG1FuXibXUK7JY3cVFAnJ7RPi7s35jS1TFVyJ1Aa
    nvBUCssIMi5rPRRlx4>
X-ME-Received: <xmr:aUyQZs2_O12Lqh9QDT1771KmEmEJ88GjzaHfidRcFNkyx5ZJWqnNNljAAON0gw1sAJEvcjSOaDk3XayoxEISGUwzZ7o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:aUyQZnBEojyjSi__4l0YIgFWix7SGoDQ5_c7Zr6BBQTOzpkHH4pZXA>
    <xmx:aUyQZgiIFw4JftsCXRxrFXinBGeTVwp8oHvQ8OjFIkNtjhuwQ0uzFg>
    <xmx:aUyQZrq3gvxu0Lj-p0L9jJN4nG7tASIqg17n172qTgFib1NU7xFjyw>
    <xmx:aUyQZrjnzhIQU4cQ1lJeXw5172KmmUoIdnNSrg0GHM9nfA3fxDmSmQ>
    <xmx:akyQZjuOeMxamCuUzjsgLWMJhwemOABpPv2IZ6V-UWgIXSDkVtr024GU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 17:19:37 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/3] btrfs-progs: btrfstune: fix documentation for --enable-simple-quota
Date: Thu, 11 Jul 2024 14:18:23 -0700
Message-ID: <e30318f3bd2579e9492d2e1e0fd4b408c2bd0fb9.1720732480.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720732480.git.boris@bur.io>
References: <cover.1720732480.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation lists -q as the flag for enabling simple quotas, but
the actual parsing only handles --enable-simple-quota. Update the
documentation string.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tune/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tune/main.c b/tune/main.c
index bec896907..cb93d2cb3 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -103,7 +103,7 @@ static const char * const tune_usage[] = {
 	OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
 	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
 	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
-	OPTLINE("-q", "enable simple quotas on the file system. (mkfs: squota)"),
+	OPTLINE("--enable-simple-quota", "enable simple quotas on the file system. (mkfs: squota)"),
 	OPTLINE("--convert-to-block-group-tree", "convert filesystem to track block groups in "
 			"the separate block-group-tree instead of extent tree (sets the incompat bit)"),
 	OPTLINE("--convert-from-block-group-tree",
-- 
2.45.2



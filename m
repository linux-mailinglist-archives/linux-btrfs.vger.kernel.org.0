Return-Path: <linux-btrfs+bounces-6140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868869240F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E496D282560
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E381BA862;
	Tue,  2 Jul 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="eBpD41HC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jqlsvEkA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7371BA081
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930726; cv=none; b=ITYTSOhCtxh1wQnFVcSwjWs8umckyttnhPflGBqWSn8HB5TcYoggICOgpRJJ9rvrr9yoNwn9zjMyL+ukq/Ybd4fhGUjHvRZLXKjkG15YoqC6UzyOhI4FDH4BBsRGAmyAOV9NCpU7+rHe/8oLdhFuOLZEa8suuRwjv//2ug/h2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930726; c=relaxed/simple;
	bh=9XqTUNsOes+w13NWsWxCwmWpmT3I2mVvGAYKAe0nbBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbCD0bDuJkUPsyizwesDvxORHDkJV0iz1JnFfo67aqQkcmZASneVRjzB3QdXu5+GkvsXVlB9e7e6zrDqxnM1NC18gKDbilE9xQYFz8dBaCuXBA2dF4QJJ0ssO0C8VaHBi5Ip3Rx+HI/wBsX4PFuzzBIGKBIqIsoiYCmK+djOCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=eBpD41HC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jqlsvEkA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 644751380226;
	Tue,  2 Jul 2024 10:32:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Jul 2024 10:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1719930724; x=
	1720017124; bh=KISj5SoyBtiCcRfqKRNlmWKKIEYm/WnavBOTH+H6UFs=; b=e
	BpD41HCnxviblo85cr/TE+S3yqbVcf33NYFG9jYeiaNM1V7if27y4NgyZz5ZpgwZ
	9yAP6l7fLDpyyCP2yrylnPbtX3OgtJV/hozFl2Wy742IJskihaSj6rlODmplf07Z
	Pb5wokEJBj8f2r99Knlk7AMv2q7HXklZ4h31E0X3W8WkUS+7Q9JOuMpSr3Nizs6o
	KM5BKoduO6+goDg5owmweXendatVUloPXAQJfeDGDwtzoNl57eOm+VfRwhScqKo7
	bCHUK7EysSuYD9K+TznVj74FLL9y9SoS1CeFFfdVwT8qvMjz5U72ruXTPevL1jOT
	DNKymg8qK6w1o5qESCE5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1719930724; x=1720017124; bh=KISj5SoyBtiCc
	RfqKRNlmWKKIEYm/WnavBOTH+H6UFs=; b=jqlsvEkAaZg+2c0dCXKx0GKPreGjX
	6EM7F4z6QXGXXDGjbZCAcxVDJlL2QGYMrkW0meIV6E4qRZynMJtK1IDjZd2OEApA
	81K9TybPE07bkWjls/eHCJ+QOJ4cDngxOBhtdaA9h6ACC3qlcK7bDShBXrEcAXNW
	/EpypW17WQCkPzyb2B3u9PwDF+58P4KE2HjKCV7UEXn1f3mGjUuDawMv5HHW5JSl
	yDBPBr8p9wLYqvY/N8kXcM4ol5ORXS9fLgI/mQ1SzBoWF2BjJnIRA0XQvUsiPlxe
	lwz4SsUCxIa6rjPpjs7fsGap7VpEAXwO+FZ8ySjmnOw1Lz01p9IX4gyLQ==
X-ME-Sender: <xms:ZA-EZn5H3g3L0ZZ4zgC8XAjzerbxE5as5ZuLqNrLbg9Td3ftNpDjfg>
    <xme:ZA-EZs7A_Q9jXfKP5KeVoDcVaY4jE4yEc1_ps08Tj4cvh7rQLcezZBzVtjJmaWZaV
    lYdUlwaPxyPZofXUL4>
X-ME-Received: <xmr:ZA-EZueDjCP-HErNtTJoJFGICszqh7djqMYh7QR9GQ8e1RLs_OGzv29XL6Xq0bw4dRJz8mzVX5J8OpZ6MlzkUIiNApw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:ZA-EZoIfLZFKFtQ0mkWckrAn7DxdjDSoqzo14daILmDhYGidetbQNg>
    <xmx:ZA-EZrL6oF4LvxGim8EOy4nWxFgl81PJcRImzVWOKdaEzuqgcKcOng>
    <xmx:ZA-EZhxGxeTcCzKpuFrBqPi1_7DSd2QI7VE7oJ1D8MR7AgRnCW6vdw>
    <xmx:ZA-EZnKTaQHtL1fawF33AtrgAHGYvMNGmIfd8hOSlibsM-4BGx6BFQ>
    <xmx:ZA-EZiXs-bTmY_tDtX5reoUV1MthAXXgNkqJkHGZ66uKhAXFGYui6fH1>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 10:32:03 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 2/2] btrfs: fix __folio_put refcount in __alloc_dummy_extent_buffer
Date: Tue,  2 Jul 2024 07:31:14 -0700
Message-ID: <a6388a5263792fd161ec19cfc68c4c5235c6b828.1719930430.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719930430.git.boris@bur.io>
References: <cover.1719930430.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another improper use of __folio_put in an error path after freshly
allocating pages/folios which returns them with the refcount initialized
to 1. The refactor from __free_pages -> __folio_put (instead of
folio_put) removed a refcount decrement found in __free_pages and
folio_put but absent from __folio_put.

Fixes: 13df3775efca ("btrfs: cleanup metadata page pointer usage")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d3ce07ab9692..cb315779af30 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2775,7 +2775,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	for (int i = 0; i < num_folios; i++) {
 		if (eb->folios[i]) {
 			detach_extent_buffer_folio(eb, eb->folios[i]);
-			__folio_put(eb->folios[i]);
+			folio_put(eb->folios[i]);
 		}
 	}
 	__free_extent_buffer(eb);
-- 
2.45.2



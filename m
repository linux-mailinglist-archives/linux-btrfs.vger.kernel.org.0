Return-Path: <linux-btrfs+bounces-6666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662EF93A987
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 00:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF466284333
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2024 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71914901F;
	Tue, 23 Jul 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="aOPm6Gso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ntcFpM+T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC7C25760
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jul 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775441; cv=none; b=i1a2leQR3NXrvGAB65tUaAYqYXIqRGJNi7Cz4glaAKs4WvEuc7tG/e+g6JkK889V1CFDWYlm/HT1CXfw7/bCT5sf8ypDVYneUQAf9O8KYEpy7gJcZGPt63t1p6fZXUGytOCAsRDN/WHjuoni5kgNyGF7KXFuTJQEQw6FNONJ4HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775441; c=relaxed/simple;
	bh=RICpQRcXi5G4Knkuz4AFiOj579RapFQrDU9S4TbGNSU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nenGxDSBEAw9rLHozd+0609V0aZcFGX88K77ly54D+rrcfvZi1LF4ZZ7tVKyvdJfd+6cH5RUjuetr3nNCSmD4tS0+SDE1/n3Jqv2lKi4CNPYAOhSJpg5lzQxxZD+RVHhWKs0z+vOPX2Dg5LzoMabAUwIJ9Fh23s0s2nEbeNqvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=aOPm6Gso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ntcFpM+T; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A4A2A11400E4;
	Tue, 23 Jul 2024 18:57:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Jul 2024 18:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1721775437; x=1721861837; bh=/B+R904tZqVdhA3I+DxB9
	Nd9YDYLNAomNr2ygV2dSGE=; b=aOPm6GsoNVsyQL72y9pJClKC3dPFvV3APEYGh
	H5DnW+iXPHesDw5EQyPDJfbp5KNK+qvRFe5aYsYo6vKsBzoxVQeY1uyhor7v2S/G
	4BsKNp22KZgUKRx07QZhhVb2+8McRhxQC7in+KZS1ovdtmCr+k4d6OC7z6NmNpl7
	gM9OXnav0ylwdWvWoQISRTSfPz1kPl3Yk2hhWWt5xve8WXiZyn6TUGT4NSnCBqGq
	eBdErH1dzKtkJuZFzcboI0zLjd3NxfGXmyts0MVVR1heFrrj4zDUqTbdSTNI+Kaq
	14yqOspbSsWzwP70KfT7IfZCROfr+3u5V7DzHSyef7ZtQUYzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721775437; x=1721861837; bh=/B+R904tZqVdhA3I+DxB9Nd9YDYL
	NAomNr2ygV2dSGE=; b=ntcFpM+T5Ds+dsJsqljJYEKLAmFGI5fJOntJ5bDRuKbf
	97l7MDdUsx0PLY+rpOj7VuNCJsuMMOrdGfHum49JX3TauUsNdux5tHvi7pNuKeil
	SdraUQSs7iaHdEqNZxUHM23/pfoFiAVIWr1jnmKw2doW0yMQWqVwptWsK/aaWYtX
	3vbfFWJtKcA+JQdae6raJVtLnzJk2AJBdPTWu+wG6XTlD2HBoww1k6W+L7sz6Vxg
	1lHetjEYlV/i1hZtdR+g5zFoRWmyDPqhprL2M1/xuS7wYjtaOjM+r2kRY0bgEKSP
	x61cQN5vlv8AS7K2hbZMr5ubRC8kr+77AHIhRdev8g==
X-ME-Sender: <xms:TTWgZmk4qL-nySK2ehvtE2yjkbkY_Pc3XVmybLJIyvfprIFySrRm6A>
    <xme:TTWgZt12EBSeaVFkD4Lhhex8pANvDnzp0-4-I5BGNdVJf7JhwfmWMDlBA-YYSYPqg
    rFvZAMSDs-JoWhrgLU>
X-ME-Received: <xmr:TTWgZkqC6YabN3o4e9yGI_fwEPr04Ngdla0sEztI1vTNDPXOnFCiMtuA_8QP4mAyv-mc9Lbx-5MB_y6Vp5nNHjFdAjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:TTWgZqlhlsnJcbI4aX2UyH8tKRwHFwyU40rLrKC6j1szBJfmJ0mqxg>
    <xmx:TTWgZk0v1cJr7T44bh9-H93T-YM1mmj5TTBo_9j0onpQcZouoTnaHQ>
    <xmx:TTWgZhvuJl-ch44-L-iqNwzQdy8mKyTAN9JOfmdKE30kvXq6RGtLvw>
    <xmx:TTWgZgU1Aduq1ibxsPiiVT3USVfUMCcNmJSZRuYyIfST9AEuK58iwg>
    <xmx:TTWgZiD5x-vH2aEo5Ur8f14p82AshJB1zAgJHgiwptH-PIocYneDxVLp>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 18:57:17 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: fixes for buffered write qgroup rsv leaks
Date: Tue, 23 Jul 2024 15:55:55 -0700
Message-ID: <cover.1721775142.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/475 exposes qgroup rsv leaks under EIO errors. These are fixes
for two classes of buffered write errors we are still hitting:
1. dirty pages leaked during an aborted transaction
2. dirty pages getting un-dirtied and leaked by cow_file_range when it
   doesn't make an ordered extent for a range.

After these two fixes, I was able to run generic/475 with squota enabled
at mkfs 100 times in a row without an error, and a modified generic/475
that always sleeps for 0 seconds 500 times.

Boris Burkov (2):
  btrfs: implement launder_folio for clearing dirty page rsv
  btrfs: fix qgroup rsv leaks in cow_file_range

 fs/btrfs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.45.2



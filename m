Return-Path: <linux-btrfs+bounces-6150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BA924386
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 18:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77012882E9
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453151BD4FE;
	Tue,  2 Jul 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="SVNLP5d1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKd0VzwC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF41BC06B
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937714; cv=none; b=HKBY7ukwTOn3QMTjDC9+GWsOYIALrlEtUAhrefn7ebbtlUE6d2nA+6wwYOPP6ERKnXayn38al6jKD1wKltCurc9BxSbZ0v89vpOSXsNZEwkKw/V5ulztLxB+wGC152vWhJVJZ3WZK+3CVolVodDI8FN18F0IPAJpVnLi9mc7Fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937714; c=relaxed/simple;
	bh=yIVolV934SmJIMWY/2GeEGJI3dBAmGZJ87922H+vV3I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TYzltIt8d1t6WN/3GCJJ6rUIKyMy0HNcHbSo5nLdMI1M//hCY2FH/ECZFDIE002/GYdSbe95knZjd78wSKuI0uuowBDAzlc2pFzgdnhX+amWihF4su8cBTFrQQ7NqcAzrbnPyXpmcRP8+O65Z360dD7KH8KN+3FzLH8aGQIvgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=SVNLP5d1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKd0VzwC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3D4AD11401D6;
	Tue,  2 Jul 2024 12:28:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 02 Jul 2024 12:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1719937711; x=1720024111; bh=NvOz7fma2xQ/fMRw2COcz
	9V33Bd1vysUMM3wClebRVA=; b=SVNLP5d1Zjv0vauj+MiM8aEGQ4gaWV+4kXQ5B
	SxshNBSvoXnBFYuh/Q4FP65jSDrPJozEIS+PsRPy/KpPTPFwkxjj2Ffu+m7Przpq
	+fV6cGO/LnrUjQVO/Hyu6812meeBFp4hhhb9NFPMP/3MjkUgUMyX0zIuSpdejtUK
	zTMPn0eqUotTOJFpc1vMOolT+ARVGxPgxOXttMmFWZoqau701IoGjvY8gRjlBaSV
	L3jIHNsx1i5iLtT2n8u8W0KUSY6mdUCJx5Yupv9WFQgBhtFyKvsAJetzEsHmMBqz
	bpwEvNyfSijj9Fm+L+mnBJJKZuyaPdfFlml8A5Dhy0AwcCG6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719937711; x=1720024111; bh=NvOz7fma2xQ/fMRw2COcz9V33Bd1
	vysUMM3wClebRVA=; b=eKd0VzwCSYw7qaxfKRiySHlYxQSFDQ8swngothz8eyQR
	5eaXWkoElkMOTM/tDVzWWmn2erdOusaOG4x8OnYHgI/jdjCY3Xx+RWBazYGqJFzz
	ErbfZnpT2bM8kOHc/ss2R3h1NithoeoMf7oACCkI7vl5EtU79W8gF5b2awyDmC+c
	f4kLaxNuIoI7u9Sv5xqw5+lImNOHaonj4o33+T7FpvN0luJxzReCp0ew1Id/BOye
	6KP19lUog0o4N/iO4g8BqXfJVKOpNdu3e/DoGb2ojSPNYJMRzYKLQJZyIQ0BZWdL
	IF3NCqfA+49BIJxUaKr5hLGAnE+cX73LZMRECXcRyA==
X-ME-Sender: <xms:riqEZvBdAJ94P9pONtV5jkBZoZFMkSFmIDucYqI56LfpkbtF1E4FqA>
    <xme:riqEZli7wwhQAhfJkd4oTNHoL83PfkQGJDFdjP58IgsHPyPLdjlwfKX3qG7MZXEPz
    nbhLPh6XzYkHVKgjz0>
X-ME-Received: <xmr:riqEZqksKJI-CbnRP9okFJZ458aQjfwvSkIp9Aftfwb_hxbpHm22k0_0Oo-HXRGb8ZGd2xdtqWFE4kg0uLneE2e7P_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:riqEZhxG6lFZ-mDVZbtdzI_PZedwZZIFSoL_69oGIBNEgTlyFftLdQ>
    <xmx:riqEZkTG0IF_nF4SXFspGqBtxJQtQ1tZX9vrGQhow3fjLDV-Lri1fA>
    <xmx:riqEZkYfnBfItHQlekM_eJHu57WAwX2mbaDC5FnzowT8jtDTAzLRwg>
    <xmx:riqEZlTGt0yHjn7n57iqhJr3k_UjPZ5JdBqmUYvTWg3usBIgc4SZHw>
    <xmx:ryqEZvfXrAetWG4TSBGHtK6tD5wwb1BmdLHjMounVuzAcvoja5oyXsQA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 12:28:30 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs-progs: receive: retry encoded_write on EPERM
Date: Tue,  2 Jul 2024 09:27:49 -0700
Message-ID: <8c2e537199608a446d5f97ea0dda319d2b9c0dad.1719937610.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

encoded_write fails if we run without CAP_SYS_ADMIN, but the decompress
and write fallback could succeed if we are running with write
permissions on the file. Therefore, it is helpful to fall back on EPERM
as well. While this will increase the "silent failure" rate of encoded
writes, we do have the verbose log in place to debug that while setting
up a receive workflow that expects encoded_write.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 412bc8afe..9101e8ccf 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1285,7 +1285,8 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 		if (ret >= 0)
 			return 0;
 		/* Fall back for these errors, fail hard for anything else. */
-		if (errno != ENOSPC && errno != ENOTTY && errno != EINVAL) {
+		if (errno != ENOSPC && errno != ENOTTY &&
+		    errno != EINVAL && errno != EPERM) {
 			ret = -errno;
 			error("encoded_write: writing to %s failed: %m", path);
 			return ret;
-- 
2.45.2



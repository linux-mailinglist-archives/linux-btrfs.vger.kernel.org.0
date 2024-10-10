Return-Path: <linux-btrfs+bounces-8807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98AB998BDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B331C22895
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E211CC16E;
	Thu, 10 Oct 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IUMRnvZB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9520DD2
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574606; cv=none; b=XIe+Ph8OITzwxPw1XP2QtdEmKxbglIYp6/8FeiEbJK0CniQM3ezBG9+wN+dobu5qcH8ThP4R8SveqIBs+7PHJvWxTdsgpncFlDfCo+/4F1pTFY/FOTfdjG56konkqb7q0NOhLvlm2OJVJcdl8KDB+OEpNprCWqXNS0pg/zlTZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574606; c=relaxed/simple;
	bh=IvCvwm5EiK6Blt8R6tOPcOuq1qSpkIVz8Ozx+1wkRKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JHCkrOEgzYldbCVq5OF0qRPoQY5WYEEoKfyNxtp+copIlX6jSKXerz1+bNeZAZzvADo1msjOkS0eWop2qmWdvWM2tWJLwiTxb62b7qhX2DyN4huE9qxThF2FvfERjkLjDkYKfxrucq5q79CVrTy6UnMPUTVbJ5r7HS5rhiXgUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=IUMRnvZB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AEOAMX032391
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 08:36:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=VUPwEcuT3FQ7HzOXxnGGGc7
	agmwlKVlRa+zqVyw2QgA=; b=IUMRnvZB5KfsBQbj6AGdzEYBcJ922Hl1m8nyDsq
	DGi81Edv2TxFp7xii6HmR3uES14gtZR6hEYeGvdn/0+O4Ucn3v1HU/lXJQgBZRyl
	iylDoMOrR/rnsd4oqOwk8f+N9Y3Ig/VjGXgC1NQBffbCdY0PQxgSeokSJ+c4f2YY
	jFCA=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4266erkg7s-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 08:36:44 -0700 (PDT)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 10 Oct 2024 15:36:42 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id DD6567A273D3; Thu, 10 Oct 2024 16:36:38 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <fstests@vger.kernel.org>
CC: <linux-btrfs@vger.kernel.org>, Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs/318: add _require_loop
Date: Thu, 10 Oct 2024 16:36:25 +0100
Message-ID: <20241010153630.1225162-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7Awdg9No7SewN4r396moKMD2UbAKMbL-
X-Proofpoint-ORIG-GUID: 7Awdg9No7SewN4r396moKMD2UbAKMbL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

btrfs/318 uses loopback devices, but was missing a call to _require_loop
to print the correct message if CONFIG_LOOP is not set.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 tests/btrfs/318 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/318 b/tests/btrfs/318
index 79977276..df5a4a07 100755
--- a/tests/btrfs/318
+++ b/tests/btrfs/318
@@ -18,6 +18,7 @@ _fixed_by_kernel_commit 9f7eb8405dcb \
 _require_test
 _require_command "$PARTED_PROG" parted
 _require_batched_discard "$TEST_DIR"
+_require_loop
=20
 _cleanup() {
 	cd /
--=20
2.44.2



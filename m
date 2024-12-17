Return-Path: <linux-btrfs+bounces-10504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD369F55A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 19:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976F61898871
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 18:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076CC1F9EC1;
	Tue, 17 Dec 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k6c6RRht"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6731F8926
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458557; cv=none; b=dAeorLSS7faBCkcpeMUWymIUBY3esFTPJNla2fLa54n50m3sOvdL16xdUQYVUGqHN3Zjkpe6jjPjYREXEEj7Z3OKnWEusirtb15ZuhI6CdzGs6DlyRUGh1hB/g0zJ7vrq9bK7rkgSQm8sT8B7GxhJW8oCtGs6/LqTYnmVB+iePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458557; c=relaxed/simple;
	bh=MRZM34NMV0EgI7G+9M5FBvWGqIbheVLEfaJJi05jtzk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfCfb+TyQWu9sMEZ058lt5h+Vt9+okBet+emqbh595vELgEkPzKg//e8r970NdMbd6f8WPHrXbk5EEo6Vf6BcqwdM+9v0TKoF5hJE5UszdR27wqu3lRE7zMWSkU0kPID9E5x7jSFOu6kOP+P59vIhJiynjc0YWkkpW+nmZ5RhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=k6c6RRht; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHGs0Od000365
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 10:02:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=u
	kEv+MRk0M738B1YTBkjNZ/0oAAvdQd0LX84fQr8t2k=; b=k6c6RRhteAfQ6Cq7u
	4j9SfpH/3mFWZ30k9JrJ8AT1CIrxl7CIZAR/auHTuEezOSXsYTtOxszwCsShSfmY
	tBz+GJT451h/ADuKavztTYwN6l6pObhB3h39kWeKS/H8KLdrbGLY+cBYafu7O9Qj
	/udEzeC2FtDcsY8zGarSu3doMQ=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43k71sk7sp-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 10:02:34 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 17 Dec 2024 18:02:26 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 5010A9A41150; Tue, 17 Dec 2024 18:02:12 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v3 3/4] io_uring: add io_uring_cmd_get_async_data helper
Date: Tue, 17 Dec 2024 18:02:01 +0000
Message-ID: <20241217180210.4044318-3-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217180210.4044318-1-maharmstone@fb.com>
References: <20241217180210.4044318-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8oCy2CCV5MBLXqk9u91GUKF6heT4UOQ2
X-Proofpoint-GUID: 8oCy2CCV5MBLXqk9u91GUKF6heT4UOQ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

Add a helper function in include/linux/io_uring/cmd.h to read the
async_data pointer from a struct io_uring_cmd.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 include/linux/io_uring/cmd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index a65c7043078f..a3ce553413de 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -118,4 +118,9 @@ static inline struct task_struct *io_uring_cmd_get_ta=
sk(struct io_uring_cmd *cmd
 	return cmd_to_io_kiocb(cmd)->tctx->task;
 }
=20
+static inline struct io_uring_cmd_data *io_uring_cmd_get_async_data(stru=
ct io_uring_cmd *cmd)
+{
+	return cmd_to_io_kiocb(cmd)->async_data;
+}
+
 #endif /* _LINUX_IO_URING_CMD_H */
--=20
2.45.2



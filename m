Return-Path: <linux-btrfs+bounces-6043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2849391C1F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8F5B261DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE7A1C68BB;
	Fri, 28 Jun 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HrTU1wE4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF71C68B9
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586714; cv=none; b=tQSWIERyr6MQy74R1ODtnK6KyRGEgtlq7ovsZYwNkj2mZxyUlwzMC6CsLvqbMQ659Z5WRHxuuRvD833fJNDhKDobMAEq+kGURI5zS+8SrCawHf+KuodxJU+Lv6Q3uOaYHWnWGGheGrxEaxuMMO6H/xwjinDAggtJ7/oS/087/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586714; c=relaxed/simple;
	bh=NtEtPWvsxmVWyy4w3fVOenXiJbhO7hZraXQ4Ez9RWlA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KacylrBJteKItqEpwBJ5JPJmEajtXKXKmJaSq3TygdgM5pT2PbCOa4E55/GLRKfbpLLxiRbygaXpas2A9gGNsRkzcrLfkOt2GS6owbKWHvavlVoriR5hpiMmBAY+5Ueq0zxcgxj6PxA9lxJHX9dtaolN8EPSxvc154RMdlkuHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=HrTU1wE4; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45SA2jTH018809
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 07:58:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	facebook; bh=fq2RARGJLAIaGPU2hIBTWMU+BqSjCIkayOAfbVai4SA=; b=HrT
	U1wE4f7s/XadDVuOdorRcjI72qcE0qN9dvYk1VUaqaOkKhiRLnKKy4MD9rOHZ7EN
	/bm0IWwjR9+Ccn33iwhc0dFvt9kPMR31fLhkCw4ZIWyY+4sWGhpcj1XPzgTJUnVM
	txRMQdH2ByIhBkZmxZCqWQdU/STqzbh6zhYgNaYg=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4016w2rn2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 07:58:31 -0700 (PDT)
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 28 Jun 2024 14:58:31 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id DAFF93B2671D; Fri, 28 Jun 2024 15:58:19 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Omar Sandoval <osandov@fb.com>, Mark Harmstone <maharmstone@meta.com>
Subject: [PATCH 3/3] btrfs-progs: remove unused qgroup functions
Date: Fri, 28 Jun 2024 15:56:49 +0100
Message-ID: <20240628145807.1800474-4-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628145807.1800474-1-maharmstone@fb.com>
References: <20240628145807.1800474-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ySIBXkJTz9SbX8IYp8gbTVyhy1mUH1sg
X-Proofpoint-GUID: ySIBXkJTz9SbX8IYp8gbTVyhy1mUH1sg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01

From: Omar Sandoval <osandov@fb.com>

Remove functions that after the previous two patches are no longer
referenced.

Signed-off-by: Mark Harmstone <maharmstone@meta.com>
Co-authored-by: Mark Harmstone <maharmstone@meta.com>

---
 cmds/qgroup.c | 64 ---------------------------------------------------
 cmds/qgroup.h |  2 --
 2 files changed, 66 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index bffe942b..35b8c7b8 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -1688,70 +1688,6 @@ out:
 	return ret;
 }
=20
-int btrfs_qgroup_inherit_size(struct btrfs_qgroup_inherit *p)
-{
-	return sizeof(*p) + sizeof(p->qgroups[0]) *
-			    (p->num_qgroups + 2 * p->num_ref_copies +
-			     2 * p->num_excl_copies);
-}
-
-static int qgroup_inherit_realloc(struct btrfs_qgroup_inherit **inherit,=
 int n,
-		int pos)
-{
-	struct btrfs_qgroup_inherit *out;
-	int nitems =3D 0;
-
-	if (*inherit) {
-		nitems =3D (*inherit)->num_qgroups +
-			 (*inherit)->num_ref_copies +
-			 (*inherit)->num_excl_copies;
-	}
-
-	out =3D calloc(1, sizeof(*out) + sizeof(out->qgroups[0]) * (nitems + n)=
);
-	if (out =3D=3D NULL) {
-		error_msg(ERROR_MSG_MEMORY, NULL);
-		return -ENOMEM;
-	}
-
-	if (*inherit) {
-		struct btrfs_qgroup_inherit *i =3D *inherit;
-		int s =3D sizeof(out->qgroups[0]);
-
-		out->num_qgroups =3D i->num_qgroups;
-		out->num_ref_copies =3D i->num_ref_copies;
-		out->num_excl_copies =3D i->num_excl_copies;
-		memcpy(out->qgroups, i->qgroups, pos * s);
-		memcpy(out->qgroups + pos + n, i->qgroups + pos,
-		       (nitems - pos) * s);
-	}
-	free(*inherit);
-	*inherit =3D out;
-
-	return 0;
-}
-
-int btrfs_qgroup_inherit_add_group(struct btrfs_qgroup_inherit **inherit=
, char *arg)
-{
-	int ret;
-	u64 qgroupid =3D parse_qgroupid_or_path(arg);
-	int pos =3D 0;
-
-	if (qgroupid =3D=3D 0) {
-		error("invalid qgroup specification, qgroupid must not 0");
-		return -EINVAL;
-	}
-
-	if (*inherit)
-		pos =3D (*inherit)->num_qgroups;
-	ret =3D qgroup_inherit_realloc(inherit, 1, pos);
-	if (ret)
-		return ret;
-
-	(*inherit)->qgroups[(*inherit)->num_qgroups++] =3D qgroupid;
-
-	return 0;
-}
-
 static const char * const qgroup_cmd_group_usage[] =3D {
 	"btrfs qgroup <command> [options] <path>",
 	NULL
diff --git a/cmds/qgroup.h b/cmds/qgroup.h
index 1fc10722..32309ce4 100644
--- a/cmds/qgroup.h
+++ b/cmds/qgroup.h
@@ -36,8 +36,6 @@ struct btrfs_qgroup_stats {
 	struct btrfs_qgroup_limit limit;
 };
=20
-int btrfs_qgroup_inherit_size(struct btrfs_qgroup_inherit *p);
-int btrfs_qgroup_inherit_add_group(struct btrfs_qgroup_inherit **inherit=
, char *arg);
 int btrfs_qgroup_query(int fd, u64 qgroupid, struct btrfs_qgroup_stats *=
stats);
=20
 #endif
--=20
2.44.2



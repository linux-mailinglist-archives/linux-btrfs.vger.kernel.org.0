Return-Path: <linux-btrfs+bounces-16257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC71B308B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 23:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921121C27EEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27DC2E9ED0;
	Thu, 21 Aug 2025 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="tcq92e2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJgtL+uv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EE2E973D
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813457; cv=none; b=vAj4U9FkDB7+bF/Q2yD9KtnpeWUPUnJbd4ctgPBPSVazHAfLES8nzDo5V/MCIzAaLQwh7aHPMSMsTCwCCKB0GBGp0+ob7/8ezT3e/EfnS0vaSSaTfpm7ibUx1fS6D/XEbSe0FWw7iFWvlVO4f6qW/aQy+pKCnELIZ1jGXsFA1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813457; c=relaxed/simple;
	bh=mS8h8lde68mtugCHEHJIuz8Hx5kgtSFaeCq5LAOcpP8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tOXqBu+J/5ET0VJw1ijZlGqr21BMU1rQGHR8UMc0WGW3ntPxg0K45hswolPk47XLPv99W8GbDPBnk5rXpt15peLMyTsTlUxFWdk+BGIUwYtXXKYyWA4CQABr8OHR/hm4OHXaN9rEFFs4cEyzQQxDC0Rqy6tAo020++kAOCn4/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=tcq92e2e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJgtL+uv; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F03B7A0119;
	Thu, 21 Aug 2025 17:57:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 21 Aug 2025 17:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1755813454; x=1755899854; bh=+bvgI/E5rU2tXWXSGj0cY
	/9hJYLWl4Z+rV5zCLDeILw=; b=tcq92e2e6/A9XjeB7/YNqehGYuauXv5705Gj4
	Rkv+a5mY7rEK/7jAFqvgT7UvZ1t9KODNtkZYHnaCqgXuPlodVpzdVbK1JDdP8fGt
	umQ8BNFdVGykbIcVCeOLbZB8yZosWiN7fzoHl8WRdnM804Ex7pcZMcUaI6lWLg/d
	l1n6hjPVbmSnmXdX/zLuDdsvIuxAaQhMi6+om/7TmScGGspD1XGz98xXbEejbSAm
	rY4nbALC+0MWU7gHQj592IyY8VeKL/OgCgkR7rMk1E51OLpQ6gfr3W9cJMPMf6Ld
	CJ1amFm54g/eKD7OB5xsVvwKubR3zaCpfIZaUuWC/d/LChrQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755813454; x=1755899854; bh=+bvgI/E5rU2tXWXSGj0cY/9hJYLWl4Z+rV5
	zCLDeILw=; b=mJgtL+uvh5kZSwpf84bhAgP/267NFJAxMylEer4LzIU1z+JQtfT
	kuNQdpYnnNHf4r/dGRMleqJ18lpulCFhtvIiLPOIbvWwbv1KBAQbiVzPGt+5swT4
	XWlcfCGUtEtZ1v2DatgNVmKYO8HG3gR17mRPQeE0zSgbw1sEgfGDMzAoXdt4U/ZH
	FgPrE7mgmESJTGli4qy0t5DsqlFHSb2+yxpJb0cRfqElB3Ok4r3jY3Zhcrlj3C+E
	iCh3uC2rx68O3ShJuetxdGAj8Dwxd2/S6RyRHYe3YQEF+tphWgajKQ/x/oEC8o3B
	Cp6447NSG9zMoh5iwczmjMfHncUB4PofF8Q==
X-ME-Sender: <xms:TZanaNTFBFG1HBVVMQAltOvHR-dAJIua74gVAScvzGWThNEmvxnvRQ>
    <xme:TZanaG-pfTQgLin7wonj1kE2bry7IBK1_fabeZ-3AOutsouNhsWw3mPpYw2DpBRty
    c-FOuBIGdr9q-pO20c>
X-ME-Received: <xmr:TZanaEon6dsOMdEVj_zquIxmf6BRkJiKl2pBeIEvIPEwpAP8NaC50EQoa_lWDt8rkcA7bvk_JLgOkXjZITyzXaAvg4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduudetfe
    ekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:TZanaDm0kGmtOnJUrTvHyuoK1Auxay3CghO15CwO2ihPoci_K_vXHQ>
    <xmx:TZanaLLdqyRHc6XR1mO6vCXnvx7Da-N27Eq93MsQUOeFszEHAfNwcw>
    <xmx:TZanaIwDCJ5aD90I4fw2W1aPlwXOiuL36ajedtG6alUQCs_rXJuilw>
    <xmx:TZanaDtCe9sld5sc22RpWQZtPsuzhUsoF_gyZdwYvWS6pbb9L25ohg>
    <xmx:TpanaDqExZMBWNOIlCCWQ63IHm6lUMuPRt04CYB0GiBYuda6ay6KvenI>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:57:33 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix squota _cmpr stats leak
Date: Thu, 21 Aug 2025 14:58:04 -0700
Message-ID: <052d87d0f70d66e7f50c45e3ec095056ae0cb4f4.1755813444.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following workload on a squota enabled fs:
 btrfs subvol create mnt/sv
 btrfs qgroup create 1/1 mnt
 btrfs qgroup assign mnt/sv 1/1 mnt
 btrfs qgroup delete mnt/sv
 # make the cleaner thread run
 btrfs filesystem sync mnt; sleep 1; btrfs filesystem sync mnt
 btrfs qgroup destroy 1/1 mnt

will fail with EBUSY. The reason is that 1/1 does the quick accounting
when we assign sv to it, gaining its exclusive usage as excl and
excl_cmpr. But then when we delete sv, the decrement happens via
record_squota_delta() which does not update excl_cmpr, as squotas does
not make any distinction between compressed and normal extents. Thus,
we increment excl_cmpr but never decrement it, and are unable to delete
1/1. The two possible fixes are to make squota always mirror excl and
excl_cmpr or to make the fast accounting separately track the plain and
cmpr numbers. The latter felt cleaner to me so that is what I opted for.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6352cd29ff89..2d8667cc609a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1455,6 +1455,7 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info, u64 ref_root,
 	struct btrfs_qgroup *qgroup;
 	LIST_HEAD(qgroup_list);
 	u64 num_bytes = src->excl;
+	u64 num_bytes_cmpr = src->excl_cmpr;
 	int ret = 0;
 
 	qgroup = find_qgroup_rb(fs_info, ref_root);
@@ -1466,11 +1467,12 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info, u64 ref_root,
 		struct btrfs_qgroup_list *glist;
 
 		qgroup->rfer += sign * num_bytes;
-		qgroup->rfer_cmpr += sign * num_bytes;
+		qgroup->rfer_cmpr += sign * num_bytes_cmpr;
 
 		WARN_ON(sign < 0 && qgroup->excl < num_bytes);
+		WARN_ON(sign < 0 && qgroup->excl_cmpr < num_bytes_cmpr);
 		qgroup->excl += sign * num_bytes;
-		qgroup->excl_cmpr += sign * num_bytes;
+		qgroup->excl_cmpr += sign * num_bytes_cmpr;
 
 		if (sign > 0)
 			qgroup_rsv_add_by_qgroup(fs_info, qgroup, src);
-- 
2.50.1



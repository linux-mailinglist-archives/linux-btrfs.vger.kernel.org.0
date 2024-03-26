Return-Path: <linux-btrfs+bounces-3633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95F88D030
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9951F81977
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05E13D8AB;
	Tue, 26 Mar 2024 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DVIhybGU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMBjmUAw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73813D8AD
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489083; cv=none; b=k71+7p/aFpSDNUW3E825kalNUo2p7tmhLop+UMiaAXn4VYSTWL9O82lmT7dkzaGbGUAOpKKC3aBV39H0GzKo5i78pMlhEOU7ydgu7SjraZaUuIVFwWPGcuOs1KvbrWoKMO37Vm/1rT1HhB4+Y1ap3SEXxLixZzEOMibNJuXJvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489083; c=relaxed/simple;
	bh=35lYeW8ohyLvpD7bftw8CAefA0RFudmeiAAFSXNYZb8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c01A4c90cwC8agweg3HgA7uHzrgRtcm9BreynMfluT+ZWUBCWG8ZlJPq8TetrBL68Wha9levff9gryiNGYi8//DNnMohUDasvJUHTuwEOvxa+CRkvjEQPoPZr3Q+6VNWupaLcTKKiXZUWXIylO3P9JM0+tMLGdPzgNmrhy6woOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DVIhybGU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMBjmUAw; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id CDBBE320077A;
	Tue, 26 Mar 2024 17:38:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 17:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711489080; x=
	1711575480; bh=90Rix8vcflTSyn2WpOd0vyJFVLZvboKDerMb//5HB5k=; b=D
	VIhybGUp0I7cEC448VjOAgztSjNaiKh0X/1oy5p0njBnR5V7LTHg5u6qoL/padzu
	Xrt5yTC0r91fNBjRCrthLaalmNIExDsT6WmMz6I5lPk7L1Vsm2UJpo4FI89FmlNu
	L4B0yN9CQARF5j0g67YtJ3C93q3Aqj2kW+RFjbhu9PqVE0Uaxqo75nHXn9aXv4Rx
	Ch5tEz5fxP9uUOZh+ePTiUTtJ0XqNQcAv86QqMCqGWsbMsKDbcBWLsz5VvBeeJ3L
	JNjwPkTcGHsiYOf4/z86bp7Kqdgp9TsD3d3MzeDfaUR8T2rLigN3kVNvUjv62gEp
	Mpky53ybAsdwsIXmvClUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711489080; x=1711575480; bh=90Rix8vcflTSy
	n2WpOd0vyJFVLZvboKDerMb//5HB5k=; b=SMBjmUAwRx6iTxAIfL1TDOqCgfpyr
	RUCU+rf6nHjiw2rN5lVtysNrxSTbMvUYXpjysrBs93bLBCGaT/jTcs4kJW+uTs+U
	mTEbLNIj21lrulSLL5pHYVyHAjO3DrMkzq2Nj4NVcf+YSFGaekBmZ5adGwFEvnEn
	YZdZg/5VFptmUbz40LCcZu4n2m3kxzknnVO31p1nAtLiBg276mMNSvX9RYcsb70B
	ydLnQee5i3yXhiHhYq9gT/08oM1Uh5TFTbE6RQyGJI1twCFh6Q5AP8KqrWNkrYSG
	sthcl6m9dT95AyLJxYewl0Qk6fMRMJzQ8LT6kGTS4wzKuPpW6NJ2hS+Og==
X-ME-Sender: <xms:OEADZuk4lf0FuQ0KyljAJZNP4PrPw8VIytXepALqS5QLbCasNWesNA>
    <xme:OEADZl2tbNas8j-nNCbMVrf4UiBPjqAYN9GE61MeBWbn3KyHbVdz1nDGc9W3ro71N
    1CFEcMc3kckbldWYS4>
X-ME-Received: <xmr:OEADZsq2I1-oYLq2W7tSG0nPYfMErbilLSBAR15LEi1kmTsy3miaf2NqvFhJgAB9KULB7xUdpCWnvSlbea2tCILRnpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:OEADZim8iYvV208i0-j1NR6tcxyh6UgODrbtMMMVtqh0EkcYD0aSXA>
    <xmx:OEADZs23wWhgyaKtt_Ebg4ZwL-Ku0zRsOmaTV3szKKcIQVwZHRBVLg>
    <xmx:OEADZpsMgF2euyUm7HiZmrWnEHtYVNKdaPTRXCPG8e1lA3mzOaUWDA>
    <xmx:OEADZoUxWlZ03nKtiUbOO-ikwRLVuv7AcbWXzQZoUtQbhHpdPalRQg>
    <xmx:OEADZp_D4kwC8_n4W3UhcQprYjbgXoanpnOiEAnDkVsNRpiV6md1vw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 17:37:59 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 7/7] btrfs: always clear meta pertrans during commit
Date: Tue, 26 Mar 2024 14:39:41 -0700
Message-ID: <e38da2f7e722fbbb6e7653e69f1d28aa2e9e3bf4.1711488980.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711488980.git.boris@bur.io>
References: <cover.1711488980.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to clear a root's IN_TRANS tag from the radix tree, but
not clear its pertrans, if there is some error in between. Eliminate
that possibility by moving the free up to where we clear the tag.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1c449d1cea1b..df2e58aa824a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1494,6 +1494,7 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			radix_tree_tag_clear(&fs_info->fs_roots_radix,
 					(unsigned long)root->root_key.objectid,
 					BTRFS_ROOT_TRANS_TAG);
+			btrfs_qgroup_free_meta_all_pertrans(root);
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 
 			btrfs_free_log(trans, root);
@@ -1518,7 +1519,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 			if (ret2)
 				return ret2;
 			spin_lock(&fs_info->fs_roots_radix_lock);
-			btrfs_qgroup_free_meta_all_pertrans(root);
 		}
 	}
 	spin_unlock(&fs_info->fs_roots_radix_lock);
-- 
2.44.0



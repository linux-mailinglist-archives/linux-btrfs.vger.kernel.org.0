Return-Path: <linux-btrfs+bounces-15773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C14B1692C
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 01:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C4B18C72D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 23:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487972264D3;
	Wed, 30 Jul 2025 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XWIfssmt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JFv1E0Ce"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFB156678;
	Wed, 30 Jul 2025 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916523; cv=none; b=j7uTHnn5In+vTVuNXdmPcFg3dIGrzUG+841nx8kiRbfQCnyLssPrH7Z5lfvWF6MnvcZbIV2jZthl5DISACcNE1ypyE2XveCAgSppOYiyiY981VCDSbUvF8EvKBe17YsG9zXKkvbEiqMHUHdCyLHLm+ZijYnPFyul+u7td2+2o44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916523; c=relaxed/simple;
	bh=7MTwhLj0hm0azTSYEeCACtYpo29YfBtnF7g6K0o5UOI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OUu0zEPp8EdU1/Qx859B0OwDli14GONWMEY3Z1jrlzlgWFTxZerCD+cs9iTYysZS5gkeZW/X+r6mAK9ZhSOe+5ozNNEPeSxhw/q1ofehWnS8bEGa8fk7UaqS3XoK1n6RXgorPjy5/vLdkxfUlFLTKcHspdFcyi7R6DvUAvnbWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=XWIfssmt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JFv1E0Ce; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B6EEDEC229F;
	Wed, 30 Jul 2025 19:01:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 30 Jul 2025 19:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1753916519; x=1754002919; bh=mtG40nGTj+BX+M1Z5XQGW
	Br3GjPm0Z3DHmgSRL2HcUo=; b=XWIfssmtQAKUke8Khu4+9r6sCBw+hI3aOBhoF
	xmXDgGZJLA58uUQwIIJpQA8fMEsMgtg5eiQ7f591Tu61THLILz5OMZg6766+K/5d
	YvSPTOkiZoo8mp9UvLe1SRS/064O7Dt3qftoNB/Ze6m/9Q5bsBBZYk+9JtcuLWNf
	2QLlK77fRherjqzVOufTq3xTfzeMvqAqqnnYiAfZp+UR/KToyvRKwa2U0Gb1n7uQ
	ZsahLJXB0R1OAFUK3tucLNGE9pWB0NDTYTG/tq0paLaW4hn+dBs8fOhLqNDl02ed
	Z/11ZbgQ/+PQzkRg1xl1ZMkarRbQXWTiLeMAZ+41/Z3fcHaVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753916519; x=1754002919; bh=mtG40nGTj+BX+M1Z5XQGWBr3GjPm0Z3DHmg
	SRL2HcUo=; b=JFv1E0CeXCynYFMvr9PmMrwIQ9QIUHD2a7qnxV2XCwjivhCfabW
	roXBJ6PYFm/4Ea8YQ07fU78PlyAiXM91NuZyAL5tDPswrJJ8UCvHB1/LxYgR9FoQ
	VfrMI4j84gL7uabRVJR/Q57EtlLBOLR7p2sxsGk0peOZK1xXMVfloqKp/IGNVdKu
	+gIv5sDarZXXzt4bJC6Uj+RWPLYNEEQI+LmNu08do3jE9JY2A68T9F3GJtocY4Mz
	/ljxzqsuQzxHNOfdE2pcAXZpjQZyq4JIlf4kLwi6gAOb5Cc9lbGPa14Bz977s5L+
	SXbkV+00Wbl3QvRjAmRlS68qmZeHE2wmW8w==
X-ME-Sender: <xms:Z6SKaCBUu1KwmIsxmY33RQAVWZGiI3I1IqFCkznRiwTsEZhPnT_mXg>
    <xme:Z6SKaDYNOT-cz5lEwBcJ74Iv4F7pKG7seLWf2BPd73wcn26FYLSkhbrhygYs30QA3
    Our-VRlUCYCq70SlR4>
X-ME-Received: <xmr:Z6SKaCilgjlFMIWmSfrtRjd5J79VkGi_TbwFxbUQN5W8fFOUyTrwoTNPsc1fOVwmD_zRV9IJ5ARnxV_ibfgc3YEW5rs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecu
    ggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekudduteefke
    fffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtg
    hpthhtohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Z6SKaN5LtTu3Sbs8xp3tzLSp2_6kWmGKTnSFOSzLW5R1rb-JHEPUuQ>
    <xmx:Z6SKaB6CMSZJLiTDaW7zZLpJLeloYynZixP-cj43sA91wBSopa0azg>
    <xmx:Z6SKaJdojSMaE0DMLKc_GlZTas04paCn4jlu2zUZZd8ZsDFS_ll-EQ>
    <xmx:Z6SKaFBAgWX9NlHuSkdWonlfJuHzc4xwa2-L243PS6Yez2aIx1kq8Q>
    <xmx:Z6SKaIH0FY4zB0t2miDi4zEp8phSePWWOmkSeGmiaj3t2vXPTmCU5Bdg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 19:01:59 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/301: enhance nested simple quotas test
Date: Wed, 30 Jul 2025 16:03:07 -0700
Message-ID: <5b4103224ad0a5f26f3856b7333e7efff8575296.1753916569.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had a bug with qgroup accounting with 2+ layers, which was most
easily detected with a slightly more complex nested squota hierarchy.
Make the nested squota test case a tiny bit more complex to capture this
test as well.

The kernel patch that this change exercises is:
        btrfs: fix iteration bug in __qgroup_excl_accounting()

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/301 | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 6b59749d..7f676001 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -19,6 +19,9 @@ _require_xfs_io_command "falloc"
 _require_scratch_enable_simple_quota
 _require_no_compress
 
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
+
 subv=$SCRATCH_MNT/subv
 nested=$SCRATCH_MNT/subv/nested
 snap=$SCRATCH_MNT/snap
@@ -49,7 +52,7 @@ get_qgroup_usage()
 	local output
 
 	output=$($BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | \
-		 grep "$qgroupid" | $AWK_PROG '{print $3}')
+		 grep -a "^$qgroupid" | $AWK_PROG '{print $3}')
 	# The qgroup is auto-removed, this can only happen if its numbers are
 	# already all zeros, so here we only need to explicitly echo "0".
 	if [ -z "$output" ]; then
@@ -218,7 +221,9 @@ prepare_nested()
 	prepare
 	local subvid=$(get_subvid)
 	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup create 2/100 $SCRATCH_MNT
 	$BTRFS_UTIL_PROG qgroup limit $limit 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup assign 1/100 2/100 $SCRATCH_MNT >> $seqres.full
 	$BTRFS_UTIL_PROG qgroup assign 0/$subvid 1/100 $SCRATCH_MNT >> $seqres.full
 	$BTRFS_UTIL_PROG subvolume create $nested >> $seqres.full
 	local nestedid=$(get_nestedid)
@@ -228,6 +233,7 @@ prepare_nested()
 	local subv_usage=$(get_subvol_usage $subvid)
 	local nested_usage=$(get_subvol_usage $nestedid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
+	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
 }
 
 # Write in a single subvolume, including going over the limit.
@@ -377,12 +383,14 @@ nested_accounting()
 	local subv_usage=$(get_subvol_usage $subvid)
 	local nested_usage=$(get_subvol_usage $nestedid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
+	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
 	rm $nested/f
 	check_subvol_usage $subvid $total_fill
 	check_subvol_usage $nestedid 0
 	subv_usage=$(get_subvol_usage $subvid)
 	nested_usage=$(get_subvol_usage $nestedid)
 	check_qgroup_usage 1/100 $(($subv_usage + $nested_usage))
+	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
 	do_enospc_falloc $nested/large_falloc 2G
 	do_enospc_write $nested/large 2G
 	_scratch_unmount
-- 
2.50.1



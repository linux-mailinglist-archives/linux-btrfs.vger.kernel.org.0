Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28C3768746
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Jul 2023 21:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjG3TDS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Jul 2023 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjG3TDH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Jul 2023 15:03:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE90AB
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 12:03:01 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UIlgFp011713
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 12:03:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=6tWXVUh+7kO+QHM/uClTW5G4+QPhxGyqV1ViCHQec9E=;
 b=RwCan1S8eqPCE/VD3YV10cAoteEMfrDgg5AOVNeyOPKpHVy4pzNvDEdxSNTMQKhZKKjE
 FbHZ1UxKbxo6dVqDcUEM91Cu6pa7fAOiAkmkO5Gofn51x2Zn/JXbqcvYGcTjCOV3HD5K
 +RvgS5MYCUqHH5o96gD9W57J13ms/iXxxVY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s4yw0hxus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Jul 2023 12:03:00 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 12:02:59 -0700
Received: from twshared37076.03.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 12:02:59 -0700
Received: by devbig003.nao1.facebook.com (Postfix, from userid 8731)
        id BE05F1D79F54F; Sun, 30 Jul 2023 12:02:42 -0700 (PDT)
From:   Chris Mason <clm@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <dsterba@suse.com>,
        <josef@toxicpanda.com>, <hch@lst.de>
Subject: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it is tracking an extent
Date:   Sun, 30 Jul 2023 12:02:26 -0700
Message-ID: <20230730190226.4001117-1-clm@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 17_yL4B-8hNx0BSAR5QqSVujvMWobgAW
X-Proofpoint-GUID: 17_yL4B-8hNx0BSAR5QqSVujvMWobgAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ This is an RFC because Christoph switched us to almost always set
len_to_oe_boundary in a patch in for-next  I think we still need this
commit for strange corners, but it's already pretty hard to hit reliably
so I wanted to toss it out for discussion. We should consider either
Christoph's "btrfs: limit write bios to a single ordered extent" or this
commit for 6.4 stable as well ]

bio_ctrl->len_to_oe_boundary is used to make sure we stay inside an
extent as we submit bios.  Every time we add a page to the bio, we
decrement those bytes from len_to_oe_boundary, and then we submit the
bio if we happen to hit zero.

Most of the time, len_to_oe_boundary gets set to U32_MAX.  With
Christoph's incoming ("btrfs: limit write bios to a single ordered
extent") we're almost always setting len_to_oe_boundary, so we might not
need this commit moving forward.  But, there's a corner of a corner in he=
re
where we can still create a massive bio, so talking through it:

submit_extent_page() adds pages into our bio, and the size of the bio
ends up limited by:

- Are we contiguous on disk?
- Does bio_add_page() allow us to stuff more in?
- is len_to_oe_boundary > 0?

The len_to_oe_boundary math starts with U32_MAX, which isn't page or
sector aligned, and subtracts from it until it hits zero.  In the
non-ordered extent case, the last IO we submit before we hit zero is
going to be unaligned, triggering BUGs and other sadness.

This is hard to trigger because bio_add_page() isn't going to make a bio
of U32_MAX size unless you give it a perfect set of pages and fully
contiguous extents on disk.  We can hit it pretty reliably while making
large swapfiles during provisioning because the machine is freshly
booted, mostly idle, and the disk is freshly formatted.

The code has been cleaned up and shifted around a few times, but this fla=
w
has been lurking since the counter was added.  I think Christoph's
commit ended up exposing the bug, but it's pretty tricky to get bios
big enough to prove if older kernels have the same problem.

The fix used here is to skip doing math on len_to_oe_boundary unless
we've changed it from the default U32_MAX value.  bio_add_page() is the
real limited we want, and there's no reason to do extra math when Jens
is doing it for us.

Signed-off-by: Chris Mason <clm@fb.com>
Fixes: 24e6c8082208 ("btrfs: simplify main loop in submit_extent_page")
---
 fs/btrfs/extent_io.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6b40189a1a3e..bb2d2d405d04 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -849,7 +849,17 @@ static void submit_extent_page(struct btrfs_bio_ctrl=
 *bio_ctrl,
 		size -=3D len;
 		pg_offset +=3D len;
 		disk_bytenr +=3D len;
-		bio_ctrl->len_to_oe_boundary -=3D len;
+
+		/*
+		 * len_to_oe_boundary defaults to U32_MAX, which isn't page or
+		 * sector aligned.  So, we don't really want to do math on
+		 * len_to_oe_boundary unless it has been intentionally set by
+		 * alloc_new_bio().  If we decrement here, we'll potentially
+		 * end up sending down an unaligned bio once we get close to
+		 * zero.
+		 */
+		if (bio_ctrl->len_to_oe_boundary !=3D U32_MAX)
+			bio_ctrl->len_to_oe_boundary -=3D len;
=20
 		/* Ordered extent boundary: move on to a new bio. */
 		if (bio_ctrl->len_to_oe_boundary =3D=3D 0)
--=20
2.34.1


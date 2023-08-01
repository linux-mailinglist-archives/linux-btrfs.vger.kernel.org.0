Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6576E76B9A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjHAQcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjHAQb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 12:31:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D177E57
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 09:31:55 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371FCZ03008235
        for <linux-btrfs@vger.kernel.org>; Tue, 1 Aug 2023 09:31:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=w3FQcTTuIVHnUR9i2jp48OrYpF9bCcl8+YO6btnpqVE=;
 b=KK23Kcn6jQWoqEY6T6dvo6aICI0yIRPtYSiJOKG36+5hx43NYOmrrokTNHr9fuj3o+JF
 ZbNyvMPQlQzYKXYF2MpXL2RyPui8V4Y+b7bJzYyMFKRqdNgxmN5FbiRRWXQZXWpPnegn
 fJrmnPoJuTSL4dunkvN29faSeYZTTts6uZU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s6qfgxau3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Aug 2023 09:31:55 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 09:31:54 -0700
Received: from twshared3345.02.ash8.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 09:31:53 -0700
Received: by devbig003.nao1.facebook.com (Postfix, from userid 8731)
        id 3456C1D9325F7; Tue,  1 Aug 2023 09:30:05 -0700 (PDT)
From:   Chris Mason <clm@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <dsterba@suse.com>,
        <josef@toxicpanda.com>, <hch@lst.de>
Subject: [PATCH v2] Btrfs: only subtract from len_to_oe_boundary when it is tracking an extent
Date:   Tue, 1 Aug 2023 09:28:28 -0700
Message-ID: <20230801162828.1396380-1-clm@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TE2Wu92MVK-m_DiO1GV-Iytxtp-ylklX
X-Proofpoint-GUID: TE2Wu92MVK-m_DiO1GV-Iytxtp-ylklX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_13,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Note: I dropped the RFC because I can now trigger on Linus kernels, and
I think we need to send something to stable as well ]

bio_ctrl->len_to_oe_boundary is used to make sure we stay inside a zone
as we submit bios for writes.  Every time we add a page to the bio, we
decrement those bytes from len_to_oe_boundary, and then we submit the
bio if we happen to hit zero.

Most of the time, len_to_oe_boundary gets set to U32_MAX.
submit_extent_page() adds pages into our bio, and the size of the bio
ends up limited by:

- Are we contiguous on disk?
- Does bio_add_page() allow us to stuff more in?
- is len_to_oe_boundary > 0?

The len_to_oe_boundary math starts with U32_MAX, which isn't page or
sector aligned, and subtracts from it until it hits zero.  In the
non-zoned case, the last IO we submit before we hit zero is going to be
unaligned, triggering BUGs and other sadness.

This is hard to trigger because bio_add_page() isn't going to make a bio
of U32_MAX size unless you give it a perfect set of pages and fully
contiguous extents on disk.  We can hit it pretty reliably while making
large swapfiles during provisioning because the machine is freshly
booted, mostly idle, and the disk is freshly formatted.  It's also
possible to trigger with reads when read_ahead_kb is set to 4GB.

The code has been clean up and shifted around a few times, but this flaw
has been lurking since the counter was added.  I think Christoph's
commit ended up exposing the bug.

The fix used here is to skip doing math on len_to_oe_boundary unless
we've changed it from the default U32_MAX value.  bio_add_page() is the
real limit we want, and there's no reason to do extra math when Jens
is doing it for us.

Sample repro, note you'll need to change the path to the bdi and device:

SUBVOL=3D/btrfs/swapvol
SWAPFILE=3D$SUBVOL/swapfile
SZMB=3D8192

mkfs.btrfs -f /dev/vdb
mount /dev/vdb /btrfs

btrfs subvol create $SUBVOL
chattr +C $SUBVOL
dd if=3D/dev/zero of=3D$SWAPFILE bs=3D1M count=3D$SZMB
sync;sync;sync

echo 4 > /proc/sys/vm/drop_caches

echo 4194304 > /sys/class/bdi/btrfs-2/read_ahead_kb

while(true) ; do
        echo 1 > /proc/sys/vm/drop_caches
        echo 1 > /proc/sys/vm/drop_caches
        dd of=3D/dev/zero if=3D$SWAPFILE bs=3D4096M count=3D2 iflag=3Dful=
lblock
done

Signed-off-by: Chris Mason <clm@fb.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
CC: stable@vger.kernel.org # 6.4
Fixes: 24e6c8082208 ("btrfs: simplify main loop in submit_extent_page")
---
 fs/btrfs/extent_io.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

v1 -> v2: update the comments, add repro to commit log

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6b40189a1a3e..c25115592d99 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -849,7 +849,30 @@ static void submit_extent_page(struct btrfs_bio_ctrl=
 *bio_ctrl,
 		size -=3D len;
 		pg_offset +=3D len;
 		disk_bytenr +=3D len;
-		bio_ctrl->len_to_oe_boundary -=3D len;
+
+		/*
+		 * len_to_oe_boundary defaults to U32_MAX, which isn't page or
+		 * sector aligned.  alloc_new_bio() then sets it to the end of
+		 * our ordered extent for writes into zoned devices.
+		 *
+		 * When len_to_oe_boundary is tracking an ordered extent, we
+		 * trust the ordered extent code to align things properly, and
+		 * the check above to cap our write to the ordered extent
+		 * boundary is correct.
+		 *
+		 * When len_to_oe_boundary is U32_MAX, the cap above would
+		 * result in a 4095 byte IO for the last page riiiiight before
+		 * we hit the bio limit of UINT_MAX.  bio_add_page() has all
+		 * the checks required to make sure we don't overflow the bio,
+		 * and we should just ignore len_to_oe_boundary completely
+		 * unless we're using it to track an ordered extent.
+		 *
+		 * It's pretty hard to make a bio sized U32_MAX, but it can
+		 * happen when the page cache is able to feed us contiguous
+		 * pages for large extents.
+		 */
+		if (bio_ctrl->len_to_oe_boundary !=3D U32_MAX)
+			bio_ctrl->len_to_oe_boundary -=3D len;
=20
 		/* Ordered extent boundary: move on to a new bio. */
 		if (bio_ctrl->len_to_oe_boundary =3D=3D 0)
--=20
2.34.1


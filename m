Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE3E72A1B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 19:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFIRye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 13:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFIRyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 13:54:33 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC29C3588
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 10:54:28 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359E9jSN024968
        for <linux-btrfs@vger.kernel.org>; Fri, 9 Jun 2023 10:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=bIK2kOOP91Hl+4ak8Q28Mv3cY+UVA4SN2dFD6WMbBhQ=;
 b=nPZ5ZPkCgEzp1ZxXTn/Xpkd3euxovD8gjgSJxpZJjOgZfEmHQ671SzdpiXLvO32Pzmwa
 HNIed6ddSKnpEtYm5x1J0VuQkfzOVWcvR2cv8RA3ejQt+gFkdWrIHEBS4pHLJhq3IQaH
 iu04KBMkQCJZX7vxJoFGM4pii180plrtEDw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r3r3fex5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jun 2023 10:54:27 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 10:54:26 -0700
Received: by devbig003.nao1.facebook.com (Postfix, from userid 8731)
        id 8E7681AD75E79; Fri,  9 Jun 2023 10:53:55 -0700 (PDT)
From:   Chris Mason <clm@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <dsterba@suse.com>,
        <josef@toxicpanda.com>, <fdmanana@suse.com>
Subject: [PATCH] Btrfs: can_nocow_file_extent should pass down args->strict from callers
Date:   Fri, 9 Jun 2023 10:53:41 -0700
Message-ID: <20230609175341.1618652-1-clm@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YQHF_wOD-ekiyxGaF1y8BULF-IDTv-ty
X-Proofpoint-ORIG-GUID: YQHF_wOD-ekiyxGaF1y8BULF-IDTv-ty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_13,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

619104ba453ad0 changed our call to btrfs_cross_ref_exist() to always
pass false for the 'strict' parameter.  We're passing this down through
the stack so that we can do a full check for cross references during
swapfile activation.

With strict always false, this test fails:

btrfs subvol create swappy
chattr +C swappy
fallocate -l1G swappy/swapfile
chmod 600 swappy/swapfile
mkswap swappy/swapfile

btrfs subvol snap swappy swapsnap
btrfs subvol del -C swapsnap

btrfs fi sync /
sync;sync;sync

swapon swappy/swapfile

The fix is to just use args->strict, and everyone except swapfile
activation is passing false.

Fixes: 619104ba453ad0 ("btrfs: move common NOCOW checks against a file ex=
tent into a helper")
Signed-off-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 19c707bc8801..e57d9969bd71 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1864,7 +1864,7 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
=20
 	ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
 				    key->offset - args->extent_offset,
-				    args->disk_bytenr, false, path);
+				    args->disk_bytenr, args->strict, path);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret !=3D 0)
 		goto out;
--=20
2.34.1


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E6588324
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 22:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiHBUcz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiHBUcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 16:32:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1417E3B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 13:32:53 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 272I2Wnu009580
        for <linux-btrfs@vger.kernel.org>; Tue, 2 Aug 2022 13:32:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=jQXMVD17Q+oY1vQphivwjVRtcDEGg5bEem2kARFesYk=;
 b=qAyOMi7bZYNvENMzOmVY0oqbM0eZheloTjHmV76fIqCtjkKsd+IOsDwdNRh8zVVF06lU
 EWBla84eOhzI7pGy7befoH77mJffUwlwFGj5z8aHyZz1wEi8Ih3CeZsAysXe288KjsKz
 Bd9jZgbw0HQWQXGMW5VdALih4lRHtPi9q88= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hn0av6c6j-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 13:32:52 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 13:32:51 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id E7BCA1B76716; Tue,  2 Aug 2022 13:32:48 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <kernel-team@fb.com>, <linux-mm@kvack.org>, <clm@fb.com>,
        <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alexander Zhu <alexlzhu@fb.com>
Subject: [PATCH v3] btrfs: fix alginment of VMA for memory mapped files on THP
Date:   Tue, 2 Aug 2022 13:32:46 -0700
Message-ID: <20220802203246.434560-1-alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: f_bxGz6StB_mQ-72-JYXUN9dGnmUuhRB
X-Proofpoint-ORIG-GUID: f_bxGz6StB_mQ-72-JYXUN9dGnmUuhRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_14,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Alexander Zhu <alexlzhu@fb.com>

With CONFIG_READ_ONLY_THP_FOR_FS, the Linux kernel supports using THPs fo=
r
read-only mmapped files, such as shared libraries. However, the kernel
makes no attempt to actually align those mappings on 2MB boundaries,
which makes it impossible to use those THPs most of the time. This issue
applies to general file mapping THP as well as existing setups using
CONFIG_READ_ONLY_THP_FOR_FS. This is easily fixed by using
thp_get_unmapped_area for the unmapped_area function in btrfs, which
is what ext2, ext4, fuse, and xfs all use.

Initially btrfs had been left out in Commit 8c07fc452ac0 ("btrfs: fix
alginment of VMA for memory mapped files on THP") as btrfs does not suppo=
rt
DAX. However, Commit 1854bc6e2420 ("mm/readahead: Align file mappings
for non-DAX") removed the DAX requirement. We should now be able to call
thp_get_unmapped_area() for btrfs.

The problem can be seen in /proc/PID/smaps where THPeligible is set to 0
on mappings to eligible shared object files as shown below.

Before this patch:

7fc6a7e18000-7fc6a80cc000 r-xp 00000000 00:1e 199856
/usr/lib64/libcrypto.so.1.1.1k
Size:               2768 kB
THPeligible:    0
VmFlags: rd ex mr mw me

With this patch the library is mapped at a 2MB aligned address:

fbdfe200000-7fbdfe4b4000 r-xp 00000000 00:1e 199856
/usr/lib64/libcrypto.so.1.1.1k
Size:               2768 kB
THPeligible:    1
VmFlags: rd ex mr mw me

This fixes the alignment of VMAs for any mmap of a file that has the
rd and ex permissions and size >=3D 2MB. The VMA alignment and
THPeligible field for anonymous memory is handled separately and
is thus not effected by this change.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>

Changes in v3:
-Fixed subject to be btrfs instead of mm
-Fixed Signed-off-by to use full name
-Added to description explaining why thp_get_unmapped_area can be
used for btrfs

Changes in v2:
-Changed from x86_64 diff to btrfs diff using thp_get_unmapped_area
---
 fs/btrfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9dfde1af8a64..2423040db167 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3808,6 +3808,7 @@ const struct file_operations btrfs_file_operations =
=3D {
 	.mmap		=3D btrfs_file_mmap,
 	.open		=3D btrfs_file_open,
 	.release	=3D btrfs_release_file,
+	.get_unmapped_area =3D thp_get_unmapped_area,
 	.fsync		=3D btrfs_sync_file,
 	.fallocate	=3D btrfs_fallocate,
 	.unlocked_ioctl	=3D btrfs_ioctl,
--=20
2.30.2


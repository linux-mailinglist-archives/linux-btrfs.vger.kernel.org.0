Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734E058707C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiHASsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiHASsG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 14:48:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F06925293
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 11:48:04 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271EmXJ1003686
        for <linux-btrfs@vger.kernel.org>; Mon, 1 Aug 2022 11:48:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=/0Ba2BW84txtNVUrI6XJ5P58G9O2nZCOBVVyrrbvLJM=;
 b=KjsEEFCrhCrTXrG2s0W8PGbKnOpceSsX7WI/vOk/ONLAPON5BgOg+ChsFMTxAiKuFBIH
 +2SuGM5RtRZV/XzxDolQ87kK5z3WJ4rV27kMh0YMSxx8V08hZziQdHJEFWyQbA/fQFDb
 xPsWHQG3NsKs4ysJvyPei2wzwIIBZgG2JXk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hmyymx2ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Aug 2022 11:48:04 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 11:48:03 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id D2E391AAF666; Mon,  1 Aug 2022 11:47:55 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <kernel-team@fb.com>, <linux-mm@kvack.org>, <clm@fb.com>,
        <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     alexlzhu <alexlzhu@fb.com>
Subject: [PATCH v2] mm: fix alginment of VMA for memory mapped files on THP
Date:   Mon, 1 Aug 2022 11:47:40 -0700
Message-ID: <20220801184740.2134364-1-alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ut0jxSWvzKW4Gk1hAjJsF4Z5JKogbogF
X-Proofpoint-ORIG-GUID: ut0jxSWvzKW4Gk1hAjJsF4Z5JKogbogF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: alexlzhu <alexlzhu@fb.com>

With CONFIG_READ_ONLY_THP_FOR_FS, the Linux kernel supports using THPs fo=
r
read-only mmapped files, such as shared libraries. However, the
kernel makes no attempt to actually align those mappings on 2MB boundarie=
s,
which makes it impossible to use those THPs most of the time. This issue
applies to general file mapping THP as well as existing setups using
CONFIG_READ_ONLY_THP_FOR_FS. This is easily fixed by using
thp_get_unmapped_area for the unmapped_area function in btrfs, which is
what ext2, ext4, fuse, and xfs all use. The problem can be seen in
/proc/PID/smaps where THPeligible is set to 0 on mappings to eligible
shared object files as shown below.

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

Signed-off-by: alexlzhu <alexlzhu@fb.com>
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


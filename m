Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056B0467FA7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383313AbhLCWIR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:08:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47024 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383316AbhLCWIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Dec 2021 17:08:16 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3L6Lof021533
        for <linux-btrfs@vger.kernel.org>; Fri, 3 Dec 2021 14:04:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=14vEMIrr4UgZZ2cy8X099sSCF3sQgJNEZHTfxQZI2zw=;
 b=C7Xffi7bUpG+wVvETX6l/sk8P/qkBcf7Af/w1gYOxQ40lOFJNVAwJxW3u4vKGFynde5C
 qkX5AOFk+Af8qP/TAL1gHROnWwqLI0B3+TIezpAiMZBIvkSwPHidoRGxBNcMTHROPF+c
 S5WrohPfuT7nufnNcmDAYYlkdd9EvBm7BtE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cqeku5qxq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:04:51 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:04:50 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 2900C76B31D1; Fri,  3 Dec 2021 14:04:47 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v6 0/4] btrfs: sysfs: set / query btrfs chunk size
Date:   Fri, 3 Dec 2021 14:04:41 -0800
Message-ID: <20211203220445.2312182-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: zaEdAZ1Vlac0eNMb1a3KTZ-jBP0vdbEq
X-Proofpoint-GUID: zaEdAZ1Vlac0eNMb1a3KTZ-jBP0vdbEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs allocator is currently not ideal for all workloads. It tends
to suffer from overallocating data block groups and underallocating
metadata block groups. This results in filesystems becoming read-only
even though there is plenty of "free" space.

This is naturally confusing and distressing to users.

Patches:
1) Store the chunk size in the btrfs_space_info structure
2) Add a sysfs entry to read and write the above information
3) Add a sysfs entry to force a space allocation
4) Increase the default size of the metadata chunk allocation to 5GB
   for volumes greater than 50GB.

Testing:
  A new test is being added to the xfstest suite. For reference the
  corresponding patch has the title:
    [PATCH] btrfs: Test chunk allocation with different sizes

  In addition also manual testing has been performed.
    - Run xfstests with the changes and the new test. It does not
      show new diffs.
    - Test with storage devices 10G, 20G, 30G, 50G, 60G
      - Default allocation
      - Increase of chunk size
      - If the stripe size is > the free space, it allocates
        free space - 1MB. The 1MB is left as free space.
      - If the device has a storage size > 50G, it uses a 5GB
        chunk size for new allocations.

---
v6: - Update btrfs_force_chunk_alloc_store to use tree_root
      instead of extent_root.
V5: - Changed the field name in the btrfs_space_info struct from
      default_chunk_size to chunk_size and made it atomic
    - Removed the compute_chunk_size_zoned function
    - Added further checks when writing /sys/fs/btrfs/<id>/allocation/<ty=
pe>/chunk_size
    - Removed the ability to query /sys/fs/btrfs/<id>/allocation/<type>/f=
orce_alloc_chunk

V4: - Patch email contained duplicate entries.

V3: - Rename sysfs entry from stripe_size to chunk_size
    - Remove max_chunk_size field in data structure btrfs_space_info
    - Rename max_stripe_size field to default_chunk_size in data
      structure btrfs_space_info
    - Remove max_chunk_size logic
    - Use stripe_size =3D chunk_size

V2:
   - Split the patch in 4 patches
   - Added checks for zone volumes in sysfs.c
   - Replaced the BUG() with ASSERT()
   - Changed if with fallthrough
   - Removed comments in space-info.h
--
Stefan Roesch (4):
  btrfs: store chunk size in space-info struct.
  btrfs: expose chunk size in sysfs.
  btrfs: add force_chunk_alloc sysfs entry to force allocation
  btrfs: increase metadata alloc size to 5GB for volumes > 50GB

 fs/btrfs/space-info.c |  41 ++++++++++++
 fs/btrfs/space-info.h |   3 +
 fs/btrfs/sysfs.c      | 152 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c    |  28 +++-----
 4 files changed, 205 insertions(+), 19 deletions(-)


Signed-off-by: Stefan Roesch <shr@fb.com>
base-commit: 87c673b657a7e4784fb7274a77a8529712232d0c
--=20
2.30.2


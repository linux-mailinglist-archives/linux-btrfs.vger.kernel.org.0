Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E81E44B514
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 23:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbhKIWFO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 17:05:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36086 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232354AbhKIWFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 17:05:14 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9Lvhpm019642
        for <linux-btrfs@vger.kernel.org>; Tue, 9 Nov 2021 14:02:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=n8CdsWsWUtbf3ZSEqJCFkKygWtk1QKQLLYwnivEtz90=;
 b=Fkuyh1s+VeW1pgpLFu+oPA4yIGVP+zGmHjitUo9oqZZQv8mI4cztTEtWe9kSG06CqT8j
 NflrbvddUdwTLGMcjPlnUVrjeDGvIYUxVZOSkMOL+Gv3HYUnWf1O9Gi7up6vK7fhqWCw
 jBzm8LfQ3I0GATn8xPui/xnhSvxVYqEwQug= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c7ys2rw3m-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 14:02:27 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 14:02:25 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 368C76326D7E; Tue,  9 Nov 2021 14:02:21 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 0/4] btrfs: sysfs: set / query btrfs chunk size
Date:   Tue, 9 Nov 2021 14:02:14 -0800
Message-ID: <20211109220218.602995-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: noK329j3k3-jPu8Y8Buyfouk3dIvg-Pp
X-Proofpoint-GUID: noK329j3k3-jPu8Y8Buyfouk3dIvg-Pp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_07,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=964 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Motivation:
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
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
--=20
2.30.2


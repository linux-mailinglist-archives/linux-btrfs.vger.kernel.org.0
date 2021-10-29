Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21BC4401DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJ2SbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 14:31:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13294 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230022AbhJ2SbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 14:31:17 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19THwS5A017444
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:28:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ZRCZBFDD6HVetxTpDHMdKg4xQ9Y1XhiJGFagMa41GuY=;
 b=mOBXsWauBgXAPRVeTlhDztEVaUyxmWUICCJkHdROSm5r/0tZtU8o9YjN4mefVV4lna5o
 sLvGjsYfpj19+K0eRPg0PNCnVmSArDCBjNSTMTjzRhvRtQ81nlLI6ByKzvevTw6YX2Sy
 /ddpoIik2kPz6tC+toR2Bhq10AG2xxjkAsk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c09avxfkh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 11:28:47 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 11:28:31 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id D78A35BCB636; Fri, 29 Oct 2021 11:28:15 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v3 0/4] btrfs: sysfs: set / query btrfs chunk size
Date:   Fri, 29 Oct 2021 11:28:06 -0700
Message-ID: <20211029182812.3560677-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: XcF6iS7jgZ0ATIuTuGp2OCBbKqU9Jlj0
X-Proofpoint-ORIG-GUID: XcF6iS7jgZ0ATIuTuGp2OCBbKqU9Jlj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_04,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=2
 lowpriorityscore=2 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=889 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290100
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
2) Add a sysfs entry to read/write the chunk size=20
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

 fs/btrfs/space-info.c |  51 +++++++++++++++
 fs/btrfs/space-info.h |   3 +
 fs/btrfs/sysfs.c      | 145 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c    |  28 +++-----
 4 files changed, 208 insertions(+), 19 deletions(-)

Signed-off-by: Stefan Roesch <shr@fb.com>
---
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
--=20
2.30.2


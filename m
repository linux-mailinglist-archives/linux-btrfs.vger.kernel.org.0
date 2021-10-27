Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CD543D2A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 22:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhJ0URS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 16:17:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37496 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238966AbhJ0URR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 16:17:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19RK0OHW014407
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 13:14:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=2YUUHSxB3b2T4YR4BXPemnrMYPNSOGGTHfuXOpMd21E=;
 b=oAyhHeJOR8x4+ipd0nd4INMmiPzteKcnuBhCEJgs5qsz2EyGiaKfu3U1lN8wxeqL3UP5
 HDYrJSKeurmnEu+c50HWSQro85RN/JSGjJ0pTQMZjNq15Q4qp+2UayG/QVyY73WQ9qRw
 VBUJNZhPMbC2oIGfw6awRoh+JuXxPv954ME= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3by9w831h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 13:14:51 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 27 Oct 2021 13:14:50 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 0EEB35A487C5; Wed, 27 Oct 2021 13:14:44 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v2 0/4] btrfs: sysfs: set / query btrfs stripe size
Date:   Wed, 27 Oct 2021 13:14:37 -0700
Message-ID: <20211027201441.3813178-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Ao_XhjdrpbGLgDfJItEKgEBaMOhCcjxX
X-Proofpoint-ORIG-GUID: Ao_XhjdrpbGLgDfJItEKgEBaMOhCcjxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_06,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=903 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270115
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
1) Store the stripe and chunk size in the btrfs_space_info structure
2) Add a sysfs entry to expose the above information
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
  btrfs: store stripe size and chunk size in space-info struct.
  btrfs: expose stripe and chunk size in sysfs.
  btrfs: add force_chunk_alloc sysfs entry to force allocation
  btrfs: increase metadata alloc size to 5GB for volumes > 50GB

 fs/btrfs/space-info.c |  72 +++++++++++++++++++++
 fs/btrfs/space-info.h |   4 ++
 fs/btrfs/sysfs.c      | 145 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c    |  28 +++-----
 4 files changed, 230 insertions(+), 19 deletions(-)

Signed-off-by: Stefan Roesch <shr@fb.com>
---
V2:
   - Split the patch in 4 patches
   - Added checks for zone volumes in sysfs.c
   - Replaced the BUG() with ASSERT()
   - Changed if with fallthrough
   - Removed comments in space-info.h
--
2.30.2


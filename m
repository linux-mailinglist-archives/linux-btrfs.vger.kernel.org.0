Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6494AE34C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 23:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386675AbiBHWVn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 17:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386264AbiBHTzz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 14:55:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD3C0613CB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 11:55:55 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218E74Vr013755
        for <linux-btrfs@vger.kernel.org>; Tue, 8 Feb 2022 11:31:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=7RRoj5Chj01QC3wwhsRgaPUgclqvOcp66Y3HuyWvgrk=;
 b=K0GLGS1S3/a8AjJ1aOujjUkEO88SymIc7QVoRi1bN5pS10WsVl+1x+U5vX4ajOsUb9F2
 OwQSSuHBzJ+OhM93JqyDt8HhkGWb/ixP2RRgSxCLj7zFQlzhpL1s9za2Wna75j+64+MA
 dr/jPlvob4W1ZWIFfJi02tBXquKG96GgxDs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3puw3p68-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 11:31:32 -0800
Received: from twshared9880.08.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 11:31:28 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 2FD82A7B5424; Tue,  8 Feb 2022 11:31:25 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v1 0/3] btrfs: add sysfs switch to get/set metadata size
Date:   Tue, 8 Feb 2022 11:31:19 -0800
Message-ID: <20220208193122.492533-1-shr@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: VhwkjEhTDEt6a0BdSqLWtkqCB-0ZU8SG
X-Proofpoint-ORIG-GUID: VhwkjEhTDEt6a0BdSqLWtkqCB-0ZU8SG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 mlxlogscore=934 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080114
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs allocator is currently not ideal for all workloads. It tends
to suffer from overallocating data block groups and underallocating
metadata block groups. This results in filesystems becoming read-only
even though there is plenty of "free" space.

This patch adds the ability to query and set the metadata allocation
size.

  Patch 1: btrfs: store chunk size in space-info struct.
    Store the stripe and chunk size in the btrfs_space_info structure
    to be able to expose and set the metadata allocation size.
   =20
  Patch 2: btrfs: expose chunk size in sysfs.
    Add a sysfs entry to read and write the above information.
   =20
  btrfs: add force_chunk_alloc sysfs entry to force allocation
    For testing purposes and under a debug flag add a sysfs entry to
    force a space allocation.


Stefan Roesch (3):
  btrfs: store chunk size in space-info struct.
  btrfs: expose chunk size in sysfs.
  btrfs: add force_chunk_alloc sysfs entry to force allocation

 fs/btrfs/space-info.c |  41 ++++++++++++
 fs/btrfs/space-info.h |   3 +
 fs/btrfs/sysfs.c      | 152 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c    |  28 +++-----
 4 files changed, 205 insertions(+), 19 deletions(-)


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
--=20
2.30.2


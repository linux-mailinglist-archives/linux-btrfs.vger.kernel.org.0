Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049DE54BD92
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 00:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiFNWXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 18:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiFNWXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 18:23:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E94B404
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:23:05 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EM2olE006245
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:23:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=RoyCpYd46hVOUJ+0WFOyuvQgCT5RSEWm1QTWKFo6xkE=;
 b=iyYb+TEdynQ/Hb/P+6WxoI6VkAbaIsh+P8UxompaGWlLX9mnhaJuBvh48mqug4o97xV6
 7sOJJ6RR1Hmw5/abyEynf1UJo5H7XOabvmLgCtahWgVW4obT6WMLPgUGrjMVQfxM7NDz
 CpdprHde+vHFMmxjzYX+2zK0DhOMcnu6yNA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gp8aw1m13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:23:04 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 14 Jun 2022 15:23:03 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id E3A3FF8C7EA; Tue, 14 Jun 2022 15:22:58 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 0/2] btrfs: Expose BTRFS commit stats through sysfs
Date:   Tue, 14 Jun 2022 15:22:30 -0700
Message-ID: <20220614222231.2582876-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DaJk4vgr3uFbCidsjjKk5rvLQX233FG8
X-Proofpoint-ORIG-GUID: DaJk4vgr3uFbCidsjjKk5rvLQX233FG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_09,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With this patch series we add the capability to BTRFS to expose some
commit stats through sysfs that might be useful for performance monitorin=
g
and debugging purposes.

Specifically, through SYSFS we expose the following data:
  1) A counter for the commits that occurred so far.
  2) The duration in ms of the last commit.
  3) The maximum commit duration in ms seen so far.
  4) The total duration in ms of the commits seen so far.

The user also has the capability to reset the aforementioned data back to
zero, again through SYSFS.

Changes from v1:

1) Edited out unnecessary comments
2) Made the memory allocation of "btrfs_commit_stats" under "fs_info" in
fs/btrfs/ctree.h static instead of dynamic
3) Transferred the conversion from ns to ms at the point where commit
stats get printed in sysfs, for better precision
4) Changed the lock that protects the update of the commit stats from
"trans_lock" to "super_lock"
5) Changed the printing of the commits stats in sysfs to conform with
the sysfs output

Ioannis Angelakopoulos (2):
  btrfs: Add the capability of getting commit stats in BTRFS
  btrfs: Expose the BTRFS commit stats through sysfs

 fs/btrfs/ctree.h       | 14 ++++++++++++
 fs/btrfs/disk-io.c     |  5 +++++
 fs/btrfs/sysfs.c       | 51 +++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/transaction.c | 29 ++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 1 deletion(-)

--=20
2.30.2


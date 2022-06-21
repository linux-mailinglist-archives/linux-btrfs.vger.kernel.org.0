Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C683553E31
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356115AbiFUVyJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 17:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356131AbiFUVyE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 17:54:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A151DA50
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:54:00 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LHIGnk031302
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=9jvBj6CWdUgmBAwZyR15OMnInMrlXlartXjU0MBK5bw=;
 b=kfJlPedSIz6c5JzqZlLjhZHp/g2DBsmwbTWADG7R2PjOOoPJn6GD5BXTP27LdiSQe5q9
 d+G77zD9692GpwyS+efgka0ZkJhp/SUZs2AfURXLMYH/SwjmaRW+QnJzARCAoNBvXu8a
 YidfdF6KrdqF2970chDyUHLkUvpQqYNt5mc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3guef4ksdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 14:53:59 -0700
Received: from twshared5640.09.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 21 Jun 2022 14:53:58 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id DDA64137BFDF; Tue, 21 Jun 2022 14:53:50 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 0/2] btrfs: Expose BTRFS commit stats through sysfs
Date:   Tue, 21 Jun 2022 14:52:44 -0700
Message-ID: <20220621215245.3603198-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NNA4OjbwZzx_VPQ3ntRTA9IxT_p4vfvK
X-Proofpoint-ORIG-GUID: NNA4OjbwZzx_VPQ3ntRTA9IxT_p4vfvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_09,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

The user also has the capability to reset the maximum commit duration
back to zero, again through SYSFS.

Changes from v2:

1) Only the maximum duration can now be zeroed out through sysfs to
prevent loss of data if multiple threads try to reset the commit stats
simultaneously
2) Removed the lock that protected the concurrent resetting and updating
of the commit stats, since only the maximum commit duration can be
cleared out now (any races can be ignored for this stat).
3) Added div_u64 when converting from ns to ms, to also support 32-bit
4) Made the output from sysfs easier to use with "grep"

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

 fs/btrfs/ctree.h       | 14 +++++++++++++
 fs/btrfs/sysfs.c       | 45 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.c | 22 +++++++++++++++++++++
 3 files changed, 81 insertions(+)

--=20
2.30.2


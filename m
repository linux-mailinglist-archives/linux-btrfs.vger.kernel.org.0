Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C5E553ECF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 01:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353604AbiFUXAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 19:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiFUXAG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 19:00:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF71C10C
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 16:00:02 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25LMWM8q013096
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 16:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JBdlswfmRYZvg91ZZ6VKsrkgTKh+Tyw2r2xojBY/CCg=;
 b=l1KX66OA7cZq/iUpbEsstZ1ifQZDUaUZBdSoN72LdcX/WgOwPW5oaCDetTkYcpWf/sxI
 2OQVE8VX8532+g/AXYfxLN+s8BCnXI6RGmX/xa82v5XjqT7p5ZDRupkM3Xil+dXOdWKx
 u7sgYEl1HlNUgKtdlQPlIyxMkiDkCZ3kl88= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gugqjk3qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 16:00:01 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 21 Jun 2022 16:00:00 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 2C569139C950; Tue, 21 Jun 2022 15:59:57 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 0/2] btrfs: Expose commit stats through sysfs
Date:   Tue, 21 Jun 2022 15:59:17 -0700
Message-ID: <20220621225918.4114998-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 97GOjwgZyzQKc-HFoFNMjmf9RoT04TRf
X-Proofpoint-GUID: 97GOjwgZyzQKc-HFoFNMjmf9RoT04TRf
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

With this patch series we add the capability to btrfs to expose some
commit stats through sysfs that might be useful for performance monitorin=
g
and debugging purposes.

Specifically, through sysfs we expose the following data:
  1) A counter for the commits that occurred so far.
  2) The duration in ms of the last commit.
  3) The maximum commit duration in ms seen so far.
  4) The total duration in ms of the commits seen so far.

The user also has the capability to reset the maximum commit duration
back to zero, again through sysfs.

Changes from v3:

1) Fixed a mistake when using div_u64 that would break the kernel build

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
  btrfs: Add the capability of getting commit stats
  btrfs: Expose the commit stats through sysfs

 fs/btrfs/ctree.h       | 14 +++++++++++++
 fs/btrfs/sysfs.c       | 45 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.c | 22 +++++++++++++++++++++
 3 files changed, 81 insertions(+)

--=20
2.30.2


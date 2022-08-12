Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7506559099D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 02:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbiHLAn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 20:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLAn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 20:43:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A77A1D2D
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:43:56 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BLYMQg030999
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:43:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=uT2Z1b7bMsTLMYhDkSrRWEvYskw5CG1h1l571FgxHkQ=;
 b=OLMm6y+4OoqPkHafRPdd/WwD3TGwpDRYTE6iU2KVLu9NZWLdJyJUX+Q9Bye2PkGkscgv
 AqsafSyPjV4TjiQzlyCZGniLucfafdnRrm3Zj/+/elv1lEb4mhbf64qc5+bHLZSYdqCV
 2/KXYwLCuwKUPOhaWAO7xPBHy0YrNexOrDs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9t70xfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:43:55 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 11 Aug 2022 17:43:54 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id BB20D33AF826; Thu, 11 Aug 2022 17:43:47 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [RFC PATCH 0/2] btrfs: Add a lockdep annotation for the extent bits wait event
Date:   Thu, 11 Aug 2022 17:42:40 -0700
Message-ID: <20220812004241.1722846-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: e5ITx2ShVKAyFRf45veG_YKgI0jFR2E4
X-Proofpoint-ORIG-GUID: e5ITx2ShVKAyFRf45veG_YKgI0jFR2E4
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_14,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

with this patch series we add a lockdep annotation for the extent bits
wait event.

Unfortunately, as it stands this wait event cannot be annotated in a
generic way. Specifically, there are cases where the extent bits are
locked in one execution context (we have to acquire the lockdep map
there) and they are unlocked in another execution context (we have to
release the lockdep map there). However, lockdep expects both the
acquisition and release of the lockdep map to occur in the same context.

Thus, we opted to manually annotate five important functions that lock
extent bits and can be involved in a convoluted deadlock (see
https://lore.kernel.org/linux-btrfs/cover.1655147296.git.josef@toxicpanda.c=
om/)

These functions are:
  1) find_lock_delalloc_range
  2) btrfs_lock_and_flush_ordered_range
  3) extent_fiemap
  4) btrfs_fallocate
  5) btrfs_finish_ordered_io

Important!!! This patch series depends on this patch series
https://lore.kernel.org/linux-btrfs/20220812001734.1587514-1-iangelak@fb.co=
m/T/#t

Ioannis Angelakopoulos (2):
  btrfs: Add lockdep wrappers around the extent bits locking and
    unlocking functions
  btrfs: Lockdep annotations for the extent bits wait event

 fs/btrfs/ctree.h             |   1 +
 fs/btrfs/disk-io.c           |   1 +
 fs/btrfs/extent-io-tree.h    |  32 ++++++++++
 fs/btrfs/extent_io.c         | 114 ++++++++++++++++++++++++++++++++---
 fs/btrfs/file.c              |  10 +--
 fs/btrfs/free-space-cache.c  |   1 +
 fs/btrfs/inode.c             |  22 +++++--
 fs/btrfs/ordered-data.c      |   4 +-
 include/trace/events/btrfs.h |   1 +
 9 files changed, 167 insertions(+), 19 deletions(-)

--=20
2.30.2


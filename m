Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B657C0F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 01:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiGTXjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 19:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiGTXjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 19:39:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39B871BFE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:39:19 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KNbFZh013299
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:39:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=mzSH5Z+To7RoXG6wR5eDr4/Fif0y9BLnUWO/Owb9XNQ=;
 b=GunropWXHP6GVK2XsxhZULz3c6KvKbLVlOLvqhBL5xlpMwPU/UprWFYJtSRZmmHDIIH1
 XvLQOtyj1Als9I2a76+1JCuUyZ7SxuzvMXV2fu806znP8UR9wjQMwaXv2CMAEEU8XdVc
 29Wmx6WttEvfWRXvilEoQAf1HfkXvTQmHFQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3he8wypfjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 16:39:19 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 20 Jul 2022 16:39:18 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 1708425F0649; Wed, 20 Jul 2022 16:39:14 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 0/6]  btrfs: Annotate wait events with lockdep
Date:   Wed, 20 Jul 2022 16:38:13 -0700
Message-ID: <20220720233818.3107724-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: auBxuYO2Zncpk2sEpDXt833aAnyf1HHr
X-Proofpoint-GUID: auBxuYO2Zncpk2sEpDXt833aAnyf1HHr
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

With this patch series we annotate wait events in btrfs with lockdep to
catch deadlocks involving these wait events.

Recently the btrfs developers fixed a non trivial deadlock involving
wait events
https://lore.kernel.org/linux-btrfs/20220614131413.GJ20633@twin.jikos.cz/

Currently lockdep is unable to catch these deadlocks since it does not
support wait events by default.

With our lockdep annotations we train lockdep to track these wait events
and catch more potential deadlocks.

Specifically, we annotate the below wait events in fs/btrfs/transaction.c
and in fs/btrfs/ordered-data.c:

  1) The num_writers wait event
  2) The num_extwriters wait event
  3) The transaction states wait events
  4) The pending_ordered wait event
  5) The ordered extents wait event

Changes from v2:
  1) Added macros to initialize the lockdep maps so that the code is
  cleaner.
  2) Added comments related to the acquisition of the lockdep maps
  by threads either as readers or writers.
  3) Moved the transaction states annotation in wait_for_commit() in
  fs/btrfs/transaction.c to make the code cleaner.
  4) Separated the lockdep class change of invalidate_lock and the
  ordered extents wait event annotation into 2 patches.

Changes from v1:
  1) Added 2 labels in the cleanup code of btrfs_commit_transaction() in
  fs/btrfs/transaction.c so that btrfs_lockdep_release() is not called
  multiple times during the error paths.
  2) Added lockdep annotations for the btrfs transaction states wait
  events.
  3) Added a lockdep annotation for the pending_ordered wait event.
  4) Added a lockdep annotation for the ordered extents wait event.

Ioannis Angelakopoulos (6):
  btrfs: Add a lockdep model for the num_writers wait event
  btrfs: Add a lockdep model for the num_extwriters wait event
  btrfs: Add lockdep models for the transaction states wait events
  btrfs: Add a lockdep model for the pending_ordered wait event
  btrfs: Change the lockdep class of struct inode's invalidate_lock
  btrfs: Add a lockdep model for the ordered extents wait event

 fs/btrfs/ctree.h            |  82 ++++++++++++++++++++++++++++
 fs/btrfs/disk-io.c          |  13 +++++
 fs/btrfs/free-space-cache.c |  11 ++++
 fs/btrfs/inode.c            |  13 +++++
 fs/btrfs/ordered-data.c     |  21 +++++++
 fs/btrfs/transaction.c      | 106 ++++++++++++++++++++++++++++++++----
 6 files changed, 235 insertions(+), 11 deletions(-)

--=20
2.30.2


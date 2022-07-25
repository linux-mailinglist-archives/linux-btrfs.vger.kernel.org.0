Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FED2580725
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 00:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiGYWNE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiGYWNC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 18:13:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1124BCA
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:13:01 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PJWtVG012049
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:13:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=bIIp5K5QB0Eof9sKkTcb4scU1sBDqlWB+6DpFsZ+QcI=;
 b=JtScl4j73bbhp6YmR0JELvFvKn4NaSvPZkkV6sfwjXk/ZFhhjxQQSID4KssjTRr8Ddt4
 3pdkfBS60NoH6U3E241QqnZVnllqS5RYaPfI1PAUpDUf9CFvgkPd9F2OmF+RtTnqpV28
 tYOR5DO+/bOLTAAVxoOBjtyF7SeqC7poGgw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hgetsvd5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:13:01 -0700
Received: from twshared6324.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 15:13:00 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 457FA2927AF1; Mon, 25 Jul 2022 15:12:59 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v4 0/7] btrfs: Annotate wait events with lockdep
Date:   Mon, 25 Jul 2022 15:11:44 -0700
Message-ID: <20220725221150.3959022-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pBc23SA67I2r46TVGAxMCaJoq8-Zc_mB
X-Proofpoint-GUID: pBc23SA67I2r46TVGAxMCaJoq8-Zc_mB
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes from v3:
  1) Put the lockdep annotation macros in a separate patch and explaned
  in more detail how the annotations work in the changelog. Also made
  small changes to the changelogs of the rest of the patches accordingly
  (suggested by Sweet Tea Dorminy).
  2) Fixed the build warning related to the change of the lockdep class
  of struct inode's mapping->invalidate_lock.

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

Ioannis Angelakopoulos (7):
  btrfs: Add macros for annotating wait events with lockdep
  btrfs: Add a lockdep annotation for the num_writers wait event
  btrfs: Add a lockdep annotation for the num_extwriters wait event
  btrfs: Add lockdep annotations for the transaction states wait events
  btrfs: Add a lockdep annotation for the pending_ordered wait event
  btrfs: Change the lockdep class of struct inode's invalidate_lock
  btrfs: Add a lockdep annotation for the ordered extents wait event

 fs/btrfs/ctree.h            |  82 ++++++++++++++++++++++++++++
 fs/btrfs/disk-io.c          |  13 +++++
 fs/btrfs/free-space-cache.c |  10 ++++
 fs/btrfs/inode.c            |  13 +++++
 fs/btrfs/ordered-data.c     |  21 +++++++
 fs/btrfs/transaction.c      | 106 ++++++++++++++++++++++++++++++++----
 6 files changed, 234 insertions(+), 11 deletions(-)

--=20
2.30.2


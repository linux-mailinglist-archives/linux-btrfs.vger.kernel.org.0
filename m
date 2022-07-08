Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5C56C496
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 01:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbiGHUJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jul 2022 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiGHUJV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jul 2022 16:09:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FC17073
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jul 2022 13:09:20 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268IrMRO005118
        for <linux-btrfs@vger.kernel.org>; Fri, 8 Jul 2022 13:09:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=yyrCC5yL3wJELb20juOMgWRr0Vsx7Hg8oHtJNixyL3w=;
 b=EI8y+1d+GwY6OYRH0qLWWISHKIJCYSXWjEnIh0NuMQQNKA4YEc89YrqioCujUw/VPcPO
 lIEud4A650dEoY+cLT+lXkqz1kENhYk1iCxFYjSl3i18Ea6OV8MTAEvRkDU2tWeVOVK8
 MMtimZj06klTAdaWPQ7+feyuV2Yxse/y53M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h67d26upy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jul 2022 13:09:20 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 8 Jul 2022 13:09:19 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 56B401D70B96; Fri,  8 Jul 2022 13:09:18 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 0/2] btrfs: Annotate transaction wait events with
Date:   Fri, 8 Jul 2022 13:08:28 -0700
Message-ID: <20220708200829.3682503-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vNggfVa7pmo4YGAMWgurcfsF7ggKzMgh
X-Proofpoint-ORIG-GUID: vNggfVa7pmo4YGAMWgurcfsF7ggKzMgh
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_17,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With this patch series we annotate wait events in btrfs transactions
with lockdep to catch deadlocks involving these wait events.

Recently the btrfs developers fixed a non trivial deadlock involving
wait events (https://lore.kernel.org/linux-btrfs/20220614131413.GJ20633@twi=
n.jikos.cz/)

Currently lockdep is unable to catch these deadlocks since it does not
support wait events by default.

With our lockdep annotations we train lockdep to track these wait events
and catch more potential deadlocks.

Specifically, we annotate two wait events in fs/btrfs/transaction.c:
  1) The num_writers wait event
  2) The num_extwriters wait event

Ioannis Angelakopoulos (2):
  btrfs: Add a lockdep model for the num_writers wait event
  btrfs: Add a lockdep annotation for the num_extwriters wait event

 fs/btrfs/ctree.h       | 15 ++++++++++++
 fs/btrfs/disk-io.c     | 10 ++++++++
 fs/btrfs/transaction.c | 55 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 76 insertions(+), 4 deletions(-)

--=20
2.30.2


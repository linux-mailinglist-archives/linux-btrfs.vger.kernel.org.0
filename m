Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD878546ED6
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbiFJUyi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 16:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350757AbiFJUye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 16:54:34 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF05B3B552
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:54:31 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AIDdX5028641
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:54:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=oafwMQF86O47Hs1oXnh9XRU3PQPpS69Yox7arjXZhaw=;
 b=XfUoOXwaBeNli0vhqe1vv/0xoMFeEgI554kmqijVgOEqyTT6DoPqgnLY646dmDvBUeOT
 ubaOLYXfupeUkQWuvuukpkRFWnmFSXupSFaZzNMKa6G1Igv7e9mP6hREsTg+6Z8nWBCT
 i/fFwsCSaR80nm2AMSI3oTrCV6uU09fspmU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmb208wbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 13:54:31 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:54:30 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 51DCED3932E; Fri, 10 Jun 2022 13:54:26 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 0/2] btrfs: Expose BTRFS commit stats through sysfs
Date:   Fri, 10 Jun 2022 13:54:05 -0700
Message-ID: <20220610205406.301397-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UasRpAQ5fZgCtKwCcs44iHMxOjrirWWa
X-Proofpoint-ORIG-GUID: UasRpAQ5fZgCtKwCcs44iHMxOjrirWWa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Ioannis Angelakopoulos (2):
  btrfs: Add the capability of getting commit stats in BTRFS
  btrfs: Expose the BTRFS commit stats through sysfs

 fs/btrfs/ctree.h       | 14 ++++++++++++
 fs/btrfs/disk-io.c     |  6 ++++++
 fs/btrfs/sysfs.c       | 48 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/transaction.c | 38 ++++++++++++++++++++++++++++++++-
 4 files changed, 105 insertions(+), 1 deletion(-)

--=20
2.30.2


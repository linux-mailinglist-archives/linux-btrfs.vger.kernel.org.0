Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EB759097D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 02:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiHLASK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 20:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHLASK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 20:18:10 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600BA419AE
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:18:09 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BLVt4M023050
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:18:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ku5Cx+z/Ge8qRXjlFR1oUYT2JiXRLWxHZgjLr8klREM=;
 b=CAcXxw7mcgEaUJLI8LTZifIcUNnopfCLluzPMKxFCLxdtWdDUmAV5Sp9umBy7vfs9fOw
 SdmbrzqW/IUbG1QZbPDKZXUcS94/fb6ZsxG2rwLPOmO3Lb/IITIoEX0Ee/uty3m5x+um
 aodwwhlB//9WxOUfAPOPYNGVfJ83KlajN4Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9rv8vy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:18:08 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 11 Aug 2022 17:18:07 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id 9B94C33AB936; Thu, 11 Aug 2022 17:18:00 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 0/1] btrfs: Add macros for multilevel wait event annotations with lockdep
Date:   Thu, 11 Aug 2022 17:17:34 -0700
Message-ID: <20220812001734.1587514-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g3l1cqVhxUi7jGQuijdpmF0gHsARugxa
X-Proofpoint-GUID: g3l1cqVhxUi7jGQuijdpmF0gHsARugxa
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

with this patch series we add two new macros, which can be used for
multilevel (nested) wait event annotations with lockdep.

The new macros added in fs/btrfs/ctree.h are:
  1) btrfs_might_wait_for_event_nested()
  2) btrfs_lockdep_acquire_nested()

Ioannis Angelakopoulos (1):
  btrfs: Macros for multilevel annotations of wait events with lockdep

 fs/btrfs/ctree.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--=20
2.30.2


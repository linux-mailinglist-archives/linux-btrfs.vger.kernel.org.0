Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27D7591561
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 20:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiHLSSR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 14:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiHLSSQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 14:18:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889AB2D96
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 11:18:15 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CF7XdB011640
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 11:18:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=EE8tQK9LaJZzaPKXhVQPp+3vdIoOPxqWW4AKWi9R2cM=;
 b=mbTf/vHTnK1BG8p+6hHo27FhY/0ewn3wJXArnKtlViIrunUt8xfwH0QPWkC5oA46jqwa
 q1Ke5HoqSod4MKr7YSxi5LCjLoREzy3aGhnUpTC6ISS6lPPs5KV5bwqnn68V6q4+UZFF
 DhAy5fDdFZX9XcjH8g0TrZw3G0bXjegYNZo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9t75xgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 11:18:14 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 12 Aug 2022 11:18:13 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id AE377341BB6A; Fri, 12 Aug 2022 11:18:06 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 0/1] btrfs: Add a lockdep annotation for the reservation space wait event
Date:   Fri, 12 Aug 2022 11:17:54 -0700
Message-ID: <20220812181754.1535281-1-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nK1A7KxbrFylJdp3uMoYiSOBpOmbFcJV
X-Proofpoint-ORIG-GUID: nK1A7KxbrFylJdp3uMoYiSOBpOmbFcJV
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
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

with this patch series we add a lockdep annotation for the reservation
space wait event in btrfs.

The condition modification and signaling for the waitqueue are
protected by the space_info->lock spinlock for the most part.

The function that can potentially be involved in a deadlock and is not
protected by the spinlock is flush_space() in fs/btrfs/space-info.c.
Thus we place the lockdep annotations in that function.

Important!!! This patch series depends on this patch series
https://lore.kernel.org/linux-btrfs/20220812001734.1587514-1-iangelak@fb.co=
m/T/#t

Ioannis Angelakopoulos (1):
  btrfs: Annotate the reservation space wait event with lockdep

 fs/btrfs/ctree.h      |  9 +++++++++
 fs/btrfs/disk-io.c    |  1 +
 fs/btrfs/space-info.c | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

--=20
2.30.2


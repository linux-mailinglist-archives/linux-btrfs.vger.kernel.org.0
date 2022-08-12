Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8459097F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiHLASp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 20:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHLASo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 20:18:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FEA419AE
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:18:43 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27BM4UHE000716
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:18:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jYWJTEFu8edo0IWwQaSTgwfkemLX5hPVEm/STkeDLFc=;
 b=nOhe1L3ZNjWkbFMESlQKoJm9wci2EJJFGOOkCnG5t6b0yZKY87jCi75Op0OZLc3Bqjfz
 +rbVGhfXNUZVQJGGgGPN4UGVSLM0sgh8LbTMUn9fO1u3UOHsaDqADaKflx3R1SehScHp
 x/20iqlqE7dPQDaDg0X9S8/1R+a/NNwT6M8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hwa84rm2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Aug 2022 17:18:42 -0700
Received: from twshared8442.02.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 17:18:39 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id A082833AB9FA; Thu, 11 Aug 2022 17:18:38 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 1/1] btrfs: Macros for multilevel annotations of wait events with lockdep
Date:   Thu, 11 Aug 2022 17:17:36 -0700
Message-ID: <20220812001734.1587514-2-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812001734.1587514-1-iangelak@fb.com>
References: <20220812001734.1587514-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nVLxvfB_djweYDEW0nAUNNk6b3eu33dm
X-Proofpoint-ORIG-GUID: nVLxvfB_djweYDEW0nAUNNk6b3eu33dm
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

The new macros are similar to the generic lockdep annotation macros used =
to
annotate wait events in btrfs in fs/btrfs/ctree.h. However, the new macro=
s
take as a parameter the subclass of the lockdep map, which can be used fo=
r
a multilevel annotation of a wait event.

The new macros introduced are:
  1) btrfs_might_wait_for_event_nested()
  2) btrfs_lockdep_acquire_nested()

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 51c480439263..44837545eef8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1211,6 +1211,16 @@ enum btrfs_lockdep_trans_states {
 		rwsem_release(&owner->lock##_map, _THIS_IP_);			\
 	} while (0)
=20
+/*
+ * Same as the btrfs_wait_for_event() macro but used for multilevel lock=
dep
+ * annotations.
+ */
+#define btrfs_might_wait_for_event_nested(owner, lock, subclass)		\
+	do {									\
+		rwsem_acquire(&owner->lock##_map, subclass, 0, _THIS_IP_);	\
+		rwsem_release(&owner->lock##_map, _THIS_IP_);			\
+	} while (0)
+
 /*
  * Protection for the resource/condition of a wait event.
  *
@@ -1225,6 +1235,13 @@ enum btrfs_lockdep_trans_states {
 #define btrfs_lockdep_acquire(owner, lock)					\
 	rwsem_acquire_read(&owner->lock##_map, 0, 0, _THIS_IP_)
=20
+/*
+ * Same as the btrfs_lockdep_acquire() macro but used for multilevel loc=
kdep
+ * annotations.
+ */
+#define btrfs_lockdep_acquire_nested(owner, lock, subclass)			\
+	rwsem_acquire_read(&owner->lock##_map, subclass, 0, _THIS_IP_)
+
 /*
  * Used after signaling the condition for a wait event to release the lo=
ckdep
  * map held by a reader thread.
--=20
2.30.2


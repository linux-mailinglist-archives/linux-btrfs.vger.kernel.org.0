Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB359156C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiHLSVm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLSVk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 14:21:40 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D463FB2DA1
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 11:21:39 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CF7Pd1008393
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 11:21:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZMG/TG3V27X6vnqEbrVYBPCj02pa/gJKPnsRoyRdYRs=;
 b=eKcLbw4qIl/q0r9U9vO4DsuVgWHs93/gQ2j3pTADwUjw5+MZmwg0SbJHeWwHtq6ov4vP
 r+H9KxkwaseRwQIyL7vlNuJMKY4W3E/wzmW6uqmlT3T+o8AIs7NDA1qpJvqquFT2Z9LY
 Kn4mBwHbhMPEtTAlYDGmHTB9+M5YoyhHEZM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9r4nycr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 11:21:39 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 12 Aug 2022 11:21:37 -0700
Received: by devvm7778.ftw0.facebook.com (Postfix, from userid 558217)
        id A4FB3341BC7F; Fri, 12 Aug 2022 11:19:04 -0700 (PDT)
From:   Ioannis Angelakopoulos <iangelak@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 1/1] btrfs: Annotate the reservation space wait event with lockdep
Date:   Fri, 12 Aug 2022 11:17:56 -0700
Message-ID: <20220812181754.1535281-2-iangelak@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812181754.1535281-1-iangelak@fb.com>
References: <20220812181754.1535281-1-iangelak@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: InSj5v22zRFPSAVJpTCmSV5I9C5W4Ewi
X-Proofpoint-GUID: InSj5v22zRFPSAVJpTCmSV5I9C5W4Ewi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a lockdep annotation for the reservation space wait event.

This wait event is special in the sense that its condition modification a=
nd
waitqueue signaling are protected by the space_info->lock spinlock.

However, that is not the case with flush_space() in fs/btrfs/space-info.c
which is usually part of the execution context that leads to the signalin=
g
of the reservation space waitqueue. This function is not protected by the
space_info->lock thus we place our annotation in flush_space().

Since, flush_space() operates differently depending on the flushing state=
,
we use a multilevel lockdep map where each subclass/level corresponds to
each flushing state.

Signed-off-by: Ioannis Angelakopoulos <iangelak@fb.com>
---
 fs/btrfs/ctree.h      |  9 +++++++++
 fs/btrfs/disk-io.c    |  1 +
 fs/btrfs/space-info.c | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 44837545eef8..9925b79cebf1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1104,6 +1104,7 @@ struct btrfs_fs_info {
 	struct lockdep_map btrfs_state_change_map[4];
 	struct lockdep_map btrfs_trans_pending_ordered_map;
 	struct lockdep_map btrfs_ordered_extent_map;
+	struct lockdep_map btrfs_reservation_space_map;
=20
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
@@ -1194,6 +1195,14 @@ enum btrfs_lockdep_trans_states {
 	BTRFS_LOCKDEP_TRANS_COMPLETED,
 };
=20
+enum btrfs_reservation_space_states {
+	BTRFS_LOCKDEP_FLUSH_DELAYED_ITEMS,
+	BTRFS_LOCKDEP_FLUSH_DELALLOC_FULL,
+	BTRFS_LOCKDEP_FLUSH_DELAYED_REFS,
+	BTRFS_LOCKDEP_ALLOC_CHUNK_FORCE,
+	BTRFS_LOCKDEP_RUN_DELAYED_IPUTS,
+};
+
 /*
  * Lockdep annotation for wait events.
  *
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6268dafeeb2d..a107b6954a8b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2996,6 +2996,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_in=
fo)
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_num_extwriters);
 	btrfs_lockdep_init_map(fs_info, btrfs_trans_pending_ordered);
 	btrfs_lockdep_init_map(fs_info, btrfs_ordered_extent);
+	btrfs_lockdep_init_map(fs_info, btrfs_reservation_space);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_commit_start,
 				     BTRFS_LOCKDEP_TRANS_COMMIT_START);
 	btrfs_state_lockdep_init_map(fs_info, btrfs_trans_unblocked,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 477e57ace48d..96631d1a9d82 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -702,7 +702,10 @@ static void flush_space(struct btrfs_fs_info *fs_inf=
o,
 			ret =3D PTR_ERR(trans);
 			break;
 		}
+		btrfs_lockdep_acquire_nested(fs_info, btrfs_reservation_space,
+					     BTRFS_LOCKDEP_FLUSH_DELAYED_ITEMS);
 		ret =3D btrfs_run_delayed_items_nr(trans, nr);
+		btrfs_lockdep_release(fs_info, btrfs_reservation_space);
 		btrfs_end_transaction(trans);
 		break;
 	case FLUSH_DELALLOC:
@@ -710,8 +713,11 @@ static void flush_space(struct btrfs_fs_info *fs_inf=
o,
 	case FLUSH_DELALLOC_FULL:
 		if (state =3D=3D FLUSH_DELALLOC_FULL)
 			num_bytes =3D U64_MAX;
+		btrfs_lockdep_acquire_nested(fs_info, btrfs_reservation_space,
+					     BTRFS_LOCKDEP_FLUSH_DELALLOC_FULL);
 		shrink_delalloc(fs_info, space_info, num_bytes,
 				state !=3D FLUSH_DELALLOC, for_preempt);
+		btrfs_lockdep_release(fs_info, btrfs_reservation_space);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
 	case FLUSH_DELAYED_REFS:
@@ -720,11 +726,14 @@ static void flush_space(struct btrfs_fs_info *fs_in=
fo,
 			ret =3D PTR_ERR(trans);
 			break;
 		}
+		btrfs_lockdep_acquire_nested(fs_info, btrfs_reservation_space,
+					     BTRFS_LOCKDEP_FLUSH_DELAYED_REFS);
 		if (state =3D=3D FLUSH_DELAYED_REFS_NR)
 			nr =3D calc_reclaim_items_nr(fs_info, num_bytes);
 		else
 			nr =3D 0;
 		btrfs_run_delayed_refs(trans, nr);
+		btrfs_lockdep_release(fs_info, btrfs_reservation_space);
 		btrfs_end_transaction(trans);
 		break;
 	case ALLOC_CHUNK:
@@ -746,10 +755,13 @@ static void flush_space(struct btrfs_fs_info *fs_in=
fo,
 			ret =3D PTR_ERR(trans);
 			break;
 		}
+		btrfs_lockdep_acquire_nested(fs_info, btrfs_reservation_space,
+					     BTRFS_LOCKDEP_ALLOC_CHUNK_FORCE);
 		ret =3D btrfs_chunk_alloc(trans,
 				btrfs_get_alloc_profile(fs_info, space_info->flags),
 				(state =3D=3D ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
+		btrfs_lockdep_release(fs_info, btrfs_reservation_space);
 		btrfs_end_transaction(trans);
=20
 		/*
@@ -777,8 +789,11 @@ static void flush_space(struct btrfs_fs_info *fs_inf=
o,
 		 * bunch of pinned space, so make sure we run the iputs before
 		 * we do our pinned bytes check below.
 		 */
+		btrfs_lockdep_acquire_nested(fs_info, btrfs_reservation_space,
+					     BTRFS_LOCKDEP_RUN_DELAYED_IPUTS);
 		btrfs_run_delayed_iputs(fs_info);
 		btrfs_wait_on_delayed_iputs(fs_info);
+		btrfs_lockdep_release(fs_info, btrfs_reservation_space);
 		break;
 	case COMMIT_TRANS:
 		ASSERT(current->journal_info =3D=3D NULL);
@@ -1444,6 +1459,16 @@ static void wait_reserve_ticket(struct btrfs_fs_in=
fo *fs_info,
 	DEFINE_WAIT(wait);
 	int ret =3D 0;
=20
+#ifdef CONFIG_LOCKDEP
+	int state =3D BTRFS_LOCKDEP_FLUSH_DELAYED_ITEMS;
+
+	while (state <=3D BTRFS_LOCKDEP_RUN_DELAYED_IPUTS) {
+		btrfs_might_wait_for_event_nested(fs_info, btrfs_reservation_space,
+						  state);
+		state++;
+	}
+#endif
+
 	spin_lock(&space_info->lock);
 	while (ticket->bytes > 0 && ticket->error =3D=3D 0) {
 		ret =3D prepare_to_wait_event(&ticket->wait, &wait, TASK_KILLABLE);
--=20
2.30.2


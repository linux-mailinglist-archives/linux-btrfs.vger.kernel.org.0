Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BD0722F1F
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjFETD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjFETDl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 15:03:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D4D10D
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 12:03:39 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355H8etL031329
        for <linux-btrfs@vger.kernel.org>; Mon, 5 Jun 2023 12:03:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=2EwcFXzaIESHqt8mxrKOSFefhZbDynuJobs2QU4ICUI=;
 b=K59HBQCe4v+ZPTo1O0ZD78NhCzmLnzR81Sh34e6y3CRssVNPJydsV1Hgs94mP44IxCGm
 kS6qmSIbTeV+CNM6C9p2bebUFtv4oZPrhGIvwOZE9nD0PfK0UGMJAuxNJWahGlgnSmLt
 UroZ0RDXsQ/STtCa2wSVvW1NQWtxQEej9ZU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r1fxpaw7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 12:03:38 -0700
Received: from twshared5974.02.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 12:03:37 -0700
Received: by devbig003.nao1.facebook.com (Postfix, from userid 8731)
        id 4C6121AA06570; Mon,  5 Jun 2023 12:03:29 -0700 (PDT)
From:   Chris Mason <clm@fb.com>
To:     <linux-btrfs@vger.kernel.org>, <dsterba@suse.com>,
        <josef@toxicpanda.com>, <boris@bur.io>
Subject: [PATCH] btrfs: properly enable async discard when switching from RO->RW
Date:   Mon, 5 Jun 2023 12:03:15 -0700
Message-ID: <20230605190315.2121377-1-clm@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WKO6GmpIlkw4rRpDhhMorEkCooJLskCb
X-Proofpoint-ORIG-GUID: WKO6GmpIlkw4rRpDhhMorEkCooJLskCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

async discard uses the BTRFS_FS_DISCARD_RUNNING bit in the fs_info to for=
ce
discards off when the filesystem has aborted or we're generally not able
to run discards.  This gets flipped on when we're mounted rw, and also
when we go from ro->rw.

Commit 63a7cb13071842 enabled async discard by default, and this meant
mount -o ro /dev/xxx /yyy had async discards turned on.

Unfortunately, this meant our check in btrfs_remount_cleanup() would see
that discards are already on:

    /* If we toggled discard async */
    if (!btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
	btrfs_test_opt(fs_info, DISCARD_ASYNC))
	    btrfs_discard_resume(fs_info);

So, we'd never call btrfs_discard_resume() when remounting the root
filesystem from ro->rw.

drgn shows this really nicely:

import os
import sys

from drgn.helpers.linux.fs import path_lookup
from drgn import NULL, Object, Type, cast

def btrfs_sb(sb):
    return cast("struct btrfs_fs_info *", sb.s_fs_info)

if len(sys.argv) =3D=3D 1:
    path =3D "/"
else:
    path =3D sys.argv[1]

fs_info =3D cast("struct btrfs_fs_info *", path_lookup(prog, path).mnt.mn=
t_sb.s_fs_info)

BTRFS_FS_DISCARD_RUNNING =3D 1 << prog['BTRFS_FS_DISCARD_RUNNING']
if fs_info.flags & BTRFS_FS_DISCARD_RUNNING:
    print("discard running flag is on")
else:
    print("discard running flag is off")

[root]# mount | grep nvme
/dev/nvme0n1p3 on / type btrfs
(rw,relatime,compress-force=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2=
,subvolid=3D5,subvol=3D/)

[root]# ./discard_running.drgn
discard running flag is off

[root]# mount -o remount,discard=3Dsync /
[root]# mount -o remount,discard=3Dasync /
[root]# ./discard_running.drgn
discard running flag is on

The fix used here is calling btrfs_discard_resume() when we're going
from ro->rw.  It already checks to make sure the async discard flag is
on, so it'll do the right thing.

Fixes: 63a7cb13071842 ("btrfs: auto enable discard=3Dasync when possible"=
)

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Chris Mason <clm@fb.com>
---
 fs/btrfs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ec18e2210602..1e212f964224 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1841,6 +1841,12 @@ static int btrfs_remount(struct super_block *sb, i=
nt *flags, char *data)
 		btrfs_clear_sb_rdonly(sb);
=20
 		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
+
+		/*
+		 * if we've gone from readonly -> read/write, we need to
+		 * get our sync/async discard lists in the right state.
+		 */
+		btrfs_discard_resume(fs_info);
 	}
 out:
 	/*
--=20
2.34.1


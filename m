Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB892E2B83
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Dec 2020 13:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgLYMrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Dec 2020 07:47:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:45065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLYMrL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Dec 2020 07:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608900335;
        bh=bPllcj1R4jv942m5L9abT8t/bEwX5ne5qlWM0csAsJk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MFw3KyPRCSEMOyfW7kRK63maDAxvMvEkrDOBxYoj5QZNaS/AKk96BvIloKUQFRneM
         0eGcfQPzw1c/ObOpkgwCFvl2xQVxYCd1qPi/wJ3TUKOfam0pZNBNzIN5+Ap9W36DWH
         Kc3x8Cu+wcyTegbdISwlc3Kmbb/23YnnWEc8ZY44=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([62.143.246.89]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbAh0-1kLdVm3gWu-00bauB; Fri, 25
 Dec 2020 13:45:34 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] fs: btrfs: simplify close_ctree_fs_info()
Date:   Fri, 25 Dec 2020 13:45:25 +0100
Message-Id: <20201225124525.17707-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WLMRotUOn7TU+JmXJq5tDyMr8HDAangBvC9wKY4onD3P99WjALO
 qIf28KKVoSpydiqJQEBgI/fNVHrqJV0Uaj8oGFe0Q3oe2n1tqxkncLvdo1KlxpfPknbFY/a
 MqxdMiNc3qWFe/h1c1MaUjAmE5tnd8sI2cvxGULnntcYZlAoQzaPArN6wYpCabotKuFWqzk
 wS+tSZe0urmAa39I/E6aQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7hU3RZRbOcU=:PxemAzJmQaEvGhguQStXHk
 IpntOuzc3a/N+Yb9f3roT5HhE8AjzC07r9VpJ9tOkvfX52CcDAaVrvCQuqiB43vg8gs8DQgqw
 ctJjOvwS3NnDTZfglggVbunKc2mneqXXv+GI0q7u4eu7RAk3VelkiP9pBJ92NbqFuWhm7SKqh
 zvZsDTyGhwgw2AdS+flAEEc59SNvBKnmchcnTRD2PHN50eVjXfZla7qvHSx5+wjs0D18smGSf
 Tz32pKdzUkgw3nJS/JbCvzPywGm+FWLnTb7jusGVDZvswd0Qqe4Xgmv5SrTOZZmLYEKjxnk4Q
 r+7H2IfRbffE5HjFp71/kPnyMFAQYWIj7qdkAEshbhBWft6Nn+wO8oKPFwYU5D4ENdkONWJST
 rK7E3UTS5QMIlzYOJkWkYchU3LXUlyPb79VypiAwlchkyA7gyhvIU8x6g3yH/jfc6/uPwbYJN
 tc+kjxkddK696mhs6IFtzbKZLWb9ZrENl/Iazz7pn6f4Aq9F09DB36sGKFosgqXSjYBc3kwbN
 219lTPXzr2xR2ZhcG1GeoKU6GV6t5j4vCZ0UELFQi7b5FwUuiKruedMQD3lKo0CaDNXcOAXVy
 rvj/548adyDQVqZ3jC0A2ZhTiCbcppDGXSeSYUEvWbrRQ37o/hSEVZ5TihHB9gwN37khMkiJx
 4HKgPIJbhAzJCzbqLUFLo4s4ro/wwu3a2IEqrpDh4dZS0X7HaBbxcsiYpIW76xUryMI032C4L
 /fS/o+2YTuntvBcY2cEtPiv1vrSRStAIoTUE6SesdOJUA9s6WR1Hhb6rPjN2Gdjq2AmjlSl+P
 LObSHFnaAfZFPGSZ/6FOI5kByL0K/ziON0iQoZlJZZOnPHLgWc49x7wfQSI4y0pUbwGQViyzj
 u67gzFDtbV5D7Xll11uQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At the beginning of close_ctree_fs_info() the value 0 is assigned to err
and never changed before testing it.

Let's get rid of the superfluous variable.

Fixes: f06bfcf54d0e ("fs: btrfs: Crossport open_ctree_fs_info() from btrfs=
-progs")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 fs/btrfs/disk-io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 01e7cee520..b332ecb796 100644
=2D-- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1030,7 +1030,6 @@ out:
 int close_ctree_fs_info(struct btrfs_fs_info *fs_info)
 {
 	int ret;
-	int err =3D 0;

 	free_fs_roots_tree(&fs_info->fs_root_tree);

@@ -1038,9 +1037,7 @@ int close_ctree_fs_info(struct btrfs_fs_info *fs_inf=
o)
 	ret =3D btrfs_close_devices(fs_info->fs_devices);
 	btrfs_cleanup_all_caches(fs_info);
 	btrfs_free_fs_info(fs_info);
-	if (!err)
-		err =3D ret;
-	return err;
+	return ret;
 }

 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid)
=2D-
2.29.2


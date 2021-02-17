Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7E31D541
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 07:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhBQGFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 01:05:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhBQGFp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 01:05:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11H60GlI005907;
        Wed, 17 Feb 2021 06:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=IV9DUOBZsJgn3sW/ZDjfRk2u64J3qZbzCRAclBjXrAQ=;
 b=hTxcesg4JEE2Qd0fLfHoeo3VNzobykQKOF3sAhuHbiqX59rG4Zwww2/TlrPeRe1vFYq+
 PqmEzf611uGWn4InyMP22M5DbxiqTIlXFW2EMu/ZSx/XniS3TtmN0hO9XJ510JHRFsBW
 CVcpA9z+O7lLnJnL56G+5bCJXS6y8JmKQgjaY/bt96apsMxRJi5oJnwIOFE6ehWJbg8k
 mxf/miwKTuubopTtR81YyG0M6jv3yVNXuvmqfWBD4VBwhbSVLS6LjwdF/VLmaqON/lyD
 KBNBnZZItpB1goWjPJ7NJP+R8kZJ9CxNDc6/MBjUXccLuCY8YQKZgxycVmEh4tPQZ9qp tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36p7dnh38n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 06:04:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11H60DRa177255;
        Wed, 17 Feb 2021 06:04:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 36prnyu6wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 06:04:44 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11H64g3R006439;
        Wed, 17 Feb 2021 06:04:42 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Feb 2021 22:04:41 -0800
Date:   Wed, 17 Feb 2021 09:04:34 +0300
From:   Dan Carpenter <dancarpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Arne Jansen <sensille@gmx.net>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: prevent potential out of bounds in
 btrfs_ioctl_snap_create_v2()
Message-ID: <YCyx8u40HaplP7a+@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102170046
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The problem is we're copying "inherit" from user space but we don't
necessarily know that we're copying enough data for a 64 byte
struct.  Then the next problem is that "inherit" has a variable size
array at the end, and we have to verify that array is the size we
expected.

Fixes: 6f72c7e20dba: ("Btrfs: add qgroup inheritance")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Presumably only root can create snapshots.  Anyway, I have not tested
this fix.  I believe it is correct, of course.  But perhaps it's best
to check.

The calculation for the number of elements in the array was copied from
btrfs_qgroup_inherit().

 fs/btrfs/ioctl.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 384d33ab02c7..9d7b24d3e3bd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1941,15 +1941,34 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
 		readonly = true;
 	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
-		if (vol_args->size > PAGE_SIZE) {
+		u64 nums;
+
+		if (vol_args->size < sizeof(*inherit) ||
+		    vol_args->size > PAGE_SIZE) {
 			ret = -EINVAL;
 			goto free_args;
 		}
+
 		inherit = memdup_user(vol_args->qgroup_inherit, vol_args->size);
 		if (IS_ERR(inherit)) {
 			ret = PTR_ERR(inherit);
 			goto free_args;
 		}
+
+		/* quick and dirty checks to prevent integer overflows */
+		if (inherit->num_qgroups > PAGE_SIZE ||
+		    inherit->num_ref_copies > PAGE_SIZE ||
+		    inherit->num_excl_copies > PAGE_SIZE) {
+			ret = -EINVAL;
+			goto free_inherit;
+		}
+
+		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
+		       2 * inherit->num_excl_copies;
+		if (vol_args->size != struct_size(inherit, qgroups, nums)) {
+			ret = -EINVAL;
+			goto free_inherit;
+		}
 	}
 
 	ret = __btrfs_ioctl_snap_create(file, vol_args->name, vol_args->fd,
-- 
2.30.0


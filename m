Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02F2DD2A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgLQONH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:13:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQONH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:13:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHEAcW5098595;
        Thu, 17 Dec 2020 14:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=yRdwBycKg4gzuoLeaMe2PQhmu2dIX+DaYWzTMpTvpKY=;
 b=HUv7BB9KPWoeOlvSPmMmDOgDLYphSx0qn3nDvEE+pTG/zvnac6T5QCN/qXQVUz/b6jc6
 I36MISK90JwL+wrkZ/2sdeTBjtahwDVQbA/GecSf7fLQ1jE/wEYffaMRtNTWy12jykis
 1M7imipqeSQWXGJNZQOS6Gc8zPnTf9xIOaniVyy1bsYv9N3Hig/BvKFpJQoYRw1Vt0cx
 cgrpme1kW9n7bWrgDbxzauziS8JA0A0R4a/ejuWpAuteSMMwKrqyPbrV65/ApPtHoMP+
 2mC9dt++9Smp4b6Hafp+touc+e1YzLmyvelnNsEN9l2rCIoBMJVuybNO77yyRd+UoH97 /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35cn9rnj8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Dec 2020 14:12:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BHEBG6n028977;
        Thu, 17 Dec 2020 14:12:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 35g3renfb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 14:12:21 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BHECKVt014667;
        Thu, 17 Dec 2020 14:12:21 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Dec 2020 06:12:20 -0800
Date:   Thu, 17 Dec 2020 17:12:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: do an allocation earlier during snapshot creation
Message-ID: <X9tnPl6nZfusgfre@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012170100
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ Sorry David, the complain script uses git blame and it just picked
  you.  And then I decided to keep the address because your email is
  still active and you seem like an expert.  -dan ]

Hello David Sterba,

The patch a1ee73626844: "btrfs: do an allocation earlier during
snapshot creation" from Nov 10, 2015, leads to the following static
checker warning:

	fs/btrfs/ioctl.c:890 create_snapshot()
	warn: 'pending_snapshot' not removed from list

fs/btrfs/ioctl.c
   809  
   810          pending_snapshot = kzalloc(sizeof(*pending_snapshot), GFP_KERNEL);
                ^^^^^^^^^^^^^^^^
Allocated here.

   811          if (!pending_snapshot)
   812                  return -ENOMEM;
   813  
   814          ret = get_anon_bdev(&pending_snapshot->anon_dev);
   815          if (ret < 0)
   816                  goto free_pending;
   817          pending_snapshot->root_item = kzalloc(sizeof(struct btrfs_root_item),
   818                          GFP_KERNEL);
   819          pending_snapshot->path = btrfs_alloc_path();
   820          if (!pending_snapshot->root_item || !pending_snapshot->path) {
   821                  ret = -ENOMEM;
   822                  goto free_pending;
   823          }
   824  
   825          btrfs_init_block_rsv(&pending_snapshot->block_rsv,
   826                               BTRFS_BLOCK_RSV_TEMP);
   827          /*
   828           * 1 - parent dir inode
   829           * 2 - dir entries
   830           * 1 - root item
   831           * 2 - root ref/backref
   832           * 1 - root of snapshot
   833           * 1 - UUID item
   834           */
   835          ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root,
   836                                          &pending_snapshot->block_rsv, 8,
   837                                          false);
   838          if (ret)
   839                  goto free_pending;
   840  
   841          pending_snapshot->dentry = dentry;
   842          pending_snapshot->root = root;
   843          pending_snapshot->readonly = readonly;
   844          pending_snapshot->dir = dir;
   845          pending_snapshot->inherit = inherit;
   846  
   847          trans = btrfs_start_transaction(root, 0);
   848          if (IS_ERR(trans)) {
   849                  ret = PTR_ERR(trans);
   850                  goto fail;
   851          }
   852  
   853          spin_lock(&fs_info->trans_lock);
   854          list_add(&pending_snapshot->list,
   855                   &trans->transaction->pending_snapshots);
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Added to the list here.

   856          spin_unlock(&fs_info->trans_lock);
   857  
   858          ret = btrfs_commit_transaction(trans);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This will clean empty the ->pending_snapshots list when we call
create_pending_snapshots() but it's possible to fail before that
happens.

Possibly one fix would be to clear out the ->pending_snapshots list in
the __btrfs_end_transaction() function.

   859          if (ret)
   860                  goto fail;
   861  
   862          ret = pending_snapshot->error;
   863          if (ret)
   864                  goto fail;
   865  
   866          ret = btrfs_orphan_cleanup(pending_snapshot->snap);
   867          if (ret)
   868                  goto fail;
   869  
   870          inode = btrfs_lookup_dentry(d_inode(dentry->d_parent), dentry);
   871          if (IS_ERR(inode)) {
   872                  ret = PTR_ERR(inode);
   873                  goto fail;
   874          }
   875  
   876          d_instantiate(dentry, inode);
   877          ret = 0;
   878          pending_snapshot->anon_dev = 0;
   879  fail:
   880          /* Prevent double freeing of anon_dev */
   881          if (ret && pending_snapshot->snap)
   882                  pending_snapshot->snap->anon_dev = 0;
   883          btrfs_put_root(pending_snapshot->snap);
   884          btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
   885  free_pending:
   886          if (pending_snapshot->anon_dev)
   887                  free_anon_bdev(pending_snapshot->anon_dev);
   888          kfree(pending_snapshot->root_item);
   889          btrfs_free_path(pending_snapshot->path);
   890          kfree(pending_snapshot);
                ^^^^^^^^^^^^^^^^^^^^^^^
If btrfs_commit_transaction() fails too early then this is freed but
it's still in the ->pending_snapshots list leading to a use after free.

   891  
   892          return ret;
   893  }

regards,
dan carpenter

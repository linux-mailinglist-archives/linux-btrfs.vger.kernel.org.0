Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7473C30D5A9
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 09:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhBCIzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 03:55:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49318 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhBCIzr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Feb 2021 03:55:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1138rZO4121978;
        Wed, 3 Feb 2021 08:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=mEROU3G96NOjA8/DfxVo6kfkokb+xge1BtRHY19+Kws=;
 b=NqXP5RnR9jYmDivy1CBdUyf8qtymQSP0tsPI5biJXgerfkIYRqju4Ie+Z/iBSDkfdoio
 /eTLZXvG9PkoH1cv/puF74d5czk9Ml0W3oo1vZjvzAtTlNR6YdHQw5kr507tH9sfc6qi
 hezM9wKIz1zaLc5bDJIinTaXnDPlyQU3U7Mf0ieo8Lzttca8r8Mx2z1RJELawP/QkgKv
 WrCGN0Hjk1jLV/IUE+kU/XtXdscSS9cwn5WNhkbYIC3wUnNkuLISizDCrMckVjgGb7uC
 crLij8dC5c6UojUrrb6A+Q37YNXt7R8YNQ7gNabc+sLposQZWShRnNhoTNKI7Wg+XH02 ZQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyay1f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 08:55:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1138t3BY119021;
        Wed, 3 Feb 2021 08:55:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36dhc0njhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 08:55:03 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1138t15X021488;
        Wed, 3 Feb 2021 08:55:01 GMT
Received: from mwanda (/10.175.206.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Feb 2021 00:55:01 -0800
Date:   Wed, 3 Feb 2021 11:54:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: mark block groups to copy for device-replace
Message-ID: <YBpk4PZ9hkOl+aKj@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030056
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030056
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Naohiro Aota,

The patch 0d57e73ac5ae: "btrfs: mark block groups to copy for
device-replace" from Jan 26, 2021, leads to the following static
checker warning:

	fs/btrfs/dev-replace.c:505 mark_block_group_to_copy()
	error: double unlocked '&fs_info->trans_lock' (orig line 486)

fs/btrfs/dev-replace.c
   463  static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
   464                                      struct btrfs_device *src_dev)
   465  {
   466          struct btrfs_path *path;
   467          struct btrfs_key key;
   468          struct btrfs_key found_key;
   469          struct btrfs_root *root = fs_info->dev_root;
   470          struct btrfs_dev_extent *dev_extent = NULL;
   471          struct btrfs_block_group *cache;
   472          struct btrfs_trans_handle *trans;
   473          int ret = 0;
   474          u64 chunk_offset;
   475  
   476          /* Do not use "to_copy" on non-ZONED for now */
   477          if (!btrfs_is_zoned(fs_info))
   478                  return 0;
   479  
   480          mutex_lock(&fs_info->chunk_mutex);
   481  
   482          /* Ensure we don't have pending new block group */
   483          spin_lock(&fs_info->trans_lock);
   484          while (fs_info->running_transaction &&
   485                 !list_empty(&fs_info->running_transaction->dev_update_list)) {
   486                  spin_unlock(&fs_info->trans_lock);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   487                  mutex_unlock(&fs_info->chunk_mutex);
   488                  trans = btrfs_attach_transaction(root);
   489                  if (IS_ERR(trans)) {
   490                          ret = PTR_ERR(trans);
   491                          mutex_lock(&fs_info->chunk_mutex);
   492                          if (ret == -ENOENT)
   493                                  continue;

We need to take the lock before the continue;

   494                          else
   495                                  goto unlock;
   496                  }
   497  
   498                  ret = btrfs_commit_transaction(trans);
   499                  mutex_lock(&fs_info->chunk_mutex);
   500                  if (ret)
   501                          goto unlock;
   502  
   503                  spin_lock(&fs_info->trans_lock);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   504          }
   505          spin_unlock(&fs_info->trans_lock);

Double unlock here.

   506  
   507          path = btrfs_alloc_path();
   508          if (!path) {

regards,
dan carpenter

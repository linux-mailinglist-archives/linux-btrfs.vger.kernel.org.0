Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E4274057
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIVLDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 07:03:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38406 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVLDa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 07:03:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MAnPeZ021202;
        Tue, 22 Sep 2020 11:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=etk25KpIE8IdAqrFdI7byxquZcU/0m4DBBQ5oTItUjA=;
 b=ZcKdMjyWDqg6SV+SaK+rK+jfVBSDofwQtANBfjZRnTaNDcuMfM4TynVKyJOPSIre2XND
 Kw0nWPg1VXISBV9CRiWzeLvenAm0MatexScer+VSplYPpJyKb46Vux6urxJPmJUDX8QU
 langgXWRGrY5O957xb9P0EqYNd0x65rN4INbfWX9M2CZctENz87VrBLkUFPFiHinru44
 iiKA6AkBVdaNVaSAfcD4GQvu4D/ak5yVAVjHhppOJOlCnAR2lXJQNg+xNMe50Hrty7Fs
 cC3dAcIFuWAuVPCTEmsIGze30XSMyEf49Si4YeSaydV668JXE2F1dRATvBNNEyBaMPf4 bQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33q5rgaefd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 11:03:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MB0e7S017597;
        Tue, 22 Sep 2020 11:01:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33nursnc36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 11:01:24 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08MB1OxT022192;
        Tue, 22 Sep 2020 11:01:24 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 04:01:23 -0700
Date:   Tue, 22 Sep 2020 14:01:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     nborisov@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: clean BTRFS_I usage in btrfs_destroy_inode
Message-ID: <20200922110118.GA1297350@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=839 bulkscore=0 mlxscore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=3 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=823 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220090
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Nikolay Borisov,

This is a semi-automatic email about new static checker warnings.

The patch ab46388723da: "btrfs: clean BTRFS_I usage in
btrfs_destroy_inode" from Sep 18, 2020, leads to the following Smatch
complaint:

    fs/btrfs/inode.c:8668 btrfs_destroy_inode()
    warn: variable dereferenced before check 'root' (see line 8651)

fs/btrfs/inode.c
  8650		struct btrfs_root *root = inode->root;
  8651		struct btrfs_fs_info *fs_info = root->fs_info;
                                                ^^^^^^^^^^^^^
New dereference

  8652	
  8653		WARN_ON(!hlist_empty(&vfs_inode->i_dentry));
  8654		WARN_ON(vfs_inode->i_data.nrpages);
  8655		WARN_ON(inode->block_rsv.reserved);
  8656		WARN_ON(inode->block_rsv.size);
  8657		WARN_ON(inode->outstanding_extents);
  8658		WARN_ON(inode->delalloc_bytes);
  8659		WARN_ON(inode->new_delalloc_bytes);
  8660		WARN_ON(inode->csum_bytes);
  8661		WARN_ON(inode->defrag_bytes);
  8662	
  8663		/*
  8664		 * This can happen where we create an inode, but somebody else also
  8665		 * created the same inode and we need to destroy the one we already
  8666		 * created.
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
But "root" can be NULL.

  8667		 */
  8668		if (!root)
                    ^^^^^
  8669			return;
  8670	

regards,
dan carpenter

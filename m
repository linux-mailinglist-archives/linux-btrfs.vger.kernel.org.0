Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C121430742B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 11:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhA1KwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 05:52:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhA1KvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 05:51:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SAnw12001259;
        Thu, 28 Jan 2021 10:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=6B6ydBAz9TnUTA7Lq7vHVkv+g2WrEUmXWDrH7v68thw=;
 b=XNBNTi8gptgYdHlUcTQG7GfgUPf2fhR8hYgKs26AP3WyyklGUuv8JCWk8criYqWa9n3S
 k954H8imUgfxsTeQ8HRuLqdmzqMz9QZU+j1iBTLP0yQmXZMQXkYqp3+UMwoxvh73HE6e
 YRtobtpCTPJvr0DeEOQ3XSqrud/UyapkOIVurH4iI6kohaR6ecf/1K1Z5d7qN2bNGJ8Q
 aN1XlP07dZ7nHzC9jAkLz1yY5aRrgBwo3+5cz0I/v/gG6Hm2XTA0tZjnQIEGMi0x8i2V
 FeUeXwoSEev3+fxqXW6r5uc/u4qQreJyiMcbW3F4duTR09HtJkXeoEPpXeb1LZGIQ8tM CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 368b7r3j7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 10:50:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SAkchb015980;
        Thu, 28 Jan 2021 10:50:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 368wq1hgex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 10:50:14 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10SAoDjd004287;
        Thu, 28 Jan 2021 10:50:13 GMT
Received: from mwanda (/10.175.203.176)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jan 2021 02:50:13 -0800
Date:   Thu, 28 Jan 2021 13:50:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     wqu@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: introduce read_extent_buffer_subpage()
Message-ID: <YBKW31GtQ2Rc6EfC@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=855 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280053
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=768
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280053
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu Wenruo,

The patch 5c60a522f1ea: "btrfs: introduce
read_extent_buffer_subpage()" from Jan 16, 2021, leads to the
following static checker warning:

	fs/btrfs/extent_io.c:5797 read_extent_buffer_subpage()
	info: return a literal instead of 'ret'

fs/btrfs/extent_io.c
  5780  static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
  5781                                        int mirror_num)
  5782  {
  5783          struct btrfs_fs_info *fs_info = eb->fs_info;
  5784          struct extent_io_tree *io_tree;
  5785          struct page *page = eb->pages[0];
  5786          struct bio *bio = NULL;
  5787          int ret = 0;
  5788  
  5789          ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
  5790          ASSERT(PagePrivate(page));
  5791          io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
  5792  
  5793          if (wait == WAIT_NONE) {
  5794                  ret = try_lock_extent(io_tree, eb->start,
  5795                                        eb->start + eb->len - 1);
  5796                  if (ret <= 0)
  5797                          return ret;

If try_lock_extent() fails to get the lock and returns 0, then is
returning zero here really the correct behavior?  It feels like there
should be some documentation because this behavior is unexpected.

  5798          } else {
  5799                  ret = lock_extent(io_tree, eb->start, eb->start + eb->len - 1);
  5800                  if (ret < 0)
  5801                          return ret;
  5802          }
  5803  
  5804          ret = 0;
  5805          if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
  5806              PageUptodate(page) ||
  5807              btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
  5808                  set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
  5809                  unlock_extent(io_tree, eb->start, eb->start + eb->len - 1);
  5810                  return ret;
  5811          }

regards,
dan carpenter

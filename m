Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB079110478
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 19:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfLCSs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 13:48:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57392 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLCSsZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Dec 2019 13:48:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3IkG9A123023;
        Tue, 3 Dec 2019 18:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=UxsCme3Suet5rYD1Ctvlxav1cVKboOVGTp+EnrIniBs=;
 b=mDe/ADOcyL0e6T1ecgDI5fbn10RCuNAKdouayd0g7gcQOLQ1gkIKcfZHSVnHJETY68XI
 5yqL1X86p8Tr1eu4FgL7JUDK2Nf0t1H7xjT/UrPgnB441scx+AbOhAWEAxRxZ70RRojM
 oYh7ayu21n5edHDHREWJD4EwFmmgUWe4JyFOJ07L3RbGKlxxFWDIcAgK436Atdjtul8t
 RbokAUGshwuFyqSEznseF2bbw2w0zfjTwIj7s3JsshqU4tPB3jWMdLj0UP46Ag8XDIyf
 ecMc1dDx29iiO1V9QymACzdiHVDF+ZSj5oygCgeT7tmR5vQsdp0qn6DWSxlrF8qVWAc4 Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wkh2r9jns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 18:46:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3IYNvq093587;
        Tue, 3 Dec 2019 18:46:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wn8k3386y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 18:46:13 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB3IkBWx013842;
        Tue, 3 Dec 2019 18:46:12 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 10:46:11 -0800
Date:   Tue, 3 Dec 2019 21:46:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Fix btrfs_find_create_tree_block() testing
Message-ID: <20191203184601.GI1787@kadam>
References: <20191203110408.GA30629@linux.ibm.com>
 <20191203112457.GF1787@kadam>
 <20191203184039.GU2734@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203184039.GU2734@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9460 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030138
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 03, 2019 at 07:40:39PM +0100, David Sterba wrote:
> On Tue, Dec 03, 2019 at 02:24:58PM +0300, Dan Carpenter wrote:
> > The btrfs_find_create_tree_block() uses alloc_test_extent_buffer() for
> > testing and alloc_extent_buffer() for production.  The problem is that
> > the test code returns NULL and the production code returns error
> > pointers.  The callers only check for error pointers.
> > 
> > I have changed alloc_test_extent_buffer() to return error pointers and
> > updated the two callers which use it directly.
> > 
> > Fixes: faa2dbf004e8 ("Btrfs: add sanity tests for new qgroup accounting code")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> I edited the changelog because btrfs_find_create_tree_block is
> misleading and seems to be unrelated to the actual fix that's just for
> alloc_test_extent_buffer. Patch added to misc-next, thanks.

The bug is in btrfs_find_create_tree_block()

fs/btrfs/disk-io.c
  1046  struct extent_buffer *btrfs_find_create_tree_block(
  1047                                                  struct btrfs_fs_info *fs_info,
  1048                                                  u64 bytenr)
  1049  {
  1050          if (btrfs_is_testing(fs_info))
  1051                  return alloc_test_extent_buffer(fs_info, bytenr);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
NULL

  1052          return alloc_extent_buffer(fs_info, bytenr);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Error pointers.

  1053  }

None of the callers of btrfs_find_create_tree_block() check for NULL.

regards,
dan carpenter

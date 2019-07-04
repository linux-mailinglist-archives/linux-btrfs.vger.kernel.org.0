Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E55F158
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 04:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfGDCNV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 22:13:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53602 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGDCNU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jul 2019 22:13:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6428r1H068624;
        Thu, 4 Jul 2019 02:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=KxZh3PhZwOFF75LmqI8RRkoA7VTTmhY0TMWgATUX2T8=;
 b=4+3NNrVTvAchgr8ehax2OkqaJndBf/JV7EghKkFgIq1R1VpFCkrGZMBmwf/jeFHorV3m
 Amte923v9i7SbOGs+yJv1fPn6iVP9+ylDz0Qxd9t7B2dG4JkZ7GlDIyjR7ynwIvEjhRh
 epVUFqCAfhx7b3m97ltaz9DQndwinbTFhHOXj3o++uy5iXrux2XLVBMn7w/Ab/Ts7zdP
 EBZRqeFj+Sdvda/c0qI82OaXCr5C6D8pE1+60ZeDPY3349btRk+rnEXZNkeJI1P7Y/P0
 jSpRLHpJ9N+yEzEUJZO69QiGzWsRENB3rypzt/yrl1nDlr+fS7gJ77Ol4FzH88sF8zhc Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2te61q4aeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 02:13:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6423ObU123838;
        Thu, 4 Jul 2019 02:13:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2th5qkst3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 02:13:16 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x642DFCG006467;
        Thu, 4 Jul 2019 02:13:15 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 19:13:15 -0700
Subject: Re: [PATCH v2 00/14] btrfs-progs: image: Enhance and bug fixes
To:     WenRuo Qu <wqu@suse.com>
References: <20190702100650.2746-1-wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <67e5ce0a-3a4d-3392-a2c8-fca86ef90fbe@oracle.com>
Date:   Thu, 4 Jul 2019 10:13:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190702100650.2746-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040027
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/19 6:07 PM, WenRuo Qu wrote:
> This patchset is based on v5.1.1 tag.
> 
> With this update, the patchset has the following features:
> - various small fixes and enhancements for btrfs-image
>    * Fix an indent misalign
>    * Fix an access-beyond-boundary bug
>    * Fix a confusing error message due to unpopulated errno
>    * Output error message for chunk tree build error
>    * Use SZ_* to replace intermediate number
>    * Verify superblock before restore
> 
> - btrfs-image dump support
>    This introduce a new option -d to dump data.
>    Due to item size limit, we have to enlarge the existing limit from
>    256K (enough for tree blocks, but not enough for free space cache) to
>    256M.
>    This change will cause incompatibility, thus we have to introduce a
>    new magic as version. While keeping all other on-disk format the same.
> 
> - Reduce memory usage for both compressed and uncompressed images
>    Originally for compressed extents, we will use 4 * max_pending_size as
>    output buffer, which can be 1G for 256M newer limit.
> 
>    Change it to use at most 512K for compressed extent output buf, and
>    also use 512K fixed buffer size for uncompressed extent.
> 
> - btrfs-image restore optimization
>    This will speed up chunk item search during restore.
> 
> Changelog:
> v2:
> - New small fixes:
>    * Fix a confusing error message due to unpopulated errno
>    * Output error message for chunk tree build error
>    
> - Fix a regression of previous version
>    Patch "btrfs-progs: image: Rework how we search chunk tree blocks"
>    deleted a "ret = 0" line which could cause false early exit.
> 
> - Reduce memory usage for data dump


> Qu Wenruo (14):
>    btrfs-progs: image: Use SZ_* to replace intermediate size
>    btrfs-progs: image: Fix an indent misalign
>    btrfs-progs: image: Fix an access-beyond-boundary bug when there are
>      32 online CPUs
>    btrfs-progs: image: Verify the superblock before restore
>    btrfs-progs: image: Introduce framework for more dump versions
>    btrfs-progs: image: Introduce -d option to dump data
>    btrfs-progs: image: Allow restore to record system chunk ranges for
>      later usage
>    btrfs-progs: image: Introduce helper to determine if a tree block is
>      in the range of system chunks
>    btrfs-progs: image: Rework how we search chunk tree blocks
>    btrfs-progs: image: Reduce memory requirement for decompression
>    btrfs-progs: image: Don't waste memory when we're just extracting
>      super block
>    btrfs-progs: image: Reduce memory usage for chunk tree search
>    btrfs-progs: image: Output error message for chunk tree build error
>    btrfs-progs: image: Fix error output to show correct return value
>

How about separating the -d option enhancement patch from rest of
the patches? Looks like -d option patch is only one, and the rest
can go independently?.


>   disk-io.c        |   6 +-
>   disk-io.h        |   1 +
>   image/main.c     | 874 +++++++++++++++++++++++++++++++++++------------
>   image/metadump.h |  15 +-
>   4 files changed, 666 insertions(+), 230 deletions(-)
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FA45CB33
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfGBIJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 04:09:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54014 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbfGBIJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jul 2019 04:09:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6288irh162788
        for <linux-btrfs@vger.kernel.org>; Tue, 2 Jul 2019 08:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2018-07-02;
 bh=5POajhMPl0qRevwXf0QmzJmvINtzQ8cr25mR/XkwaEI=;
 b=npQIMBjDjPGEbNEpl/lEntV6KaJcnaS38ozL+ylzbtSdz6R0zL/JRil285SEBR11y7iu
 naxqa4i7qwnXMKzTGI7O3SdtCXTKLrQNVYuRmLuKLFXY/e65K5BKPfgwZ42XlolSTEFX
 Kzk+owtZf+ANpUCX5CZf0IfM6GL9miXtaVpTqFE2ZTBTr0JDt8oX3wE8SQjOmg7ro2Nc
 dBnZMpb58ZhZzhj+NAg5/pEI1x7wb+4FuIDHBa7EE7UUQoFL6BD6nEgeu6MM36pYPRgi
 P/i08JL/a+7WMw69OX5284DoSd0e08PxLTtlIhd6xcHo4IpY/QPrgCV6y3Et0r18vUtv nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbhv0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2019 08:09:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6287UIe170653
        for <linux-btrfs@vger.kernel.org>; Tue, 2 Jul 2019 08:09:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tebqgc0pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2019 08:09:34 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6289XWN012529
        for <linux-btrfs@vger.kernel.org>; Tue, 2 Jul 2019 08:09:33 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 01:09:33 -0700
Subject: Re: [PATCH 0/3 RESEND Rebased] readmirror feature
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
Message-ID: <5fcf9c23-89b5-b167-1f80-a0f4ac107d0b@oracle.com>
Date:   Tue, 2 Jul 2019 16:09:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190626083402.1895-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020095
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping?


On 26/6/19 4:33 PM, Anand Jain wrote:
> These patches are tested to be working fine.
> 
> Function call chain  __btrfs_map_block()->find_live_mirror() uses
> thread pid to determine the %mirror_num when the mirror_num=0.
> 
> This patch introduces a framework so that we can add policies to determine
> the %mirror_num. And adds the devid as the readmirror policy.
> 
> The property is stored as an extented attributes of root inode
> (BTRFS_FS_TREE_OBJECTID).
> User provided devid list is validated against the fs_devices::dev_list.
> 
>   For example:
>     Usage:
>       btrfs property set <mnt> readmirror devid<n>[,<m>...]
>       btrfs property set <mnt> readmirror ""
> 
>     mkfs.btrfs -fq -draid1 -mraid1 /dev/sd[b-d] && mount /dev/sdb /btrfs
>     btrfs prop set /btrfs readmirror devid1,2
>     btrfs prop get /btrfs readmirror
>      readmirror=devid1,2
>     getfattr -n btrfs.readmirror --absolute-names /btrfs
>      btrfs.readmirror="devid1,2"
>     btrfs prop set /btrfs readmirror ""
>     getfattr -n btrfs.readmirror --absolute-names /btrfs
>      /btrfs: btrfs.readmirror: No such attribute
>     btrfs prop get /btrfs readmirror
> 
> RFC->v1:
>    Drops pid as one of the readmirror policy choices and as usual remains
>    as default. And when the devid is reset the readmirror policy falls back
>    to pid.
>    Drops the mount -o readmirror idea, it can be added at a later point of
>    time.
>    Property now accepts more than 1 devid as readmirror device. As shown
>    in the example above.
> 
> Anand Jain (3):
>    btrfs: add inode pointer to prop_handler::validate()
>    btrfs: add readmirror property framework
>    btrfs: add readmirror devid property
> 
>   fs/btrfs/props.c   | 120 +++++++++++++++++++++++++++++++++++++++++++--
>   fs/btrfs/props.h   |   4 +-
>   fs/btrfs/volumes.c |  25 +++++++++-
>   fs/btrfs/volumes.h |   8 +++
>   fs/btrfs/xattr.c   |   2 +-
>   5 files changed, 150 insertions(+), 9 deletions(-)
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D5D1B0710
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgDTLKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 07:10:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36036 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDTLKn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 07:10:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KB8lLw126388;
        Mon, 20 Apr 2020 11:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nhFPBHdqpClRcBQb5/ebAAEUD8Y6uH2IzVqpT5bNk3I=;
 b=em3+VVzF6BkwwfZkxzcBmu8Jn2ViCfjeP5ELAMNZEUvB85WGpL/jhQzXL8XLSHXX/1mu
 krZJa95CbH6lmZzgQBOBrPF47Ew+590/XulBNshTeYe6U8VZ/xhW4/YpQtRefk5Dflnf
 kyBf/7z27WaU8z1+5m+IbF8UO2lHsiult11pIvRl7IbiBD70XJysB8Ljoi/2vICWXrVZ
 lTYc1hwYcDAMxOohK1r6Wre+C7dfWwOtGOGgqZZvQlKfSFJ0Csb9ikq0meuEStkWfReW
 xNA1IALuPrTpinq/bWuhe1sHL5fGIjizB1EBEp05OXTxdPpGqEh9qCvz7A+mjxmrqtha 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30ft6mxdy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 11:10:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03KB7amK095178;
        Mon, 20 Apr 2020 11:10:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30gb3q8w14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 11:10:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03KBAT5B002371;
        Mon, 20 Apr 2020 11:10:29 GMT
Received: from [10.191.37.168] (/10.191.37.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Apr 2020 04:10:29 -0700
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
To:     Marc MERLIN <marc@merlins.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
 <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
 <20200326013007.GS15123@merlins.org>
 <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
 <20200326042624.GT15123@merlins.org> <20200414003854.GA6639@merlins.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <07166dd6-4554-a545-9774-a622890095a7@oracle.com>
Date:   Mon, 20 Apr 2020 19:10:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414003854.GA6639@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9596 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9596 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200100
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




The steps below are they in the chronological order?

> gargamel:~# dmtail 3
> [1887142.765448] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4529, flush 0, corrupt 0, gen 0
> [1887142.795820] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4530, flush 0, corrupt 0, gen 0
> [1887142.826176] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4531, flush 0, corrupt 0, gen 0
> gargamel:~# cat /proc/partitions  |grep sd[ep]
>     8      240 3750738264 sdp
>     8      241 3750737223 sdp1
> gargamel:~# mount | grep sde
> /dev/sde1 on /mnt/btrfs_space type btrfs (ro,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=5,subvol=/)
> /dev/sde1 on /var/local/space type btrfs (ro,noexec,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=257,subvol=/varlocalspace)
> /dev/sde1 on /var/cache/zoneminder type btrfs (ro,nosuid,nodev,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=257,subvol=/varlocalspace/zoneminder)
> /dev/sde1 on /var/lib/mysql type btrfs (ro,nosuid,nodev,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=3648,subvol=/mysql)
> gargamel:~# umount /mnt/btrfs_space; umount /var/local/space; umount /var/cache/zoneminder; umount /var/lib/mysql
> gargamel:~# mount | grep sde
> 
> gargamel:~# mount /dev/sdp1 /mnt/mnt
> mount: /mnt/mnt: mount(2) system call failed: File exists.
> gargamel:~# dmtail 2
> [1887142.826176] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4531, flush 0, corrupt 0, gen 0
> [1887453.610947] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdp1


  Before and after --forget command
     btrfs fi show -m
  could have told us what devices are still mounted.

I will send a boilerplate code to dump device list from the kernel it 
will help to debug. As of now this boilderplate code which I have been 
using is too localized needs a lot of cleanups, will take sometime.


> gargamel:/usr/local/bin# btrfs device scan --forget
> gargamel:/usr/local/bin# mount /dev/sdp1 /mnt/mnt
> mount: /mnt/mnt: mount(2) system call failed: File exists.


Thanks, Anand

> 
> After reboot, I made sure sde is not used by anything weird, just simple mounts:
> gargamel:~# lsblk  | grep sde
> sde                                 8:64   1 931.5G  0 disk
> ├─sde1                              8:65   1 488.3M  0 part
> ├─sde2                              8:66   1  14.9G  0 part
> ├─sde3                              8:67   1    80G  0 part
> └─sde4                              8:68   1 836.1G  0 part
> 
> Any ideas?
> 
> Marc
> 

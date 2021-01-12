Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503E52F2CF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbhALKfv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 05:35:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54694 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbhALKfv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 05:35:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CATkkL095331
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 10:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Cq/sut22k3GR43sANnrHpGt9CoFTxGQIbLwkzblc3iY=;
 b=YUWmPW5x2Ew1ddRg4XunFvGf2p6VSbaQ75P9c9oddFNQHvZ5/bt3LFaHy6I7865y9Ker
 TjlS3zZn+yl0YxO1zt+SgCwLBFJmXy8kOoYULHwjtKO834/b4OvY2pX/hIKmi4p7ySIQ
 vBjd5GCPo5qrJ5r5MY8kGGtVsv6Y+8P1w1fnd13U4sLMHIOEeXWoKEJd58MyCyzYSLbd
 jT+9z5S0efeMwR3I8lyqsKccwCXB580bCCCxLpDgbvj7e/LM0+FYW21BcpGWHZmrFi+P
 ZB3pdUP19iSu4PcPY/I0sCr2qjaFp52qA7G4sfaJLvmQEF1BWIMtLFcfxrMg/1I/LIY9 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcynpwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 10:35:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CAVU6a089166
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 10:35:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360ke6ajmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 10:35:09 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CAZ8WC030175
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 10:35:08 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 02:35:08 -0800
From:   Anand Jain <anand.jain@oracle.com>
Subject: [bug] Balance fails due to ENOSPC
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <1540e370-a019-5d3b-312d-dc5e70169597@oracle.com>
Date:   Tue, 12 Jan 2021 18:35:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Balance fails due to ENOSPC on 5.11.0-rc2+.


[ 2460.219094] BTRFS info (device sdb6): balance: start -f 
-dconvert=single -mconvert=single -sconvert=single
[ 2460.219224] BTRFS info (device sdb6): relocating block group 
194572713984 flags data
[ 2460.241299] ------------[ cut here ]------------
[ 2460.241302] BTRFS: Transaction aborted (error -28)
[ 2460.241328] WARNING: CPU: 3 PID: 4135 at fs/btrfs/volumes.c:3003 
btrfs_remove_chunk+0x60e/0x6c0 [btrfs]
::
[ 2460.241447] RIP: 0010:btrfs_remove_chunk+0x60e/0x6c0 [btrfs]
::
[ 2460.241497] Call Trace:
[ 2460.241500]  btrfs_relocate_chunk+0x9d/0xd0 [btrfs]
[ 2460.241533]  __btrfs_balance+0x413/0xa30 [btrfs]
[ 2460.241566]  btrfs_balance+0x436/0x4d0 [btrfs]
[ 2460.241597]  btrfs_ioctl_balance+0x2d5/0x380 [btrfs]
[ 2460.241647]  btrfs_ioctl+0x565/0x22b0 [btrfs]
[ 2460.241693]  ? selinux_file_ioctl+0x174/0x220
[ 2460.241698]  ? handle_mm_fault+0xd7/0x2b0
[ 2460.241702]  __x64_sys_ioctl+0x91/0xc0
[ 2460.241705]  ? __x64_sys_ioctl+0x91/0xc0
[ 2460.241707]  do_syscall_64+0x38/0x50
[ 2460.241711]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
::
[ 2460.241735] ---[ end trace 95b8b7b84503a477 ]---
[ 2460.241738] BTRFS: error (device sdb6) in btrfs_remove_chunk:3003: 
errno=-28 No space left
[ 2460.241743] BTRFS info (device sdb6): forced readonly
[ 2460.242646] BTRFS info (device sdb6): 1 enospc errors during balance
[ 2460.242649] BTRFS info (device sdb6): balance: ended with status: -30


btrfs fi us /Volumes/
Overall:
     Device size:		 154.97GiB
     Device allocated:		 154.97GiB
     Device unallocated:		   2.00MiB
     Device missing:		     0.00B
     Used:			 147.91GiB
     Free (estimated):		   2.75GiB	(min: 2.75GiB)
     Data ratio:			      1.99
     Metadata ratio:		      1.52
     Global reserve:		 183.72MiB	(used: 0.00B)

Data,single: Size:894.00MiB, Used:0.00B (0.00%)
    /dev/sdb6	 894.00MiB

Data,RAID1: Size:75.53GiB, Used:73.23GiB (96.96%)
    /dev/sdb6	  75.53GiB
    /dev/sdc2	  75.53GiB

Metadata,single: Size:964.00MiB, Used:0.00B (0.00%)
    /dev/sdb6	 964.00MiB

Metadata,RAID1: Size:1.00GiB, Used:737.25MiB (72.00%)
    /dev/sdb6	   1.00GiB
    /dev/sdc2	   1.00GiB

System,single: Size:32.00MiB, Used:0.00B (0.00%)
    /dev/sdb6	  32.00MiB

System,RAID1: Size:32.00MiB, Used:16.00KiB (0.05%)
    /dev/sdb6	  32.00MiB
    /dev/sdc2	  32.00MiB

Unallocated:
    /dev/sdb6	   1.00MiB
    /dev/sdc2	   1.00MiB

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F32EFEB1
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jan 2021 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbhAIIyO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jan 2021 03:54:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41550 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbhAIIyO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jan 2021 03:54:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1098rWD9157252
        for <linux-btrfs@vger.kernel.org>; Sat, 9 Jan 2021 08:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=zJBllj1h82kwU5+KkqXX1dFKq3tqQ+m1jrNL6zW53+o=;
 b=HSDG2Yzy0ZImvrw4njHQL2993k1e8HFQSc5kiPExzSoX7TYevcE4ImtileK5hGWS7qaf
 NxnHjmnU1HPAaenjZkoqhU8BloNiL+jPEQ+Ala2rjAgUsAT+FzbwIeDVfxvpOrY7r1di
 dWazbg/qOdLUD3K6+sT/chaVu6/KGAPRhCbmL088HO24D0Ibg2zFUoZ0IICx55BDGa2O
 9JatOtRbM24YGEoJpffKY6lYIeY76xw11xqrWAWkL/6OBwzyGKfdJo78zM1Z3WGB7Tdu
 KxOOCCH/GXkTS1f7qE7Zce981+ISDx6c/CDCQPdjtW8mTNBpt6nWj+NSJwQnkxE7NfW1 hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35y3wqrdkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jan 2021 08:53:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1098iZSS133939
        for <linux-btrfs@vger.kernel.org>; Sat, 9 Jan 2021 08:53:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35y3tgyqx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jan 2021 08:53:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1098rWaX020127
        for <linux-btrfs@vger.kernel.org>; Sat, 9 Jan 2021 08:53:32 GMT
Received: from [192.168.10.102] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 09 Jan 2021 08:53:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
Subject: [bug] scrub on low disk space leads to Transaction aborted
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <0f061eb2-2192-da85-0f34-43faa4e2812f@oracle.com>
Date:   Sat, 9 Jan 2021 16:53:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101090057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101090058
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  I ran scrub when disk space was low on a btrfs with some raid1 csum
  errors, on a system with kernel 5.11.0-rc2+. It lead to transaction
  aborted and rdonly FS.

[ 2365.314375] ------------[ cut here ]------------
[ 2365.314385] BTRFS: Transaction aborted (error -28)
[ 2365.314470] WARNING: CPU: 2 PID: 4672 at fs/btrfs/inode.c:2823 
btrfs_finish_ordered_io+0x8e6/0x950 [btrfs]
<snap>
[ 2365.314921] CPU: 2 PID: 4672 Comm: kworker/u8:11 Not tainted 
5.11.0-rc2+ #3
[ 2365.314933] Hardware name: LENOVO 20FAS6PN00/20FAS6PN00, BIOS 
N1CET47W (1.15 ) 08/08/2016
[ 2365.314939] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[ 2365.315093] RIP: 0010:btrfs_finish_ordered_io+0x8e6/0x950 [btrfs]
<snap>
[ 2365.315290] Call Trace:
[ 2365.315309] BTRFS warning (device sda6): 
btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
[ 2365.315305]  finish_ordered_fn+0x15/0x20 [btrfs]
[ 2365.315532]  btrfs_work_helper+0xcc/0x2f0 [btrfs]
[ 2365.315763]  process_one_work+0x1ee/0x390
[ 2365.315781]  worker_thread+0x50/0x3d0
[ 2365.315797]  kthread+0x114/0x150
[ 2365.315811]  ? process_one_work+0x390/0x390
[ 2365.315824]  ? kthread_park+0x90/0x90
[ 2365.315836]  ret_from_fork+0x22/0x30
[ 2365.315861] ---[ end trace b0e289a2c3d424e8 ]---
[ 2365.315871] BTRFS warning (device sda6): 
btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
[ 2365.316713] BTRFS warning (device sda6): 
btrfs_finish_ordered_io:2823: Aborting unused transaction(No space left).
[ 2365.316796] BTRFS warning (device sda6): Skipping commit of aborted 
transaction.
[ 2365.316809] BTRFS: error (device sda6) in cleanup_transaction:1938: 
errno=-30 Readonly filesystem
[ 2365.316824] BTRFS info (device sda6): forced readonly
[ 2365.359195] BTRFS info (device sda6): scrub: not finished on devid 2 
with status: -125

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866B4EACFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 11:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfJaKAx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 06:00:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41046 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfJaKAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 06:00:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V9xJ0S130302;
        Thu, 31 Oct 2019 10:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=hSEBeWNHPNvSQ9j/tl9meZU8VmlU6b5TeU7Su3vFKio=;
 b=ICjNe+7JHDeUR/eq5WIJsG1nC7gjySdj0DHYGsj7nbIdmwO677ma2wggdE5Eyc3lQUNe
 bHIbw5Ff/oodgJ88iTizFh83U90iwvI5HLVny76xQwk1sQAc9o1u0Dky3xIJIluZXurQ
 hoqOMSgn4nVz9/Gpm1dLEiEpvfOcQ8Lllu6dq7LeY+dbs1UqsDyrrVrww+dbJS4oMnge
 2YCQGku4MN0yFIcuLVeIk0oVz0OQBfteUKLGb0XloEiXDJ4dQ+Mk+J6N0y1Zt93HJAGP
 lUPObPEosQapf0vP0f3eXXmiKqturpJDi1+/AW7vJcj3LPvX17jkaiyVQsWt050L1Azd 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vxwhfj5gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:00:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9V9vXK9002949;
        Thu, 31 Oct 2019 10:00:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vyv9fum5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 10:00:45 +0000
Received: from abhmp0021.oracle.com (abhmp0021.oracle.com [141.146.116.27])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9VA0i1l014724;
        Thu, 31 Oct 2019 10:00:44 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 03:00:43 -0700
Subject: Re: [PATCH btrfs-progs 0/2] balance: check balance errors on
 background
To:     dsterba@suse.com
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
References: <20191030233641.30123-1-marcos.souza.org@gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <87bc3923-8cda-4bcf-a3e7-fa6204c71d5e@oracle.com>
Date:   Thu, 31 Oct 2019 18:00:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191030233641.30123-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310101
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/31/19 7:36 AM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> The first patch removes the close/open operation of stderr, so we can receive
> errors of balance when starting in the background.
> 
> The second patch waits up to three seconds after started the balance process, to
> check is some problem happened to the balance process. This is done only when
> the user issues the "balance start" in background mode.
> 
> This was tested by issuing running "btrfs balance start --background
> --full-balance <path>", when the balance started, issue the same command again
> in the same terminal:
> 
> # ./btrfs balance start --background --full-balance /mnt
> # ./btrfs balance start --background --full-balance /mnt
> ERROR: error during balancing '/mnt': Operation now in progress
> 
> These two patches together fixes the issue 167[1].
> 
> Please review,
> Thanks.
> 
> [1]: https://github.com/kdave/btrfs-progs/issues/167


David,

-----
(To fix this, the parent process should wait a bit if the forked 
background process still runs and report errors otherwise. There are no 
blocking calls when the 2nd ioctl is called, so a few seconds should be 
enough.)
-----

  This approach might work in most of the cases. However user thread
  waiting for 3 sec is not a deterministic way to find if the balance
  was started successfully in the kernel. IMO.

  Instead can we use the balance start ioctl to spin a kthread
  to run the actual balance that is __btrfs_balance(). With means
  until call to __btrfs_balance() we shall use ioctl-thread and
  to spin up kthread to run __btrfs_balance() and return the ioctl
  thread with the interim status
  (So for the --no-background user thread has to monitor the
  balance status using the balance progress ioctl and return when
  the status becomes completed and also it should call balance control
  ioctl if the received sigint).

  We do use kthread for balance, if mount thread has to resume the
  balance. so its a kind of extension to it.

  But in the view of the backward btrfs-progs compatibility (that is new
  kernel with old progs) it looks like we need a new balance-ioctl
  altogether, but the question is if its too much infrastructure changes,
  which otherwise might have worked fairly well with a 3 sec delay? What
  do you think? I think its a good idea to fix it in the right way.


Thanks, Anand

> Marcos Paulo de Souza (2):
>    btrfs-progs: balance: Don't set stderr to /dev/null on balance_start
>    btrfs-progs: balance: Verify EINPROGRESS on background balance
> 
>   cmds/balance.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A832FD194
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbhATM6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 07:58:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44146 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388496AbhATMd7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 07:33:59 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KCDrUe109221;
        Wed, 20 Jan 2021 12:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HzfOv772ohV0iM1umymOyh5ibV/l31d4RqUmhDwAmuw=;
 b=U9cUj9v1Yea0R4EUUW7pAw3HV/6gKXB4Cw0APXAy6bHQ9RvfyYCPd6lcMEvaU8D17M4w
 s0zw2iKcSIaFPFB9/X+6zh7+QvuWhUGUFrEbm4mtOsZOJSF5LWnE5J1Mz8VlHiUyGhDJ
 nXI7zIUJbCLwX8E48E3+FJv4pnIvkL4Jj6X28Nz1zzRMI+JEWZd46814/Z2outrZLUpj
 Uu7kj/jghbfoLZwKcy3UxmH3iyb2KQ3tCgCnoENZLuV/bBmLe/k9s8/MGZuNqjRl2OHr
 OdhZIFTFck5vSgMsQ9XmfRc+kLyV3T9vMbI1j+gcKQ7OmlyiEP2RA4pr7BxVP4A5xjaC Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qaa83n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 12:33:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KCFgCV034119;
        Wed, 20 Jan 2021 12:31:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3668rcyttn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 12:31:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10KCV10Y018643;
        Wed, 20 Jan 2021 12:31:01 GMT
Received: from [192.168.10.137] (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jan 2021 04:31:01 -0800
Subject: Re: [PATCH v3 1/4] btrfs: add read_policy latency
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
References: <cover.1610324448.git.anand.jain@oracle.com>
 <64bb4905dc4b77e9fa22d8ba2635a36d15a33469.1610324448.git.anand.jain@oracle.com>
 <20210120102742.GA4584@wotan.suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bc5665c0-f066-39af-48e2-dbc063b260ed@oracle.com>
Date:   Wed, 20 Jan 2021 20:30:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120102742.GA4584@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200073
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Hi Anand,
> 
> I tested this policy with fio and dstat. It performs overall really
> well. On my raid1c3 array with two HDDs and one SSD (which is the last
> device), I'm getting the following results.
> 

Michal,

  Thank you for verifying. More below...

> With direct=0:
> 
>    Run status group 0 (all jobs):
>       READ: bw=3560MiB/s (3733MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
>       io=3129GiB (3360GB), run=900003-900013msec
> 
> With direct=1:
> 
>    Run status group 0 (all jobs):
>       READ: bw=520MiB/s (545MB/s), 64.9MiB/s-65.0MiB/s (68.1MB/s-68.2MB/s),
>       io=457GiB (490GB), run=900001-900001msec
> 
> However, I was also running dstat at the same time and I noticed that
> the read stop sometimes for ~15-20 seconds. For example:
> 
>    ----system---- --dsk/sdb-- --dsk/sdc-- --dsk/sdd--
>    20-01 00:37:21|   0     0 :   0     0 : 509M    0
>    20-01 00:37:22|   0     0 :   0     0 : 517M    0
>    20-01 00:37:23|   0     0 :   0     0 : 507M    0
>    20-01 00:37:24|   0     0 :   0     0 : 518M    0
>    20-01 00:37:25|   0     0 :   0     0 :  22M    0
>    20-01 00:37:26|   0     0 :   0     0 :   0     0
>    20-01 00:37:27|   0     0 :   0     0 :   0     0
>    20-01 00:37:28|   0     0 :   0     0 :   0     0
>    20-01 00:37:29|   0     0 :   0     0 :   0     0
>    20-01 00:37:30|   0     0 :   0     0 :   0     0
>    20-01 00:37:31|   0     0 :   0     0 :   0     0
>    20-01 00:37:32|   0     0 :   0     0 :   0     0
>    20-01 00:37:33|   0     0 :   0     0 :   0     0
>    20-01 00:37:34|   0     0 :   0     0 :   0     0
>    20-01 00:37:35|   0     0 :   0     0 :   0     0
>    20-01 00:37:36|   0     0 :   0     0 :   0     0
>    20-01 00:37:37|   0     0 :   0     0 :   0     0
>    20-01 00:37:38|   0     0 :   0     0 :   0     0
>    20-01 00:37:39|   0     0 :   0     0 :   0     0
>    20-01 00:37:40|   0     0 :   0     0 :   0     0
>    20-01 00:37:41|   0     0 :   0     0 :   0     0
>    20-01 00:37:42|   0     0 :   0     0 :   0     0
>    20-01 00:37:43|   0     0 :   0     0 :   0     0
>    20-01 00:37:44|   0     0 :   0     0 :   0     0
>    20-01 00:37:45|   0     0 :   0     0 :   0     0
>    20-01 00:37:46|   0     0 :   0     0 :  55M    0
>    20-01 00:37:47|   0     0 :   0     0 : 516M    0
>    20-01 00:37:48|   0     0 :   0     0 : 515M    0
>    20-01 00:37:49|   0     0 :   0     0 : 516M    0
>    20-01 00:37:50|   0     0 :   0     0 : 520M    0
>    20-01 00:37:51|   0     0 :   0     0 : 520M    0
>    20-01 00:37:52|   0     0 :   0     0 : 514M    0
> 
> Here is the full log:
> 
> https://susepaste.org/16928336
> 
> I never noticed that happening with the PID policy. Is that maybe
> because of reading the part stats for all CPUs while selecting the
> mirror?
> 

  I ran fio tests again, now with dstat in an another window. I don't
  notice any such stalls, the read numbers went continuous until fio
  finished. Could you please check with the below fio command, also
  could you please share your fio command options.

fio \
--filename=/btrfs/largefile \
--directory=/btrfs \
--filesize=50G \
--size=50G \
--bs=64k \
--ioengine=libaio \
--rw=read \
--direct=1 \
--numjobs=1 \
--group_reporting \
--thread \
--name iops-test-job

  It is system specific?

Thanks.
Anand


> Michal
> 


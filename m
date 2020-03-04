Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91417178818
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 03:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbgCDCOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 21:14:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgCDCOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Mar 2020 21:14:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0242CxOZ037438;
        Wed, 4 Mar 2020 02:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KTm/h65FoScwUpan2Qqq+hhlCHax9f5Jy+ZVQn/agUI=;
 b=tzJ1/LERLkVdA9AETKJe/fxFj6v6SeLei26ROi0/b3wINVPuMDreebXzy8rx0iRloT/0
 wstixuGnT7x6Zelrho+AAPdaBDaKjMPbzxqyJG0xd5Fthc3OZynWn3SJ/Q1JNYAFjnj3
 1wPVQQFZJh2p3FMBtClN9WNr3MLSHveI6UkgbQCeMVWxKWILI02HWGw58Pwb/AOn1TfQ
 ECSSBJO022EtaFF/4N5hxYEwHN/hMCojFOBvMt+WH4U708+AseJ54+Qp26gKtp6VL6Hb
 ykx/gvOqb4Y5lVzdClcsiHyP9UdE6dpSvC0i/5gaCxygEhdp7GKC75IkXCzbD5WLaM3b AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yghn373b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 02:14:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0242DJJJ196388;
        Wed, 4 Mar 2020 02:14:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yg1gysrx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Mar 2020 02:14:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0242ETGU022923;
        Wed, 4 Mar 2020 02:14:29 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Mar 2020 02:14:29 +0000
Subject: Re: [PATCH] btrfs-progs: convert, warn if converting a fs which won't
 mount
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
 <af69d1ab-4609-d603-980c-b8a6cfb87f43@gmx.com>
 <39c3e381-b49e-a571-d058-a01734b8b4a9@oracle.com>
 <20200303174422.GM2902@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <fc02b904-5af5-035f-bb62-a2982409ffbe@oracle.com>
Date:   Wed, 4 Mar 2020 10:14:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174422.GM2902@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9549 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003040015
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/4/20 1:44 AM, David Sterba wrote:
> On Fri, Feb 28, 2020 at 05:06:52PM +0800, Anand Jain wrote:
>> On 2/28/20 4:27 PM, Qu Wenruo wrote:
>>> On 2020/2/28 下午4:03, Anand Jain wrote:
>>>> On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
>>>> but it won't mount because we don't yet support subpage blocksize/
>>>> sectorsize.
>>>>
>>>>    BTRFS error (device vda): sectorsize 4096 not supported yet, only support 65536
>>>>
>>>> So in this case during convert provide a warning and a 10s delay to
>>>> terminate the command.
>>>
>>> This is no different than calling mkfs.btrfs -s 64k on x86 system.
>>> And I see no warning from mkfs.btrfs.
>>>
>>> Thus I don't see the point of only introducing such warning to
>>> btrfs-convert.
>>>
>>
>> I have equal weight-age on the choices if blocksize != pagesize viz..
>>     delay and warn (this patch)
>>     quit (Nikolay).
>>     keep it as it is without warning (Qu).
>>
>>    Here we are dealing with already user data. Should it be different
>>    from mkfs?
>>    Quit is fine, but convert tool should it be system neutral?
> 
> The delays should be used in exceptional cases, now we have it for check
> --repair and for unfiltered balance. Both on user request because
> expecting users to know everything in advance what the commands do has
> shown to be too optimistic.
> 
> Refusing to allow the conversion does not make much sense for usability,
> mising the unmounted and mounted constraints.
> 
> A warning might be in place but there's nothing wrong to let the user do
> the conversion.
> 
> I've tried mkfs.ext4 with 64k block size and it warns and in the
> interactive session wants to confirm that by the user:
> 
>    $ mkfs.ext4 -b 64k img
>    Warning: blocksize 65536 not usable on most systems.
>    mke2fs 1.45.5 (07-Jan-2020)
>    img contains a ext4 file system
> 	  created on Tue Mar  3 18:41:46 2020
>    Proceed anyway? (y,N) y
>    mkfs.ext4: 65536-byte blocks too big for system (max 4096)
>    Proceed anyway? (y,N) y
>    Warning: 65536-byte blocks too big for system (max 4096), forced to continue
>    Creating filesystem with 32768 64k blocks and 32768 inodes
> 
>    Allocating group tables: done
>    Writing inode tables: done
>    Creating journal (4096 blocks): done
>    Writing superblocks and filesystem accounting information: done
> 

Just warn is reasonable. But I don't think you meant to introduce
interactive part similar to mkfs.ext4 in btrfs-convert? we don't have it
anywhere in btrfs-progs. As the btrfs-convert is not an exceptional case
(though it deals with the user data) removing the delay makes sense,
mover over the conversion and the rollback does not take much time in
general.

Thanks, Anand

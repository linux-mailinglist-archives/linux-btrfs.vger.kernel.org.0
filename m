Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0D291668
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Oct 2020 10:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgJRIRS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Oct 2020 04:17:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52792 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgJRIRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Oct 2020 04:17:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09I8Ej4O053843;
        Sun, 18 Oct 2020 08:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=woGv61y4wS1dgTM+37Re56ouKOW1tzweZ0FrS4dabRU=;
 b=s8JIribEAKhtV94ojZB3oMVTQGskBxum/RbgZQkoUBUqSt4Bt8D7vfOyryVWsDSFVQkb
 5sB3aXzgTICEMn8ZCSIh8Kpu+LeLqD9gy+42FWT5wHaQXk1zGP1wTemoIiY9hzFtjLnK
 b2VIvIXDOKDUndaSvUt62Je64bxPOBdTsJU6+IDHwrM9apTEdTIfqedTAXQPcxYs/Q46
 yD7JnjlZdgAfcgM2kgKDEG/C53pJ5S+vL+pFyhz16XSB5CNLKgb98naYmI8ZLXL7Aghw
 aSJ4eTbg0ALMiC6AM6EqmswmU3h7L/pfsMbFXpso8V8cAunWqHaLtlgCLKvXmstxEDm0 RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 347rjkhydc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 18 Oct 2020 08:17:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09I8FiGs081793;
        Sun, 18 Oct 2020 08:17:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 348acney6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Oct 2020 08:17:08 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09I8H359019140;
        Sun, 18 Oct 2020 08:17:04 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 18 Oct 2020 01:16:58 -0700
Subject: Re: [PATCH] btrfs: balance RAID1/RAID10 mirror selection
To:     louis@waffle.tech, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <b4f37e58-496d-818a-35d9-ab0832a6fe61@gmx.com>
 <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
 <4226ff1b-e313-2881-0670-965e7e98ce59@suse.com>
 <e954bedcb5647369753424177dc63928@waffle.tech>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3bddd73e-cb60-b716-4e98-61ff24beb570@oracle.com>
Date:   Sun, 18 Oct 2020 16:16:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <e954bedcb5647369753424177dc63928@waffle.tech>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9777 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010180063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9777 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 clxscore=1011 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010180063
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17/10/20 1:28 am, louis@waffle.tech wrote:
> October 16, 2020 1:29 AM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:
> 
>> On 2020/10/16 下午3:15, Nikolay Borisov wrote:
>>
>>> On 16.10.20 г. 8:59 ч., louis@waffle.tech wrote:
>>>> Balance RAID1/RAID10 mirror selection via plain round-robin scheduling. This should roughly double
>>>> throughput for large reads.
>>>>
>>>> Signed-off-by: Louis Jencka <louis@waffle.tech>
>>>
>>> Can you show numbers substantiating your claims?
>>
>> And isn't this related to the read policy? IIRC some patches are
>> floating in the mail list to provide the framework of how the read
>> policy should work.
>>
>> Those patches aren't yet merged?
>>
>> Thanks,
>> Qu
> 
> Oh, I hadn't seen the read-policy framework thread. Within that, this could be
> a new policy or a replacement for BTRFS_READ_POLICY_PID. Is work ongoing for
> those patches?
> 

  Yes. Those patches are just few days away please stayed tuned.

Thanks, Anand

> Louis
> 

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35EA1FDAA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 04:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfEPCKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 22:10:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34250 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEPCKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 22:10:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4G2A0gq137289;
        Thu, 16 May 2019 02:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=zE7Q3bQSUpgQMF9FqM5iixGz7qQgRVr45/hTmbGqFLY=;
 b=UC6uDUVVZ2ZoREfTpqPprVvP5Jt3uOZ4O+jbfFnxDV2152kK2z48glbpcs1zz7RmqaTN
 Cm+/cUz/T8nuKo+/QcTjIFgZyo1bDBQ507nMyv1fMMt9AnmBfiBUKIvKgjlj06zyyJMM
 knqRQif5QQoZiJIKLfeLI6IwfAwgNVD74P5ifPt/uxxQE3IJ6yHHL7HK/GQ4okebVnta
 VJ4xLWlOy9erGcLej7BIRcbALRYUpOStTEjRGPdWhp6WXTkMSmIguYll9AtPl0yk7w7c
 RGwX9LaegiTPQwC0wZWSBh/H2BcASry3XO0QJnqzRNRSg1Y8C7NvQC4pLQxtYdVXUJVH RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2sdq1qr9yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 02:10:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4G29QWW072209;
        Thu, 16 May 2019 02:10:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2sggetdea3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 02:10:16 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4G2AERr023051;
        Thu, 16 May 2019 02:10:14 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 May 2019 19:10:14 -0700
Subject: Re: [PATCH v5 RESEND] btrfs-progs: dump-tree: add noscan option
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20190404072957.2847-1-anand.jain@oracle.com>
 <121e7005-2535-c3d3-d779-9401db10bfa9@gmx.com>
 <e46d41f4-6f40-b8cb-fe2d-6ddd3b9458e4@suse.com>
 <839115e0-3874-97e1-a3d9-fe35daaeb782@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Message-ID: <8544202c-3d71-7f1f-d6c4-706548cba770@oracle.com>
Date:   Thu, 16 May 2019 10:10:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <839115e0-3874-97e1-a3d9-fe35daaeb782@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9258 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905160013
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9258 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905160014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/19 3:28 PM, Qu Wenruo wrote:
> 
> 
> On 2019/4/11 下午2:52, Nikolay Borisov wrote:
>>
>>
>> On 11.04.19 г. 7:53 ч., Qu Wenruo wrote:
>>>
>>>
>>> On 2019/4/4 下午3:29, Anand Jain wrote:
>>>> From: Anand Jain <Anand.Jain@oracle.com>
>>>>
>>>> The cli 'btrfs inspect dump-tree <dev>' will scan for the partner devices
>>>> if any by default.
>>>>
>>>> So as of now you can not inspect each mirrored device independently.
>>>>
>>>> This patch adds noscan option, which when used won't scan the system for
>>>> the partner devices, instead it just uses the devices provided in the
>>>> argument.
>>>>
>>>> For example:
>>>>    btrfs inspect dump-tree --noscan <dev> [<dev>..]
>>>
>>> So you can specify multiple devices, just like kernel "device=" mount
>>> option.
>>>
>>> Then I don't think --noscan is a good naming, while I don't have any
>>> good alternative, as the --degraded is no better.
>>
>> How about skipscan ?
> 
> I still prefer "--device=", no surprise, anyone who used "device=" mount
> option knows what it is.

  --device is already taken.

usage: btrfs inspect-internal dump-tree [options] <device> [<device> ..]
::
     -d|--device            print only device info: tree root, chunk and 
device trees


> The only problem is, when only using one device, it will be super stupid:
>    dump-tree --device /dev/sda /dev/sda
> 
> If this doesn't sound good, then --noscan is good enough AFAIK.

   IMO --noscan OR --degraded is good.

Thanks, Anand

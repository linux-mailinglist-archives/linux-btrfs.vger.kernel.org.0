Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843A5278303
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Sep 2020 10:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgIYImW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Sep 2020 04:42:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41188 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYImW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Sep 2020 04:42:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08P8Z42Q078040;
        Fri, 25 Sep 2020 08:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qFaMLho9K1ikjRl1TUYlmRKAAoROL4UOSOCbUwyC1DA=;
 b=zlPjslvI1YpbDby6Eaa9HkJVPpP+Rr48H82SBomGjAU0uNM8ozq38UUrV7DL/NS5HzID
 jT9hXMd3zQ4ObRkVP/9g3diUc/FcsFjAbXWmrGfrk2HnZLUmb3ZVjXc26zI7Gm0qSyAK
 E5t2ECK7Avvjny7XZ1USrOmitRK3s9hpoi1+QyjFtQpU2xEFe0N2nirUuDG37Ec2p0yM
 0LchR5ipSDT62qNiQPLt+D42duPMEKOWJ92zFMZoY13Y2n8vwjoyuHvvsKehbjOYo4WG
 D1aFgN0RyINEtCIWAZR9F67WEgE1EM2Z2xfeALlHYlIUDA/KzS4c4VIPqvwSYWInYxEL TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33ndnuve6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Sep 2020 08:42:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08P8YXMo043227;
        Fri, 25 Sep 2020 08:42:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33nurxfv20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Sep 2020 08:42:16 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08P8gF6C009199;
        Fri, 25 Sep 2020 08:42:15 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Sep 2020 01:42:15 -0700
Subject: Re: [PATCH 2/2] btrfs: fix btrfs_find_device unused arg seed
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <b9108a14773af7a899226f59a9dbd0953d20abe5.1600940809.git.anand.jain@oracle.com>
 <34706a92-3153-20d7-2a22-cbc39b1980eb@suse.com>
 <8d33a6d5-b2bd-aa58-5833-b321a6f4e9d2@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <53868e52-9580-43ce-2ffc-9c48f04686f1@oracle.com>
Date:   Fri, 25 Sep 2020 16:42:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <8d33a6d5-b2bd-aa58-5833-b321a6f4e9d2@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009250059
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25/9/20 4:22 pm, Nikolay Borisov wrote:
> 
> 
> On 24.09.20 г. 13:21 ч., Nikolay Borisov wrote:
>>
>>
>> On 24.09.20 г. 13:11 ч., Anand Jain wrote:
>>> commit 343694eee8d8 (btrfs: switch seed device to list api), missed to
>>> check if the last arg (seed) is true in the function btrfs_find_device().
>>> This arg tells whether to traverse through the seed device list or not.
>>>
>>> This means after the above commit the arg is always true, and the parent
>>> function which set this arg to false aren't effective.
>>>
>>> So we don't worry about the parent functions which set the last arg to
>>> true, instead there is only one parent with calling btrfs_find_device
>>> with the last arg false in device_list_add().
>>>
>>> But in fact, even the device_list_add() has no purpose that it has to set
>>> the last arg to false. Because the fs_devices always points to the
>>> device's fs_devices. So with the devid+uuid matching, it shall find the
>>> btrfs_device and returns. So naturally, it won't traverse through the
>>> seed fs_devices (if) present.
>>>
>>> So this patch makes it official that we don't need the last arg in the
>>> function btrfs_find_device() and it shall always traverse through the
>>> seed device list.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> IMO the changelog could be vastly simplified by stating that following
>> commit 343694eee8d8 the seed argument is no longer used and can simply
>> be removed.
>>
>> In any case
>>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>>
>>
> 
> 
> Actually I went back and it seems that I accidentally removed the
> portion of btrfs_find_device() which was predicated on seed bool
> parameter being true or false. So the correct thing to do is really to
> send a patch which adds it back and consider it a fix (i.e adding a
> Fixes: tag as well).
> 
> 
> OTOH - does it really make any difference? SO what if btrfs_find_device
> returns a device from fs_devices->seed_list  in device_list_add (which
> is called only from device scan)?
> 

There isn't bug as such. device scan is through the btrfs_control 
interface. So it depends on the device fsid to get fs_devices and it 
could never use seed_list with a genuine (non crafted) disk image.

Thanks, Anand
